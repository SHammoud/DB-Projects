SELECT
       DD.date                                                   AS "Date",
       CONCAT(U.initials,'/',D.id)                               AS "Deal ID",
       CONCAT(U.name,' ',U.surname)                                AS "Agent",
       CASE
            WHEN D.draft = 1 THEN 'DRAFT'
            ELSE DD.type END                                     AS "Status",
       MAX(CD.issue)                                             AS "Issue Number",
       MAX(CD.created_at)                                        AS 'Created',
       D.contractType                                            AS "Contract Type",
       A.name                                                    AS "Artist",
       COALESCE(DD.customCountry, CO.country)                    AS "Country",
       COALESCE(DD.customCity, V.city)                           AS "City",
       CO.region                                                 AS "Territory",
       V.name                                                    AS "Venue",
       V.capacity                                                AS "Capacity",
       DD.budgetedCapacity                                       AS "Budgeted Capacity",
       DD.fee                                                    AS "Fee",
	   COALESCE(ROUND(PF.amount/100,2),0)                        AS "Production Fee",
       CU.code                                                   AS "Currency",
       DD.notes                                                  AS "Notes",
       DD.priceNotes                                             AS "Extra Notes",
       DD.ticketPrice                                            AS "Ticket Price",
       COALESCE(DD.tempPromoter, CONCAT(P.name, ' ', P.surname,' (',P.email,')')) AS "Promoter"



FROM Deal_Date DD
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN User U ON A.agentID = U.id
         LEFT JOIN User BA ON A.bookingAssistantID = BA.id
         LEFT JOIN Venue V ON DD.venueID = V.id
         LEFT JOIN Country CO ON V.country = CO.id
         LEFT JOIN Currency CU ON DD.currencyID = CU.id
         LEFT JOIN Deal D ON DD.dealID = D.id
		 LEFT JOIN Contact P ON D.promoterID = P.id
         LEFT JOIN Contract_Data CD ON CD.contractID = D.id
		 LEFT JOIN (SELECT showID, category, SUM(amount) AS 'amount' FROM Contract_Extra WHERE category LIKE 'production_fee' GROUP BY showID) PF ON PF.showID = DD.id


WHERE DD.type IN ('CONTRACT', 'DEALMEMO')
  AND DD.fee > 0
  AND DD.date BETWEEN CURRENT_DATE AND '2022-12-31'
  AND D.cancelled = 0
GROUP BY DD.id
HAVING Created BETWEEN '2020-09-01' AND '2020-10-01'
ORDER BY Date, Artist
