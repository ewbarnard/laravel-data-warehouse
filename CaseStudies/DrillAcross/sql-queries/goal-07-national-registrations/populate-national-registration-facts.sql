INSERT INTO national_registration_facts
(created_at,
 updated_at,
 season_league_dimension_id,
 national_id,
 team_id,
 season_id,
 discipline_id,
 discipline_name,
 season_roster_id)
SELECT NOW()  AS created_at,
       NOW()  AS updated_at,
       sld.id AS season_league_dimension_id,
       n.id   AS national_id,
       nr.team_id,
       n.season_id,
       n.discipline_id,
       d.name AS discipline_name,
       nr.season_roster_id
FROM national_rosters nr
         INNER JOIN nationals n ON n.id = nr.national_id
         INNER JOIN season_league_dimensions sld ON sld.national_id = n.id
         INNER JOIN disciplines d ON d.id = n.discipline_id
WHERE nr.is_registration_complete = 1
  AND nr.is_active = 1;
