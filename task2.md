
# Task 2: Population per Square Mile Metrics

## Objective
Calculate the ratio of population per square mile for each country using the data in the `Country` table of the `world.db` database.

---

## Step-by-Step Explanation

### 1. Population Density Calculation
Each country’s population density per square mile is calculated using:
```
Population / (SurfaceArea * 2.58999)
```
- `SurfaceArea` is given in square kilometers.
- We multiply by **2.58999** to convert square kilometers to **square miles**.

### 2. Use of CTE (Common Table Expression)
A **CTE named `DensityPerMile`** is used to:
- Select all valid countries (Population > 0, SurfaceArea > 0)
- Compute their population density per square mile

### 3. Calculating Metrics
We use a second CTE with `ROW_NUMBER()` and `COUNT()` to rank the population densities.

We compute:
- **Minimum** using `MIN(...)`
- **Maximum** using `MAX(...)`
- **Median** using:
  - Middle value (if odd number of countries)
  - Average of two middle values (if even)

### 4. Final Challenge Output
A third layer of CTEs (`MinVal`, `MaxVal`, `MedianVal`) is used to return the result in this format:

| Metric  | Value            |
|---------|------------------|
| Minimum | min_density      |
| Median  | median_density   |
| Maximum | max_density      |

---

## Query Results

| Metric   |          Value |
|:---------|---------------:|
| Minimum  |     0.00998191 |
| Median   |    27.4527     |
| Maximum  | 10145.9        |

---

## SQL Queries
See the file `population_density_metrics.sql` for the full list of queries used in this task.
