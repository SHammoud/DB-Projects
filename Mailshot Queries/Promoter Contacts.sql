# Requested by James Whitting for a mailshot
# 11/06/20

SELECT
COUNT(*) AS "Shows",
MAX(DD.date) AS "Last Booked",
C.name AS "Name",
C.surname AS "Surname",
C.email AS "Email",
C.companyName AS "Company",
MAX(DD.fee)/CU.rate AS "Fee"


FROM Contact C
LEFT JOIN Deal D ON C.id = D.promoterID
LEFT JOIN Deal_Date DD ON D.id = DD.dealID
LEFT JOIN Venue V ON V.id = DD.venueID
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Currency CU ON DD.currencyID = CU.id

WHERE DD.dealID IS NOT NULL
AND C.disabled IS NULL
AND YEAR(DD.date) BETWEEN 2019 AND 2022
# AND C.country = 223
AND C.name NOT REGEXP 'test|PT|and|/|AEG|behalf|\\(|C.O|/'
AND C.surname NOT REGEXP 'not use|and|behalf|\\(|/'
AND C.email NOT REGEXP 'paradigmagency.com|codaagency.com|accounts|info|contracts'
GROUP BY C.email
HAVING Shows > 0 AND Fee > "10000"
ORDER BY Fee DESC
LIMIT 200
