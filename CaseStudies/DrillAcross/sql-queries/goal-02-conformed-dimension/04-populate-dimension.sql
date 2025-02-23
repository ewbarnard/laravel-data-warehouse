INSERT INTO `season_league_dimensions` (`season_id`,
                                        `season`,
                                        `league_type_id`,
                                        `league_id`,
                                        `league_sort`,
                                        `league_name`,
                                        `national_id`)
SELECT `sr`.`season_id`,
       `s`.`name`                           AS `season`,
       `l`.`league_type_id`,
       `l`.`id`                             AS `league_id`,
       CONCAT_WS(':', 'league', `l`.`name`) AS `league_sort`,
       `l`.`name`                           AS `league_name`,
       0                                    AS `national_id`
FROM `season_rosters` `sr`
         INNER JOIN `seasons` `s`
                    ON `sr`.`season_id` = `s`.`id`
         INNER JOIN `teams` `t`
                    ON `t`.`id` = `sr`.`team_id`
         INNER JOIN `leagues` `l`
                    ON `l`.`id` = `t`.`league_id`
         INNER JOIN `league_types` `lt`
                    ON `lt`.`id` = `l`.`league_type_id`
GROUP BY `sr`.`season_id`,
         `l`.`league_type_id`,
         `l`.`id`,
         `national_id`
UNION
SELECT `sr`.`season_id`,
       `s`.`name` AS `season`,
       `l`.`league_type_id`,
       '0'        AS `league_id`,
       CONCAT_WS(':', 'national', LPAD(`n`.`id`, 5, '0'))
                  AS `league_sort`,
       CONCAT_WS(' ', `lt`.`description`, `n`.`name`)
                  AS `league_name`,
       `n`.`id`   AS `national_id`
FROM `season_rosters` `sr`
         INNER JOIN `seasons` `s`
                    ON `sr`.`season_id` = `s`.`id`
         INNER JOIN `teams` `t`
                    ON `t`.`id` = `sr`.`team_id`
         INNER JOIN `leagues` `l`
                    ON `l`.`id` = `t`.`league_id`
         INNER JOIN `league_types` `lt`
                    ON `lt`.`id` = `l`.`league_type_id`
         INNER JOIN `nationals` `n`
                    ON `n`.`season_id` = `sr`.`season_id`
                        AND `n`.`league_type_id` = `l`.`league_type_id`
                        AND `n`.`discipline_id` = `sr`.`discipline_id`
         INNER JOIN `national_rosters` `nr`
                    ON `nr`.`national_id` = `n`.`id`
                        AND `nr`.`is_registration_complete` = 1
                        AND `nr`.`is_active` = 1
GROUP BY `sr`.`season_id`,
         `l`.`league_type_id`,
         `n`.`id`
ORDER BY `season_id`,
         `league_sort`;
