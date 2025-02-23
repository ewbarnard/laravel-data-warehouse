INSERT INTO agg_national_registration_facts
(created_at,
 updated_at,
 season_league_dimension_id,
 t_team_count,
 t_athlete_total,
 t_athlete_unique)
SELECT NOW()                                 AS created_at,
       NOW()                                 AS updated_at,
       nrf.season_league_dimension_id,
       COUNT(DISTINCT nrf.team_id)           AS t_team_count,
       COUNT(sr.happy_user_role_id)          AS t_athlete_total,
       COUNT(DISTINCT sr.happy_user_role_id) AS t_athlete_unique
FROM national_registration_facts nrf
         JOIN season_league_dimensions sld ON sld.id = nrf.season_league_dimension_id
         JOIN season_rosters sr ON sr.id = nrf.season_roster_id
GROUP BY nrf.season_league_dimension_id;
