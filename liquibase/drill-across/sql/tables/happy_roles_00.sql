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
