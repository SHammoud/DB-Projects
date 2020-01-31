SELECT CONCAT(U.name, ' ', U.surname),
       ROUND(SUM((DD.fee) / COALESCE(DD.exchangeRate, CU.rate, 1)), 2)                 AS 'FEE GBP',
       ROUND(SUM((DD.fee) / COALESCE(DD.exchangeRate, CU.rate, 1) *
                 (COALESCE(NULLIF(DD.commissionRate, 0), A.commissionRate) / 100)), 2) AS 'Commission GBP'


FROM Deal_Date DD
         LEFT JOIN User U ON U.id = DD.userID
         LEFT JOIN Deal D ON D.id = DD.dealID
         LEFT JOIN Artist A ON A.id = DD.artistID
         LEFT JOIN Venue V ON V.id = DD.venueID
         LEFT JOIN Currency CU ON CU.id = DD.currencyID
WHERE DD.date LIKE '2018%'
  AND (DD.cancelled = 0 AND DD.cancelled = 0)

GROUP BY U.name
