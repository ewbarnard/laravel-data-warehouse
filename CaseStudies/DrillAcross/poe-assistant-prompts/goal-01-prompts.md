please take the following query and add backticks, for example bare column name "league" becomes "`league`". Do not change the query itself, only add backticks. SELECT ltr.season_id,
s.`name`,
t.league_id,
l.`name`                              league,
count(DISTINCT ltr.team_id)           t_team_count,
count(sr.happy_user_role_id)          t_athlete_total,
count(DISTINCT sr.happy_user_role_id) t_athlete_unique
FROM league_tournament_rosters ltr
INNER JOIN league_tournaments lt ON ltr.league_tournament_id = lt.id
INNER JOIN teams t ON t.id = ltr.team_id
INNER JOIN leagues l ON t.league_id = l.id
INNER JOIN seasons s ON ltr.season_id = s.id
INNER JOIN season_rosters sr ON sr.id = ltr.season_roster_id
INNER JOIN happy_user_roles hur ON hur.id = sr.happy_user_role_id
GROUP BY ltr.season_id,
t.league_id
ORDER BY ltr.season_id,
t.league_id

---

The two attached files are two MySQL 8 queries that produce one row per (season_id, league_id). Create a single drill-across query that combines the results into one row per (season_id, league_id). 

* Implement the two queries as common table expressions (cte).
* The result set should be the season_rosters cte left join league_tournament_rosters cte.
* Do NOT rename columns for clarity.
* Add backticks to all identifiers.
* Reformat the output to be less than 55 characters per line to be used as a documentation listing.

---


Here’s a suggested prompt to guide the creation of the final query based on the first two queries:

---

**Prompt:**

The attached files contain two MySQL 8 queries that produce one row per `(season_id, league_id)`:

1. `01-season-registrations.sql` generates metrics related to season rosters.
2. `02-league-tournament-registrations.sql` generates metrics related to league tournament rosters.

Using these queries:

1. **Implement the two queries as Common Table Expressions (CTEs):**
    - Name the first query `season_rosters_cte`.
    - Name the second query `league_tournament_rosters_cte`.

2. **Combine the CTEs into a single drill-across query:**
    - Use a `LEFT JOIN` to join `season_rosters_cte` with `league_tournament_rosters_cte` on both `season_id` and `league_id`.

3. **Include all columns from both queries:**
    - Use the exact column names and structure from the original queries, without renaming columns for clarity.

4. **Add backticks to all identifiers:**
    - Ensure all column names, table names, and aliases are enclosed in backticks for proper syntax.

5. **Format the query cleanly for documentation purposes:**
    - Align and indent the query so that it is easy to read and follows a consistent structure.
    - Keep the query style and formatting similar to the provided examples.

6. **Order the output by `season_id` and `league_id`.**

The resulting query should combine the two data sets into a single result set with one row per `(season_id, league_id)`, matching the style and structure of the provided example in `03-drill-across-registrations.sql`.

--- 

This prompt provides clear instructions on how to transform the two queries into the final result.

---

Please reformat the attached query for documentation purposes. 

* Make each line less than 55 characters. 
* Use backticks for all identifiers.
* Do not change the query at all, except reformatting according to the above rules.

---

