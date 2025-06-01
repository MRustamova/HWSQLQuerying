
-- Recursive CTE to build chains of employee-manager relationships
WITH RECURSIVE SubordinationChains AS (

  -- Anchor member:
  -- Start with employees who have no manager (i.e., top-level managers).
  -- These form the base of each chain.
  SELECT 
    EmployeeID,  -- Current employee's ID
    CAST(EmployeeID AS TEXT) AS Chain  -- Start the chain as a string with this employee's ID
  FROM employee
  WHERE ManagerID IS NULL  -- Only top-level employees (no supervisor)

  UNION ALL

  -- Recursive member:
  -- For each employee who reports to someone already in a chain,
  -- extend the chain by appending that employee to it.
  SELECT 
    e.EmployeeID,  -- Employee ID of the subordinate
    sc.Chain || ' -> ' || e.EmployeeID AS Chain  -- Append to the existing chain
  FROM employee e
  JOIN SubordinationChains sc 
    ON e.ManagerID = sc.EmployeeID  -- Link subordinate to their direct manager

)

-- Final selection:
-- Return all constructed subordination chains
SELECT * 
FROM SubordinationChains
ORDER BY Chain;
