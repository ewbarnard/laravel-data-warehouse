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
    public function handle()
    {
        // Commands to execute in sequence
        $commands = [
            'populate:leagues',
            'populate:teams',
            'populate:seasons',
            'populate:disciplines',
            'populate:nationals',
            'populate:happy',
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
