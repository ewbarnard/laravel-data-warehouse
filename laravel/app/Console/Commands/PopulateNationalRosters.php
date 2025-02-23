<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class PopulateNationalRosters extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'populate:national_rosters';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Populate the national_rosters table based on season_rosters and related tables.';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $this->info('Starting to populate national_rosters table...');

        // Query to retrieve data from season_rosters and related tables
        $results = DB::table('season_rosters as sr')
            ->join('teams as t', 't.id', '=', 'sr.team_id')
            ->join('leagues as l', 'l.id', '=', 't.league_id')
            ->join('nationals as n', function ($join) {
                $join->on('n.season_id', '=', 'sr.season_id')
                    ->on('n.league_type_id', '=', 'l.league_type_id')
                    ->on('n.discipline_id', '=', 'sr.discipline_id')
                ;
            })
            ->join('happy_user_roles as hur', 'hur.id', '=', 'sr.happy_user_role_id')
            ->where('sr.is_registration_complete', 1)
            ->where('sr.is_active', 1)
            ->where('hur.is_active', 1)
            ->select(
                'n.id as national_id',
                't.id as team_id',
                'sr.season_id',
                'sr.discipline_id',
                'sr.id as season_roster_id'
            )
            ->get()
        ;

        $recordsInserted = 0;

        foreach ($results as $row) {
            // Insert data into national_rosters table
            DB::table('national_rosters')->insert([
                'national_id' => $row->national_id,
                'team_id' => $row->team_id,
                'season_id' => $row->season_id,
                'discipline_id' => $row->discipline_id,
                'season_roster_id' => $row->season_roster_id,
                'is_registration_complete' => 1, // Set to 1
                'is_active' => 1, // Set to 1
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            $recordsInserted++;
        }

        $this->info("Finished populating national_rosters. $recordsInserted records inserted.");
        return 0;
    }
}
