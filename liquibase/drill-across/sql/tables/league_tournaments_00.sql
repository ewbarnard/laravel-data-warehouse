CREATE TABLE `league_tournaments`
(
    `id`             INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_at`     TIMESTAMP    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`     TIMESTAMP    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `season_id`      INT UNSIGNED NOT NULL,
    `league_type_id` INT UNSIGNED NOT NULL,
    `league_id`      INT UNSIGNED NOT NULL,
    `discipline_id`  INT UNSIGNED NOT NULL,
    `name`           VARCHAR(255) NOT NULL,
    `description`    VARCHAR(255)      DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_season_league_discipline` (`season_id`, `league_id`, `discipline_id`),
    KEY `league_type_id` (`league_type_id`),
    KEY `league_id` (`league_id`),
    KEY `discipline_id` (`discipline_id`),
    CONSTRAINT `league_tournaments_ibfk_1` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
    CONSTRAINT `league_tournaments_ibfk_2` FOREIGN KEY (`league_type_id`) REFERENCES `league_types` (`id`),
    CONSTRAINT `league_tournaments_ibfk_3` FOREIGN KEY (`league_id`) REFERENCES `leagues` (`id`),
    CONSTRAINT `league_tournaments_ibfk_4` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
