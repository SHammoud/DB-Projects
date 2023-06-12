# Requested by James Whitting for a mailshot
# 11/06/20

SELECT
MIN(DD2.date) AS "Start",
MAX(DD2.date) AS "End",
# C.name AS "Name",
# C.surname AS "Surname",
# C.email AS "Email",
V.name AS "Venue",
V.city AS "City",
CO.country AS "Country"

FROM Deal_Date DD
LEFT JOIN Deal D ON D.id = DD.dealID
LEFT JOIN Deal_Date DD2 ON  DD.id = DD2.id AND YEAR(DD2.date)=2023
LEFT JOIN Venue V ON V.id = DD.venueID
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Territory T on CO.territoryID = T.id
LEFT JOIN Currency CU ON DD.currencyID = CU.id


WHERE DD.dealID IS NOT NULL
AND DAYOFYEAR(DD.date) BETWEEN  DAYOFYEAR('2023-01-01') AND DAYOFYEAR('2023-12-31')
AND (V.name LIKE '%Fest%' OR D.contractType LIKE 'FESTIVAL')
# AND T.name IN ('United Kingdom','Europe')
AND T.name NOT IN ('United Kingdom')
GROUP BY V.id
HAVING End > '2018'
ORDER BY Start ASC
