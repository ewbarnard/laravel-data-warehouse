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
