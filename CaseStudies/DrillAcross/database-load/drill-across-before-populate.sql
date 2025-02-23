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

 Date: 23/02/2025 08:45:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for agg_league_registration_facts
-- ----------------------------
DROP TABLE IF EXISTS `agg_league_registration_facts`;
CREATE TABLE `agg_league_registration_facts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `season_league_dimension_id` int unsigned NOT NULL,
  `t_team_count` int unsigned NOT NULL,
  `t_athlete_total` int unsigned NOT NULL,
  `t_athlete_unique` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `season_league_dimension_id` (`season_league_dimension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of agg_league_registration_facts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for agg_league_score_facts
-- ----------------------------
DROP TABLE IF EXISTS `agg_league_score_facts`;
CREATE TABLE `agg_league_score_facts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `season_league_dimension_id` int unsigned NOT NULL,
  `t_straight_25` int unsigned NOT NULL,
  `t_straight_50` int unsigned NOT NULL,
  `t_straight_75` int unsigned NOT NULL,
  `t_straight_100` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `season_league_dimension_id` (`season_league_dimension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of agg_league_score_facts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for agg_national_registration_facts
-- ----------------------------
DROP TABLE IF EXISTS `agg_national_registration_facts`;
CREATE TABLE `agg_national_registration_facts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `season_league_dimension_id` int unsigned NOT NULL,
  `t_team_count` int unsigned NOT NULL,
  `t_athlete_total` int unsigned NOT NULL,
  `t_athlete_unique` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `season_league_dimension_id` (`season_league_dimension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of agg_national_registration_facts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for agg_national_score_facts
-- ----------------------------
DROP TABLE IF EXISTS `agg_national_score_facts`;
CREATE TABLE `agg_national_score_facts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `season_league_dimension_id` int unsigned NOT NULL,
  `t_straight_25` int unsigned NOT NULL,
  `t_straight_50` int unsigned NOT NULL,
  `t_straight_75` int unsigned NOT NULL,
  `t_straight_100` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `season_league_dimension_id` (`season_league_dimension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of agg_national_score_facts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for agg_season_registration_facts
-- ----------------------------
DROP TABLE IF EXISTS `agg_season_registration_facts`;
CREATE TABLE `agg_season_registration_facts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `season_league_dimension_id` int unsigned NOT NULL,
  `team_count` int unsigned NOT NULL,
  `athlete_total` int unsigned NOT NULL,
  `athlete_unique` int unsigned NOT NULL,
  `athlete_new` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `season_league_dimension_id` (`season_league_dimension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of agg_season_registration_facts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for agg_season_score_facts
-- ----------------------------
DROP TABLE IF EXISTS `agg_season_score_facts`;
CREATE TABLE `agg_season_score_facts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `season_league_dimension_id` int unsigned NOT NULL,
  `straight_25` int unsigned NOT NULL,
  `straight_50` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `season_league_dimension_id` (`season_league_dimension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of agg_season_score_facts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `databasechangelog`;
CREATE TABLE `databasechangelog` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of databasechangelog
-- ----------------------------
BEGIN;
INSERT INTO `databasechangelog` VALUES ('2025-02-21aa', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 1, 'EXECUTED', '9:71de4fd0c157fa916bb228a0cf97bef4', 'sqlFile path=../sql/tables/league_types_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21ab', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 2, 'EXECUTED', '9:769f6a90e1e01e904f3cd9a2a68341f1', 'sqlFile path=../sql/tables/leagues_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21ac', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 3, 'EXECUTED', '9:23bc5e3aa80d71c89b94cf46a9c331d6', 'sqlFile path=../sql/data/league_types_01.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21ad', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 4, 'EXECUTED', '9:67f701eba34ed2376f693e8fef354b04', 'sqlFile path=../sql/tables/teams_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21ae', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 5, 'EXECUTED', '9:35eac39b871cd71053fa984f0df55fc1', 'sqlFile path=../sql/tables/seasons_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21af', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 6, 'EXECUTED', '9:f2fc925dc491eb66e0315a20ddfd3efa', 'sqlFile path=../sql/tables/discipline_types_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21ag', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 7, 'EXECUTED', '9:d77f4a52f3b01361086867a3608fac87', 'sqlFile path=../sql/data/discipline_types_01.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21ah', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 8, 'EXECUTED', '9:a0a0e0d28caa941af58d16c1181ed21d', 'sqlFile path=../sql/tables/disciplines_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21ai', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 9, 'EXECUTED', '9:8b19a194118451dddfe73c0a2f597147', 'sqlFile path=../sql/tables/nationals_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21aj', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 10, 'EXECUTED', '9:cb0780ad41ef8914db5f8599490fd985', 'sqlFile path=../sql/tables/season_league_dimensions_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21ak', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 11, 'EXECUTED', '9:1caae2ef4c2ee4491b3bd39d1d371d78', 'sqlFile path=../sql/tables/happy_user_role_type_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21al', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 12, 'EXECUTED', '9:6715c2b8b750d8f7f587fc37a75a8249', 'sqlFile path=../sql/data/happy_user_role_type_01.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21am', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 13, 'EXECUTED', '9:35f2a62c0192e704f605fd4d73efb6ee', 'sqlFile path=../sql/tables/happy_roles_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21an', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 14, 'EXECUTED', '9:feebdbaf3f701e9f7bac3f76d1cd1283', 'sqlFile path=../sql/data/happy_roles_01.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21ao', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:16', 15, 'EXECUTED', '9:f16d96c11b9e2cc76cf9dfd40c75ff8a', 'sqlFile path=../sql/tables/happy_users_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-21ap', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 16, 'EXECUTED', '9:ad9ccf97262e8c90baf8a5b0c023d189', 'sqlFile path=../sql/tables/happy_user_roles_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22aa', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 17, 'EXECUTED', '9:733863d03f5de098896f80fcbc970aa8', 'sqlFile path=../sql/tables/season_rosters_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22ab', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 18, 'EXECUTED', '9:b2eb1753e49a0a1909c84aac2c0f1530', 'sqlFile path=../sql/tables/season_registration_facts_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22ac', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 19, 'EXECUTED', '9:7acec94c922076452213f9c035031b51', 'sqlFile path=../sql/tables/season_scores_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22ad', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 20, 'EXECUTED', '9:b355bf40f77c3b42b9a86248109c25a1', 'sqlFile path=../sql/tables/season_score_facts_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22ae', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 21, 'EXECUTED', '9:d6b25bb3d0758adcb8a25b906ce9ddcf', 'sqlFile path=../sql/tables/league_tournaments_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22af', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 22, 'EXECUTED', '9:554c2a1ed39410b4131929a1d52ea4a9', 'sqlFile path=../sql/tables/league_tournament_rosters_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22ag', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 23, 'EXECUTED', '9:5d4e52092e4b0c29d2dca46b12f6c509', 'sqlFile path=../sql/tables/league_registration_facts_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22ah', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 24, 'EXECUTED', '9:22e147af5c9e66b1775eae45b5ec2174', 'sqlFile path=../sql/tables/league_tournament_scores_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22ai', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 25, 'EXECUTED', '9:fcd9c01c61e96b7bfbbe0208cb8bb222', 'sqlFile path=../sql/tables/league_score_facts_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22aj', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 26, 'EXECUTED', '9:0fda9010c1a2b8df817181df682cf4d5', 'sqlFile path=../sql/tables/national_rosters_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22ak', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 27, 'EXECUTED', '9:c0132de8be935e766cbed76016ee6e9a', 'sqlFile path=../sql/tables/national_registration_facts_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22al', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 28, 'EXECUTED', '9:55c0f7add0f855087f694575ab8de0c9', 'sqlFile path=../sql/tables/national_scores_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22am', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 29, 'EXECUTED', '9:d2ede3ad7113129a67c9c91f91787389', 'sqlFile path=../sql/tables/national_score_facts_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22an', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 30, 'EXECUTED', '9:56d4a9cc00b96d4387465271d2b7fd73', 'sqlFile path=../sql/tables/agg_season_registration_facts_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22ao', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 31, 'EXECUTED', '9:8bae6324c5aca2ba52a9b13db29e3fb8', 'sqlFile path=../sql/tables/agg_season_score_facts_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22ap', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 32, 'EXECUTED', '9:25b6ea6eec6ae3c4dc558ae3f339c2d6', 'sqlFile path=../sql/tables/agg_league_registration_facts_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22aq', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 33, 'EXECUTED', '9:d2cfe50b97578000eda182c4645592db', 'sqlFile path=../sql/tables/agg_league_score_facts_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22ar', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 34, 'EXECUTED', '9:6e5dd27641c1de483b807d39dd22862a', 'sqlFile path=../sql/tables/agg_national_registration_facts_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
INSERT INTO `databasechangelog` VALUES ('2025-02-22as', 'ewbarnard', 'drill-across/changesets/2025-02-21.xml', '2025-02-23 08:41:17', 35, 'EXECUTED', '9:e74ea466a14a8f717cddc0e9a4c265ec', 'sqlFile path=../sql/tables/agg_national_score_facts_00.sql', '', NULL, '4.25.1', NULL, NULL, '0321676586');
COMMIT;

-- ----------------------------
-- Table structure for databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `databasechangeloglock`;
CREATE TABLE `databasechangeloglock` (
  `ID` int NOT NULL,
  `LOCKED` tinyint NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of databasechangeloglock
-- ----------------------------
BEGIN;
INSERT INTO `databasechangeloglock` VALUES (1, 0, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for discipline_types
-- ----------------------------
DROP TABLE IF EXISTS `discipline_types`;
CREATE TABLE `discipline_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of discipline_types
-- ----------------------------
BEGIN;
INSERT INTO `discipline_types` VALUES (1, '2025-02-23 08:41:16', '2025-02-23 08:41:16', '5-Stand', NULL);
INSERT INTO `discipline_types` VALUES (2, '2025-02-23 08:41:16', '2025-02-23 08:41:16', 'Skeet', NULL);
INSERT INTO `discipline_types` VALUES (3, '2025-02-23 08:41:16', '2025-02-23 08:41:16', 'Sporting Clays', NULL);
INSERT INTO `discipline_types` VALUES (4, '2025-02-23 08:41:16', '2025-02-23 08:41:16', 'Trap', NULL);
COMMIT;

-- ----------------------------
-- Table structure for disciplines
-- ----------------------------
DROP TABLE IF EXISTS `disciplines`;
CREATE TABLE `disciplines` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `league_type_id` int unsigned NOT NULL,
  `discipline_type_id` int unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`league_type_id`) USING BTREE,
  KEY `league_type_id` (`league_type_id`),
  KEY `discipline_type_id` (`discipline_type_id`),
  CONSTRAINT `disciplines_ibfk_1` FOREIGN KEY (`league_type_id`) REFERENCES `league_types` (`id`),
  CONSTRAINT `disciplines_ibfk_2` FOREIGN KEY (`discipline_type_id`) REFERENCES `discipline_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of disciplines
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for happy_roles
-- ----------------------------
DROP TABLE IF EXISTS `happy_roles`;
CREATE TABLE `happy_roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `happy_user_role_type_id` int unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `happy_user_role_type_id` (`happy_user_role_type_id`),
  CONSTRAINT `happy_roles_ibfk_1` FOREIGN KEY (`happy_user_role_type_id`) REFERENCES `happy_user_role_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of happy_roles
-- ----------------------------
BEGIN;
INSERT INTO `happy_roles` VALUES (1, '2025-02-23 08:41:16', '2025-02-23 08:41:16', 1, 'Athlete', 'Athlete');
COMMIT;

-- ----------------------------
-- Table structure for happy_user_role_type
-- ----------------------------
DROP TABLE IF EXISTS `happy_user_role_type`;
CREATE TABLE `happy_user_role_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of happy_user_role_type
-- ----------------------------
BEGIN;
INSERT INTO `happy_user_role_type` VALUES (1, '2025-02-23 08:41:16', '2025-02-23 08:41:16', 'Athlete', 'Athlete');
COMMIT;

-- ----------------------------
-- Table structure for happy_user_roles
-- ----------------------------
DROP TABLE IF EXISTS `happy_user_roles`;
CREATE TABLE `happy_user_roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `team_id` int unsigned NOT NULL,
  `happy_user_id` int unsigned NOT NULL,
  `happy_role_id` int unsigned NOT NULL,
  `is_active` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `team_id` (`team_id`),
  KEY `happy_user_id` (`happy_user_id`),
  KEY `happy_role_id` (`happy_role_id`),
  CONSTRAINT `happy_user_roles_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `happy_user_roles_ibfk_2` FOREIGN KEY (`happy_user_id`) REFERENCES `happy_users` (`id`),
  CONSTRAINT `happy_user_roles_ibfk_3` FOREIGN KEY (`happy_role_id`) REFERENCES `happy_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of happy_user_roles
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for happy_users
-- ----------------------------
DROP TABLE IF EXISTS `happy_users`;
CREATE TABLE `happy_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of happy_users
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for league_registration_facts
-- ----------------------------
DROP TABLE IF EXISTS `league_registration_facts`;
CREATE TABLE `league_registration_facts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `season_league_dimension_id` int unsigned NOT NULL,
  `league_tournament_id` int unsigned NOT NULL,
  `team_id` int unsigned NOT NULL,
  `season_id` int unsigned NOT NULL,
  `discipline_id` int unsigned NOT NULL,
  `discipline_name` varchar(255) NOT NULL,
  `season_roster_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `season_roster_id` (`season_roster_id`),
  KEY `season_league_dimension_id` (`season_league_dimension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of league_registration_facts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for league_score_facts
-- ----------------------------
DROP TABLE IF EXISTS `league_score_facts`;
CREATE TABLE `league_score_facts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `season_league_dimension_id` int unsigned NOT NULL,
  `league_tournament_score_id` int unsigned NOT NULL,
  `league_tournament_id` int unsigned NOT NULL,
  `league_tournament_roster_id` int unsigned NOT NULL,
  `team_id` int unsigned NOT NULL,
  `season_id` int unsigned NOT NULL,
  `discipline_id` int unsigned NOT NULL,
  `discipline_name` varchar(255) NOT NULL,
  `season_roster_id` int unsigned NOT NULL,
  `s1round1` tinyint unsigned DEFAULT NULL,
  `s1round2` tinyint unsigned DEFAULT NULL,
  `s1total_score` tinyint unsigned DEFAULT NULL,
  `s2round1` tinyint unsigned DEFAULT NULL,
  `s2round2` tinyint unsigned DEFAULT NULL,
  `s2total_score` tinyint unsigned DEFAULT NULL,
  `total_score` tinyint unsigned DEFAULT NULL,
  `s1round1_25` tinyint unsigned DEFAULT NULL,
  `s1round2_25` tinyint unsigned DEFAULT NULL,
  `s2round1_25` tinyint unsigned DEFAULT NULL,
  `s2round2_25` tinyint unsigned DEFAULT NULL,
  `round_50` tinyint unsigned DEFAULT NULL,
  `round_75` tinyint unsigned DEFAULT NULL,
  `round_100` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `league_tournament_score_id` (`league_tournament_score_id`),
  UNIQUE KEY `season_roster_id` (`season_roster_id`),
  KEY `idx_season_league_dimension_id` (`season_league_dimension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of league_score_facts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for league_tournament_rosters
-- ----------------------------
DROP TABLE IF EXISTS `league_tournament_rosters`;
CREATE TABLE `league_tournament_rosters` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `league_tournament_id` int unsigned NOT NULL,
  `team_id` int unsigned NOT NULL,
  `season_id` int unsigned NOT NULL,
  `discipline_id` int unsigned NOT NULL,
  `season_roster_id` int unsigned NOT NULL,
  `is_registration_complete` tinyint unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `season_roster_id` (`season_roster_id`),
  KEY `league_tournament_id` (`league_tournament_id`),
  KEY `team_id` (`team_id`),
  KEY `season_id` (`season_id`),
  KEY `discipline_id` (`discipline_id`),
  CONSTRAINT `league_tournament_rosters_ibfk_1` FOREIGN KEY (`league_tournament_id`) REFERENCES `league_tournaments` (`id`),
  CONSTRAINT `league_tournament_rosters_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `league_tournament_rosters_ibfk_3` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
  CONSTRAINT `league_tournament_rosters_ibfk_4` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`),
  CONSTRAINT `league_tournament_rosters_ibfk_5` FOREIGN KEY (`season_roster_id`) REFERENCES `season_rosters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of league_tournament_rosters
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for league_tournament_scores
-- ----------------------------
DROP TABLE IF EXISTS `league_tournament_scores`;
CREATE TABLE `league_tournament_scores` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `league_tournament_id` int unsigned NOT NULL,
  `league_tournament_roster_id` int unsigned NOT NULL,
  `team_id` int unsigned NOT NULL,
  `season_id` int unsigned NOT NULL,
  `discipline_id` int unsigned NOT NULL,
  `discipline_name` varchar(255) NOT NULL,
  `season_roster_id` int unsigned NOT NULL,
  `participated` tinyint unsigned NOT NULL DEFAULT '0',
  `s1round1` tinyint unsigned DEFAULT NULL,
  `s1round2` tinyint unsigned DEFAULT NULL,
  `s1total_score` tinyint unsigned DEFAULT NULL,
  `s2round1` tinyint unsigned DEFAULT NULL,
  `s2round2` tinyint unsigned DEFAULT NULL,
  `s2total_score` tinyint unsigned DEFAULT NULL,
  `total_score` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `season_roster_id` (`season_roster_id`),
  KEY `league_tournament_id` (`league_tournament_id`),
  KEY `league_tournament_roster_id` (`league_tournament_roster_id`),
  KEY `team_id` (`team_id`),
  KEY `season_id` (`season_id`),
  KEY `discipline_id` (`discipline_id`),
  CONSTRAINT `league_tournament_scores_ibfk_1` FOREIGN KEY (`league_tournament_id`) REFERENCES `league_tournaments` (`id`),
  CONSTRAINT `league_tournament_scores_ibfk_2` FOREIGN KEY (`league_tournament_roster_id`) REFERENCES `league_tournament_rosters` (`id`),
  CONSTRAINT `league_tournament_scores_ibfk_3` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `league_tournament_scores_ibfk_4` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
  CONSTRAINT `league_tournament_scores_ibfk_5` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`),
  CONSTRAINT `league_tournament_scores_ibfk_6` FOREIGN KEY (`season_roster_id`) REFERENCES `season_rosters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of league_tournament_scores
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for league_tournaments
-- ----------------------------
DROP TABLE IF EXISTS `league_tournaments`;
CREATE TABLE `league_tournaments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `season_id` int unsigned NOT NULL,
  `league_type_id` int unsigned NOT NULL,
  `league_id` int unsigned NOT NULL,
  `discipline_id` int unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_season_league_discipline` (`season_id`,`league_id`,`discipline_id`),
  KEY `league_type_id` (`league_type_id`),
  KEY `league_id` (`league_id`),
  KEY `discipline_id` (`discipline_id`),
  CONSTRAINT `league_tournaments_ibfk_1` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
  CONSTRAINT `league_tournaments_ibfk_2` FOREIGN KEY (`league_type_id`) REFERENCES `league_types` (`id`),
  CONSTRAINT `league_tournaments_ibfk_3` FOREIGN KEY (`league_id`) REFERENCES `leagues` (`id`),
  CONSTRAINT `league_tournaments_ibfk_4` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of league_tournaments
-- ----------------------------
BEGIN;
COMMIT;

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
INSERT INTO `league_types` VALUES (1, '2025-02-23 08:41:16', '2025-02-23 08:41:16', 'Wizarding World', 'Hogwarts');
INSERT INTO `league_types` VALUES (2, '2025-02-23 08:41:16', '2025-02-23 08:41:16', 'College', 'U.S. colleges and universities');
INSERT INTO `league_types` VALUES (3, '2025-02-23 08:41:16', '2025-02-23 08:41:16', 'Home School', 'Home School');
INSERT INTO `league_types` VALUES (4, '2025-02-23 08:41:16', '2025-02-23 08:41:16', 'High School', 'High School');
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

-- ----------------------------
-- Table structure for national_registration_facts
-- ----------------------------
DROP TABLE IF EXISTS `national_registration_facts`;
CREATE TABLE `national_registration_facts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `season_league_dimension_id` int unsigned NOT NULL,
  `national_id` int unsigned NOT NULL,
  `team_id` int unsigned NOT NULL,
  `season_id` int unsigned NOT NULL,
  `discipline_id` int unsigned NOT NULL,
  `discipline_name` varchar(255) NOT NULL,
  `season_roster_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `season_roster_id` (`season_roster_id`),
  KEY `season_league_dimension_id` (`season_league_dimension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of national_registration_facts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for national_rosters
-- ----------------------------
DROP TABLE IF EXISTS `national_rosters`;
CREATE TABLE `national_rosters` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `national_id` int unsigned NOT NULL,
  `team_id` int unsigned NOT NULL,
  `season_id` int unsigned NOT NULL,
  `discipline_id` int unsigned NOT NULL,
  `season_roster_id` int unsigned NOT NULL,
  `is_registration_complete` tinyint unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `season_roster_id` (`season_roster_id`),
  KEY `national_id` (`national_id`),
  KEY `team_id` (`team_id`),
  KEY `season_id` (`season_id`),
  KEY `discipline_id` (`discipline_id`),
  CONSTRAINT `national_rosters_ibfk_1` FOREIGN KEY (`national_id`) REFERENCES `nationals` (`id`),
  CONSTRAINT `national_rosters_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `national_rosters_ibfk_3` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
  CONSTRAINT `national_rosters_ibfk_4` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`),
  CONSTRAINT `national_rosters_ibfk_5` FOREIGN KEY (`season_roster_id`) REFERENCES `season_rosters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of national_rosters
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for national_score_facts
-- ----------------------------
DROP TABLE IF EXISTS `national_score_facts`;
CREATE TABLE `national_score_facts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `season_league_dimension_id` int unsigned NOT NULL,
  `national_score_id` int unsigned NOT NULL,
  `national_id` int unsigned NOT NULL,
  `national_roster_id` int unsigned NOT NULL,
  `team_id` int unsigned NOT NULL,
  `season_id` int unsigned NOT NULL,
  `discipline_id` int unsigned NOT NULL,
  `discipline_name` varchar(255) NOT NULL,
  `season_roster_id` int unsigned NOT NULL,
  `s1round1` tinyint unsigned DEFAULT NULL,
  `s1round2` tinyint unsigned DEFAULT NULL,
  `s1total_score` tinyint unsigned DEFAULT NULL,
  `s2round1` tinyint unsigned DEFAULT NULL,
  `s2round2` tinyint unsigned DEFAULT NULL,
  `s2total_score` tinyint unsigned DEFAULT NULL,
  `total_score` tinyint unsigned DEFAULT NULL,
  `s1round1_25` tinyint unsigned DEFAULT NULL,
  `s1round2_25` tinyint unsigned DEFAULT NULL,
  `s2round1_25` tinyint unsigned DEFAULT NULL,
  `s2round2_25` tinyint unsigned DEFAULT NULL,
  `round_50` tinyint unsigned DEFAULT NULL,
  `round_75` tinyint unsigned DEFAULT NULL,
  `round_100` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `national_score_id` (`national_score_id`),
  KEY `idx_season_league_dimension_id` (`season_league_dimension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of national_score_facts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for national_scores
-- ----------------------------
DROP TABLE IF EXISTS `national_scores`;
CREATE TABLE `national_scores` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `national_id` int unsigned NOT NULL,
  `national_roster_id` int unsigned NOT NULL,
  `team_id` int unsigned NOT NULL,
  `season_id` int unsigned NOT NULL,
  `discipline_id` int unsigned NOT NULL,
  `discipline_name` varchar(255) NOT NULL,
  `season_roster_id` int unsigned NOT NULL,
  `participated` tinyint unsigned NOT NULL DEFAULT '0',
  `s1round1` tinyint unsigned DEFAULT NULL,
  `s1round2` tinyint unsigned DEFAULT NULL,
  `s1total_score` tinyint unsigned DEFAULT NULL,
  `s2round1` tinyint unsigned DEFAULT NULL,
  `s2round2` tinyint unsigned DEFAULT NULL,
  `s2total_score` tinyint unsigned DEFAULT NULL,
  `total_score` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `national_id` (`national_id`),
  KEY `national_roster_id` (`national_roster_id`),
  KEY `team_id` (`team_id`),
  KEY `season_id` (`season_id`),
  KEY `discipline_id` (`discipline_id`),
  KEY `national_scores_ibfk_6` (`season_roster_id`),
  CONSTRAINT `national_scores_ibfk_1` FOREIGN KEY (`national_id`) REFERENCES `nationals` (`id`),
  CONSTRAINT `national_scores_ibfk_2` FOREIGN KEY (`national_roster_id`) REFERENCES `national_rosters` (`id`),
  CONSTRAINT `national_scores_ibfk_3` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `national_scores_ibfk_4` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
  CONSTRAINT `national_scores_ibfk_5` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`),
  CONSTRAINT `national_scores_ibfk_6` FOREIGN KEY (`season_roster_id`) REFERENCES `season_rosters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of national_scores
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for nationals
-- ----------------------------
DROP TABLE IF EXISTS `nationals`;
CREATE TABLE `nationals` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `season_id` int unsigned NOT NULL,
  `league_type_id` int unsigned NOT NULL,
  `discipline_id` int unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_season_league_discipline` (`season_id`,`league_type_id`,`discipline_id`),
  KEY `season_id` (`season_id`),
  KEY `league_type_id` (`league_type_id`),
  KEY `discipline_id` (`discipline_id`),
  CONSTRAINT `nationals_ibfk_1` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
  CONSTRAINT `nationals_ibfk_2` FOREIGN KEY (`league_type_id`) REFERENCES `league_types` (`id`),
  CONSTRAINT `nationals_ibfk_3` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of nationals
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for season_league_dimensions
-- ----------------------------
DROP TABLE IF EXISTS `season_league_dimensions`;
CREATE TABLE `season_league_dimensions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `season_id` int unsigned DEFAULT NULL,
  `season` varchar(255) DEFAULT NULL,
  `league_type_id` int unsigned DEFAULT NULL,
  `league_id` int unsigned DEFAULT NULL,
  `league_sort` varchar(255) DEFAULT NULL,
  `league_name` varchar(255) DEFAULT NULL,
  `national_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `season_id` (`season_id`,`league_type_id`,`league_id`,`national_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of season_league_dimensions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for season_registration_facts
-- ----------------------------
DROP TABLE IF EXISTS `season_registration_facts`;
CREATE TABLE `season_registration_facts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `season_league_dimension_id` int unsigned NOT NULL,
  `team_id` int unsigned NOT NULL,
  `season_roster_id` int unsigned NOT NULL,
  `happy_user_role_id` int unsigned NOT NULL,
  `happy_user_id` int unsigned NOT NULL,
  `discipline_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `season_roster_id` (`season_roster_id`),
  KEY `season_league_dimension_id_idx` (`season_league_dimension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of season_registration_facts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for season_rosters
-- ----------------------------
DROP TABLE IF EXISTS `season_rosters`;
CREATE TABLE `season_rosters` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `team_id` int unsigned NOT NULL,
  `season_id` int unsigned NOT NULL,
  `discipline_id` int unsigned NOT NULL,
  `happy_user_role_id` int unsigned NOT NULL,
  `is_registration_complete` tinyint unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_team_season_discipline_user_role` (`team_id`,`season_id`,`discipline_id`,`happy_user_role_id`),
  KEY `season_id` (`season_id`),
  KEY `discipline_id` (`discipline_id`),
  KEY `happy_user_role_id` (`happy_user_role_id`),
  CONSTRAINT `season_rosters_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `season_rosters_ibfk_2` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
  CONSTRAINT `season_rosters_ibfk_3` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`),
  CONSTRAINT `season_rosters_ibfk_4` FOREIGN KEY (`happy_user_role_id`) REFERENCES `happy_user_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of season_rosters
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for season_score_facts
-- ----------------------------
DROP TABLE IF EXISTS `season_score_facts`;
CREATE TABLE `season_score_facts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `season_league_dimension_id` int unsigned NOT NULL,
  `team_id` int unsigned NOT NULL,
  `season_id` int unsigned NOT NULL,
  `discipline_id` int unsigned NOT NULL,
  `discipline_name` varchar(255) NOT NULL,
  `happy_user_role_id` int unsigned NOT NULL,
  `season_score_id` int unsigned NOT NULL,
  `scoring_week` tinyint unsigned NOT NULL,
  `round1` tinyint unsigned DEFAULT NULL,
  `round2` tinyint unsigned DEFAULT NULL,
  `round1_25` tinyint unsigned DEFAULT NULL,
  `round2_25` tinyint unsigned DEFAULT NULL,
  `round_50` tinyint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `season_league_dimension_id` (`season_league_dimension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of season_score_facts
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for season_scores
-- ----------------------------
DROP TABLE IF EXISTS `season_scores`;
CREATE TABLE `season_scores` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `team_id` int unsigned NOT NULL,
  `season_id` int unsigned NOT NULL,
  `discipline_id` int unsigned NOT NULL,
  `happy_user_role_id` int unsigned NOT NULL,
  `scoring_week` tinyint unsigned NOT NULL,
  `participated` tinyint unsigned NOT NULL DEFAULT '0',
  `round1` tinyint unsigned DEFAULT NULL,
  `round2` tinyint unsigned DEFAULT NULL,
  `total_score` smallint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_team_season_discipline_user_role_week` (`team_id`,`season_id`,`discipline_id`,`happy_user_role_id`,`scoring_week`),
  KEY `season_id` (`season_id`),
  KEY `discipline_id` (`discipline_id`),
  KEY `happy_user_role_id` (`happy_user_role_id`),
  CONSTRAINT `season_scores_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`),
  CONSTRAINT `season_scores_ibfk_2` FOREIGN KEY (`season_id`) REFERENCES `seasons` (`id`),
  CONSTRAINT `season_scores_ibfk_3` FOREIGN KEY (`discipline_id`) REFERENCES `disciplines` (`id`),
  CONSTRAINT `season_scores_ibfk_4` FOREIGN KEY (`happy_user_role_id`) REFERENCES `happy_user_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of season_scores
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for seasons
-- ----------------------------
DROP TABLE IF EXISTS `seasons`;
CREATE TABLE `seasons` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(255) NOT NULL,
  `year` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `season_of_year` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of seasons
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for teams
-- ----------------------------
DROP TABLE IF EXISTS `teams`;
CREATE TABLE `teams` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `league_id` int unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`league_id`) USING BTREE,
  KEY `league_id` (`league_id`),
  CONSTRAINT `teams_ibfk_1` FOREIGN KEY (`league_id`) REFERENCES `leagues` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of teams
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
