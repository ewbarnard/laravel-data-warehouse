CREATE TABLE `season_score_facts`
(
    `id`                         INT UNSIGNED     NOT NULL AUTO_INCREMENT,
    `season_league_dimension_id` INT UNSIGNED     NOT NULL,
    `team_id`                    INT UNSIGNED     NOT NULL,
    `season_id`                  INT UNSIGNED     NOT NULL,
    `discipline_id`              INT UNSIGNED     NOT NULL,
    `discipline_name`            VARCHAR(255)     NOT NULL,
    `happy_user_role_id`         INT UNSIGNED     NOT NULL,
    `season_score_id`            INT UNSIGNED     NOT NULL,
    `scoring_week`               TINYINT UNSIGNED NOT NULL,
    `round1`                     TINYINT UNSIGNED      DEFAULT NULL,
    `round2`                     TINYINT UNSIGNED      DEFAULT NULL,
    `round1_25`                  TINYINT UNSIGNED      DEFAULT NULL,
    `round2_25`                  TINYINT UNSIGNED      DEFAULT NULL,
    `round_50`                   TINYINT UNSIGNED      DEFAULT NULL,
    `created_at`                 TIMESTAMP        NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`                 TIMESTAMP        NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `season_league_dimension_id` (`season_league_dimension_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
