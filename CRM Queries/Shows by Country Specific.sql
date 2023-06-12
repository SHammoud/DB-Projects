SELECT YEAR(DD.date) AS 'Year',
 COUNT(*) AS 'Shows'

From Deal_Date DD


LEFT JOIN Venue V ON DD.venueID = V.id
LEFT JOIN Country CO ON V.country =  CO.id
LEFT JOIN Deal D on DD.dealID = D.id

WHERE DD.dealID IS NOT NULL
# AND CO.country = 'Australia'
AND (DD.cancelled + D.cancelled = 0)

GROUP BY Year
WITH ROLLUP