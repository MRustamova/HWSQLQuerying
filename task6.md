
# Task 6: Largest USD <-> CAD Exchange Rate Change

## Objective
Identify the date on which the USD to CAD exchange rate changed the most compared to the previous day.

---

## Strategy

1. **Filter** only `USD` to `CAD` exchange rates.
2. **Use `LAG()`** window function to compare each day's `AverageRate` to the previous day's.
3. **Calculate the absolute difference** using `ABS(...)`.
4. **Sort** by the difference and return the date with the largest change.

---

## SQL Query
```sql
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
```

---

## Result

- **Date**: 2004-03-08  
- **Rate Change**: 0.0218
