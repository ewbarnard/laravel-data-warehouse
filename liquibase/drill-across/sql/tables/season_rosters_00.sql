CREATE TABLE `season_rosters`
(
    `id`                       int unsigned     NOT NULL AUTO_INCREMENT,
    `created_at`               timestamp        NULL     DEFAULT CURRENT_TIMESTAMP,
    `updated_at`               timestamp        NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `team_id`                  int unsigned     NOT NULL,
    `season_id`                int unsigned     NOT NULL,
    `discipline_id`            int unsigned     NOT NULL,
    `happy_user_role_id`       int unsigned     NOT NULL,
    `is_registration_complete` tinyint unsigned NOT NULL DEFAULT '0',
    `is_active`                tinyint unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_team_season_discipline_user_role` (`team_id`, `season_id`, `discipline_id`, `happy_user_role_id`),
    KEY `season_id` (`season_id`),
    KEY `discipline_id` (`discipline_id`),
    KEY `happy_user_role_id` (`happy_user_role_id`),
    CONSTRAINT `season_rosters_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ,
    CONSTRAINT `season_rosters_ibfk_2` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`) ,
    CONSTRAINT `season_rosters_ibfk_3` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`) ,
    CONSTRAINT `season_rosters_ibfk_4` FOREIGN KEY (`happy_user_role_id`) REFERENCES `happy_user_roles` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
