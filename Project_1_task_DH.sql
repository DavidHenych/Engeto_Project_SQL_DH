--1. task - Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?	

WITH 
year_ind_val AS (
    SELECT 
    	DISTINCT year,
        industry_branch_name,
        payroll_value
    FROM t_David_Henych_project_SQL_primary_final
    WHERE payroll_value IS NOT NULL
		AND value_type_code = 5958
    	AND industry_branch_name IS NOT NULL
   		AND year BETWEEN 2000 AND 2021
),
base AS (
    SELECT 
        year,
        industry_branch_name,
        SUM(payroll_value) AS sum_current_year,
        LAG(SUM(payroll_value)) OVER (PARTITION BY industry_branch_name ORDER BY year) AS sum_previous_year,
        RANK() OVER (PARTITION BY industry_branch_name ORDER BY year) AS rnk
    FROM year_ind_val
    GROUP BY industry_branch_name, year
)
SELECT 
    year,
    industry_branch_name,
    rnk,
    sum_current_year,
    sum_previous_year,
    sum_current_year - sum_previous_year AS difference,
    CASE 
        WHEN sum_previous_year IS NULL THEN 'first available year'
        WHEN sum_current_year - sum_previous_year < 0 THEN 'decrease against previous year'
        WHEN sum_current_year - sum_previous_year > 0 THEN 'increase against previous year'
        ELSE 'is equal to previous year' 
    END AS description
	FROM base
	ORDER BY industry_branch_name, year
;