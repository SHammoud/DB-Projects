SELECT
       CONCAT(U.name,' ',U.surname) AS 'Agent',
       CONCAT(U.initials,'/',D.id) 'Deal ID',
       D.firstDate AS 'First Date',
      GROUP_CONCAT(CONCAT(ROUND(PS.percent),'% @ ',PS.due_at) ORDER BY PS.due_at SEPARATOR ', ') AS 'Payment Scheduled',
       A.name 'Artist',
       D.worth 'Fee',
	   D.totalPaid AS 'Paid',
       D.worth-D.totalPaid AS 'Due',
       CX.code AS 'Currency',
       D.cancelled 'Deal Cancelled'


FROM Deal D

LEFT JOIN Currency CX ON D.currencyId = CX.id
# LEFT JOIN Payment P ON D.id = P.dealID
LEFT JOIN Payment_Schedule PS ON D.id = PS.dealID
LEFT JOIN Artist A ON D.artistID = A.id
LEFT JOIN Contact C ON D.promoterID = C.id
LEFT JOIN User U ON D.userID = U.id
WHERE
      YEAR(D.firstDate) = YEAR(CURRENT_DATE)
AND   (D.userID = 95 OR D.secondaryAgentID = 95)

GROUP BY D.id
ORDER BY D.firstDate