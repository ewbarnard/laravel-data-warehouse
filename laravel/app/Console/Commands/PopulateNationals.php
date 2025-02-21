<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class PopulateNationals extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'populate:nationals';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Populates the nationals table with all possible combinations of seasons, league_types, and their corresponding disciplines.';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        // Fetch all seasons
        $seasons = DB::table('seasons')->select('id')->get();

        // Fetch all league_types
        $leagueTypes = DB::table('league_types')->select('id', 'name')->get();

        // Check if the necessary tables have data
        if ($seasons->isEmpty()) {
            $this->error('No seasons found in the database. Please populate the seasons table first.');
            return Command::FAILURE;
        }

        if ($leagueTypes->isEmpty()) {
            $this->error('No league types found in the database. Please populate the league_types table first.');
            return Command::FAILURE;
        }

        // Prepare the data for insertion
        $data = [];
        $descriptionAlternatives = ['Virtual', 'In-Person'];
        $descriptionIndex = 0;

        foreach ($seasons as $season) {
            foreach ($leagueTypes as $leagueType) {
                // Fetch disciplines for the current league type
                $disciplines = DB::table('disciplines')
                    ->join('discipline_types', 'disciplines.discipline_type_id', '=', 'discipline_types.id')
                    ->where('disciplines.league_type_id', $leagueType->id)
                    ->select('disciplines.id as discipline_id', 'discipline_types.name as discipline_type_name')
                    ->get()
                ;

                if ($disciplines->isEmpty()) {
                    $this->warn("No disciplines found for league type ID {$leagueType->id}. Skipping.");
                    continue;
                }

                foreach ($disciplines as $discipline) {
                    $data[] = [
                        'season_id' => $season->id,
                        'league_type_id' => $leagueType->id,
                        'discipline_id' => $discipline->discipline_id,
                        'name' => "{$discipline->discipline_type_name} Nationals",
                        'description' => "{$descriptionAlternatives[$descriptionIndex]} {$leagueType->name}",
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];

                    // Alternate the description between "Virtual" and "In-Person"
                    $descriptionIndex = ($descriptionIndex + 1) % 2;
                }
            }
        }

        // Insert the data into the nationals table
        if (!empty($data)) {
            DB::table('nationals')->insert($data);
            $this->info('Successfully populated the nationals table with all possible combinations.');
        } else {
            $this->warn('No data was inserted into the nationals table. Ensure all related tables are populated.');
        }

        return Command::SUCCESS;
    }
}
