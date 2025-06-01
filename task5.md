
# Task 5: Employees per Department on May 1, 1999

## Objective
Determine how many people were employed in each department on **May 1, 1999** using the `EmployeeDepartmentHistory` table.

---

## Strategy

1. We identify employees who were **actively assigned** to a department on `1999-05-01`.
2. An employee is considered **active** if:
   - `StartDate <= '1999-05-01'`
   - AND (`EndDate IS NULL` OR `EndDate > '1999-05-01'`)
3. Group by `DepartmentID` and count the number of records.

---

## SQL Query
```sql
SELECT DepartmentID, COUNT(*) AS EmployeeCount
FROM EmployeeDepartmentHistory
WHERE StartDate <= '1999-05-01'
  AND (EndDate IS NULL OR EndDate > '1999-05-01')
GROUP BY DepartmentID
ORDER BY DepartmentID;
```

---

## Result

| DepartmentID | EmployeeCount |
|--------------|----------------|
| 1            | 5              |
| 2            | 1              |
| 4            | 5              |
| 5            | 3              |
| 6            | 3              |
| 7            | 149            |
| 8            | 5              |
| 9            | 6              |
| 10           | 11             |
| 11           | 10             |
| 12           | 5              |
| 13           | 5              |
| 14           | 1              |
| 15           | 6              |
| 16           | 1              |
