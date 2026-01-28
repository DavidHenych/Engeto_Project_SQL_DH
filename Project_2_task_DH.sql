--2. task - Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období 
--v dostupných datech cen a mezd?

WITH 
milk_06 AS (
    SELECT AVG(avg_price_value) AS avg_milk_price_06
    FROM t_David_Henych_project_SQL_primary_final
    WHERE category_name ILIKE '%mléko%'
      AND year = '2006'
      AND payroll_value IS NOT NULL
),
milk_18 AS (
    SELECT AVG(avg_price_value) AS avg_milk_price_18
    FROM t_David_Henych_project_SQL_primary_final
    WHERE category_name ILIKE '%mléko%'
      AND year = '2018'
      AND payroll_value IS NOT NULL
),
bread_06 AS (
    SELECT AVG(avg_price_value) AS avg_bread_price_06
    FROM t_David_Henych_project_SQL_primary_final
    WHERE category_name ILIKE '%chléb%'
      AND year = '2006'
      AND payroll_value IS NOT NULL
),
bread_18 AS (
    SELECT AVG(avg_price_value) AS avg_bread_price_18
    FROM t_David_Henych_project_SQL_primary_final
    WHERE category_name ILIKE '%chléb%'
      AND year = '2018'
      AND payroll_value IS NOT NULL
),
pay_06 AS (
    SELECT
        industry_branch_name,
        AVG(payroll_value) AS avg_pay_06
    FROM t_David_Henych_project_SQL_primary_final
    WHERE value_type_code = 5958
      AND year = '2006'
    GROUP BY industry_branch_name
),
pay_18 AS (
    SELECT
        industry_branch_name,
        AVG(payroll_value) AS avg_pay_18
    FROM t_David_Henych_project_SQL_primary_final
    WHERE value_type_code = 5958
      AND year = '2018'
    GROUP BY industry_branch_name
)
SELECT
    p06.industry_branch_name,
    ROUND((p06.avg_pay_06 / m06.avg_milk_price_06)::NUMERIC, 0) AS mléko_2006,
    ROUND((p18.avg_pay_18 / m18.avg_milk_price_18)::NUMERIC, 0) AS mléko_2018,
    ROUND((p06.avg_pay_06 / b06.avg_bread_price_06)::NUMERIC, 0) AS chléb_2006,
    ROUND((p18.avg_pay_18 / b18.avg_bread_price_18)::NUMERIC, 0) AS chléb_2018
FROM pay_06 p06
JOIN pay_18 p18
	ON p06.industry_branch_name = p18.industry_branch_name
CROSS JOIN milk_06 m06
CROSS JOIN milk_18 m18
CROSS JOIN bread_06 b06
CROSS JOIN bread_18 b18
ORDER BY p06.industry_branch_name
;