# Requested by Ryan Penty for a mailshot
# EU Promoters that have:
# Booked between 2015 & 2020
# For shows with a value between 5k & 15k


SELECT
COUNT(*) AS "Shows",
MAX(DD.date) AS "Last Booked",
C.name AS "Name",
C.surname AS "Surname",
C.email AS "Email",
CO.country AS "Country",
DD.fee/CU.rate AS "Fee"

FROM Contact C
LEFT JOIN Deal D ON C.id = D.promoterID
LEFT JOIN Deal_Date DD ON D.id = DD.dealID
LEFT JOIN Venue V ON V.id = DD.venueID
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Currency CU ON DD.currencyID = CU.id

WHERE DD.dealID IS NOT NULL
AND CO.region IN ("Europe")
AND CO.country NOT IN ("United Kingdom")
AND C.disabled IS NULL
AND C.name NOT IN ("Test", "PT")
AND DD.date > "2015"

GROUP BY C.id
HAVING Shows > 1 AND Fee BETWEEN "5000" AND "15000"
ORDER BY Shows DESC
