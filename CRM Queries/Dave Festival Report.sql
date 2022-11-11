SELECT
       V.name 'Venue',
       A.name 'Artist',
       DATE_FORMAT(DD.date,'%Y/%m/%d') AS 'Show Date',
       V.city 'City',
       CO.country 'Country',
       CONCAT(U.name,' ',U.surname) AS 'Agent',
       CONCAT(U.initials,'/',D.id) AS 'Contract Number',
       CONCAT(U.initials,'/',PD.id) AS 'Prod Contract Number',
	   CONCAT('=Hyperlink("https://www.codacrm.com/contracts?display=future&page=1&q=',D.id,'&agentType=all&onlySomeStates=false&sort=nextHappeningShow&preset=none&dateType=date","Open in CRM")') AS 'Link',
	   CX.code AS 'Currency',
       CASE
           WHEN DD.cancelled + D.cancelled > 0 THEN IFNULL((DCF.fee*(1+IFNULL(DD.vatRate,0))),0) + IFNULL(DDCF.fee*(1+IFNULL(DD.vatRate,0)),0)
           ELSE ROUND((DD.worth*(1+IFNULL(DD.vatRate,0))),2)
        END AS 'Total_Fee',
       D.expectedDuePayments+IFNULL(PD.expectedDuePayments,0) AS 'Expected_Amount',
       D.nextPaymentDue AS 'Next_Payment',
#       CASE
#            WHEN DD.cancelled + D.cancelled > 0 THEN (IFNULL(DCF.fee,0) + IFNULL(DDCF.fee,0))/COALESCE(DD.exchangeRate,CX.rate)
#            ELSE ROUND(((DD.worth*(1+IFNULL(DD.vatRate,0)))+(IFNULL(OV.amount,0)/100))/COALESCE(DD.exchangeRate,CX.rate),2)
#       END AS 'Total Fee In GBP',
#       CASE
#            WHEN DD.cancelled + D.cancelled > 0 THEN  ((IFNULL(DCF.fee,0) + IFNULL(DDCF.fee,0))*(COALESCE(DD.commissionRate,A.commissionRate)/100))/COALESCE(DD.exchangeRate,CX.rate)
#            ELSE ROUND((DD.worth+(IFNULL(OV.amount,0)/100))*(COALESCE(DD.commissionRate,A.commissionRate)/100)/COALESCE(DD.exchangeRate,CX.rate),2)
#       END AS 'Total Commission In GBP',
#        DATE_FORMAT(BT.entryDate,'%Y-%m-%d') AS 'Transaction Date',
# 	  GROUP_CONCAT(BT.receiptNo SEPARATOR ' ') AS 'Receipt No',
       CASE
    WHEN DD.cancelled + D.cancelled > 0 AND (SELECT Expected_Amount) = 0 THEN 'Cancelled'
    WHEN (SELECT Total_Fee) = SUM( P.amount) THEN 'Fully Paid'
    WHEN D.nextPaymentDue > NOW() AND (SELECT Expected_Amount) > SUM( P.amount)  THEN 'Part Paid'
    WHEN SUM( P.amount) > (SELECT Expected_Amount) THEN 'Overpaid'

    ELSE 'Overdue'
    END AS 'Status',
SUM( P.amount) 'Received',


#        GROUP_CONCAT(P.id),
       D.cancelled 'Deal Cancelled',
       DD.cancelled 'Show Cancelled'
		
		
       

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
LEFT JOIN Deal PD ON D.id = PD.parentId

	LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount"
	FROM Contract_Extra
	WHERE type LIKE "above_line"
	GROUP BY showID) OV ON OV.showID = DD.id



WHERE DD.date BETWEEN NOW() AND '2022-12-31'
AND (D.contractType = 'FESTIVAL' OR V.isFestival ='1')
AND D.isComplete = 0
GROUP BY DD.id, D.id
ORDER BY V.name, DD.date, A.name