
# Task 8: Vendor Credit Rating and Transaction Volume Analysis

## Objective
Explore whether there is any correlation between a vendor's `CreditRating` and the **total amount of purchases** (i.e., financial volume of purchase orders) associated with that vendor.

---

## SQL Query Used

```sql
SELECT 
    v.VendorID,
    v.CreditRating,
    SUM(poh.SubTotal) AS TotalTransactionAmount
FROM vendor v
JOIN purchaseorderheader poh ON v.VendorID = poh.VendorID
GROUP BY v.VendorID, v.CreditRating
ORDER BY v.CreditRating;
```

---

## Observations

The data aggregates total `SubTotal` values from the `purchaseorderheader` table for each vendor and associates it with the vendor’s `CreditRating`.

From the results, we observe that vendors with **CreditRating = 1** appear frequently and have a wide range of transaction totals, from just a few thousand to over a million in purchases. To establish a real correlation, statistical aggregation would be needed — for example, computing the **average transaction amount per rating level** or running a **regression analysis**. However, based on this raw grouping, there doesn't appear to be a **clear and simple linear correlation** between CreditRating and transaction amount.

A more detailed correlation analysis might consider:
- Average or median transaction volume per rating
- Standard deviation of totals per rating
- Correlation coefficient (in external tools like Python or Excel)

