# Requested by Ryan Penty for a mailshot
# EU Promoters that have:
# Booked between 2015 & 2020
# For shows with a value between 5k & 15k


SELECT
IF(D.contractType = '','STANDARD',D.contractType) AS "Contract Type",
IF(D.contractSubtype IS NULL,'DEFAULT',D.contractSubtype) AS "Contract Sub Type",
V.city AS "City",
CO.country AS "Country",
CONCAT(C.name,' ',C.surname) AS "Promoter",
C.email AS "Promoter Email",
C.companyName AS "Promoter Company",
COUNT(*) AS 'Shows'


FROM Deal_Date DD
LEFT JOIN Deal D ON D.id = DD.dealID
LEFT JOIN Contact C ON C.id = D.promoterID
LEFT JOIN Venue V ON V.id = DD.venueID
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Currency CU ON DD.currencyID = CU.id

WHERE DD.dealID IS NOT NULL
# AND CO.region IN ("Europe")
# AND CO.country NOT IN ("United Kingdom")
AND C.name NOT IN ("Test", "PT")
AND YEAR(DD.date) = 2023
AND D.cancelled + DD.cancelled = 0
AND DD.corporateRate IS NULL
AND D.contractType NOT IN ('CORPORATE','BRANDPARTNERSHIP')
GROUP BY DD.dealID
