INSERT INTO agg_league_registration_facts
(created_at,
 updated_at,
 season_league_dimension_id,
 t_team_count,
 t_athlete_total,
 t_athlete_unique)
SELECT NOW()                                 AS created_at,
       NOW()                                 AS updated_at,
       lrf.season_league_dimension_id,
       COUNT(DISTINCT lrf.team_id)           AS t_team_count,
       COUNT(sr.happy_user_role_id)          AS t_athlete_total,
       COUNT(DISTINCT sr.happy_user_role_id) AS t_athlete_unique
FROM league_registration_facts lrf
         JOIN
     season_league_dimensions sld ON sld.id = lrf.season_league_dimension_id
         JOIN
     season_rosters sr ON sr.id = lrf.season_roster_id
GROUP BY lrf.season_league_dimension_id;
