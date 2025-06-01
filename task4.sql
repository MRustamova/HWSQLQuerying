
-- Simple average life expectancy per language (unweighted)
SELECT
  cl.Language,
  ROUND(AVG(c.LifeExpectancy), 2) AS AvgLifeExpectancy
FROM CountryLanguage cl
JOIN Country c ON cl.CountryCode = c.Code
WHERE c.LifeExpectancy IS NOT NULL
GROUP BY cl.Language
ORDER BY AvgLifeExpectancy DESC;

-- Weighted average life expectancy per language (correct approach)
SELECT
  cl.Language,
  ROUND(SUM(c.LifeExpectancy * cl.Percentage) / SUM(cl.Percentage), 2) AS WeightedAvgLifeExpectancy
FROM CountryLanguage cl
JOIN Country c ON cl.CountryCode = c.Code
WHERE c.LifeExpectancy IS NOT NULL AND cl.Percentage > 0
GROUP BY cl.Language
ORDER BY WeightedAvgLifeExpectancy DESC;
