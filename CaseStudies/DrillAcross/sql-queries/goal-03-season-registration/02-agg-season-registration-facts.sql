INSERT INTO agg_season_registration_facts
(created_at,
 updated_at,
 season_league_dimension_id,
 team_count,
 athlete_total,
 athlete_unique,
 athlete_new)
SELECT NOW()                             AS created_at,
       NOW()                             AS updated_at,
       srf.season_league_dimension_id,
       COUNT(DISTINCT srf.team_id)       AS team_count,
       COUNT(srf.happy_user_id)          AS athlete_total,
       COUNT(DISTINCT srf.happy_user_id) AS athlete_unique,
       SUM(
               IF(
                       NOT EXISTS (SELECT 1
                                   FROM season_rosters sr
                                   WHERE sr.happy_user_role_id = srf.happy_user_role_id
                                     AND sr.season_id < sld.season_id),
                       1,
                       0
               )
       )                                 AS athlete_new
FROM season_registration_facts srf
         JOIN
     season_league_dimensions sld ON sld.id = srf.season_league_dimension_id
GROUP BY srf.season_league_dimension_id;
