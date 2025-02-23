<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class PopulateLeagueTournamentScores extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'populate:league_tournament_scores';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Populate the league_tournament_scores table based on the league_tournament_rosters and scoring rules.';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $this->info('Starting to populate league_tournament_scores table...');

        // Fetch eligible league_tournament_rosters records
        $eligibleRecords = DB::table('league_tournament_rosters as ltr')
            ->join('disciplines as d', 'ltr.discipline_id', '=', 'd.id')
            ->select(
                'ltr.id as league_tournament_roster_id',
                'ltr.league_tournament_id',
                'ltr.team_id',
                'ltr.season_id',
                'ltr.discipline_id',
                'd.name as discipline_name',
                'ltr.season_roster_id'
            )
            ->where('ltr.is_registration_complete', 1)
            ->where('ltr.is_active', 1)
            ->get()
        ;

        $recordsInserted = 0;

        foreach ($eligibleRecords as $record) {
            // Determine if the team participated (90% chance)
            $participated = mt_rand(1, 100) <= 90 ? 1 : 0;

            // Default values for scores
            $s1round1 = $s1round2 = $s1total_score = null;
            $s2round1 = $s2round2 = $s2total_score = null;
            $total_score = null;

            if ($participated) {
                if ($record->discipline_name === 'Sporting Clays') {
                    // Special rules for "Sporting Clays"
                    $s1round1 = mt_rand(26, 50);
                    $s1round2 = 0;
                    $s1total_score = $s1round1 + $s1round2;

                    $s2round1 = mt_rand(26, 50);
                    $s2round2 = 0;
                    $s2total_score = $s2round1 + $s2round2;

                    $total_score = $s1total_score + $s2total_score;
                } else {
                    // General rules for other disciplines
                    $s1round1 = mt_rand(12, 25);
                    $s1round2 = mt_rand(12, 25);
                    $s1total_score = $s1round1 + $s1round2;

                    $s2round1 = mt_rand(12, 25);
                    $s2round2 = mt_rand(12, 25);
                    $s2total_score = $s2round1 + $s2round2;

                    $total_score = $s1total_score + $s2total_score;
                }
            }

            // Insert record into league_tournament_scores
            DB::table('league_tournament_scores')->insert([
                'league_tournament_id' => $record->league_tournament_id,
                'league_tournament_roster_id' => $record->league_tournament_roster_id,
                'team_id' => $record->team_id,
                'season_id' => $record->season_id,
                'discipline_id' => $record->discipline_id,
                'discipline_name' => $record->discipline_name,
                'season_roster_id' => $record->season_roster_id,
                'participated' => $participated,
                's1round1' => $s1round1,
                's1round2' => $s1round2,
                's1total_score' => $s1total_score,
                's2round1' => $s2round1,
                's2round2' => $s2round2,
                's2total_score' => $s2total_score,
                'total_score' => $total_score,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            $recordsInserted++;
        }

        $this->info("Finished populating league_tournament_scores.");
        $this->info("Total records inserted: {$recordsInserted}");
        return 0;
    }
}
