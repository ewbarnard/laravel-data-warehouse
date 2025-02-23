CREATE TABLE `league_score_facts`
(
    `id`                          INT UNSIGNED     NOT NULL AUTO_INCREMENT,
    `created_at`                  TIMESTAMP        NULL     DEFAULT CURRENT_TIMESTAMP,
    `updated_at`                  TIMESTAMP        NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `season_league_dimension_id`  INT UNSIGNED     NOT NULL,
    `league_tournament_score_id`  INT UNSIGNED     NOT NULL UNIQUE,
    `league_tournament_id`        INT UNSIGNED     NOT NULL,
    `league_tournament_roster_id` INT UNSIGNED     NOT NULL,
    `team_id`                     INT UNSIGNED     NOT NULL,
    `season_id`                   INT UNSIGNED     NOT NULL,
    `discipline_id`               INT UNSIGNED     NOT NULL,
    `discipline_name`             VARCHAR(255)     NOT NULL,
    `season_roster_id`            INT UNSIGNED     NOT NULL UNIQUE,
    `s1round1`                    TINYINT UNSIGNED          DEFAULT NULL,
    `s1round2`                    TINYINT UNSIGNED          DEFAULT NULL,
    `s1total_score`               TINYINT UNSIGNED          DEFAULT NULL,
    `s2round1`                    TINYINT UNSIGNED          DEFAULT NULL,
    `s2round2`                    TINYINT UNSIGNED          DEFAULT NULL,
    `s2total_score`               TINYINT UNSIGNED          DEFAULT NULL,
    `total_score`                 TINYINT UNSIGNED          DEFAULT NULL,
    `s1round1_25`                 TINYINT UNSIGNED          DEFAULT NULL,
    `s1round2_25`                 TINYINT UNSIGNED          DEFAULT NULL,
    `s2round1_25`                 TINYINT UNSIGNED          DEFAULT NULL,
    `s2round2_25`                 TINYINT UNSIGNED          DEFAULT NULL,
    `round_50`                    TINYINT UNSIGNED          DEFAULT NULL,
    `round_75`                    TINYINT UNSIGNED          DEFAULT NULL,
    `round_100`                   TINYINT UNSIGNED          DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `idx_season_league_dimension_id` (`season_league_dimension_id`) -- Index on season_league_dimension_id
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
