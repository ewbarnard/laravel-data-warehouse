INSERT INTO league_score_facts
(created_at,
 updated_at,
 season_league_dimension_id,
 league_tournament_score_id,
 league_tournament_id,
 league_tournament_roster_id,
 team_id,
 season_id,
 discipline_id,
 discipline_name,
 season_roster_id,
 s1round1,
 s1round2,
 s1total_score,
 s2round1,
 s2round2,
 s2total_score,
 total_score,
 s1round1_25,
 s1round2_25,
 s2round1_25,
 s2round2_25,
 round_50,
 round_75,
 round_100)
SELECT NOW()                           AS created_at,
       NOW()                           AS updated_at,
       sld.id                          as season_league_dimension_id,
       lts.id                          AS league_tournament_score_id,
       lts.league_tournament_id,
       lts.league_tournament_roster_id,
       lts.team_id,
       lts.season_id,
       lts.discipline_id,
       d.name                          AS discipline_name,
       lts.season_roster_id,
       lts.s1round1,
       lts.s1round2,
       lts.s1total_score,
       lts.s2round1,
       lts.s2round2,
       lts.s2total_score,
       lts.total_score,
       -- s1round1_25 calculation
       CASE
           WHEN lts.s1round1 IS NULL THEN 0
           WHEN d.name = 'Sporting Clays' THEN 0
           WHEN lts.s1round1 = 25 THEN 1
           ELSE 0
           END                         AS s1round1_25,
       -- s1round2_25 calculation
       CASE
           WHEN lts.s1round2 IS NULL THEN 0
           WHEN d.name = 'Sporting Clays' THEN 0
           WHEN lts.s1round2 = 25 THEN 1
           ELSE 0
           END                         AS s1round2_25,
       -- s2round1_25 calculation
       CASE
           WHEN lts.s2round1 IS NULL THEN 0
           WHEN d.name = 'Sporting Clays' THEN 0
           WHEN lts.s2round1 = 25 THEN 1
           ELSE 0
           END                         AS s2round1_25,
       -- s2round2_25 calculation
       CASE
           WHEN lts.s2round2 IS NULL THEN 0
           WHEN d.name = 'Sporting Clays' THEN 0
           WHEN lts.s2round2 = 25 THEN 1
           ELSE 0
           END                         AS s2round2_25,
       -- round_50 calculation
       CASE
           WHEN lts.total_score = 100 THEN 2
           WHEN lts.s1total_score = 50 OR lts.s2total_score = 50 THEN 1
           WHEN d.name != 'Sporting Clays'
               AND COALESCE(lts.s1round2, 0) = 25
               AND COALESCE(lts.s2round1, 0) = 25 THEN 1
           ELSE 0
           END                         AS round_50,
       -- round_75 calculation
       CASE
           WHEN d.name = 'Sporting Clays' THEN 0
           WHEN (COALESCE(lts.s1round2, 0) = 25 AND COALESCE(lts.s2round1, 0) = 25)
               AND (COALESCE(lts.s1round1, 0) = 25 OR COALESCE(lts.s2round2, 0) = 25) THEN 1
           ELSE 0
           END                         AS round_75,
       -- round_100 calculation
       IF(lts.total_score = 100, 1, 0) AS round_100
FROM league_tournament_scores lts
         JOIN disciplines d ON lts.discipline_id = d.id
         join league_tournaments lt on lt.id = lts.league_tournament_id
         join season_league_dimensions sld on sld.season_id = lt.season_id and sld.league_id = lt.league_id
WHERE lts.participated = 1;
