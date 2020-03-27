SELECT CONCAT(U.initials, '/', D.id) AS 'Contact Number',
       A.name                                                 AS 'Name',
       CASE
	       WHEN D.worth = D.totalPaid THEN CONCAT('FULLY PAID')
	       WHEN D.totalPaid < D.totalExpectedPayments AND D.nextPaymentDue <= CURRENT_DATE THEN CONCAT('OVERDUE')
           WHEN D.totalPaid > 0 AND D.nextPaymentDue > CURRENT_DATE THEN CONCAT('PART PAID')
           WHEN D.totalPaid > D.totalExpectedPayments THEN CONCAT('OVERPAID')
	       ELSE CONCAT('NO PAYMENTS')
	       END                                                AS 'Status',
       D.firstDate                                            AS 'First Date',
       GROUP_CONCAT(DD.date ORDER BY DD.date SEPARATOR ' ')  AS 'Other Dates',
       REPLACE(V.name, ',', ' ')                              AS 'Venue',
       V.city                                                 AS 'City',
       CO.country                                             AS 'Country',
       IF(D.cancelled , 'Yes', 'No')                          AS "Deal Cancelled",
       NULL                                                   AS 'Notes'

FROM Deal_Date DD
	     LEFT JOIN Deal D ON D.id = DD.dealID
	     LEFT JOIN Artist A ON DD.artistID = A.id
	     LEFT JOIN User AC ON A.accountantId = AC.id
	     LEFT JOIN User U ON DD.userID = U.id
	     LEFT JOIN Venue V ON DD.venueID = V.id
	     LEFT JOIN Country CO ON V.country = CO.id

WHERE D.isComplete = 0
  AND DD.date > CURRENT_DATE
  AND DD.holdOnChase = 0
GROUP BY DD.dealID
HAVING Status = 'OVERDUE'
ORDER BY D.firstDate

