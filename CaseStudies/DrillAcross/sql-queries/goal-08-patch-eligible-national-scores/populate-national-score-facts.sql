INSERT INTO national_score_facts
(created_at,
 updated_at,
 season_league_dimension_id,
 national_score_id,
 national_id,
 national_roster_id,
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
       sld.id                          AS season_league_dimension_id,
       nts.id                          AS national_score_id,
       nts.national_id,
       nts.national_roster_id,
       nts.team_id,
       nts.season_id,
       nts.discipline_id,
       d.name                          AS discipline_name,
       nts.season_roster_id,
       nts.s1round1,
       nts.s1round2,
       nts.s1total_score,
       nts.s2round1,
       nts.s2round2,
       nts.s2total_score,
       nts.total_score,
       -- Case logic for s1round1_25
       CASE
           WHEN nts.s1round1 IS NULL THEN 0
           WHEN d.name = 'Sporting Clays' THEN 0
           WHEN nts.s1round1 = 25 THEN 1
           ELSE 0
           END                         AS s1round1_25,
       -- Case logic for s1round2_25
       CASE
           WHEN nts.s1round2 IS NULL THEN 0
           WHEN d.name = 'Sporting Clays' THEN 0
           WHEN nts.s1round2 = 25 THEN 1
           ELSE 0
           END                         AS s1round2_25,
       -- Case logic for s2round1_25
       CASE
           WHEN nts.s2round1 IS NULL THEN 0
           WHEN d.name = 'Sporting Clays' THEN 0
           WHEN nts.s2round1 = 25 THEN 1
           ELSE 0
           END                         AS s2round1_25,
       -- Case logic for s2round2_25
       CASE
           WHEN nts.s2round2 IS NULL THEN 0
           WHEN d.name = 'Sporting Clays' THEN 0
           WHEN nts.s2round2 = 25 THEN 1
           ELSE 0
           END                         AS s2round2_25,
       -- Case logic for round_50
       CASE
           WHEN nts.total_score = 100 THEN 2
           WHEN nts.s1total_score = 50 OR nts.s2total_score = 50 THEN 1
           WHEN d.name != 'Sporting Clays' AND
                COALESCE(nts.s1round2, 0) = 25 AND
                COALESCE(nts.s2round1, 0) = 25 THEN 1
           ELSE 0
           END                         AS round_50,
       -- Case logic for round_75
       CASE
           WHEN d.name = 'Sporting Clays' THEN 0
           WHEN (COALESCE(nts.s1round2, 0) = 25 AND COALESCE(nts.s2round1, 0) = 25) AND
                (COALESCE(nts.s1round1, 0) = 25 OR COALESCE(nts.s2round2, 0) = 25) THEN 1
           ELSE 0
           END                         AS round_75,
       -- Logic for round_100
       IF(nts.total_score = 100, 1, 0) AS round_100
FROM national_scores nts
         INNER JOIN disciplines d ON nts.discipline_id = d.id
         INNER JOIN season_league_dimensions sld ON sld.national_id = nts.national_id
WHERE nts.participated = 1;
