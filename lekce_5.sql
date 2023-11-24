-- modulo ze 3
SELECT 5 % 2;
SELECT 14 % 5;
SELECT 15 % 5;
SELECT 123456789874 % 11;
SELECT 123456759874 % 11;

-- common table expression ze 4
-- 1
WITH high_price AS (
    SELECT category_code AS code
    FROM czechia_price
    WHERE value > 150
)
SELECT DISTINCT cpc.name
FROM high_price hp
JOIN czechia_price_category cpc
    ON hp.code = cpc.code;
    
SELECT DISTINCT cpc.name
FROM (SELECT category_code AS code
    FROM czechia_price
    WHERE value > 150) ccc
JOIN czechia_price_category cpc
    ON ccc.code = cpc.code;
    
-- 2
WITH not_completed_provider_info_district AS (
    SELECT DISTINCT district_code
    FROM healthcare_provider
    WHERE phone IS NULL AND email IS NULL AND fax IS NULL AND
        provider_type = 'Samost. ordinace všeob. prakt. lékaře'
)
SELECT *
FROM czechia_district
WHERE code NOT IN (
    SELECT *
    FROM not_completed_provider_info_district
); 

-- 3
WITH large_gdp_area AS (
    SELECT *
    FROM economies
    WHERE GDP > 70000000000
)
SELECT
    ROUND( AVG(taxes), 2) AS taxes_average
FROM large_gdp_area;
   
-- HAVING lekce 5
-- NEFUNKČNÍ DOTAZ - musíme použít HAVING:
SELECT
	country,
	SUM(confirmed) AS total_confirmed
FROM covid19_basic_differences
WHERE SUM(confirmed) > 5000000
GROUP BY
	country;
-- Země s více než 5 000 000 potvrzenými případy COVID-19:

SELECT
    country, SUM(confirmed) AS total_confirmed
FROM covid19_basic_differences
GROUP BY country
HAVING SUM(confirmed) > 5000000;

-- 2
SELECT
	country,
	`year`,
	SUM(population) AS overall_population
FROM economies e
GROUP BY
	country,
	`year`
HAVING overall_population > 4000000000
ORDER BY overall_population DESC;

-- 3
/*
 * 6371 = km, 3959 = miles
 */
SELECT 
    name,
    (6371 * ACOS( COS( RADIANS(49)) * COS( RADIANS( latitude )) 
    * COS( RADIANS( longitude ) - RADIANS(15)) 
    + SIN( RADIANS(49)) * SIN( RADIANS(latitude)))) AS distance 
FROM healthcare_provider
HAVING distance < 10
ORDER BY distance 
LIMIT 0, 20;
-- Příklad postavený na výpočtu uveřejněném na https://stackoverflow.com/a/574736

-- kde čerpat?, "komunita"?
-- www.meetup.com
-- www.datatalk.cz
-- MLMU tohle na FB
-- X
-- datacamp.com
