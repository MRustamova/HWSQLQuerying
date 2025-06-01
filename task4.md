
# Task 4: Average Life Expectancy by Language

## Objective
Determine the average life expectancy for each language using the `Country` and `CountryLanguage` tables.

---

## Step 1: Simple (Unweighted) Approach

### Logic
We calculate the average life expectancy for each language by simply averaging the life expectancies of all countries where the language is spoken, regardless of how many people in each country speak it.

### SQL Query
```sql
SELECT
  cl.Language,
  ROUND(AVG(c.LifeExpectancy), 2) AS AvgLifeExpectancy
FROM CountryLanguage cl
JOIN Country c ON cl.CountryCode = c.Code
WHERE c.LifeExpectancy IS NOT NULL
GROUP BY cl.Language
ORDER BY AvgLifeExpectancy DESC;
```

### Top 10 Results
| Language         |   AvgLifeExpectancy |
|:-----------------|--------------------:|
| Catalan          |               81.15 |
| Ainu             |               80.7  |
| Canton Chinese   |               80.3  |
| Romansh          |               79.6  |
| Fukien           |               79.5  |
| Chiu chau        |               79.5  |
| Icelandic        |               79.4  |
| Eskimo Languages |               79.4  |
| Sardinian        |               79    |
| Mandarin Chinese |               79    |

---

## Step 2: More Correct (Weighted) Approach

### Logic
We improve accuracy by **weighting** the life expectancy of each country by the **percentage of people** who speak the language there. This reflects actual speaker distribution more realistically.

### SQL Query
```sql
SELECT
  cl.Language,
  ROUND(SUM(c.LifeExpectancy * cl.Percentage) / SUM(cl.Percentage), 2) AS WeightedAvgLifeExpectancy
FROM CountryLanguage cl
JOIN Country c ON cl.CountryCode = c.Code
WHERE c.LifeExpectancy IS NOT NULL AND cl.Percentage > 0
GROUP BY cl.Language
ORDER BY WeightedAvgLifeExpectancy DESC;
```

### Top 10 Results
| Language         |   WeightedAvgLifeExpectancy |
|:-----------------|----------------------------:|
| Catalan          |                       81.89 |
| Japanese         |                       80.57 |
| Canton Chinese   |                       80.53 |
| Italian          |                       79.79 |
| Romansh          |                       79.6  |
| Fukien           |                       79.5  |
| Chiu chau        |                       79.5  |
| Swedish          |                       79.46 |
| Icelandic        |                       79.4  |
| Eskimo Languages |                       79.4  |

---

## Conclusion
- The **simple method** treats every country equally, even if a language is spoken by only a few people.
- The **weighted method** accounts for how widely a language is spoken in each country, producing more meaningful averages.
