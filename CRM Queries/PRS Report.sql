# PRS Report
# Requested by Madie 25/02/20
SELECT
       DD.date,
       DD.dealID,
       A.name,
       V.name,
       V.city

FROM Contract_Extra CE
LEFT JOIN Deal D ON CE.contractID = D.id
LEFT JOIN Deal_Date DD ON D.id = DD.dealID
LEFT JOIN Venue V ON DD.venueID = V.id
LEFT JOIN Artist A ON D.artistID = A.id
WHERE CE.description LIKE '%PRS%'
AND YEAR(DD.date) > 2019
GROUP BY DD.id
