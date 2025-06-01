
SELECT 
    e.EmployeeID,
    e.Gender,
    e.MaritalStatus,
    CAST((julianday('2004-07-31') - julianday(e.BirthDate)) / 365.25 AS INT) AS Age,
    ep.Rate
FROM employee e
JOIN employeepayhistory ep ON e.EmployeeID = ep.EmployeeID
WHERE e.BirthDate IS NOT NULL AND ep.Rate IS NOT NULL;
