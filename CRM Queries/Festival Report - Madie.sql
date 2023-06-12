SELECT
    COUNT(*) AS "Shows",
    V.name AS 'Venue',
    V.city AS 'City',
    V.isFestival,
	CO.country AS 'Country',
	GROUP_CONCAT(D.id),
	MIN(DD.date) 'First Show',
	MAX(DD.date) 'Last Show'

FROM Deal_Date DD
         LEFT JOIN Deal D ON DD.dealID = D.id
         LEFT JOIN Currency C ON DD.currencyID = C.id
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN Venue V ON DD.venueID = V.id
    	 LEFT JOIN Country CO ON V.country = CO.id
         LEFT JOIN Contact P ON D.promoterID = P.id
WHERE DD.date BETWEEN "2023-01-01" AND "2023-12-31"
  AND D.contractType = "Festival"
  AND DD.dealID IS NOT NULL

GROUP BY V.id

    
