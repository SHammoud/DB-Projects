# Requested by James Whitting for a mailshot
# 11/06/20

SELECT
COUNT(*) AS "Shows",
MAX(DD.date) AS "Last Booked",
C.name AS "Name",
C.surname AS "Surname",
C.email AS "Email",
C.companyName AS "Company",
MAX(DD.fee)/CU.rate AS "MaxFee"


FROM Contact C
LEFT JOIN Deal D ON C.id = D.promoterID
LEFT JOIN Deal_Date DD ON D.id = DD.dealID
LEFT JOIN Venue V ON V.id = DD.venueID
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Currency CU ON DD.currencyID = CU.id
LEFT JOIN Territory T ON CO.territoryID = T.id
LEFT JOIN Flags F ON F.flaggableId = C.id

WHERE DD.dealID IS NOT NULL
AND F.id IS NULL
AND C.disabled IS NULL
AND YEAR(DD.date) BETWEEN 2017 AND 2023
AND CO.country = 'United Kingdom'
AND C.name NOT REGEXP 'test|PT|and|/|AEG|behalf|\\(|C.O|/'
AND C.surname NOT REGEXP 'not use|and|behalf|\\(|/'
AND C.blackListed IS NULL
GROUP BY C.email
HAVING Shows > 1 AND MaxFee > 1000
ORDER BY MaxFee DESC
# LIMIT 200
