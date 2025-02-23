INSERT INTO agg_national_score_facts
(created_at,
 updated_at,
 season_league_dimension_id,
 t_straight_25,
 t_straight_50,
 t_straight_75,
 t_straight_100)
SELECT NOW()                                         AS created_at,
       NOW()                                         AS updated_at,
       nsf.season_league_dimension_id,
       (SUM(nsf.s1round1_25) + SUM(nsf.s1round2_25) +
        SUM(nsf.s2round1_25) + SUM(nsf.s2round2_25)) AS t_straight_25,
       SUM(nsf.round_50)                             AS t_straight_50,
       SUM(nsf.round_75)                             AS t_straight_75,
       SUM(nsf.round_100)                            AS t_straight_100
FROM national_score_facts nsf
         JOIN season_league_dimensions sld ON sld.id = nsf.season_league_dimension_id
GROUP BY nsf.season_league_dimension_id;
