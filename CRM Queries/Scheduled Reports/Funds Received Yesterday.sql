SELECT
       CONCAT(U.name,' ',U.surname) AS 'Agent',
       CONCAT(U.initials,'/',D.id) 'Deal ID',
       DD.date AS 'Show Date',
       A.name AS 'Artist',
       V.name AS 'Venue',
       V.city AS 'City',
       CO.country AS 'Country',
       CX.code AS 'Currency',
       CASE
           WHEN DD.cancelled + D.cancelled > 0 THEN IFNULL(DCF.fee,0) + IFNULL(DDCF.fee,0)
           ELSE DD.worth+(IFNULL(OV.amount,0)/100)
        END AS 'Total Fee',


#        DATE_FORMAT(BT.entryDate,'%Y-%m-%d') AS 'Transaction Date',
# 	  GROUP_CONCAT(BT.receiptNo SEPARATOR ' ') AS 'Receipt No',
       SUM( P.amount) 'Received',
#        GROUP_CONCAT(P.id),
       D.cancelled 'Deal Cancelled',
       DD.cancelled 'Show Cancelled',
       D.isComplete 'Contract Completed'

		
		
       

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
	WHERE type LIKE 'above_line'
	GROUP BY showID) OV ON OV.showID = DD.id



WHERE P.dateReceived = CURRENT_DATE - INTERVAL 1 DAY
AND DD.date < NOW()
# AND D.id = 101078
GROUP BY DD.id
ORDER BY DD.date, D.id