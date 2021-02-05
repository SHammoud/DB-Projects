SELECT
       DD.date                                                   AS "Date",
       CONCAT(U.initials,'/',D.id)                               AS "Deal ID",
       CASE
            WHEN D.draft = 1 THEN 'DRAFT'
            ELSE DD.type END                                     AS "Status",
       D.contractType                                            AS "Contract Type",
       CASE
       WHEN DD.cvStatus = 'PRESUMED_CANCELLATION' THEN 'PRESUMED CANCELLED'
       WHEN DD.cvStatus = 'RESCHEDULE' THEN 'RESCHEDULE'
       WHEN DD.cvStatus = 'SUCCESSFULLY_RESCHEDULED' THEN 'SUCCESSFULLY RESCHEDULED'
       END                                                       AS 'CV Status',
       CONCAT(U.name, ' ',U.surname)                             AS 'Agent',
       A.name                                                    AS "Artist",
       COALESCE(DD.customCountry, CO.country)                    AS "Country",
       COALESCE(DD.customCity, V.city)                           AS "City",
       CO.region                                              AS "Territory",
       V.name                                                    AS "Venue",
       V.capacity                                                AS "Capacity",
       DD.budgetedCapacity                                       AS "Budgeted Capacity",
       DD.fee                                                    AS "Fee",
	   COALESCE(ROUND(PF.amount/100,2),0)                        AS "Production Fee",
       ROUND(OV.amount / 100, 2)                                 AS "Commissionable_Extras",
       CX.code                                                   AS "Currency",
       CONCAT(COALESCE(DD.commissionRate, A.commissionRate),'%')     AS "Commission Rate",
       COALESCE(DD.exchangeRate, CX.rate)                        AS "Exchange Rate",
       ROUND((COALESCE(DDCF.fee, DCF.fee, DD.fee) + COALESCE((OV.amount / 100),0)) / COALESCE(DD.exchangeRate, CX.rate)      ,2) AS "Total Fee GBP",
       ROUND((((COALESCE(DDCF.fee, DCF.fee, DD.fee) + COALESCE((OV.amount / 100),0)) * COALESCE(DD.commissionRate, A.commissionRate) / 100)) / COALESCE(DD.exchangeRate, CX.rate)      ,2) AS "Total Commision GBP",
       DD.notes                                                  AS "Notes",
       DD.priceNotes                                             AS "Extra Notes",
       COALESCE(DD.tempPromoter, CONCAT(P.name, ' ', P.surname,' (',P.email,')')) AS "Promoter",
       MAX(AL.info) AS "Info",
       MAX(AL.created_at) AS "Updated At",
       MAX(CONCAT(ALU.name,' ',ALU.surname)) "Updated By"



FROM Deal_Date DD
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN User U ON A.agentID = U.id
         LEFT JOIN User BA ON A.bookingAssistantID = BA.id
         LEFT JOIN Venue V ON DD.venueID = V.id
         LEFT JOIN Country CO ON V.country = CO.id
         LEFT JOIN Currency CX ON CX.id = DD.currencyID
         LEFT JOIN Deal D ON DD.dealID = D.id
         LEFT JOIN Cancellation_Fee DCF ON DCF.dealID = DD.dealID
         LEFT JOIN Cancellation_Fee DDCF ON DDCF.dealDateID = DD.id
		 LEFT JOIN Contact P ON D.promoterID = P.id
		 LEFT JOIN (SELECT showID, category, SUM(amount) AS 'amount' FROM Contract_Extra WHERE category LIKE 'production_fee' GROUP BY showID) PF ON PF.showID = DD.id
         LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount"
                    FROM Contract_Extra
                    WHERE TYPE LIKE "above_line"
                    GROUP BY showID) OV ON OV.showID = DD.id
		LEFT JOIN Activity_Log AL ON AL.showId = DD.id
		LEFT JOIN User ALU ON ALU.id = AL.userID

WHERE DD.type NOT IN ('OFFER_REJECTED')
  AND DD.fee > 0
  AND DD.date BETWEEN '2021-01-01' AND '2021-03-31'
  AND (COALESCE(D.cancelled, 0) + DD.cancelled = 0)

GROUP BY DD.id

ORDER BY Date, Artist