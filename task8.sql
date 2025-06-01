
SELECT 
    v.VendorID,
    v.CreditRating,
    SUM(poh.SubTotal) AS TotalTransactionAmount
FROM vendor v
JOIN purchaseorderheader poh ON v.VendorID = poh.VendorID
GROUP BY v.VendorID, v.CreditRating
ORDER BY v.CreditRating;
