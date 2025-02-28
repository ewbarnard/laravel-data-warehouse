SELECT `sr`.`season_id`,
       `s`.`name`,
       `t`.`league_id`,
       `l`.`name`                            `league`,
       count(DISTINCT `sr`.`team_id`)        `team_count`,
       count(`hur`.`happy_user_id`)          `athlete_total`,
       count(DISTINCT `hur`.`happy_user_id`) `athlete_unique`,
       sum(
               IF
               (NOT EXISTS (SELECT 1
                            FROM `season_rosters` `sr2`
                            WHERE `sr2`.`happy_user_role_id` =
                                  `sr`.`happy_user_role_id`
                              AND `sr2`.`season_id` < `sr`.`season_id`), 1,
                0)
       )                                     `athlete_new`
FROM `season_rosters` `sr`
         INNER JOIN `teams` `t` ON `t`.`id` = `sr`.`team_id`
         INNER JOIN `leagues` `l` ON `t`.`league_id` = `l`.`id`
         INNER JOIN `seasons` `s` ON `sr`.`season_id` = `s`.`id`
         INNER JOIN `happy_user_roles` `hur` ON `hur`.`id` = `sr`.`happy_user_role_id`
GROUP BY `sr`.`season_id`,
         `t`.`league_id`
ORDER BY `sr`.`season_id`,
         `t`.`league_id`;
