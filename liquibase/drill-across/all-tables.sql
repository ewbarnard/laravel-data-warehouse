CREATE TABLE `discipline_types`
(
    `id`          int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`  timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`  timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `name`        varchar(255) NOT NULL,
    `description` varchar(255)      DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
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
CREATE TABLE `happy_roles`
(
    `id`                      int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`              timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`              timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `happy_user_role_type_id` int unsigned NOT NULL,
    `name`                    varchar(255) NOT NULL,
    `description`             varchar(255)      DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`),
    KEY `happy_user_role_type_id` (`happy_user_role_type_id`),
    CONSTRAINT `happy_roles_ibfk_1` FOREIGN KEY (`happy_user_role_type_id`) REFERENCES `happy_user_role_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE `happy_user_role_type`
(
    `id`          int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`  timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`  timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `name`        varchar(255) NOT NULL,
    `description` varchar(255)      DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE `happy_user_roles`
(
    `id`            int unsigned     NOT NULL AUTO_INCREMENT,
    `created_at`    timestamp        NULL     DEFAULT CURRENT_TIMESTAMP,
    `updated_at`    timestamp        NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `team_id`       int unsigned     NOT NULL,
    `happy_user_id` int unsigned     NOT NULL,
    `happy_role_id` int unsigned     NOT NULL,
    `is_active`     tinyint unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    KEY `team_id` (`team_id`),
    KEY `happy_user_id` (`happy_user_id`),
    KEY `happy_role_id` (`happy_role_id`),
    CONSTRAINT `happy_user_roles_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
    CONSTRAINT `happy_user_roles_ibfk_2` FOREIGN KEY (`happy_user_id`) REFERENCES `happy_users` (`id`),
    CONSTRAINT `happy_user_roles_ibfk_3` FOREIGN KEY (`happy_role_id`) REFERENCES `happy_roles` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE `happy_users`
(
    `id`         int unsigned                                                  NOT NULL AUTO_INCREMENT,
    `created_at` timestamp                                                     NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp                                                     NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `user_name`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `user_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci      DEFAULT NULL,
    `password`   varchar(255)                                                       DEFAULT NULL,
    `first_name` varchar(255)                                                       DEFAULT NULL,
    `last_name`  varchar(255)                                                       DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `user_name` (`user_name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE `league_types`
(
    `id`          int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`  timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`  timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `name`        varchar(255) NOT NULL,
    `description` varchar(255)      DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
CREATE TABLE `leagues`
(
    `id`             int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`     timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`     timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `league_type_id` int unsigned NOT NULL,
    `name`           varchar(255) NOT NULL,
    `description`    varchar(255)      DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `name` (`name`),
    KEY `league_type_id` (`league_type_id`),
    CONSTRAINT `leagues_ibfk_1` FOREIGN KEY (`league_type_id`) REFERENCES `league_types` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;
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
