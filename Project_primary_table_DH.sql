CREATE TABLE t_David_Henych_project_SQL_primary_final AS
WITH 
price_year AS (
    SELECT
        category_code,
        region_code,
        DATE_PART('year', date_from)::int AS price_year,
        AVG(value) AS avg_price_in_year
    FROM czechia_price
    GROUP BY 
        category_code,
        region_code,
        DATE_PART('year', date_from)
)
	SELECT 
	    cp.id,
	    cp.payroll_year AS year,
	    cp.value AS payroll_value,
	    cp.value_type_code,
	    cpvt.name AS value_type_name,
	    cpib.name AS industry_branch_name,
	    py.avg_price_in_year AS avg_price_value,
	    cpcat.name AS category_name,
	    cpcat.price_value AS category_price_value,
	    cpcat.price_unit,
	    cr.name AS region_name
	FROM czechia_payroll cp
	JOIN czechia_payroll_calculation cpc 
	    ON cp.calculation_code = cpc.code
	JOIN czechia_payroll_industry_branch cpib
	    ON cp.industry_branch_code = cpib.code
	JOIN czechia_payroll_unit cpu
	    ON cp.unit_code = cpu.code
	JOIN czechia_payroll_value_type cpvt
	    ON cp.value_type_code = cpvt.code
	LEFT JOIN price_year py
	    ON cp.payroll_year = py.price_year
	LEFT JOIN czechia_price_category cpcat
	    ON py.category_code = cpcat.code
	LEFT JOIN czechia_region cr
	    ON py.region_code = cr.code
;



SELECT *
FROM t_David_Henych_project_SQL_primary_final
LIMIT 5;