CREATE TABLE `teams`
(
    `id`          int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`  timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`  timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `league_id`   int unsigned NOT NULL,
    `name`        varchar(255) NOT NULL,
    `description` varchar(255)      DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`, `league_id`) USING BTREE,
    KEY `league_id` (`league_id`),
    CONSTRAINT `teams_ibfk_1` FOREIGN KEY (`league_id`) REFERENCES `leagues` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
