CREATE TABLE `season_league_dimensions`
(
    `id`             int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`     timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`     timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `season_id`      int unsigned      DEFAULT NULL,
    `season`         varchar(255)      DEFAULT NULL,
    `league_type_id` int unsigned      DEFAULT NULL,
    `league_id`      int unsigned      DEFAULT NULL,
    `league_sort`    varchar(255)      DEFAULT NULL,
    `league_name`    varchar(255)      DEFAULT NULL,
    `national_id`    int unsigned      DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `season_id` (`season_id`, `league_type_id`, `league_id`, `national_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
