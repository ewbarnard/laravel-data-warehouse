SELECT `ltr`.`season_id`,
       `s`.`name`,
       `t`.`league_id`,
       `l`.`name`                                AS `league`,
       COUNT(DISTINCT `ltr`.`team_id`)           AS `t_team_count`,
       COUNT(`sr`.`happy_user_role_id`)          AS `t_athlete_total`,
       COUNT(DISTINCT `sr`.`happy_user_role_id`) AS `t_athlete_unique`
FROM `league_tournament_rosters` `ltr`
         INNER JOIN `league_tournaments` `lt` ON `ltr`.`league_tournament_id` = `lt`.`id`
         INNER JOIN `teams` `t` ON `t`.`id` = `ltr`.`team_id`
         INNER JOIN `leagues` `l` ON `t`.`league_id` = `l`.`id`
         INNER JOIN `seasons` `s` ON `ltr`.`season_id` = `s`.`id`
         INNER JOIN `season_rosters` `sr` ON `sr`.`id` = `ltr`.`season_roster_id`
         INNER JOIN `happy_user_roles` `hur` ON `hur`.`id` = `sr`.`happy_user_role_id`
GROUP BY `ltr`.`season_id`,
         `t`.`league_id`
ORDER BY `ltr`.`season_id`,
         `t`.`league_id`;
