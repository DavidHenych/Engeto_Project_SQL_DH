--3. task - Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 

WITH 
year_avg_val AS (
	SELECT 
		DISTINCT year AS year,
		category_name,
		AVG(avg_price_value) AS avg
	FROM t_David_Henych_project_SQL_primary_final
	WHERE avg_price_value IS NOT NULL 
	GROUP BY category_name, year
),
base AS(
	SELECT 
		year,
		category_name,
		avg AS avg_current_year,
		LAG(avg) OVER (PARTITION BY category_name ORDER BY YEAR) AS avg_previous_year
	FROM year_avg_val
),
final AS(
	SELECT 
		year,
	    category_name,
	    ROUND(avg_current_year::NUMERIC, 2) AS avg_current_year,
	    ROUND(avg_previous_year::NUMERIC, 2) AS avg_previous_year,
	    ROUND((avg_current_year - avg_previous_year)::NUMERIC, 2) AS diff_in_value,
	  	ROUND((((avg_current_year - avg_previous_year)/avg_current_year)*100)::NUMERIC, 2) AS diff_in_percent
	FROM base
	WHERE avg_previous_year IS NOT NULL 
)
	SELECT
		category_name,
		round(AVG(diff_in_percent)::NUMERIC, 2) AS avg_diff_in_percent_over_years
	FROM FINAL
	GROUP BY category_name
	HAVING AVG(diff_in_percent) > 0
	ORDER BY avg_diff_in_percent_over_years
;