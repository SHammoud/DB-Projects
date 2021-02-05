SELECT
COUNT(*) AS "Shows",
MAX(DD.date) AS "Last Booked",
C.name AS "Name",
C.surname AS "Surname",
C.email AS "Email"

FROM Contact C
LEFT JOIN Deal D ON C.id = D.promoterID
LEFT JOIN Deal_Date DD ON D.id = DD.dealID
LEFT JOIN Venue V ON V.id = DD.venueID
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Currency CU ON DD.currencyID = CU.id

WHERE DD.dealID IS NOT NULL

AND C.disabled IS NULL
AND C.name NOT IN ("Test", "PT")
AND DD.date > "2015"
AND (D.cancelled = 0)

GROUP BY C.id
ORDER BY Shows DESC

# SELECT
# C.name AS "Name",
# C.surname AS "Surname",
# C.email AS "Email"
#
# FROM Contact C
#
# WHERE C.disabled IS NULL
# AND C.isPromoter = 1
# GROUP BY C.id
