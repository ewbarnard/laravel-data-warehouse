WITH season_rosters_cte AS
         (SELECT `sr`.`season_id`,
                 `s`.`name`,
                 `t`.`league_id`,
                 `l`.`name`                     AS `league`,
                 COUNT(DISTINCT `sr`.`team_id`) AS `team_count`,
                 COUNT(`hur`.`happy_user_id`)   AS `athlete_total`,
                 COUNT(DISTINCT `hur`.`happy_user_id`)
                                                AS `athlete_unique`,
                 SUM(
                         IF(
                                 NOT EXISTS (SELECT 1
                                             FROM `season_rosters` `sr2`
                                             WHERE `sr2`.`happy_user_role_id`
                                                 = `sr`.`happy_user_role_id`
                                               AND `sr2`.`season_id` < `sr`.`season_id`),
                                 1,
                                 0
                         )
                 )                              AS `athlete_new`
          FROM `season_rosters` `sr`
                   INNER JOIN `teams` `t`
                              ON `t`.`id` = `sr`.`team_id`
                   INNER JOIN `leagues` `l`
                              ON `t`.`league_id` = `l`.`id`
                   INNER JOIN `seasons` `s`
                              ON `sr`.`season_id` = `s`.`id`
                   INNER JOIN `happy_user_roles` `hur`
                              ON `hur`.`id` = `sr`.`happy_user_role_id`
          GROUP BY `sr`.`season_id`,
                   `t`.`league_id`),
     league_tournament_rosters_cte AS
         (SELECT `ltr`.`season_id`,
                 `s`.`name`,
                 `t`.`league_id`,
                 `l`.`name` AS `league`,
                 COUNT(DISTINCT `ltr`.`team_id`)
                            AS `t_team_count`,
                 COUNT(`sr`.`happy_user_role_id`)
                            AS `t_athlete_total`,
                 COUNT(DISTINCT `sr`.`happy_user_role_id`)
                            AS `t_athlete_unique`
          FROM `league_tournament_rosters` `ltr`
                   INNER JOIN `league_tournaments` `lt`
                              ON `ltr`.`league_tournament_id` = `lt`.`id`
                   INNER JOIN `teams` `t`
                              ON `t`.`id` = `ltr`.`team_id`
                   INNER JOIN `leagues` `l`
                              ON `t`.`league_id` = `l`.`id`
                   INNER JOIN `seasons` `s`
                              ON `ltr`.`season_id` = `s`.`id`
                   INNER JOIN `season_rosters` `sr`
                              ON `sr`.`id` = `ltr`.`season_roster_id`
                   INNER JOIN `happy_user_roles` `hur`
                              ON `hur`.`id` = `sr`.`happy_user_role_id`
          GROUP BY `ltr`.`season_id`,
                   `t`.`league_id`)
SELECT `sr`.`season_id`,
       `sr`.`name`,
       `sr`.`league_id`,
       `sr`.`league`,
       `sr`.`team_count`,
       `sr`.`athlete_total`,
       `sr`.`athlete_unique`,
       `sr`.`athlete_new`,
       `lr`.`t_team_count`,
       `lr`.`t_athlete_total`,
       `lr`.`t_athlete_unique`
FROM season_rosters_cte sr
         LEFT JOIN league_tournament_rosters_cte lr
                   ON `sr`.`season_id` = `lr`.`season_id`
                       AND `sr`.`league_id` = `lr`.`league_id`
ORDER BY `sr`.`season_id`,
         `sr`.`league_id`;
