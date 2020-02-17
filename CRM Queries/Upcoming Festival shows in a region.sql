#Requested by Eleanour Aiken

SELECT
	DD.date,
	DD.dealID,
	A.name,
    V.name,
    V.city,
    CO.country

FROM Deal_Date DD

LEFT JOIN Deal D ON DD.dealID = D.id
LEFT JOIN Artist A ON A.id = DD.artistID
LEFT JOIN Venue V ON V.id = DD.venueID
LEFT JOIN Country CO ON CO.id = V.country

WHERE DD.date > CURDATE()
AND D.contractType = 'FESTIVAL'
AND CO.subregion LIKE 'South-eastern Asia' #Add festival region here