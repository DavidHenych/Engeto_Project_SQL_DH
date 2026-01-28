CREATE TABLE t_David_Henych_project_SQL_secondary_final AS	
	WITH 
price_year AS (
    SELECT
        DATE_PART('year', date_from)::int AS price_year,
        AVG(value) AS avg_price_in_year
    FROM czechia_price
    GROUP BY DATE_PART('year', date_from)
) 
	SELECT 
		DISTINCT cp.payroll_year AS year,
	    AVG(cp.value) AS avg_payroll_value,
	    py.avg_price_in_year AS avg_price_value,
	    e.gdp AS gdp
	FROM czechia_payroll cp
		LEFT JOIN price_year py
	    ON cp.payroll_year = py.price_year
	    LEFT JOIN economies e
	    ON cp.payroll_year = e.year
	WHERE cp.value_type_code = 5958
	AND e.country ILIKE '%czech%'
	GROUP BY cp.payroll_year, avg_price_value, gdp
	ORDER BY YEAR
;


SELECT *
FROM t_David_Henych_project_SQL_secondary_final
LIMIT 5;