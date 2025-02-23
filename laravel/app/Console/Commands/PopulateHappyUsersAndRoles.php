<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class PopulateHappyUsersAndRoles extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'populate:happy';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Populates the happy_users and happy_user_roles tables with random data using only the "Athlete" role.';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $faker = Faker::create();

        // Fetch all teams
        $teams = DB::table('teams')->select('id')->get();

        // Fetch the "Athlete" role
        $athleteRole = DB::table('happy_roles')->where('name', 'Athlete')->first();

        if ($teams->isEmpty()) {
            $this->error('The Teams table is empty. Please populate it first.');
            return Command::FAILURE;
        }

        if (!$athleteRole) {
            $this->error('No role found with the name "Athlete".');
            return Command::FAILURE;
        }

        $this->info('Populating happy_users and happy_user_roles...');

        $allUsers = []; // Array to hold all users for bulk insert
        $allUserRoles = []; // Array to hold all user roles for bulk insert
        $now = now();

        foreach ($teams as $team) {
            // Determine how many users this team will have (0 to 50)
            $userCount = $faker->numberBetween(5, 8);

            // Generate users for this team
            $teamUsers = [];
            for ($i = 0; $i < $userCount; $i++) {
                $teamUsers[] = [
                    'user_name' => $faker->unique()->userName(),
                    'user_email' => $faker->unique()->safeEmail(),
                    'password' => bcrypt($faker->password()),
                    'first_name' => $faker->firstName(),
                    'last_name' => $faker->lastName(),
                    'created_at' => $now,
                    'updated_at' => $now,
                ];
            }
            $this->info("Generated $userCount users for team {$team->id}");

            // Append the team users to the global user list for bulk insert
            $allUsers = array_merge($allUsers, $teamUsers);

            // Generate user roles for this team
            foreach ($teamUsers as $userIndex => $user) {
                $allUserRoles[] = [
                    'team_id' => $team->id,
                    'happy_user_id' => null, // Placeholder, will be updated after users are inserted
                    'happy_role_id' => $athleteRole->id,
                    'is_active' => $faker->boolean(90) ? 1 : 0,
                    'created_at' => $now,
                    'updated_at' => $now,
                ];
            }
        }

        // Bulk insert all users and retrieve their IDs
        if (!empty($allUsers)) {
            DB::table('happy_users')->insert($allUsers);

            // Fetch the IDs of the newly created users in bulk
            $userIds = DB::table('happy_users')
                ->select('id')
                ->orderBy('id', 'desc')
                ->take(count($allUsers))
                ->pluck('id')
                ->toArray()
            ;

            // Update the happy_user_id in allUserRoles with the correct IDs
            $userIndex = 0;
            foreach ($allUserRoles as &$userRole) {
                $userRole['happy_user_id'] = $userIds[$userIndex];
                $userIndex++;
            }

            // Bulk insert all user roles
            DB::table('happy_user_roles')->insert($allUserRoles);

            $this->info(
                'Successfully populated the happy_users and happy_user_roles tables using only the "Athlete" role.'
            );
        } else {
            $this->warn('No users were created because no teams had users assigned.');
        }

        return Command::SUCCESS;
    }
}
