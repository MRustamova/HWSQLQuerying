
# Missing Letters in Country Codes (SQLite Task)

## Task
Determine which **Latin letters (A–Z)** do **not** appear in:
- the **first** character of any 3-letter country code,
- the **second** character,
- the **third** character.

We analyze the `Code` field in the `Country` table of `world.db`.

---

## Query Logic Breakdown

###  Step 1: Generate All Letters A–Z
We simulate a list of all uppercase Latin letters using:
```sql
SELECT substr('ABCDEFGHIJKLMNOPQRSTUVWXYZ', n, 1) AS char
FROM (
  SELECT 1 AS n UNION SELECT 2 UNION ... UNION SELECT 26
)
```
SQLite doesn’t support arrays, so we build 1–26 manually, then extract each letter.

---

###  Step 2: Extract Characters at Positions
We want to examine each character position in the 3-letter `Code`:
- `SUBSTR(Code, 1, 1)` → first letter
- `SUBSTR(Code, 2, 1)` → second letter
- `SUBSTR(Code, 3, 1)` → third letter

We use `DISTINCT` to get only the unique letters used at that position.

---

### Step 3: Subtract Actual Letters from A–Z
Using `NOT IN (...)`, we subtract the letters **present** in the codes from the full list of A–Z to get the **missing** ones.

---

##  Full Query: Missing First-Letter Codes

```sql
SELECT char
FROM (
  SELECT substr('ABCDEFGHIJKLMNOPQRSTUVWXYZ', n, 1) AS char
  FROM (
    SELECT 1 AS n UNION SELECT 2 UNION ... UNION SELECT 26
  )
)
WHERE char NOT IN (
  SELECT DISTINCT SUBSTR(Code, 1, 1)
  FROM Country
  WHERE LENGTH(Code) = 3
);
```

Change the `SUBSTR(Code, 1, 1)` to `2,1` or `3,1` for second and third letters.

---

##  Final Answers

- Missing in **first** position: `X`
- Missing in **second** position: `Q`
- Missing in **third** position: `J`
