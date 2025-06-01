
-- Task 5: Count employees per department on May 1, 1999
SELECT DepartmentID, COUNT(*) AS EmployeeCount
FROM EmployeeDepartmentHistory
WHERE StartDate <= '1999-05-01'
  AND (EndDate IS NULL OR EndDate > '1999-05-01')
GROUP BY DepartmentID
ORDER BY DepartmentID;
