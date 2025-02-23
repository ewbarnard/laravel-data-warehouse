<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class PopulateTeams extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'populate:teams';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Populates the teams table with random data using Faker';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        // Initialize Faker
        $faker = Faker::create();

        // Fetch all leagues with their associated league_types
        $leagues = DB::table('leagues')
            ->join('league_types', 'leagues.league_type_id', '=', 'league_types.id')
            ->select('leagues.id as league_id', 'league_types.name as league_type_name')
            ->get()
        ;

        // Check if there are any leagues in the database
        if ($leagues->isEmpty()) {
            $this->error('No leagues found in the database. Please ensure the leagues table is populated.');
            return Command::FAILURE;
        }

        // Insert random teams for each league
        foreach ($leagues as $league) {
            // Generate a random number of teams between 5 and 100 for the current league
            $teamCount = $faker->numberBetween(5, 10);

            for ($i = 0; $i < $teamCount; $i++) {
                $city = $faker->city;
                $state = $faker->state;

                DB::table('teams')->insert([
                    'league_id' => $league->league_id,
                    'name' => "{$city}, {$state}",
                    'description' => "{$city} {$league->league_type_name}",
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }

            $this->info("Added {$teamCount} teams to league ID {$league->league_id}.");
        }

        $this->info("Successfully populated the teams table.");
        return Command::SUCCESS;
    }
}
