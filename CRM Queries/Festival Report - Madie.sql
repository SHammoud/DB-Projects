SELECT COUNT(*)                                                               AS "Contracts",
       V.name                                                                 AS 'Venue',
       V.city                                                                 AS 'City',
       C.code                                                                 AS 'Currency',
       SUM(DD.fee)                                                            AS 'Fees',
       ROUND((SUM(DD.fee) / COALESCE(DD.exchangeRate, C.rate)), 2)            AS "FeesGBP",
       ROUND((SUM(DD.fee) / COALESCE(DD.exchangeRate, C.rate)) / COUNT(*), 2) AS "AverageGBP",
       P.companyName                                                          AS "Promoter Company"

FROM Deal_Date DD
         LEFT JOIN Deal D ON DD.dealID = D.id
         LEFT JOIN Currency C ON DD.currencyID = C.id
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN Venue V ON DD.venueID = V.id
         LEFT JOIN Contact P ON D.promoterID = P.id
WHERE DD.date BETWEEN "2019-01-01" AND "2019-12-31"
  AND D.contractType = "Festival"
  AND DD.dealID IS NOT NULL

GROUP BY V.id
ORDER BY FeesGBP DESC

    
