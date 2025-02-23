<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class PopulateLeagueTournaments extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'populate:league_tournaments';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Populate the league_tournaments table for all seasons, leagues, and league disciplines based on probability rules.';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $this->info('Starting to populate league_tournaments table...');

        // Retrieve all seasons and leagues
        $seasons = DB::table('seasons')->get();
        $leagues = DB::table('leagues')->get();

        $recordsInserted = 0;

        foreach ($seasons as $season) {
            foreach ($leagues as $league) {
                // Retrieve disciplines matching the league's league_type_id
                $disciplines = DB::table('disciplines')
                    ->where('league_type_id', $league->league_type_id)
                    ->get()
                ;

                foreach ($disciplines as $discipline) {
                    $probability = $this->getProbability($discipline->name);

                    // Roll a random number to determine if a record should be created
                    if (mt_rand(1, 100) <= $probability) {
                        // Generate name and description based on the new requirements
                        $name = $discipline->name . ' Tournament';
                        $description = $league->name;

                        // Insert the record into the league_tournaments table
                        DB::table('league_tournaments')->insert([
                            'season_id' => $season->id,
                            'league_type_id' => $league->league_type_id,
                            'league_id' => $league->id,
                            'discipline_id' => $discipline->id,
                            'name' => $name,
                            'description' => $description,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);

                        $recordsInserted++;
                    }
                }
            }
        }

        $this->info("Finished populating league_tournaments. $recordsInserted records inserted.");
        return 0;
    }

    /**
     * Get the probability of creating a record for a discipline.
     *
     * @param string $disciplineName
     * @return int
     */
    private function getProbability(string $disciplineName): int
    {
        if ($disciplineName === 'Trap') {
            return 20; // 20% probability for 'Trap'
        }

        return 5; // 5% probability for all other disciplines
    }
}
