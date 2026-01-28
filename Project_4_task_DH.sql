--4. task - Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

WITH
tot_price_per_year AS (
	SELECT 
		DISTINCT year AS year,
		AVG(avg_price_value) AS total_avg_price
	FROM t_David_Henych_project_SQL_primary_final
	WHERE avg_price_value IS NOT NULL 
	GROUP BY year
),
tot_payroll_per_year AS (
	SELECT 
		DISTINCT year AS year,
		AVG(payroll_value) AS total_avg_payroll
	FROM t_David_Henych_project_SQL_primary_final
	WHERE value_type_code = 5958
	GROUP BY YEAR
),
base AS (
	SELECT
		tpripy.YEAR AS year,
		total_avg_price AS current_year_price,
		LAG(total_avg_price) OVER (ORDER BY tpripy.YEAR) AS previous_year_price,
		total_avg_payroll AS current_year_payroll,
		LAG(total_avg_payroll) OVER (ORDER BY tpaypy.year) AS previous_year_payroll
	FROM tot_price_per_year tpripy
	JOIN tot_payroll_per_year tpaypy
	ON tpripy.year = tpaypy.YEAR
),
final AS (
	SELECT 
		YEAR,
		ROUND(current_year_price::NUMERIC, 2) AS current_year_price,
	    ROUND(previous_year_price::NUMERIC, 2) AS previous_year_price,
		ROUND((((current_year_price - previous_year_price)/current_year_price)*100)::NUMERIC, 2) AS price_diff_in_percent,
	    ROUND(current_year_payroll::NUMERIC, 2) AS current_year_payroll,
	    ROUND(previous_year_payroll::NUMERIC, 2) AS previous_year_payroll,
	    ROUND((((current_year_payroll - previous_year_payroll)/current_year_payroll)*100)::NUMERIC, 2) AS payroll_diff_in_percent
	FROM base
	WHERE previous_year_price IS NOT NULL 
	AND previous_year_payroll IS NOT NULL
)
	SELECT
		YEAR,
		price_diff_in_percent,
		payroll_diff_in_percent,
			CASE 
		    WHEN price_diff_in_percent - payroll_diff_in_percent > 10 THEN 'price increase against payroll more than 10%'
		    ELSE 'price increase against payroll less than 10%' 
		    END AS description
	FROM final
;