
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
LEFT JOIN Artist A ON A.id = DD.artistID
LEFT JOIN Venue V ON V.id = DD.venueID
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Currency CU ON DD.currencyID = CU.id
LEFT JOIN Territory T ON CO.territoryID = T.id

WHERE DD.dealID IS NOT NULL
AND C.disabled IS NULL
AND YEAR(DD.date) BETWEEN 2021 AND 2023
# AND A.id IN ('3716', '3304','3311','2929','1664','1911','1518','2839','1972','2606','2228')
AND V.country IN ('171','58','241','55','98','176','192')
AND C.name NOT REGEXP 'test|PT|and|/|AEG|behalf|\\(|C.O|/'
AND C.surname NOT REGEXP 'not use|and|behalf|\\(|/'
AND C.email NOT REGEXP 'paradigmagency.com|codaagency.com|accounts|info|contracts|teamwass.com'
GROUP BY C.email
HAVING Shows > 1
ORDER BY Fee DESC
# LIMIT 200
