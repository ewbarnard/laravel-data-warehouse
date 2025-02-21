CREATE TABLE `disciplines`
(
    `id`                 int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`         timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`         timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `league_type_id`     int unsigned NOT NULL,
    `discipline_type_id` int unsigned      DEFAULT NULL,
    `name`               varchar(255) NOT NULL,
    `description`        varchar(255)      DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`, `league_type_id`) USING BTREE,
    KEY `league_type_id` (`league_type_id`),
    KEY `discipline_type_id` (`discipline_type_id`),
    CONSTRAINT `disciplines_ibfk_1` FOREIGN KEY (`league_type_id`) REFERENCES `league_types` (`id`),
    CONSTRAINT `disciplines_ibfk_2` FOREIGN KEY (`discipline_type_id`) REFERENCES `discipline_types` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
