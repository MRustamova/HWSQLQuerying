
# Task 3: Population Share in Capital City

## Objective
Identify the percentage of each country's population that lives in its capital city, and find the 10 countries with the smallest share.

---

## Step-by-Step Explanation

### 1. Tables Involved
- **Country**: Contains data about each country including its name, population, and a foreign key reference (`Capital`) to the city that serves as its capital.
- **City**: Contains data about cities including their population and unique `ID`.

### 2. Join Condition
We use an **inner join**:
```sql
JOIN City ON Country.Capital = City.ID
```
This links each country to its capital city.

### 3. Calculating the Capital Share
We calculate:
```sql
100.0 * City.Population / Country.Population
```
This gives the percentage of a country’s total population that resides in its capital.

- We multiply by 100.0 to ensure floating-point division and result in percentage format.
- We round it using `ROUND(..., 4)` to get 4 decimal places of precision.

### 4. Filtering
We ensure valid data using:
```sql
WHERE Country.Population > 0 AND City.Population > 0
```
This avoids division by zero and ensures meaningful ratios.

### 5. Sorting and Limiting
We order the results to find countries with the **smallest percentage**:
```sql
ORDER BY CapitalSharePercent ASC
```
Then limit to the top 10:
```sql
LIMIT 10
```

---

## Interpretation of Results
This method helps identify:
- Large countries with very small official capital cities (e.g., India, USA)
- Nations with decentralized population distribution
- Edge cases due to outdated or narrow population counts (e.g., capital district only)

The results can seem surprising due to how capital city boundaries are defined in the database — for example, New Delhi vs. greater Delhi, or Washington D.C. vs. metro area.

---

## SQL Query
See the `task3.sql` file for the exact query.


---

## Query Results (Top 10 Countries with Smallest Capital Population Share)

| Country       | Capital      |   CapitalPopulation |   CountryPopulation |   CapitalSharePercent |
|:--------------|:-------------|--------------------:|--------------------:|----------------------:|
| India         | New Delhi    |              301297 |          1013662000 |                0.0297 |
| United States | Washington   |              572059 |           278357000 |                0.2055 |
| Nigeria       | Abuja        |              350100 |           111506000 |                0.314  |
| Pakistan      | Islamabad    |              524500 |           156483000 |                0.3352 |
| Tanzania      | Dodoma       |              189000 |            33517000 |                0.5639 |
| China         | Peking       |             7472000 |          1277558000 |                0.5849 |
| Guam          | Agaña        |                1139 |              168000 |                0.678  |
| Côte d’Ivoire | Yamoussoukro |              130000 |            14786000 |                0.8792 |
| Bhutan        | Thimphu      |               22000 |             2124000 |                1.0358 |
| Canada        | Ottawa       |              335277 |            31147000 |                1.0764 |