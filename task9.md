
# Task 9: Correlation Between Pay Rate and Employee Demographics

## Objective
Investigate how an employee's **pay rate** correlates with their **age**, **gender**, and **marital status** using the `employee` and `employeepayhistory` tables.

---

## SQL Query Used

```sql
SELECT 
    e.EmployeeID,
    e.Gender,
    e.MaritalStatus,
    CAST((julianday('2004-07-31') - julianday(e.BirthDate)) / 365.25 AS INT) AS Age,
    ep.Rate
FROM employee e
JOIN employeepayhistory ep ON e.EmployeeID = ep.EmployeeID
WHERE e.BirthDate IS NOT NULL AND ep.Rate IS NOT NULL;
```

---

## Observations

Using Pearson correlation:

- **Age vs Rate**: `0.18` — weak positive correlation  
- **Gender (Male=1) vs Rate**: `-0.10` — very weak negative correlation  
- **Marital Status (Married=1) vs Rate**: `-0.06` — negligible correlation

This suggests that **age has a slight positive correlation** with pay rate (possibly due to seniority), but **gender and marital status do not meaningfully impact pay rate** in this dataset.

---

## Additional Notes
- Gender and MaritalStatus were encoded as binary variables for correlation analysis.
- This analysis used `julianday()` to compute age as of the reference date `2004-07-31` (latest data point in AdventureWorks).
