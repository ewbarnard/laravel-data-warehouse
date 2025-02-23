select sr.season_id,
       s.`name`,
       l.league_type_id,
       '0'                                            league_id,
       concat_ws(':', 'national', lpad(n.id, 5, '0')) league_sort,
       concat_ws(' ', lt.description, n.`name`)       league_name,
       n.id                                           national_id
from season_rosters sr
         inner join seasons s on sr.season_id = s.id
         inner join teams t on t.id = sr.team_id
         inner join leagues l on l.id = t.league_id
         inner join league_types lt on lt.id = l.league_type_id
         inner join nationals n on n.season_id = sr.season_id and n.league_type_id = l.league_type_id and
                                   n.discipline_id = sr.discipline_id
         inner join national_rosters nr
                    on nr.national_id = n.id and nr.is_registration_complete = 1 and nr.is_active = 1
group by sr.season_id, l.league_type_id, n.id
order by sr.season_id, l.league_type_id, n.id
