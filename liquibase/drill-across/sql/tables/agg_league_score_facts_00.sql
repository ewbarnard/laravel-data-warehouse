CREATE TABLE `agg_league_score_facts`
(
    `id`                         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at`                 TIMESTAMP    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`                 TIMESTAMP    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `season_league_dimension_id` INT UNSIGNED NOT NULL UNIQUE,
    `t_straight_25`              INT UNSIGNED NOT NULL,
    `t_straight_50`              INT UNSIGNED NOT NULL,
    `t_straight_75`              INT UNSIGNED NOT NULL,
    `t_straight_100`             INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
