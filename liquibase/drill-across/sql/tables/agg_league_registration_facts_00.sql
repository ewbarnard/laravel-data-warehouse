CREATE TABLE `agg_league_registration_facts`
(
    `id`                         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at`                 TIMESTAMP    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`                 TIMESTAMP    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `season_league_dimension_id` INT UNSIGNED NOT NULL UNIQUE,
    `t_team_count`               INT UNSIGNED NOT NULL,
    `t_athlete_total`            INT UNSIGNED NOT NULL,
    `t_athlete_unique`           INT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
