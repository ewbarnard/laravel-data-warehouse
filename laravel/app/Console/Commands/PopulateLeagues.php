<?php

namespace App\Console\Commands;

use Faker\Factory as Faker;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class PopulateLeagues extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'populate:leagues {count=10 : The number of leagues to generate}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Populates the leagues table with random data using Faker';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        // Get the number of leagues to generate from the command argument
        $count = (int)$this->argument('count');

        // Initialize Faker
        $faker = Faker::create();

        // Fetch all league_types from the database
        $leagueTypes = DB::table('league_types')->pluck('id')->toArray();

        // Check if there are available league_types
        if (empty($leagueTypes)) {
            $this->error('No league_types found in the database. Please ensure the league_types table is populated.');
            return Command::FAILURE;
        }

        // Insert random leagues into the database
        for ($i = 0; $i < $count; $i++) {
            DB::table('leagues')->insert([
                'league_type_id' => $faker->randomElement($leagueTypes),
                'name' => $faker->randomElement(['Greater', 'Lesser', 'Metro', 'Metropolitan']) . ' ' . $faker->city,
                'description' => $faker->randomElement([
                    'Elite league',
                    'Competitive play',
                    'Regional league',
                    'Amateur league',
                    'Professional division',
                    'Youth division',
                    'Senior league',
                    'Open competition',
                ]),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        $this->info("Successfully added {$count} leagues to the leagues table.");
        return Command::SUCCESS;
    }
}
