SELECT YEAR(DD.date) AS 'Year',
 COUNT(*) AS 'Shows'

From Deal_Date DD

LEFT JOIN Venue V ON DD.venueID = V.id
LEFT JOIN Country CO ON V.country =  CO.id

WHERE DD.dealID IS NOT NULL
AND CO.country = 'Australia'
AND (DD.cancelled = 0 AND DD.type NOT LIKE 'CANCELLED')

GROUP BY Year
WITH ROLLUP