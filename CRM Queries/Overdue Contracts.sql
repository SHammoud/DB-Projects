SELECT
       CONCAT(U.name,' ',U.surname) AS 'Agent',
       CONCAT(U.initials,'/',D.id) 'Deal ID',
       D.firstDate AS 'First Date',
       CX.code AS 'Deal Currency',
       D.totalExpectedPayments AS 'Total Expected Payments',
       D.nextCodaPaymentDue AS 'Payment Due Date',
#        D.expectedDuePayments AS 'Schedule overdue amount',
       IFNULL(SUM( P.amount),0) AS 'Total Received',
       D.totalExpectedPayments-IFNULL(SUM( P.amount),0) AS 'Total overdue amount',
       CASE WHEN D.awaitingDocuments = 1 THEN 'YES' ELSE 'NO' END AS 'Awaiting Docs'
	

FROM Deal D

LEFT JOIN Payment P on  D.id = P.dealID
LEFT JOIN Artist A on D.artistID = A.id
LEFT JOIN Currency CX ON D.currencyID = CX.id
LEFT JOIN User U ON D.userID = U.id


WHERE D.firstDate BETWEEN '2023-02-20' AND '2023-02-22'
AND D.isComplete = 0
# AND (D.nextCodaPaymentDue < CURDATE() OR D.nextCodaPaymentDue IS NULL)
#   AND D.nextCodaPaymentDue < CURDATE()
# AND U.name = 'James'
AND D.promoterID = 49603
GROUP BY D.id
# HAVING `Total Received` < `Total Expected Payments`



