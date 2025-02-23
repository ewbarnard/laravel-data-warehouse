Please reformat the attached query for documentation purposes.

* Make each line less than 55 characters.
* Use backticks for all identifiers.
* Do not change the query at all, except reformatting according to the above rules.

---

The attached files contain two MySQL 8 queries that produce one per `(season_id, league_type_id, league_id, national_id)` combination.

1. `01-all-season-leagues-with-registrations.sql` produces rows for all `(season_id, league_type_id, league_id)` combinations with `national_id` set to 0.
2. `02-all-national-with-registrations.sql` produces rows for all `(season_id, league_type_id, national_id)` combinations with `league_id` set to 0.

Using these queries:

1. **Implement the two queries as Common Table Expressions (CTEs):**
    - Name the first query `season_league_cte`.
    - Name the second query `season_national_cte`.
2. **Combine the CTEs with a `UNION` producing one row for each of the two result sets.**
    - Column names should be the same for both queries.
    - Use the exact column names from the original query, without renaming columns for clarity.
3. **Add backticks to all identifiers:**
   - Ensure all column names, table names, and aliases are enclosed in backticks for proper syntax.
4. **Format the query cleanly for documentation purposes:**
   - Make each line less than 55 characters.
5. **Order the output by `season_id`, `league_type_id`, `league_id`, `national_id`.**

---

Enhance the combined query to populate table `season_league_dimensions` (attached). Map `seasons`.`name` in the combined query to `season_league_dimensions`.`season`. The output table sort order should be `season_id`, `league_sort`. Format the new query cleanly for documentation purposes, with each line less than 55 characters.

---

That became garbled. Create a query to populate table `season_league_dimensions`: 

1. Map `seasons`.`name` in the combined query to `season_league_dimensions`.`season`. 
2. The output table sort order should be `season_id`, `league_sort`. 
3. Format the new query cleanly for documentation purposes, with each line less than 55 characters.
4. Do not use CTEs. That did not work. A `UNION` of the two original queries should work.

