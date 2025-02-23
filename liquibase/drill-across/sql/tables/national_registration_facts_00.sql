CREATE TABLE `national_registration_facts`
(
    `id`                       INT UNSIGNED     NOT NULL AUTO_INCREMENT,
    `created_at`               TIMESTAMP        NULL     DEFAULT CURRENT_TIMESTAMP,
    `updated_at`               TIMESTAMP        NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `season_league_dimension_id` int unsigned NOT NULL,
    `national_id`              INT UNSIGNED     NOT NULL,
    `team_id`                  INT UNSIGNED     NOT NULL,
    `season_id`                INT UNSIGNED     NOT NULL,
    `discipline_id`            INT UNSIGNED     NOT NULL,
    `discipline_name` varchar(255) NOT NULL,
    `season_roster_id`         INT UNSIGNED     NOT NULL UNIQUE,
    PRIMARY KEY (`id`),
    KEY `season_league_dimension_id` (`season_league_dimension_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
