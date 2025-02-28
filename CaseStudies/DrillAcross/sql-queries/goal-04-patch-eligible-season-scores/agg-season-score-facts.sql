INSERT INTO agg_season_score_facts
(created_at,
 updated_at,
 season_league_dimension_id,
 straight_25,
 straight_50)
SELECT NOW()                                     AS created_at,
       NOW()                                     AS updated_at,
       ssf.season_league_dimension_id,
       (SUM(ssf.round1_25) + SUM(ssf.round2_25)) AS straight_25,
       SUM(ssf.round_50)                         AS straight_50
FROM season_score_facts ssf
         JOIN
     season_league_dimensions sld ON sld.id = ssf.season_league_dimension_id
GROUP BY ssf.season_league_dimension_id;
