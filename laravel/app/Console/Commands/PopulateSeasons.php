<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class PopulateSeasons extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'populate:seasons';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Populates the seasons table with data for the years 2012 to 2026.';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        // Define the range of years and the seasons
        $years = range(2012, 2026);
        $seasons = ['Spring', 'Fall'];

        // Prepare the data for insertion
        $data = [];
        foreach ($years as $year) {
            foreach ($seasons as $season) {
                $data[] = [
                    'name' => "{$year} {$season}",
                    'year' => (string)$year,
                    'season_of_year' => $season,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }
        }

        // Insert the data into the seasons table
        DB::table('seasons')->insert($data);

        $this->info("Successfully populated the seasons table with data for the years 2012 to 2026.");
        return Command::SUCCESS;
    }
}
