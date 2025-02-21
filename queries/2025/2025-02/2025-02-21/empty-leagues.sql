/*
 Navicat MySQL Data Transfer

 Source Server         : MacLocalhost
 Source Server Type    : MySQL
 Source Server Version : 90100
 Source Host           : localhost:3306
 Source Schema         : laravel

 Target Server Type    : MySQL
 Target Server Version : 90100
 File Encoding         : 65001

 Date: 21/02/2025 12:48:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for league_types
-- ----------------------------
DROP TABLE IF EXISTS `league_types`;
CREATE TABLE `league_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of league_types
-- ----------------------------
BEGIN;
INSERT INTO `league_types` VALUES (1, '2025-02-21 12:47:28', '2025-02-21 12:47:28', 'Wizarding World', 'Hogwarts');
INSERT INTO `league_types` VALUES (2, '2025-02-21 12:47:28', '2025-02-21 12:47:28', 'College', 'U.S. colleges and universities');
INSERT INTO `league_types` VALUES (3, '2025-02-21 12:47:28', '2025-02-21 12:47:28', 'Home School', 'Home School');
INSERT INTO `league_types` VALUES (4, '2025-02-21 12:47:28', '2025-02-21 12:47:28', 'High School', 'High School');
COMMIT;

-- ----------------------------
-- Table structure for leagues
-- ----------------------------
DROP TABLE IF EXISTS `leagues`;
CREATE TABLE `leagues` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `league_type_id` int unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `league_type_id` (`league_type_id`),
  CONSTRAINT `leagues_ibfk_1` FOREIGN KEY (`league_type_id`) REFERENCES `league_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of leagues
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
