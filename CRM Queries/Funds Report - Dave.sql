SELECT
       DATE_FORMAT(BT.entryDate,'%Y-%m-%d') AS 'Transaction Date',
	  GROUP_CONCAT(BT.receiptNo SEPARATOR ' ') AS 'Receipt No',
       CX.code AS 'Currency',
       CONCAT(U.name,' ',U.surname) AS 'Agent',
       CONCAT(U.initials,'/',D.id) 'Deal ID',
       DD.date AS 'Show Date',
       A.name 'Artist',
       V.name 'Venue',
       V.city 'City',
       CO.country 'Country',
       DD.fee 'Show Fee',
       SUM(P.amount) 'Amount Allocated to Show',
       DD.notes AS 'Notes',
       DD.priceNotes AS 'Extra Notes',
       D.cancelled 'Deal Cancelled',
       DD.cancelled 'Show Cancelled'
       

FROM Bank_Transaction BT

LEFT JOIN  Currency CX ON BT.currencyId = CX.id
LEFT JOIN Payment P ON BT.id = P.bankTransactionId
LEFT JOIN Deal_Date DD ON P.showID = DD.id
LEFT JOIN Venue V ON DD.venueID = V.id
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Deal D ON DD.dealID = D.id
LEFT JOIN Artist A ON D.artistID = A.id
LEFT JOIN Contact C ON D.promoterID = C.id
LEFT JOIN User U ON D.userID = U.id
WHERE
      DD.date > CURRENT_DATE

GROUP BY DD.id
ORDER BY D.id, DD.date