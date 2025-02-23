CREATE TABLE `season_registration_facts`
(
    `id`                         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `season_league_dimension_id` INT UNSIGNED NOT NULL,
    `team_id`                    INT UNSIGNED NOT NULL,
    `season_roster_id`           INT UNSIGNED NOT NULL UNIQUE,
    `happy_user_role_id`         INT UNSIGNED NOT NULL,
    `happy_user_id`              INT UNSIGNED NOT NULL,
    `discipline_id`              INT UNSIGNED NOT NULL,
    `created_at`                 TIMESTAMP    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`                 TIMESTAMP    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `season_league_dimension_id_idx` (`season_league_dimension_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
