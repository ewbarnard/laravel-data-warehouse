<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class Feature01AssignTeamAthletes extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'feature:01';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Runs a sequence of commands to populate leagues, teams, seasons, disciplines, nationals, and assign happy users and roles.';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle(): int
    {
        // Commands to execute in sequence
        $commands = [
            'populate:leagues',
            'populate:disciplines',
            'populate:seasons',
            'populate:teams',
            'populate:happy',
            'populate:season_rosters',
            'populate:season_scores',
            'populate:league_tournaments',
            'populate:league_tournament_rosters',
            'populate:league_tournament_scores',
            'populate:nationals',
            'populate:national_rosters',
            'populate:national_scores',
        ];

        foreach ($commands as $command) {
            $this->info("Running command: $command...");

            // Call each command
            $this->call($command);
        }

        $this->info('Feature01AssignTeamAthletes command completed successfully.');
        return Command::SUCCESS;
    }
}
