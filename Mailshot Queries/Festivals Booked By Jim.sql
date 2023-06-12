
SELECT
COUNT(*) AS "Shows",
DD.date AS "Date",
C.name AS "Name",
C.surname AS "Surname",
C.email AS "Email",
V.name AS "Venue",
CO.country AS "Country"



FROM Contact C
LEFT JOIN Deal D ON C.id = D.promoterID
LEFT JOIN Deal_Date DD ON D.id = DD.dealID
LEFT JOIN Venue V ON V.id = DD.venueID
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Territory T on CO.territoryID = T.id
LEFT JOIN Currency CU ON DD.currencyID = CU.id
LEFT JOIN Flags F ON F.flaggableId = C.id
WHERE DD.dealID IS NOT NULL
AND DD.userID IN (2757,3598,87,78)
AND C.disabled IS NULL
AND C.blackListed IS NULL
AND F.id IS NULL

AND C.name NOT IN ('Test', 'PT')
# AND (D.contractType LIKE 'FESTIVAL'OR V.festivalId IS NOT NULL)
GROUP BY C.email
HAVING Shows > 1
ORDER BY Shows DESC

