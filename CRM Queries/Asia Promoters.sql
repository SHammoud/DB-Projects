SELECT 
COUNT(*) AS "Shows",
MAX(DD.date) AS "Last Booked",
C.name AS "Name",
C.surname AS "Surname",
C.email AS "Email",
CO.country AS "Country"

FROM Contact C
LEFT JOIN Deal D ON C.id = D.promoterID 
LEFT JOIN Deal_Date DD ON D.id = DD.dealID
LEFT JOIN Country CO ON C.country = CO.id

WHERE DD.dealID IS NOT NULL
AND CO.region IN ("Asia")
AND C.disabled IS NULL
AND C.name NOT IN ("Test")

GROUP BY C.id
ORDER BY Shows DESC


