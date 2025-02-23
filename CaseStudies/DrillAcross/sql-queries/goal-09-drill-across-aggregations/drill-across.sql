with season_league_dimensions_cte as
         (select sld.id season_league_dimension_id,
                 sld.season_id,
                 sld.season,
                 sld.league_name
          from season_league_dimensions sld),
     season_registration_cte as
         (select asrf.season_league_dimension_id,
                 asrf.team_count,
                 asrf.athlete_total,
                 asrf.athlete_unique,
                 asrf.athlete_new
          from agg_season_registration_facts asrf),
     season_scores_cte as
         (select assf.season_league_dimension_id,
                 assf.straight_25,
                 assf.straight_50
          from agg_season_score_facts assf),
     league_registrations_cte as
         (select alrf.season_league_dimension_id,
                 alrf.t_team_count,
                 alrf.t_athlete_total,
                 alrf.t_athlete_unique
          from agg_league_registration_facts alrf),
     league_scores_cte as
         (select alsf.season_league_dimension_id,
                 alsf.t_straight_25,
                 alsf.t_straight_50,
                 alsf.t_straight_75,
                 alsf.t_straight_100
          from agg_league_score_facts alsf),
     national_registrations_cte as
         (select anrf.season_league_dimension_id,
                 anrf.t_team_count,
                 anrf.t_athlete_total,
                 anrf.t_athlete_unique
          from agg_national_registration_facts anrf),
     national_scores_cte as
         (select ansf.season_league_dimension_id,
                 ansf.t_straight_25,
                 ansf.t_straight_50,
                 ansf.t_straight_75,
                 ansf.t_straight_100
          from agg_national_score_facts ansf)
select sd.season_league_dimension_id,
       sd.season_id,
       sd.season,
       sd.league_name,
       sr.team_count                                      season_team_count,
       sr.athlete_total                                   season_athlete_total,
       sr.athlete_unique                                  season_athlete_unique,
       sr.athlete_new                                     season_athlete_new,
       ss.straight_25                                     season_straight_25,
       ss.straight_50                                     season_straight_50,
       coalesce(lr.t_team_count, nr.t_team_count)         tourn_team_count,
       coalesce(lr.t_athlete_total, nr.t_athlete_total)   tourn_athlete_total,
       coalesce(lr.t_athlete_unique, nr.t_athlete_unique) tourn_athlete_unique,
       coalesce(ls.t_straight_25, ns.t_straight_25)       tourn_straight_25,
       coalesce(ls.t_straight_50, ns.t_straight_50)       tourn_straight_50,
       coalesce(ls.t_straight_75, ns.t_straight_75)       tourn_straight_75,
       coalesce(ls.t_straight_100, ns.t_straight_100)     tourn_straight_100
from season_league_dimensions_cte sd
         left join season_registration_cte sr on sd.season_league_dimension_id = sr.season_league_dimension_id
         left join season_scores_cte ss on sd.season_league_dimension_id = ss.season_league_dimension_id
         left join league_registrations_cte lr on sd.season_league_dimension_id = lr.season_league_dimension_id
         left join league_scores_cte ls on sd.season_league_dimension_id = ls.season_league_dimension_id
         left join national_registrations_cte nr on sd.season_league_dimension_id = nr.season_league_dimension_id
         left join national_scores_cte ns on sd.season_league_dimension_id = ns.season_league_dimension_id
order by sd.season_league_dimension_id
