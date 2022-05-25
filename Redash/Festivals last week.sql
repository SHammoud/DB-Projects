SELECT

    --   CONCAT(V.name,' ','(',CO.code,')') 'Venue',
       V.name 'Venue',
       A.name 'Artist',
       DATE_FORMAT(DD.date,'%a %b %d') AS 'Show Date',
       V.city 'City',
       CO.country 'Country'

		
		
       

FROM Bank_Transaction BT

LEFT JOIN  Currency CX ON BT.currencyId = CX.id
LEFT JOIN Payment P ON BT.id = P.bankTransactionId
LEFT JOIN Deal_Date DD ON P.showID = DD.id

	LEFT JOIN (SELECT id, showID, contractId, SUM(amount) AS "amount", currencyId,currencyExchangeRate
	FROM Payment_Artist
	GROUP BY showID) PA ON DD.id = PA.showId

LEFT JOIN Currency ACX ON PA.currencyId = ACX.id
LEFT JOIN Venue V ON DD.venueID = V.id
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Deal D ON DD.dealID = D.id
LEFT JOIN Artist A ON D.artistID = A.id
LEFT JOIN Contact C ON D.promoterID = C.id
LEFT JOIN User U ON D.userID = U.id
LEFT JOIN Cancellation_Fee DCF ON DCF.dealID = DD.dealID
LEFT JOIN Cancellation_Fee DDCF ON DDCF.dealDateID = DD.id

	LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount"
	FROM Contract_Extra
	WHERE type LIKE "above_line"
	GROUP BY showID) OV ON OV.showID = DD.id



WHERE DD.date BETWEEN SUBDATE(NOW(), INTERVAL 1 WEEK) AND NOW()
AND D.contractType = 'FESTIVAL'
AND D.cancelled + DD.cancelled < 1
GROUP BY DD.id
ORDER BY V.name, DD.date