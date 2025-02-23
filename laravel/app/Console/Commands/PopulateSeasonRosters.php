<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class PopulateSeasonRosters extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'populate:season_rosters';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Populate the season_rosters table based on the given rules.';

    /**
     * Execute the console command.
     */
    public function handle(): void
    {
        $this->info("Starting to populate season_rosters...");

        // Fetch the "2025 Spring" season
        $springSeason = DB::table('seasons')->where('name', '2025 Spring')->first();
        if (!$springSeason) {
            $this->error("Season '2025 Spring' not found.");
            return;
        }

        $springSeasonId = $springSeason->id;

        // Fetch all active happy_user_roles
        $activeUserRoles = DB::table('happy_user_roles')->where('is_active', 1)->get();

        foreach ($activeUserRoles as $userRole) {
            $teamId = $userRole->team_id;

            // Determine the league_id and league_type_id from the team
            $league = DB::table('leagues')
                ->join('teams', 'leagues.id', '=', 'teams.league_id')
                ->where('teams.id', $teamId)
                ->select('leagues.id as league_id', 'leagues.league_type_id')
                ->first()
            ;

            if (!$league) {
                $this->warn("No league found for team_id: {$teamId}. Skipping.");
                continue;
            }

            // Fetch the discipline_id for "Trap" based on league_type_id
            $trapDiscipline = DB::table('disciplines')
                ->where('league_type_id', $league->league_type_id)
                ->where('name', 'Trap')
                ->first()
            ;

            if (!$trapDiscipline) {
                $this->warn("No discipline 'Trap' found for league_type_id: {$league->league_type_id}. Skipping.");
                continue;
            }

            $trapDisciplineId = $trapDiscipline->id;

            // Insert "Trap" for "2025 Spring" if it doesn't already exist
            $this->insertIfNotExists($teamId, $springSeasonId, $trapDisciplineId, $userRole->id);

            // Create roster records for other seasons with a 10% chance
            $otherSeasons = DB::table('seasons')->where('id', '!=', $springSeasonId)->get();
            foreach ($otherSeasons as $season) {
                if (rand(1, 100) <= 10) { // 10% chance
                    $this->insertIfNotExists($teamId, $season->id, $trapDisciplineId, $userRole->id);
                }
            }

            // Create roster records for other disciplines and all seasons with a 5% chance
            $allDisciplines = DB::table('disciplines')->where('league_type_id', $league->league_type_id)->get();
            foreach ($allDisciplines as $discipline) {
                foreach (DB::table('seasons')->get() as $season) {
                    if (rand(1, 100) <= 5) { // 5% chance
                        $this->insertIfNotExists($teamId, $season->id, $discipline->id, $userRole->id);
                    }
                }
            }
        }

        $this->info("season_rosters table populated successfully.");
    }

    /**
     * Inserts a record into season_rosters if it doesn't already exist, with random values for is_registration_complete and is_active.
     *
     * @param int $teamId
     * @param int $seasonId
     * @param int $disciplineId
     * @param int $happyUserRoleId
     */
    private function insertIfNotExists($teamId, $seasonId, $disciplineId, $happyUserRoleId): void
    {
        $exists = DB::table('season_rosters')->where([
            'team_id' => $teamId,
            'season_id' => $seasonId,
            'discipline_id' => $disciplineId,
            'happy_user_role_id' => $happyUserRoleId,
        ])->exists();

        if (!$exists) {
            // Randomly determine is_registration_complete and is_active
            $isRegistrationComplete = rand(1, 100) <= 50 ? 1 : 0; // 50% chance
            $isActive = rand(1, 100) <= 90 ? 1 : 0; // 90% chance

            DB::table('season_rosters')->insert([
                'team_id' => $teamId,
                'season_id' => $seasonId,
                'discipline_id' => $disciplineId,
                'happy_user_role_id' => $happyUserRoleId,
                'is_registration_complete' => $isRegistrationComplete,
                'is_active' => $isActive,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
