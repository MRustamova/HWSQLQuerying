
-- Query 1: Compute population per square mile for each country
WITH DensityPerMile AS (
  SELECT
    Name,
    Population / (SurfaceArea * 2.58999) AS PopPerSqMile
  FROM Country
  WHERE Population > 0 AND SurfaceArea > 0
)
SELECT * FROM DensityPerMile;

-- Query 2: Compute min, max, median using CTE and window functions
WITH DensityPerMile AS (
  SELECT
    Name,
    Population / (SurfaceArea * 2.58999) AS PopPerSqMile
  FROM Country
  WHERE Population > 0 AND SurfaceArea > 0
),
Ordered AS (
  SELECT PopPerSqMile,
         ROW_NUMBER() OVER (ORDER BY PopPerSqMile) AS rn,
         COUNT(*) OVER () AS total
  FROM DensityPerMile
)
SELECT
  MAX(CASE WHEN rn = 1 THEN PopPerSqMile END) AS Minimum,
  MAX(CASE WHEN rn = total THEN PopPerSqMile END) AS Maximum,
  MAX(CASE
        WHEN total % 2 = 1 AND rn = (total + 1) / 2 THEN PopPerSqMile
        WHEN total % 2 = 0 AND (rn = total / 2 OR rn = total / 2 + 1) THEN PopPerSqMile
      END) AS Median
FROM Ordered;

-- Query 3: Challenge - return result in two columns "Metric" and "Value"
WITH DensityPerMile AS (
  SELECT
    Name,
    Population / (SurfaceArea * 2.58999) AS PopPerSqMile
  FROM Country
  WHERE Population > 0 AND SurfaceArea > 0
),
Ordered AS (
  SELECT PopPerSqMile,
         ROW_NUMBER() OVER (ORDER BY PopPerSqMile) AS rn,
         COUNT(*) OVER () AS total
  FROM DensityPerMile
),
MinVal AS (
  SELECT 'Minimum' AS Metric, MIN(PopPerSqMile) AS Value FROM Ordered
),
MaxVal AS (
  SELECT 'Maximum' AS Metric, MAX(PopPerSqMile) AS Value FROM Ordered
),
MedianVal AS (
  SELECT 'Median' AS Metric,
         AVG(PopPerSqMile) AS Value
  FROM (
    SELECT PopPerSqMile
    FROM Ordered
    WHERE rn = (total + 1) / 2
       OR (total % 2 = 0 AND rn IN (total / 2, total / 2 + 1))
  )
)
SELECT * FROM MinVal
UNION ALL
SELECT * FROM MedianVal
UNION ALL
SELECT * FROM MaxVal;
