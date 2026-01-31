# Engeto_Project_SQL_DH


Informace pro tiskovou konferenci

Na základě výzkumných otázek naše oddělení připravilo datové podklady pro tiskovou konferenci.
Dotazy, které jsme zodpovídali se týkají porovnání dostupnosti základních potravin na základě průměrných příjmů za určité období.

Použité zdroje

Jako zdroje jsme použili tabulky s daty o českých mzdách a cenách potravin.
Jelikož poskytnuté databáze obsahovaly údaje s jiným časovým rozpětím:
-	Mzdy – rok 2000 – 2021
-	Ceny potravin – rok 2006 – 2018
Museli jsme po spojení těchto tabulek použít společné roky, aby hodnoty mohly být porovnatelné.
Pokud se jedná o závěrečný dotaz s obsahující HDP, získali jsme informace pouze do roku 2020.

Výsledky analýz

1.  Dotaz: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
Podle našich výsledků v průběhu valné většiny let mzdy ve všech odvětvích mzdy rostou. Nejvíce poklesu jsme zaznamenali u odvětví Těžba a dobývání, kde mzdy klesly 5x z měřených 21 let.
Avšak chtěli bychom upozornit na roky 2013, kde meziročně klesly mzdy u větší poloviny odvětví a v roce 2021, kde pokles byl u všech.

2.  Dotaz: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
V níže uvedené tabulce můžete vidět, kolik litrů mléka a kilogramů si bylo možné koupit v letech 2006 a 2018.
Ty hodnoty jsme rozdělili po jednotlivých odvětvích.
![Task 2](Images/2_task.PNG)

3.  Dotaz: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
Dle naší analýzy jsme zjistili, že meziročně nejpomaleji zdražují Banány žluté průměrným nárůstem 0,39%.
Dále stojí za zmínku Jablka konzumní (0,69%), Vepřová pečeně s kostí (0,76%) a Přírodní minerální voda uhličitá (0,93%), u nichž průměrný narůst je menší než 1%.

4.  Dotaz: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
Po srovnání průměrných mezd a cen potravin můžeme potvrdit, že nebyl rok, ve kterém by meziroční rozdíl přesahoval 10% mezi mzdami a cenou potravin.

5.  Dotaz: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
Na základě naší analýzy není prokazatelné, že by HDP přímo ovlivňovalo změny ve mzdách a cenách potravin.
