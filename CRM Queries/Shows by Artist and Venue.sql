SELECT
#        CONCAT(U.name, ' ', U.surname),
       A.name AS 'Artist',
	   V.name AS 'Venue',
       CO.country AS 'Country',
       CO.region AS 'Region',
       ROUND(((DD.worth) / COALESCE(DD.exchangeRate, CU.rate, 1)), 2)                 AS 'FEE',
       ROUND(((DD.worth) / COALESCE(DD.exchangeRate, CU.rate, 1) * (COALESCE(NULLIF(DD.commissionRate, 0), A.commissionRate) / 100)), 2) AS 'COMMISSION'


FROM Deal_Date DD
         LEFT JOIN User U ON U.id = DD.userID
         LEFT JOIN Deal D ON D.id = DD.dealID
         LEFT JOIN Artist A ON A.id = DD.artistID
         LEFT JOIN Venue V ON V.id = DD.venueID
         LEFT JOIN Country CO ON V.country = CO.id
         LEFT JOIN Currency CU ON CU.id = DD.currencyID

WHERE DD.date BETWEEN  '2020-01-01' AND '2020-06-30'
  AND (COALESCE(D.cancelled, 0) + DD.cancelled = 0)
  AND DD.type = 'CONTRACT'
HAVING COMMISSION > 0

