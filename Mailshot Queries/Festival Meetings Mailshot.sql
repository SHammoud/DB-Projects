# Requested by Nick & Cecilia to setup 2021 Festival Meetings

SELECT
COUNT(*) AS "Shows",
MAX(DD.date) AS "Last Booked",
C.name AS "Name",
C.surname AS "Surname",
C.email AS "Email",
V.name AS "Venue",
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
AND C.disabled IS NULL
AND C.name NOT IN ("Test", "PT")
AND D.contractType IN ("FESTIVAL")

GROUP BY V.id
HAVING Shows > 1 AND Fee > "30000"
ORDER BY Shows DESC
