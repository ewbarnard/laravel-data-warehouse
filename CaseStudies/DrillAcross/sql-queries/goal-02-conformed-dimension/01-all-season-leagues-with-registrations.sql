select sr.season_id,
       s.`name`,
       l.league_type_id,
       l.id                               league_id,
       concat_ws(':', 'league', l.`name`) league_sort,
       l.`name`                           league_name,
       0                                  national_id
from season_rosters sr
         inner join seasons s on sr.season_id = s.id
         inner join teams t on t.id = sr.team_id
         inner join leagues l on l.id = t.league_id
         inner join league_types lt on lt.id = l.league_type_id
group by sr.season_id, l.league_type_id, l.id, national_id
order by sr.season_id, l.league_type_id, l.id, national_id
