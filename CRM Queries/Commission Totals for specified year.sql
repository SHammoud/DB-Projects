SELECT
#        CONCAT(U.name, ' ', U.surname),
       A.name AS 'Artist',
       N.nationality AS 'Nationality',
       A.address 'Address 1',
       A.address2 'Address 2',
       A.address3 'Address 3',
       A.city 'City',
       A.postcode 'Postcode',
       CO.country 'Country',
       ROUND(((DD.fee) / COALESCE(DD.exchangeRate, CU.rate, 1)), 2)                 AS 'FEE GBP',
       ROUND(((DD.fee) / COALESCE(DD.exchangeRate, CU.rate, 1) * (COALESCE(NULLIF(DD.commissionRate, 0), A.commissionRate) / 100)), 2) AS 'Commission GBP',
       DD.cvStatus AS 'CV Status'

FROM Deal_Date DD
         LEFT JOIN User U ON U.id = DD.userID
         LEFT JOIN Deal D ON D.id = DD.dealID
         LEFT JOIN Artist A ON A.id = DD.artistID
         LEFT JOIN Country CO ON A.country = CO.id
         LEFT JOIN Nationality N ON A.nationalityID = N.id
         LEFT JOIN Venue V ON V.id = DD.venueID
         LEFT JOIN Currency CU ON CU.id = DD.currencyID
WHERE DD.date BETWEEN  '2021-01-01' AND '2021-03-31'
  AND (COALESCE(D.cancelled, 0) + DD.cancelled = 0)
  AND DD.type = 'CONTRACT'
