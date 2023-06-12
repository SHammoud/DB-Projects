SELECT
       V.name AS 'Name',
       V.capacity AS 'Capacity',
       V.address AS 'Address',
       V.city AS 'City',
       CO.country AS 'Country',
       T.name AS 'Territory',
       MAX(LBS.date) 'Last Booked At',
       GROUP_CONCAT(CONCAT(P.name,' ',P.surname,' (',P.email,')') ORDER BY P.name DESC) AS 'Promoter'
       

FROM Venue V
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Territory T ON T.id = CO.territoryID
LEFT JOIN Deal_Date DD ON DD.venueID = V.id
LEFT JOIN Deal D on DD.dealID = D.id
LEFT JOIN Contact P ON P.id = D.promoterId
LEFT JOIN Deal_Date LBS ON LBS.id = V.lastBookedShow


WHERE V.disabled IS NULL
AND DD.dealID IS NOT NULL
AND (D.cancelled = 0 AND DD.cancelled = 0)
AND V.name NOT LIKE '%stream%'
AND YEAR(DD.date) > 2018
AND V.capacity > 20
GROUP BY V.id
# HAVING `Last Booked At` IS NULL
ORDER BY CO.country, V.city, V.name
