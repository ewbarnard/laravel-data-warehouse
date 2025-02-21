CREATE TABLE `seasons`
(
    `id`             int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`     timestamp    NULL                                             DEFAULT CURRENT_TIMESTAMP,
    `updated_at`     timestamp    NULL                                             DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `name`           varchar(255) NOT NULL,
    `year`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
    `season_of_year` varchar(255)                                                  DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
