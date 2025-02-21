<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class PopulateDisciplines extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'populate:disciplines';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Populates the disciplines table with all combinations of discipline_types and league_types.';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        // Fetch all discipline types
        $disciplineTypes = DB::table('discipline_types')->select('id', 'name')->get();

        // Fetch all league types
        $leagueTypes = DB::table('league_types')->select('id', 'name')->get();

        // Check if the necessary tables have data
        if ($disciplineTypes->isEmpty()) {
            $this->error(
                'No discipline types found in the database. Please populate the discipline_types table first.'
            );
            return Command::FAILURE;
        }

        if ($leagueTypes->isEmpty()) {
            $this->error('No league types found in the database. Please populate the league_types table first.');
            return Command::FAILURE;
        }

        // Prepare the data for insertion
        $data = [];
        foreach ($leagueTypes as $leagueType) {
            foreach ($disciplineTypes as $disciplineType) {
                $data[] = [
                    'league_type_id' => $leagueType->id,
                    'discipline_type_id' => $disciplineType->id,
                    'name' => $disciplineType->name,
                    'description' => "{$leagueType->name} {$disciplineType->name}",
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }
        }

        // Insert the data into the disciplines table
        DB::table('disciplines')->insert($data);

        $this->info(
            'Successfully populated the disciplines table with all combinations of discipline types and league types.'
        );
        return Command::SUCCESS;
    }
}
