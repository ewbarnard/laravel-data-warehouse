CREATE TABLE `nationals`
(
    `id`             int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`     timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`     timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `season_id`      int unsigned NOT NULL,
    `league_type_id` int unsigned NOT NULL,
    `discipline_id`  int unsigned NOT NULL,
    `name`           varchar(255) NOT NULL,
    `description`    varchar(255)      DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_season_league_discipline` (`season_id`, `league_type_id`, `discipline_id`),
    KEY `season_id` (`season_id`),
    KEY `league_type_id` (`league_type_id`),
    KEY `discipline_id` (`discipline_id`),
    CONSTRAINT `nationals_ibfk_1` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
    CONSTRAINT `nationals_ibfk_2` FOREIGN KEY (`league_type_id`) REFERENCES `league_types` (`id`),
    CONSTRAINT `nationals_ibfk_3` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
