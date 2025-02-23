CREATE TABLE `season_scores`
(
    `id`                 INT UNSIGNED     NOT NULL AUTO_INCREMENT,
    `created_at`         TIMESTAMP        NULL     DEFAULT CURRENT_TIMESTAMP,
    `updated_at`         TIMESTAMP        NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `team_id`            INT UNSIGNED     NOT NULL,
    `season_id`          INT UNSIGNED     NOT NULL,
    `discipline_id`      INT UNSIGNED     NOT NULL,
    `happy_user_role_id` INT UNSIGNED     NOT NULL,
    `scoring_week`       TINYINT UNSIGNED NOT NULL,
    `participated`       TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `round1`             TINYINT UNSIGNED          DEFAULT NULL,
    `round2`             TINYINT UNSIGNED          DEFAULT NULL,
    `total_score`        SMALLINT UNSIGNED         DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_team_season_discipline_user_role_week`
        (`team_id`, `season_id`, `discipline_id`, `happy_user_role_id`, `scoring_week`),
    KEY `season_id` (`season_id`),
    KEY `discipline_id` (`discipline_id`),
    KEY `happy_user_role_id` (`happy_user_role_id`),
    CONSTRAINT `season_scores_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ,
    CONSTRAINT `season_scores_ibfk_2` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`) ,
    CONSTRAINT `season_scores_ibfk_3` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`) ,
    CONSTRAINT `season_scores_ibfk_4` FOREIGN KEY (`happy_user_role_id`) REFERENCES `happy_user_roles` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
