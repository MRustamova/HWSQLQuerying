
-- Task 3: Percentage of Country Population Living in Capital
-- This query calculates the share of the capital population relative to the total country population
-- and lists the 10 countries with the smallest share.

SELECT
  Country.Name AS Country,
  City.Name AS Capital,
  City.Population AS CapitalPopulation,
  Country.Population AS CountryPopulation,
  ROUND(100.0 * City.Population / Country.Population, 4) AS CapitalSharePercent
FROM Country
JOIN City ON Country.Capital = City.ID
WHERE Country.Population > 0 AND City.Population > 0
ORDER BY CapitalSharePercent ASC
LIMIT 10;
