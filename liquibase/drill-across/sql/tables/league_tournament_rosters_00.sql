CREATE TABLE `league_tournament_rosters`
(
    `id`                       INT UNSIGNED     NOT NULL AUTO_INCREMENT,
    `created_at`               TIMESTAMP        NULL     DEFAULT CURRENT_TIMESTAMP,
    `updated_at`               TIMESTAMP        NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `league_tournament_id`     INT UNSIGNED     NOT NULL,
    `team_id`                  INT UNSIGNED     NOT NULL,
    `season_id`                INT UNSIGNED     NOT NULL,
    `discipline_id`            INT UNSIGNED     NOT NULL,
    `season_roster_id`         INT UNSIGNED     NOT NULL UNIQUE,
    `is_registration_complete` TINYINT UNSIGNED NOT NULL DEFAULT '0',
    `is_active`                TINYINT UNSIGNED NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    KEY `league_tournament_id` (`league_tournament_id`),
    KEY `team_id` (`team_id`),
    KEY `season_id` (`season_id`),
    KEY `discipline_id` (`discipline_id`),
    CONSTRAINT `league_tournament_rosters_ibfk_1` FOREIGN KEY (`league_tournament_id`) REFERENCES `league_tournaments` (`id`),
    CONSTRAINT `league_tournament_rosters_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
    CONSTRAINT `league_tournament_rosters_ibfk_3` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
    CONSTRAINT `league_tournament_rosters_ibfk_4` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`),
    CONSTRAINT `league_tournament_rosters_ibfk_5` FOREIGN KEY (`season_roster_id`) REFERENCES `season_rosters` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
