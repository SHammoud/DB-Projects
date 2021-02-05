# SELECT
# COUNT(*) AS "Shows",
# MAX(DD.date) AS "Last Booked",
# V.name AS "Venue",
# V.city AS "City",
# CO.country AS "Country"
#
# FROM Venue V
# LEFT JOIN Deal_Date DD ON V.id = DD.venueID
# LEFT JOIN Country CO ON V.country = CO.id
# LEFT JOIN Currency CU ON DD.currencyID = CU.id
#
# WHERE DD.dealID IS NOT NULL
#
# AND V.disabled IS NULL
# AND V.name NOT IN ("Test", "PT")
# AND DD.date > "2015"
# AND (DD.cancelled = 0)
#
# GROUP BY V.id
# ORDER BY Shows DESC

SELECT
V.name AS "Name",
V.city AS "City",
CO.country AS "Country"

FROM Venue V
LEFT JOIN Country CO ON V.country = CO.id

WHERE V.disabled IS NULL

GROUP BY V.id
ORDER BY V.name