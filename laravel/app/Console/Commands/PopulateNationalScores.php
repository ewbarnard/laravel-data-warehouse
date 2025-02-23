<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class PopulateNationalScores extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'populate:national_scores';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Populate the national_scores table based on rules for participated and score generation.';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $this->info('Starting to populate the national_scores table...');

        // Fetch all relevant national_rosters records
        $nationalRosters = DB::table('national_rosters as nr')
            ->join('nationals as n', 'nr.national_id', '=', 'n.id')
            ->join('disciplines as d', 'n.discipline_id', '=', 'd.id')
            ->select(
                'nr.id as national_roster_id',
                'nr.national_id',
                'nr.team_id',
                'nr.season_id',
                'nr.season_roster_id',
                'n.discipline_id',
                'd.name as discipline_name'
            )
            ->where('nr.is_registration_complete', 1)
            ->where('nr.is_active', 1)
            ->get()
        ;

        $recordsInserted = 0;

        foreach ($nationalRosters as $roster) {
            // Determine if the record participated (90% chance)
            $participated = mt_rand(1, 100) <= 90 ? 1 : 0;
            $scores = [
                's1round1' => null,
                's1round2' => null,
                's1total_score' => null,
                's2round1' => null,
                's2round2' => null,
                's2total_score' => null,
                'total_score' => null,
            ];

            if ($participated === 1) {
                if ($roster->discipline_name === 'Sporting Clays') {
                    // Sporting Clays special rules
                    $scores['s1round1'] = mt_rand(26, 50);
                    $scores['s1round2'] = 0;
                    $scores['s1total_score'] = $scores['s1round1'] + $scores['s1round2'];

                    $scores['s2round1'] = mt_rand(26, 50);
                    $scores['s2round2'] = 0;
                    $scores['s2total_score'] = $scores['s2round1'] + $scores['s2round2'];

                    $scores['total_score'] = $scores['s1total_score'] + $scores['s2total_score'];
                } else {
                    // Non-Sporting Clays rules
                    $scores['s1round1'] = mt_rand(12, 25);
                    $scores['s1round2'] = mt_rand(12, 25);
                    $scores['s1total_score'] = $scores['s1round1'] + $scores['s1round2'];

                    $scores['s2round1'] = mt_rand(12, 25);
                    $scores['s2round2'] = mt_rand(12, 25);
                    $scores['s2total_score'] = $scores['s2round1'] + $scores['s2round2'];

                    $scores['total_score'] = $scores['s1total_score'] + $scores['s2total_score'];
                }
            }

            // Insert record into national_scores
            DB::table('national_scores')->insert([
                'created_at' => now(),
                'updated_at' => now(),
                'national_id' => $roster->national_id,
                'national_roster_id' => $roster->national_roster_id,
                'team_id' => $roster->team_id,
                'season_id' => $roster->season_id,
                'discipline_id' => $roster->discipline_id,
                'discipline_name' => $roster->discipline_name,
                'season_roster_id' => $roster->season_roster_id,
                'participated' => $participated,
                's1round1' => $scores['s1round1'],
                's1round2' => $scores['s1round2'],
                's1total_score' => $scores['s1total_score'],
                's2round1' => $scores['s2round1'],
                's2round2' => $scores['s2round2'],
                's2total_score' => $scores['s2total_score'],
                'total_score' => $scores['total_score'],
            ]);

            $recordsInserted++;
        }

        $this->info("Finished populating the national_scores table. $recordsInserted records inserted.");
        return 0;
    }
}
