SELECT
       CONCAT(U.name,' ',U.surname)                               AS "Agent",
       DD.date                                                   AS "Date",
       A.name                                                    AS "Artist",
       COALESCE(DD.customCountry, CO.country)                    AS "Country",
       COALESCE(DD.customCity, V.city)                           AS "City",
       V.name                                                    AS "Venue",
       V.capacity                                                AS "Capacity",
       DD.budgetedCapacity                                       AS "Budgeted Capacity",
       DD.fee                                                    AS "Fee",
	   COALESCE(ROUND(PF.amount/100,2),0)                        AS "Production Fee",
       CU.code                                                   AS "Currency",
       ROUND(((DD.fee+COALESCE(ROUND(PF.amount/100,2),0)) / COALESCE(DD.exchangeRate, CU.rate)), 2)            AS "Fees GBP",
       ROUND(((DD.fee+COALESCE(ROUND(PF.amount/100,2),0)) / COALESCE(DD.exchangeRate, CU.rate)*(DD.commissionRate/100)), 2) AS "Commission GBP",
       DD.type                                                   AS "Status",
       CONCAT(U.initials,'/',D.id)                               AS 'Deal ID',
       CASE
           WHEN DD.notes LIKE '%Coronavirus cancel%' THEN CONCAT('Coronavirus Cancellation')
           WHEN DD.notes LIKE '%Coronavirus%Reschedul%' THEN CONCAT('Coronavirus Reschedule')
           WHEN DD.notes LIKE '%Coronavirus Impacted%' THEN CONCAT('Coronavirus Impacted')
           WHEN DD.priceNotes LIKE '%Coronavirus cancel%' THEN CONCAT('Coronavirus Cancellation')
           WHEN DD.priceNotes LIKE '%Coronavirus Reschedul%' THEN CONCAT('Coronavirus Reschedule')
           WHEN DD.priceNotes LIKE '%Coronavirus Impacted%' THEN CONCAT('Coronavirus Impacted')
        END AS 'COV-19 Status',
       COALESCE(DD.tempPromoter, CONCAT(P.name, ' ', P.surname,' (',P.email,')')) AS "Promoter",
       DD.ticketPrice                                            AS "Ticket Price",
       DD.notes                                                AS "Notes",
	   IF(DD.cancelled , 'Yes', 'No')                                         AS "Show Cancelled",
	   IF(D.cancelled , 'Yes', 'No')                                           AS "Deal Cancelled"


FROM Deal_Date DD
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN User U ON A.agentID = U.id
         LEFT JOIN Venue V ON DD.venueID = V.id
         LEFT JOIN Country CO ON V.country = CO.id
         LEFT JOIN Currency CU ON DD.currencyID = CU.id
         LEFT JOIN Deal D ON DD.dealID = D.id
		 LEFT JOIN Contact P ON D.promoterID = P.id
		 LEFT JOIN (SELECT showID, category, SUM(amount) AS 'amount' FROM Contract_Extra WHERE category LIKE 'production_fee' GROUP BY showID) PF ON PF.showID = DD.id


WHERE (DD.notes LIKE '%Coronavirus%' OR DD.priceNotes LIKE '%Coronavirus%' OR DD.notes LIKE '%cancel%' OR DD.priceNotes LIKE '%cancel%' )
AND YEAR(DD.date) > 2019
GROUP BY DD.id
ORDER BY DD.date,A.name
