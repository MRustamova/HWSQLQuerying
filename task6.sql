
-- Task 6: Find the date with the largest change in USD <-> CAD exchange rate
WITH RateChanges AS (
  SELECT
    CurrencyRateDate,
    AverageRate,
    LAG(AverageRate) OVER (ORDER BY CurrencyRateDate) AS PrevRate,
    ABS(AverageRate - LAG(AverageRate) OVER (ORDER BY CurrencyRateDate)) AS RateChange
  FROM CurrencyRate
  WHERE FromCurrencyCode = 'USD' AND ToCurrencyCode = 'CAD'
)
SELECT CurrencyRateDate, RateChange
FROM RateChanges
WHERE RateChange IS NOT NULL
ORDER BY RateChange DESC
LIMIT 1;
