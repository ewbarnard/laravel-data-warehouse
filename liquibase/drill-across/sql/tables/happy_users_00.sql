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
