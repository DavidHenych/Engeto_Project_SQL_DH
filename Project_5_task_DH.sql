--5. task - Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

WITH base AS (
SELECT 
	year,
	avg_price_value AS current_year_price,
	LAG(avg_price_value) OVER (ORDER BY YEAR) AS previous_year_price,
	avg_payroll_value AS current_year_payroll,
	LAG(avg_payroll_value) OVER (ORDER BY year) AS previous_year_payroll,
	gdp AS current_year_gdp,
	LAG(gdp) OVER (ORDER BY year) AS previous_year_gdp
	FROM t_David_Henych_project_SQL_secondary_final
	WHERE avg_payroll_value IS NOT NULL
)
	SELECT 
		year,
		ROUND(current_year_price::NUMERIC, 2) AS current_year_price,
	    ROUND(previous_year_price::NUMERIC, 2) AS previous_year_price,
	    ROUND(current_year_payroll::NUMERIC, 2) AS current_year_payroll,
	    ROUND(previous_year_payroll::NUMERIC, 2) AS previous_year_payroll,
	    ROUND(current_year_gdp::NUMERIC, 2) AS current_year_gdp,
	    ROUND(previous_year_gdp::NUMERIC, 2) AS previous_year_gdp,
	    ROUND((((current_year_payroll - previous_year_payroll)/current_year_payroll)*100)::NUMERIC, 2) AS payroll_diff_in_percent,
	    ROUND((((current_year_price - previous_year_price)/current_year_price)*100)::NUMERIC, 2) AS price_diff_in_percent,
	    ROUND((((current_year_gdp - previous_year_gdp)/current_year_gdp)*100)::NUMERIC, 2) AS gdp_diff_in_percent
	FROM base
	WHERE previous_year_gdp IS NOT NULL
;