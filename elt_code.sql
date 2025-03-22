CREATE DATABASE energy_analysis;

-- 1. Data Cleaning
-- 1.1. Basic DC + Timeframe
-- 1.1.1. Population table
ALTER TABLE world_population
CHANGE COLUMN `Country Code` `country_code` text;

ALTER TABLE world_population
CHANGE COLUMN `ď»żCountry Name` `country_name` text;

DELETE FROM world_population
WHERE country_name = 'ď»żCountry Name';

ALTER TABLE world_population
DROP COLUMN `1960`,
DROP COLUMN `1961`,
DROP COLUMN `1962`,
DROP COLUMN `1963`,
DROP COLUMN `1964`,
DROP COLUMN `1965`,
DROP COLUMN `1966`,
DROP COLUMN `1967`,
DROP COLUMN `1968`,
DROP COLUMN `1969`,
DROP COLUMN `1970`,
DROP COLUMN `1971`,
DROP COLUMN `1972`,
DROP COLUMN `1973`,
DROP COLUMN `1974`,
DROP COLUMN `1975`,
DROP COLUMN `1976`,
DROP COLUMN `1977`,
DROP COLUMN `1978`,
DROP COLUMN `1979`,
DROP COLUMN `1980`,
DROP COLUMN `1981`,
DROP COLUMN `1982`,
DROP COLUMN `1983`,
DROP COLUMN `1984`,
DROP COLUMN `1985`,
DROP COLUMN `1986`,
DROP COLUMN `1987`,
DROP COLUMN `1988`,
DROP COLUMN `1989`,
DROP COLUMN `1990`,
DROP COLUMN `1991`,
DROP COLUMN `1992`,
DROP COLUMN `1993`,
DROP COLUMN `1994`,
DROP COLUMN `1995`,
DROP COLUMN `1996`,
DROP COLUMN `1997`,
DROP COLUMN `1998`,
DROP COLUMN `1999`,
DROP COLUMN `2023`;

-- 1.1.2. Temperature table
DELETE FROM world_temperature
WHERE `Year` BETWEEN 1900 AND 1999;

ALTER TABLE world_temperature
DROP COLUMN `5-yr smooth`;

ALTER TABLE world_temperature
CHANGE COLUMN `Country` `country_name` text;

ALTER TABLE world_temperature
CHANGE COLUMN `Code` `country_code` text;

ALTER TABLE world_temperature
CHANGE COLUMN `Year` `year` int;

ALTER TABLE world_temperature
CHANGE COLUMN `Annual Mean` `avg_temp` double;

-- 1.1.3. Electricity table
UPDATE electricity_generation
SET `Code` = NULL
WHERE `Code` = '' OR `Code` IS NULL;

DELETE FROM electricity_generation
WHERE `Code` = NULL OR `Code` IS NULL;

ALTER TABLE electricity_generation
CHANGE COLUMN `Entity` `country_name` text;

ALTER TABLE electricity_generation
CHANGE COLUMN `Code` `country_code` text;

ALTER TABLE electricity_generation
CHANGE COLUMN `Year` `year` int;

ALTER TABLE electricity_generation
CHANGE COLUMN `Electricity generation - TWh` `electricity_twh` double;

DELETE FROM electricity_generation WHERE `year` IN (1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2023);

-- 1.2. Country Data Mapping
CREATE TABLE country_mapping
LIKE world_temperature;

ALTER TABLE country_mapping
DROP COLUMN `year`,
DROP COLUMN `avg_temp`;

INSERT INTO country_mapping (country_name, country_code)
SELECT DISTINCT world_population.country_name, world_population.country_code
FROM world_population
JOIN world_temperature ON world_population.country_code = world_temperature.country_code
JOIN electricity_generation ON world_population.country_code = electricity_generation.country_code;

-- 1.3. Country Data Cleaning
UPDATE country_mapping
SET country_name = 'Bahamas'
WHERE country_code = 'BHS';

UPDATE country_mapping
SET country_name = 'Timor Leste'
WHERE country_code = 'TLS';

UPDATE country_mapping
SET country_name = 'Egypt'
WHERE country_code = 'EGY';

UPDATE country_mapping
SET country_name = 'Gambia'
WHERE country_code = 'GMB';

UPDATE country_mapping
SET country_name = 'Guinea Bissau'
WHERE country_code = 'GNB';

UPDATE country_mapping
SET country_name = 'Iran'
WHERE country_code = 'IRN';

UPDATE country_mapping
SET country_name = 'Kyrgyzstan'
WHERE country_code = 'KGZ';

UPDATE country_mapping
SET country_name = 'Russia'
WHERE country_code = 'RUS';

UPDATE country_mapping
SET country_name = 'Slovakia'
WHERE country_code = 'SVK';

UPDATE country_mapping
SET country_name = 'South Korea'
WHERE country_code = 'KOR';

UPDATE country_mapping
SET country_name = 'Vietnam'
WHERE country_code = 'VNM';

UPDATE country_mapping
SET country_name = 'Yemen'
WHERE country_code = 'YEM';

-- 1.4. Population table transformation
CREATE TABLE world_population_new AS
SELECT `country_name`, `country_code`, '2000' AS year, `2000` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2001' AS year, `2001` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2002' AS year, `2002` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2003' AS year, `2003` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2004' AS year, `2004` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2005' AS year, `2005` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2006' AS year, `2006` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2007' AS year, `2007` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2008' AS year, `2008` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2009' AS year, `2009` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2010' AS year, `2010` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2011' AS year, `2011` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2012' AS year, `2012` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2013' AS year, `2013` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2014' AS year, `2014` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2015' AS year, `2015` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2016' AS year, `2016` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2017' AS year, `2017` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2018' AS year, `2018` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2019' AS year, `2019` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2020' AS year, `2020` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2021' AS year, `2021` AS population FROM world_population
UNION ALL
SELECT `country_name`, `country_code`, '2022' AS year, `2022` AS population FROM world_population;

DROP TABLE world_population;

ALTER TABLE world_population_new RENAME TO population_table;

-- 1.5. Country Data Normalization
DELETE population_table
FROM population_table
LEFT JOIN country_mapping ON population_table.country_code = country_mapping.country_code
WHERE country_mapping.country_code IS NULL;

UPDATE population_table
JOIN country_mapping ON population_table.country_code = country_mapping.country_code
SET population_table.country_name = country_mapping.country_name;

DELETE electricity_generation
FROM electricity_generation
LEFT JOIN country_mapping ON electricity_generation.country_code = country_mapping.country_code
WHERE country_mapping.country_code IS NULL;

UPDATE electricity_generation
JOIN country_mapping ON electricity_generation.country_code = country_mapping.country_code
SET electricity_generation.country_name = country_mapping.country_name;

DELETE world_temperature
FROM world_temperature
LEFT JOIN country_mapping ON world_temperature.country_code = country_mapping.country_code
WHERE country_mapping.country_code IS NULL;

UPDATE world_temperature
JOIN country_mapping ON world_temperature.country_code = country_mapping.country_code
SET world_temperature.country_name = country_mapping.country_name;

-- 2. Data Preprocessing Prior to Analysis and Visualization
-- 2.1. Merging key data into a single analytical table
CREATE TABLE final_table
LIKE population_table;

ALTER TABLE final_table ADD COLUMN electricity_twh double;
ALTER TABLE final_table ADD COLUMN avg_temp double;

INSERT INTO final_table
SELECT pt.country_name, pt.country_code, pt.`year`, pt.population, eg.electricity_twh, wt.avg_temp
FROM population_table AS pt
JOIN electricity_generation AS eg ON pt.country_code = eg.country_code AND pt.`year` = eg.`year`
JOIN world_temperature AS wt ON pt.country_code = wt.country_code AND pt.`year` = wt.`year`
ORDER BY country_name, `year`;

-- 2.2 Removing duplicates and identifying missing data
SELECT country_name, COUNT(*) AS count
FROM final_table
GROUP BY country_name
HAVING COUNT(*) < 23 OR COUNT(*) > 23;

DELETE FROM final_table WHERE country_name IN ('South Sudan', 'Timor Leste');

CREATE TABLE final_table_two
LIKE final_table;

ALTER TABLE final_table_two ADD COLUMN row_num int;

INSERT INTO final_table_two
SELECT *,
	ROW_NUMBER() OVER (PARTITION BY country_name, country_code, `year`) AS rn
FROM final_table;

DELETE
FROM final_table_two
WHERE row_num > 1;

ALTER TABLE final_table_two
DROP COLUMN row_num;

DROP TABLE final_table;

RENAME TABLE final_table_two TO final_table;

-- 2.3 Feature engineering
-- 2.3.1 Population growth
ALTER TABLE final_analysis_table ADD COLUMN population_growth int;
ALTER TABLE final_analysis_table ADD COLUMN population_growth_pct double;

WITH growth_of_population AS (
	SELECT *,
		population - (LAG(population) OVER (PARTITION BY country_code ORDER BY `year`)) AS population_g,
		ROUND(((population - (LAG(population) OVER (PARTITION BY country_code ORDER BY `year`))) / ((LAG(population) OVER (PARTITION BY country_code ORDER BY `year`)))) * 100, 2) AS population_g_pct
	FROM final_analysis_table
)
UPDATE final_analysis_table AS fat
JOIN growth_of_population AS gop ON fat.country_code = gop.country_code AND fat.`year` = gop.`year`
SET 
fat.population_growth = gop.population_g,
fat.population_growth_pct = gop.population_g_pct;

-- 2.3.2. Electricity growth
ALTER TABLE final_analysis_table ADD COLUMN electro_growth double;
ALTER TABLE final_analysis_table ADD COLUMN electro_growth_pct double;

WITH growth_of_electro AS (
	SELECT *,
		ROUND(electricity_twh - LAG(electricity_twh) OVER (PARTITION BY country_code ORDER BY `year`), 2) AS electro_g,
		ROUND(((electricity_twh - (LAG(electricity_twh) OVER (PARTITION BY country_code ORDER BY `year`))) / 
		(NULLIF(LAG(electricity_twh) OVER (PARTITION BY country_code ORDER BY `year`), 0)) * 100), 2) AS electro_g_pct
	FROM final_analysis_table
)
UPDATE final_analysis_table AS fat
JOIN growth_of_electro AS goe ON fat.country_code = goe.country_code AND fat.`year` = goe.`year`
SET 
fat.electro_growth = goe.electro_g,
fat.electro_growth_pct = goe.electro_g_pct;

-- 2.3.3. Temperature growth
ALTER TABLE final_analysis_table ADD COLUMN temp_growth double;
ALTER TABLE final_analysis_table ADD COLUMN temp_growth_pct double;

WITH growth_of_temp AS (
	SELECT *,
		ROUND(avg_temp - (LAG(avg_temp) OVER (PARTITION BY country_code ORDER BY `year`)), 2) AS temp_g,
		ROUND(((avg_temp - (LAG(avg_temp) OVER (PARTITION BY country_code ORDER BY `year`))) / 
		(NULLIF(LAG(avg_temp) OVER (PARTITION BY country_code ORDER BY `year`), 0))) * 100, 2) AS temp_g_pct
	FROM final_analysis_table
)
UPDATE final_analysis_table AS fat
JOIN growth_of_temp AS got ON fat.country_code = got.country_code AND fat.`year` = got.`year`
SET
fat.temp_growth = got.temp_g,
fat.temp_growth_pct = got.temp_g_pct;

-- 2.3.4. Electricity per capita
ALTER TABLE final_analysis_table ADD COLUMN electro_per_capita_kwh double;

UPDATE final_analysis_table
SET electro_per_capita_kwh = ROUND(((electricity_twh * POWER(10, 9)) / population), 2);

-- 3. Data Aggregation
-- 3.1 Population Data Aggregation
SELECT country_name, ROUND(AVG(population), 2) AS avg_population, MIN(population) AS min_population, 
MAX(population) AS max_ppulation, ROUND(AVG(population_growth_pct), 2) AS avg_population_change
FROM final_analysis_table
GROUP BY country_name;

-- 3.2 Temperature Data Aggregaion
SELECT country_name, ROUND(AVG(avg_temp), 2) AS avg_temperature, MIN(avg_temp) AS min_temperature, 
MAX(avg_temp) AS max_temperature, ROUND(AVG(temp_growth_pct), 2) AS avg_temp_change
FROM final_analysis_table
GROUP BY country_name;

-- 3.3 Electricity Generation Data Aggregation
SELECT country_name, ROUND(AVG(electricity_twh), 2) AS avg_electricity, ROUND(SUM(electricity_twh), 2) AS sum_electricity , MIN(electricity_twh) AS min_electricity, 
MAX(electricity_twh) AS max_electricity, ROUND(AVG(electro_growth_pct), 2) AS avg_electro_change
FROM final_analysis_table
GROUP BY country_name;