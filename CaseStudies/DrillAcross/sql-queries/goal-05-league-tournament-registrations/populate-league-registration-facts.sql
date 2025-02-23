INSERT INTO `league_registration_facts`
(`season_league_dimension_id`,
 `league_tournament_id`,
 `team_id`,
 `season_id`,
 `discipline_id`,
 `discipline_name`,
 `season_roster_id`,
 `created_at`,
 `updated_at`)
SELECT sld.id AS season_league_dimension_id,
       ltr.league_tournament_id,
       ltr.team_id,
       ltr.season_id,
       ltr.discipline_id,
       d.name AS discipline_name, -- Discipline name from the disciplines table
       ltr.season_roster_id,
       NOW()  AS created_at,
       NOW()  AS updated_at
FROM league_tournament_rosters ltr
         JOIN
     disciplines d ON ltr.discipline_id = d.id
         JOIN
     league_tournaments lt ON ltr.league_tournament_id = lt.id
         JOIN
     season_league_dimensions sld
     ON sld.season_id = ltr.season_id
         AND sld.league_id = lt.league_id
         AND sld.league_type_id = lt.league_type_id
WHERE ltr.is_registration_complete = 1
  AND ltr.is_active = 1;
