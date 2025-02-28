INSERT INTO season_score_facts
(season_league_dimension_id,
 team_id,
 season_id,
 discipline_id,
 discipline_name,
 happy_user_role_id,
 season_score_id,
 scoring_week,
 round1,
 round2,
 round1_25,
 round2_25,
 round_50,
 created_at,
 updated_at)
SELECT sld.id            AS season_league_dimension_id,
       ss.team_id,
       ss.season_id,
       ss.discipline_id,
       d.name            AS discipline_name,
       sr.happy_user_role_id,
       ss.id             AS season_score_id,
       ss.scoring_week,
       ss.round1,
       ss.round2,
       -- round1_25 calculation
       CASE
           WHEN ss.round1 IS NULL THEN 0
           WHEN d.name = 'Sporting Clays' THEN 0
           WHEN ss.round1 = 25 THEN 1
           ELSE 0
           END           AS round1_25,
       -- round2_25 calculation
       CASE
           WHEN ss.round2 IS NULL THEN 0
           WHEN d.name = 'Sporting Clays' THEN 0
           WHEN ss.round2 = 25 THEN 1
           ELSE 0
           END           AS round2_25,
       -- round_50 calculation
       IF(
               (COALESCE(ss.round1, 0) + COALESCE(ss.round2, 0)) = 50,
               1,
               0
       )                 AS round_50,
       CURRENT_TIMESTAMP AS created_at,
       CURRENT_TIMESTAMP AS updated_at
FROM season_scores ss
         JOIN season_rosters sr
              ON ss.team_id = sr.team_id
                  AND ss.season_id = sr.season_id
                  AND ss.happy_user_role_id = sr.happy_user_role_id
         JOIN disciplines d
              ON ss.discipline_id = d.id
         JOIN teams t
              ON ss.team_id = t.id
         JOIN season_league_dimensions sld
              ON sld.season_id = ss.season_id
                  AND sld.league_id = t.league_id
WHERE ss.participated = 1
  AND sr.is_registration_complete = 1
  AND sr.is_active = 1;
