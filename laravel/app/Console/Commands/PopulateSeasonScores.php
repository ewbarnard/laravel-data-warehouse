<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class PopulateSeasonScores extends Command
{
    protected $signature = 'populate:season_scores';
    protected $description = 'Populate the season_scores table in smaller chunks';

    public function handle()
    {
        $batchSize = 1000; // Number of rows to insert per batch
        $scoringWeeks = range(1, 5);

        $seasonRosters = DB::table('season_rosters')
            ->join('disciplines', 'season_rosters.discipline_id', '=', 'disciplines.id')
            ->select(
                'season_rosters.id as roster_id',
                'season_rosters.team_id',
                'season_rosters.season_id',
                'season_rosters.discipline_id',
                'season_rosters.happy_user_role_id',
                'disciplines.name as discipline_name'
            )
            ->where('season_rosters.is_registration_complete', 1)
            ->where('season_rosters.is_active', 1)
            ->get()
        ;

        if ($seasonRosters->isEmpty()) {
            $this->info('No eligible season_rosters records found.');
            return 0;
        }

        $this->info('Populating season_scores table in chunks...');

        $seasonScoresData = [];

        foreach ($seasonRosters as $roster) {
            foreach ($scoringWeeks as $week) {
                // Determine participation
                $participated = rand(1, 100) <= 95 ? 1 : 0;
                $round1 = null;
                $round2 = null;
                $totalScore = null;

                if ($participated === 1) {
                    if ($roster->discipline_name === 'Sporting Clays') {
                        $round1 = rand(0, 50);
                        $round2 = 0;
                        $totalScore = $round1;
                    } else {
                        $round1 = rand(0, 25);
                        $round2 = rand(0, 25);
                        $totalScore = $round1 + $round2;
                    }
                }

                $seasonScoresData[] = [
                    'team_id' => $roster->team_id,
                    'season_id' => $roster->season_id,
                    'discipline_id' => $roster->discipline_id,
                    'happy_user_role_id' => $roster->happy_user_role_id,
                    'scoring_week' => $week,
                    'participated' => $participated,
                    'round1' => $round1,
                    'round2' => $round2,
                    'total_score' => $totalScore,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];

                // Insert in batches
                if (count($seasonScoresData) >= $batchSize) {
                    DB::table('season_scores')->insert($seasonScoresData);
                    $seasonScoresData = []; // Reset the batch
                }
            }
        }

        // Insert remaining records
        if (!empty($seasonScoresData)) {
            DB::table('season_scores')->insert($seasonScoresData);
        }

        $this->info('Season scores have been populated successfully.');
        return 0;
    }
}
