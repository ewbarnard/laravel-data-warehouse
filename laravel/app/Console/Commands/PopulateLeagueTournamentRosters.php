<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class PopulateLeagueTournamentRosters extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'populate:league_tournament_rosters';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Populate the league_tournament_rosters table based on season_rosters and league_tournaments with specific conditions.';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $this->info('Starting to populate league_tournament_rosters table...');

        // Query to get eligible season_rosters records with matching league_tournaments
        $eligibleRecords = DB::select(
            "
            SELECT
                sr.*,
                lt.id AS league_tournament_id
            FROM
                season_rosters sr
            JOIN teams t ON sr.team_id = t.id
            JOIN happy_user_roles hur ON sr.happy_user_role_id = hur.id
            JOIN league_tournaments lt ON lt.season_id = sr.season_id
                AND lt.league_id = t.league_id
                AND lt.discipline_id = sr.discipline_id
            WHERE
                sr.is_registration_complete = 1
                AND sr.is_active = 1
                AND hur.is_active = 1
        "
        );

        $recordsInserted = 0;

        foreach ($eligibleRecords as $record) {
            // Determine is_registration_complete (80% chance) and is_active (95% chance)
            $isRegistrationComplete = mt_rand(1, 100) <= 80 ? 1 : 0; // 80% chance
            $isActive = mt_rand(1, 100) <= 95 ? 1 : 0; // 95% chance

            // Insert into league_tournament_rosters
            DB::table('league_tournament_rosters')->insert([
                'league_tournament_id' => $record->league_tournament_id,
                'team_id' => $record->team_id,
                'season_id' => $record->season_id,
                'discipline_id' => $record->discipline_id,
                'season_roster_id' => $record->id,
                'is_registration_complete' => $isRegistrationComplete,
                'is_active' => $isActive,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            $recordsInserted++;
        }

        $this->info("Finished populating league_tournament_rosters.");
        $this->info("Total records inserted: {$recordsInserted}");
        return 0;
    }
}
