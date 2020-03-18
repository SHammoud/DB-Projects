SELECT
       DATE_FORMAT(BT.entryDate,'%Y-%m-%d') AS 'Transaction Date',
	   BT.receiptNo AS 'Receipt No',
       CX.code AS 'Currency',
       BT.status 'Status',
       BT.type 'Type',
       BT.name 'Note',
       BT.memo 'Memo',
       CONCAT(U.name,' ',U.surname) AS 'Agent',
       CONCAT(U.initials,'/',D.id) 'Deal ID',
       A.name 'Artist',
       V.name 'Venue',
       V.city 'City',
       CO.country 'Country',
       DD.fee 'Show Fee',
       P.amount 'Amount Allocated to Show',
       ROUND(P.amount/COALESCE(DD.exchangeRate,CX.rate),2) AS 'Amount Allocated to Show GBP'
	
       

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
WHERE BT.entryDate BETWEEN '2020-03-01' AND '2020-03-31'
AND BT.type = 'CREDIT'
ORDER BY BT.entryDate ASC