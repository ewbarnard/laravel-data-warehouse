INSERT INTO agg_league_score_facts
(created_at,
 updated_at,
 season_league_dimension_id,
 t_straight_25,
 t_straight_50,
 t_straight_75,
 t_straight_100)
SELECT NOW()                                         AS created_at,
       NOW()                                         AS updated_at,
       lsf.season_league_dimension_id,
       (SUM(lsf.s1round1_25) + SUM(lsf.s1round2_25) +
        SUM(lsf.s2round1_25) + SUM(lsf.s2round2_25)) AS t_straight_25,
       SUM(lsf.round_50)                             AS t_straight_50,
       SUM(lsf.round_75)                             AS t_straight_75,
       SUM(lsf.round_100)                            AS t_straight_100
FROM league_score_facts lsf
         JOIN
     season_league_dimensions sld ON sld.id = lsf.season_league_dimension_id
GROUP BY lsf.season_league_dimension_id;
