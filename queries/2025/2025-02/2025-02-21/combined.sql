
CREATE TEMPORARY TABLE `patch_dimensions`
(
    `id`                     int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`             timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`             timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `season_id`              int unsigned      DEFAULT NULL,
    `season`                 varchar(255)      DEFAULT NULL,
    `league_type_id`         int unsigned      DEFAULT NULL,
    `league_id`              int unsigned      DEFAULT NULL,
    `league_sort`            varchar(255)      DEFAULT NULL,
    `league_name`            varchar(255)      DEFAULT NULL,
    `tournament_national_id` int unsigned      DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

insert into patch_dimensions
(season_id, season, league_type_id, league_id, league_sort, league_name, tournament_national_id)
SELECT sr.season_id,
       s.season,
       l.league_type_id,
       tu.league_id,
       concat_ws(':',
                 'league',
                 l.league_description) league_sort,
       l.league_description            league_name,
       '0'                             tournament_national_id
FROM seasons s
         INNER JOIN season_rosters sr
                    ON sr.season_id = s.id
         INNER JOIN TeamUser tu
                    ON tu.id = sr.team_id
         INNER JOIN leagues l
                    ON l.id = tu.league_id
WHERE s.is_active = 1
  AND s.is_data_accessible = 1
GROUP BY sr.season_id,
         l.league_type_id,
         tu.league_id
UNION
SELECT tn.season_id,
       s.season,
       tn.league_type_id,
       '0'                            league_id,
       CONCAT_WS(':',
                 'national',
                 LPAD(tn.id, 5, '0')) league_sort,
       CONCAT_WS(' ',
                 lt.description,
                 d.`name`,
                 tn.tournament_name)  league_name,
       tn.id                          tournament_national_id
FROM tournament_nationals tn
         INNER JOIN league_types lt
                    ON tn.league_type_id = lt.id
         INNER JOIN seasons s
                    ON s.id = tn.season_id
         INNER JOIN disciplines d
                    ON d.id = tn.discipline_id
WHERE s.is_active = 1
  AND s.is_data_accessible = 1
ORDER BY season_id,
         league_type_id,
         league_sort;
CREATE TEMPORARY TABLE `patch_season_registrations`
(
    `id`                 int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`         timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`         timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `patch_dimension_id` int unsigned      DEFAULT NULL,
    `team_id`            int unsigned      DEFAULT NULL,
    `season_roster_id`   int unsigned      DEFAULT NULL,
    `team_member_id`     int unsigned      DEFAULT NULL,
    `user_id`            int unsigned      DEFAULT NULL,
    `discipline_id`      int unsigned      DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `patch_dimension_id` (`patch_dimension_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

insert into patch_season_registrations
(patch_dimension_id, team_id, season_roster_id, team_member_id, user_id, discipline_id)
SELECT pd.id patch_dimension_id,
       sr.team_id,
       sr.id season_roster_id,
       sr.team_member_id,
       u.ID  user_id,
       sr.discipline_id
FROM season_rosters sr
         INNER JOIN disciplines d ON d.id = sr.discipline_id
         INNER JOIN TeamMember tm ON tm.id = sr.team_member_id
         INNER JOIN TeamUser tu ON tu.ID = sr.team_id
         INNER JOIN USER u ON u.ID = tm.UserID
         INNER JOIN UserRole ur ON ur.UserID = u.ID
    AND ur.TeamID = sr.team_id
    AND ur.RoleID = 3
    AND ur.Active = 1
         INNER JOIN leagues lg ON lg.id = tu.league_id
         LEFT JOIN refund_request rr ON rr.team_roster_id = sr.id
         INNER JOIN patch_dimensions pd ON pd.season_id = sr.season_id
    AND pd.league_id = tu.league_id
WHERE sr.is_active = 1
  AND ur.Active = 1
  AND (rr.id IS NULL OR rr.is_active = 0)
  AND sr.registration_completed = 1
ORDER BY pd.id,
         sr.team_id,
         sr.team_member_id,
         sr.discipline_id;

CREATE TEMPORARY TABLE patch_season_registrations_copy1 AS
SELECT *
FROM patch_season_registrations;

CREATE TEMPORARY TABLE patch_season_registrations_copy2 AS
SELECT *
FROM patch_season_registrations;

CREATE TEMPORARY TABLE patch_season_registrations_copy3 AS
SELECT *
FROM patch_season_registrations;

CREATE TEMPORARY TABLE patch_season_registrations_copy4 AS
SELECT *
FROM patch_season_registrations;
CREATE TEMPORARY TABLE `patch_season_scores`
(
    `id`                 int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`         timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`         timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `patch_dimension_id` int unsigned      DEFAULT NULL,
    `season_roster_id`   int unsigned      DEFAULT NULL,
    `discipline_name`    varchar(255)      DEFAULT NULL,
    `scoring_week`       tinyint unsigned  DEFAULT NULL,
    `round1`             tinyint unsigned  DEFAULT NULL,
    `round2`             tinyint unsigned  DEFAULT NULL,
    `round1_25`          tinyint unsigned  DEFAULT NULL,
    `round2_25`          tinyint unsigned  DEFAULT NULL,
    `round_50`           tinyint unsigned  DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `patch_dimension_id` (`patch_dimension_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

insert into patch_season_scores
(patch_dimension_id, season_roster_id, discipline_name, scoring_week, round1, round2, round1_25, round2_25, round_50)
SELECT psr.patch_dimension_id,
       se.season_roster_id,
       d.`name`                                     discipline_name,
       '1'                                          scoring_week,
       se.week_1_round1                             round1,
       se.week_1_round2                             round2,
       CASE

           WHEN se.week_1_round1 IS NULL THEN 0
           WHEN d.`name` = 'Sporting Clays' THEN 0
           WHEN se.week_1_round1 = 25 THEN 1
           ELSE 0
           END                                      round1_25,
       CASE

           WHEN se.week_1_round2 IS NULL THEN 0
           WHEN d.`name` = 'Sporting Clays' THEN 0
           WHEN se.week_1_round2 = 25 THEN 1
           ELSE 0
           END                                      round2_25,
       IF
       ((COALESCE(se.week_1_round1, 0) +
         COALESCE(se.week_1_round2, 0)) = 50, 1, 0) round_50
FROM patch_season_registrations psr
         INNER JOIN score_entries se ON se.season_roster_id = psr.season_roster_id
         INNER JOIN disciplines d ON d.id = se.discipline_id
UNION ALL
SELECT psr1.patch_dimension_id,
       se.season_roster_id,
       d.`name`                                     discipline_name,
       '2'                                          scoring_week,
       se.week_2_round1                             round1,
       se.week_2_round2                             round2,
       CASE

           WHEN se.week_2_round1 IS NULL THEN 0
           WHEN d.`name` = 'Sporting Clays' THEN 0
           WHEN se.week_2_round1 = 25 THEN 1
           ELSE 0
           END                                      round1_25,
       CASE

           WHEN se.week_2_round2 IS NULL THEN 0
           WHEN d.`name` = 'Sporting Clays' THEN 0
           WHEN se.week_2_round2 = 25 THEN 1
           ELSE 0
           END                                      round2_25,
       IF
       ((COALESCE(se.week_2_round1, 0) +
         COALESCE(se.week_2_round2, 0)) = 50, 1, 0) round_50
FROM patch_season_registrations_copy1 psr1
         INNER JOIN score_entries se ON se.season_roster_id = psr1.season_roster_id
         INNER JOIN disciplines d ON d.id = se.discipline_id
UNION ALL
SELECT psr2.patch_dimension_id,
       se.season_roster_id,
       d.`name`                                     discipline_name,
       '3'                                          scoring_week,
       se.week_3_round1                             round1,
       se.week_3_round2                             round2,
       CASE

           WHEN se.week_3_round1 IS NULL THEN 0
           WHEN d.`name` = 'Sporting Clays' THEN 0
           WHEN se.week_3_round1 = 25 THEN 1
           ELSE 0
           END                                      round1_25,
       CASE

           WHEN se.week_3_round2 IS NULL THEN 0
           WHEN d.`name` = 'Sporting Clays' THEN 0
           WHEN se.week_3_round2 = 25 THEN 1
           ELSE 0
           END                                      round2_25,
       IF
       ((COALESCE(se.week_3_round1, 0) +
         COALESCE(se.week_3_round2, 0)) = 50, 1, 0) round_50
FROM patch_season_registrations_copy2 psr2
         INNER JOIN score_entries se ON se.season_roster_id = psr2.season_roster_id
         INNER JOIN disciplines d ON d.id = se.discipline_id
UNION ALL
SELECT psr3.patch_dimension_id,
       se.season_roster_id,
       d.`name`                                     discipline_name,
       '4'                                          scoring_week,
       se.week_4_round1                             round1,
       se.week_4_round2                             round2,
       CASE

           WHEN se.week_4_round1 IS NULL THEN 0
           WHEN d.`name` = 'Sporting Clays' THEN 0
           WHEN se.week_4_round1 = 25 THEN 1
           ELSE 0
           END                                      round1_25,
       CASE

           WHEN se.week_4_round2 IS NULL THEN 0
           WHEN d.`name` = 'Sporting Clays' THEN 0
           WHEN se.week_4_round2 = 25 THEN 1
           ELSE 0
           END                                      round2_25,
       IF
       ((COALESCE(se.week_4_round1, 0) +
         COALESCE(se.week_4_round2, 0)) = 50, 1, 0) round_50
FROM patch_season_registrations_copy3 psr3
         INNER JOIN score_entries se ON se.season_roster_id = psr3.season_roster_id
         INNER JOIN disciplines d ON d.id = se.discipline_id
UNION ALL
SELECT psr4.patch_dimension_id,
       se.season_roster_id,
       d.`name`                                     discipline_name,
       '5'                                          scoring_week,
       se.week_5_round1                             round1,
       se.week_5_round2                             round2,
       CASE

           WHEN se.week_5_round1 IS NULL THEN 0
           WHEN d.`name` = 'Sporting Clays' THEN 0
           WHEN se.week_5_round1 = 25 THEN 1
           ELSE 0
           END                                      round1_25,
       CASE

           WHEN se.week_5_round2 IS NULL THEN 0
           WHEN d.`name` = 'Sporting Clays' THEN 0
           WHEN se.week_5_round2 = 25 THEN 1
           ELSE 0
           END                                      round2_25,
       IF
       ((COALESCE(se.week_5_round1, 0) +
         COALESCE(se.week_5_round2, 0)) = 50, 1, 0) round_50
FROM patch_season_registrations_copy4 psr4
         INNER JOIN score_entries se ON se.season_roster_id = psr4.season_roster_id
         INNER JOIN disciplines d ON d.id = se.discipline_id;

CREATE TEMPORARY TABLE `patch_league_registrations`
(
    `id`                          int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`                  timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`                  timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `patch_dimension_id`          int unsigned      DEFAULT NULL,
    `tournament_league_id`        int unsigned      DEFAULT NULL,
    `discipline_id`               int unsigned      DEFAULT NULL,
    `tournament_league_roster_id` int unsigned      DEFAULT NULL,
    `team_id`                     int unsigned      DEFAULT NULL,
    `team_member_id`              int unsigned      DEFAULT NULL,
    `discipline_name`             varchar(255)      DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `patch_dimension_id` (`patch_dimension_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

insert into patch_league_registrations
(patch_dimension_id, tournament_league_id, discipline_id, tournament_league_roster_id, team_id, team_member_id,
 discipline_name)
SELECT pd.id    patch_dimension_id,
       tlr.tournament_league_id,
       tl.discipline_id,
       tlr.id   tournament_league_roster_id,
       tlr.team_id,
       tlr.team_member_id,
       d.`name` discipline_name
FROM tournament_leagues tl
         INNER JOIN tournament_league_rosters tlr ON tlr.tournament_league_id = tl.id
         LEFT JOIN tournament_league_refund_requests tlrr ON tlrr.tournament_roster_id = tlr.id
         INNER JOIN TeamUser tu ON tlr.team_id = tu.id
         INNER JOIN patch_dimensions pd ON pd.season_id = tl.season_id
    AND pd.league_id = tu.league_id
         INNER JOIN disciplines d ON d.id = tlr.discipline_id
WHERE tlr.registration_completed = 1
  AND tlr.is_active = 1
  AND (tlrr.id IS NULL OR tlrr.is_active = 0)
ORDER BY pd.id,
         tlr.tournament_league_id,
         tlr.team_id,
         tlr.team_member_id;
CREATE TEMPORARY TABLE `patch_league_scores`
(
    `id`                         int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`                 timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`                 timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `patch_dimension_id`         int unsigned      DEFAULT NULL,
    `tournament_league_id`       int unsigned      DEFAULT NULL,
    `team_id`                    int unsigned      DEFAULT NULL,
    `team_member_id`             int unsigned      DEFAULT NULL,
    `discipline_id`              int unsigned      DEFAULT NULL,
    `discipline_name`            varchar(255)      DEFAULT NULL,
    `tournament_league_score_id` int unsigned      DEFAULT NULL,
    `s1round1`                   tinyint unsigned  DEFAULT NULL,
    `s1round2`                   tinyint unsigned  DEFAULT NULL,
    `s1totalScore`               tinyint unsigned  DEFAULT NULL,
    `s2round1`                   tinyint unsigned  DEFAULT NULL,
    `s2round2`                   tinyint unsigned  DEFAULT NULL,
    `s2totalScore`               tinyint unsigned  DEFAULT NULL,
    `s1round1_25`                tinyint unsigned  DEFAULT NULL,
    `s1round2_25`                tinyint unsigned  DEFAULT NULL,
    `s2round1_25`                tinyint unsigned  DEFAULT NULL,
    `s2round2_25`                tinyint unsigned  DEFAULT NULL,
    `round_50`                   tinyint unsigned  DEFAULT NULL,
    `round_75`                   tinyint unsigned  DEFAULT NULL,
    `round_100`                  tinyint unsigned  DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `patch_dimension_id` (`patch_dimension_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

insert into patch_league_scores
(patch_dimension_id, tournament_league_id, team_id, team_member_id, discipline_id, discipline_name,
 tournament_league_score_id, s1round1, s1round2, s1totalScore, s2round1, s2round2, s2totalScore, s1round1_25,
 s1round2_25, s2round1_25, s2round2_25, round_50, round_75, round_100)

SELECT plr.patch_dimension_id,
       plr.tournament_league_id,
       plr.team_id,
       plr.team_member_id,
       plr.discipline_id,
       d.`name`                       discipline_name,
       tls.tournScoreID               tournament_league_score_id,
       tls.s1round1,
       tls.s1round2,
       tls.s1totalScore,
       tls.s2round1,
       tls.s2round2,
       tls.s2totalScore,
       case
           when tls.s1round1 is null then 0
           when d.`name` = 'Sporting Clays' then 0
           when tls.s1round1 = 25 then 1
           else 0 end                 s1round1_25,
       case
           when tls.s1round2 is null then 0
           when d.`name` = 'Sporting Clays' then 0
           when tls.s1round2 = 25 then 1
           else 0 end                 s1round2_25,
       case
           when tls.s2round1 is null then 0
           when d.`name` = 'Sporting Clays' then 0
           when tls.s2round1 = 25 then 1
           else 0 end                 s2round1_25,
       case
           when tls.s2round2 is null then 0
           when d.`name` = 'Sporting Clays' then 0
           when tls.s2round2 = 25 then 1
           else 0 end                 s2round2_25,
       case
           when tls.totalScore = 100 then 2
           when tls.s1totalScore = 50 or tls.s2totalScore = 50 then 1
           when d.`name` != 'Sporting Clays' and
                coalesce(tls.s1round2, 0) = 25 and
                coalesce(tls.s2round1, 0) = 25 then 1
           else 0 end                 round_50,
       case
           when d.`name` = 'Sporting Clays' then 0
           when (coalesce(tls.s1round2, 0) = 25 and coalesce(tls.s2round1, 0) = 25) and
                (coalesce(tls.s1round1, 0) = 25 or coalesce(tls.s2round2, 0) = 25) then 1
           else 0 end                 round_75,
       IF(tls.totalScore = 100, 1, 0) round_100
FROM patch_league_registrations plr
         INNER JOIN tournament_league_scores tls ON tls.tournamentID = plr.tournament_league_id
    AND tls.teamUserID = plr.team_id
    AND tls.teamMemberID = plr.team_member_id
    AND tls.is_active = 1
         INNER JOIN tournament_leagues tl ON tl.id = tls.tournamentID
         INNER JOIN tournament_league_dates tld ON tld.id = tls.tournDateID
         INNER JOIN disciplines d ON d.id = plr.discipline_id
ORDER BY plr.patch_dimension_id,
         plr.tournament_league_id,
         plr.team_id,
         plr.team_member_id,
         plr.discipline_id;
CREATE TEMPORARY TABLE `patch_national_registrations`
(
    `id`                            int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`                    timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`                    timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `patch_dimension_id`            int unsigned      DEFAULT NULL,
    `tournament_national_id`        int unsigned      DEFAULT NULL,
    `discipline_id`                 int unsigned      DEFAULT NULL,
    `tournament_national_roster_id` int unsigned      DEFAULT NULL,
    `team_id`                       int unsigned      DEFAULT NULL,
    `team_member_id`                int unsigned      DEFAULT NULL,
    `discipline_name`               varchar(255)      DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `patch_dimension_id` (`patch_dimension_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;


insert into patch_national_registrations
(patch_dimension_id, tournament_national_id, discipline_id, tournament_national_roster_id, team_id, team_member_id,
 discipline_name)
SELECT pd.id    patch_dimension_id,
       pd.tournament_national_id,
       tn.discipline_id,
       tnr.id   tournament_national_roster_id,
       tnr.team_id,
       tnr.team_member_id,
       d.`name` discipline_name
FROM tournament_nationals tn
         INNER JOIN patch_dimensions pd ON pd.tournament_national_id = tn.id
         INNER JOIN tournament_national_rosters tnr ON tnr.tournament_national_id = tn.id
         INNER JOIN disciplines d ON d.id = tn.discipline_id
WHERE tnr.registration_completed = 1
  AND tnr.is_active = 1;
CREATE TEMPORARY TABLE `patch_national_scores`
(
    `id`                           int unsigned NOT NULL AUTO_INCREMENT,
    `created_at`                   timestamp    NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`                   timestamp    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `patch_dimension_id`           int unsigned      DEFAULT NULL,
    `tournament_national_id`       int unsigned      DEFAULT NULL,
    `team_id`                      int unsigned      DEFAULT NULL,
    `team_member_id`               int unsigned      DEFAULT NULL,
    `discipline_id`                int unsigned      DEFAULT NULL,
    `discipline_name`              varchar(255)      DEFAULT NULL,
    `tournament_national_score_id` int unsigned      DEFAULT NULL,
    `s1round1`                     tinyint unsigned  DEFAULT NULL,
    `s1round2`                     tinyint unsigned  DEFAULT NULL,
    `s1totalScore`                 tinyint unsigned  DEFAULT NULL,
    `s2round1`                     tinyint unsigned  DEFAULT NULL,
    `s2round2`                     tinyint unsigned  DEFAULT NULL,
    `s2totalScore`                 tinyint unsigned  DEFAULT NULL,
    `s1round1_25`                  tinyint unsigned  DEFAULT NULL,
    `s1round2_25`                  tinyint unsigned  DEFAULT NULL,
    `s2round1_25`                  tinyint unsigned  DEFAULT NULL,
    `s2round2_25`                  tinyint unsigned  DEFAULT NULL,
    `round_50`                     tinyint unsigned  DEFAULT NULL,
    `round_75`                     tinyint unsigned  DEFAULT NULL,
    `round_100`                    tinyint unsigned  DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `patch_dimension_id` (`patch_dimension_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci;

insert into patch_national_scores
(patch_dimension_id, tournament_national_id, team_id, team_member_id, discipline_id, discipline_name,
 tournament_national_score_id, s1round1, s1round2, s1totalScore, s2round1, s2round2, s2totalScore, s1round1_25,
 s1round2_25, s2round1_25, s2round2_25, round_50, round_75, round_100)

SELECT pnr.patch_dimension_id,
       pnr.tournament_national_id,
       pnr.discipline_id,
       pnr.team_id,
       pnr.team_member_id,
       tns.id                          tournament_national_score_id,
       tns.s1_round1,
       tns.s1_round2,
       tns.s1_total_score,
       tns.s2_round1,
       tns.s2_round2,
       tns.s2_total_score,
       tns.total_score,
       CASE

           WHEN tns.s1_round1 IS NULL THEN 0
           WHEN pnr.discipline_name = 'Sporting Clays' THEN 0
           WHEN tns.s1_round1 = 25 THEN 1
           ELSE 0
           END                         s1_round1_25,
       CASE

           WHEN tns.s1_round2 IS NULL THEN 0
           WHEN pnr.discipline_name = 'Sporting Clays' THEN 0
           WHEN tns.s1_round2 = 25 THEN 1
           ELSE 0
           END                         s1_round2_25,
       CASE

           WHEN tns.s2_round1 IS NULL THEN 0
           WHEN pnr.discipline_name = 'Sporting Clays' THEN 0
           WHEN tns.s2_round1 = 25 THEN 1
           ELSE 0
           END                         s2_round1_25,
       CASE

           WHEN tns.s2_round2 IS NULL THEN 0
           WHEN pnr.discipline_name = 'Sporting Clays' THEN 0
           WHEN tns.s2_round2 = 25 THEN 1
           ELSE 0
           END                         s2_round2_25,
       CASE

           WHEN tns.total_score = 100 THEN 2
           WHEN tns.s1_total_score = 50
               OR tns.s2_total_score = 50 THEN 1
           WHEN pnr.discipline_name != 'Sporting Clays'
               AND COALESCE(tns.s1_round2, 0) = 25
               AND COALESCE(tns.s2_round1, 0) = 25 THEN 1
           ELSE 0
           END                         round_50,
       CASE

           WHEN pnr.discipline_name = 'Sporting Clays' THEN 0
           WHEN (COALESCE(tns.s1_round2, 0) = 25 AND
                 COALESCE(tns.s2_round1, 0) = 25)
               AND
                (COALESCE(tns.s1_round2, 0) = 25 OR
                 COALESCE(tns.s2_round1, 0) = 25) THEN 1
           ELSE 0
           END                         round_75,
       IF(tns.total_score = 100, 1, 0) round_100
FROM patch_national_registrations pnr
         INNER JOIN tournament_national_scores tns
                    ON tns.tournament_national_roster_id = pnr.tournament_national_roster_id
ORDER BY pnr.patch_dimension_id,
         pnr.discipline_id,
         pnr.team_id,
         pnr.team_member_id;

insert into patch_counts
(patch_dimension_id, season_id, season, league_name, season_team_count, season_athlete_total, season_athlete_unique,
 season_athlete_new, season_straight_25, season_straight_50, tourn_team_count, tourn_athlete_total,
 tourn_athlete_unique, tourn_straight_25, tourn_straight_50, tourn_straight_75, tourn_straight_100)
WITH patch_dimensions_cte AS (
    -- Query patch dimension
    SELECT pd.id AS patch_dimension_id,
           pd.season_id,
           pd.season,
           pd.league_name
    FROM patch_dimensions pd),
     season_registration_cte AS (
         -- Query season registration counts
         SELECT psr.patch_dimension_id,
                count(DISTINCT psr.team_id)        AS team_count,
                count(psr.team_member_id)          AS athlete_total,
                count(DISTINCT psr.team_member_id) AS athlete_unique,
                sum(
                        CASE
                            WHEN NOT EXISTS (SELECT 1
                                             FROM season_rosters sr
                                             WHERE sr.team_member_id = psr.team_member_id
                                               AND sr.season_id < pd1.season_id) THEN 1
                            ELSE 0
                            END
                )                                  AS athlete_new
         FROM patch_season_registrations psr
                  INNER JOIN patch_dimensions_copy1 pd1 ON pd1.id = psr.patch_dimension_id
         GROUP BY psr.patch_dimension_id),
     season_scores_cte AS (
         -- Query season scores
         SELECT pss.patch_dimension_id,
                (sum(pss.round1_25) + sum(pss.round2_25)) AS straight_25,
                sum(pss.round_50)                         AS straight_50
         FROM patch_season_scores pss
         GROUP BY pss.patch_dimension_id),
     league_registrations_cte AS (
         -- Query league registrations
         SELECT plr.patch_dimension_id,
                count(DISTINCT plr.team_id)        AS t_team_count,
                count(plr.team_member_id)          AS t_athlete_total,
                count(DISTINCT plr.team_member_id) AS t_athlete_unique
         FROM patch_league_registrations plr
         GROUP BY plr.patch_dimension_id),
     league_scores_cte AS (
         -- Query league scores
         SELECT pls.patch_dimension_id,
                (sum(pls.s1round1_25) + sum(pls.s1round2_25) +
                 sum(pls.s2round1_25) + sum(pls.s2round2_25)) AS t_straight_25,
                sum(pls.round_50)                             AS t_straight_50,
                sum(pls.round_75)                             AS t_straight_75,
                sum(pls.round_100)                            AS t_straight_100
         FROM patch_league_scores pls
         GROUP BY pls.patch_dimension_id),
     national_registrations_cte AS (
         -- Query national registrations
         SELECT pnr.patch_dimension_id,
                count(DISTINCT pnr.team_id)        AS t_team_count,
                count(pnr.team_member_id)          AS t_athlete_total,
                count(DISTINCT pnr.team_member_id) AS t_athlete_unique
         FROM patch_national_registrations pnr
         GROUP BY pnr.patch_dimension_id),
     national_scores_cte AS (
         -- Query national scores
         SELECT pns.patch_dimension_id,
                (sum(pns.s1round1_25) + sum(pns.s1round2_25) +
                 sum(pns.s2round1_25) + sum(pns.s2round2_25)) AS t_straight_25,
                sum(pns.round_50)                             AS t_straight_50,
                sum(pns.round_75)                             AS t_straight_75,
                sum(pns.round_100)                            AS t_straight_100
         FROM patch_national_scores pns
         GROUP BY pns.patch_dimension_id)
-- Combine all result sets
SELECT pd.patch_dimension_id,
       pd.season_id,
       pd.season,
       pd.league_name,
       sr.team_count     AS                               season_team_count,
       sr.athlete_total  AS                               season_athlete_total,
       sr.athlete_unique AS                               season_athlete_unique,
       sr.athlete_new    AS                               season_athlete_new,
       ss.straight_25    AS                               season_straight_25,
       ss.straight_50    AS                               season_straight_50,
       coalesce(lr.t_team_count, nr.t_team_count)         tourn_team_count,
       coalesce(lr.t_athlete_total, nr.t_athlete_total)   tourn_athlete_total,
       coalesce(lr.t_athlete_unique, nr.t_athlete_unique) tourn_athlete_unique,
       coalesce(ls.t_straight_25, ns.t_straight_25)       tourn_straight_25,
       coalesce(ls.t_straight_50, ns.t_straight_50)       tourn_straight_50,
       coalesce(ls.t_straight_75, ns.t_straight_75)       tourn_straight_75,
       coalesce(ls.t_straight_100, ns.t_straight_100)     tourn_straight_100
FROM patch_dimensions_cte pd
         LEFT JOIN season_registration_cte sr ON pd.patch_dimension_id = sr.patch_dimension_id
         LEFT JOIN season_scores_cte ss ON pd.patch_dimension_id = ss.patch_dimension_id
         LEFT JOIN league_registrations_cte lr ON pd.patch_dimension_id = lr.patch_dimension_id
         LEFT JOIN league_scores_cte ls ON pd.patch_dimension_id = ls.patch_dimension_id
         LEFT JOIN national_registrations_cte nr ON pd.patch_dimension_id = nr.patch_dimension_id
         LEFT JOIN national_scores_cte ns ON pd.patch_dimension_id = ns.patch_dimension_id
ORDER BY pd.patch_dimension_id;
