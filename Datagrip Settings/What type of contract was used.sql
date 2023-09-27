SELECT
       DD.date                                                   AS "Date",
       CONCAT(U.initials,'/',D.id)                               AS "Deal ID",
       CASE
            WHEN D.draft = 1 THEN 'DRAFT'
            ELSE DD.type END                                     AS "Status",
#        CASE
#            WHEN DD.cvStatus = 'PRESUMED_CANCELLATION' THEN 'PRESUMED CANCELLED'
#            WHEN DD.cvStatus = 'RESCHEDULE' THEN 'RESCHEDULE'
#            WHEN DD.cvStatus = 'SUCCESSFULLY_RESCHEDULED' THEN 'SUCCESSFULLY RESCHEDULED'
#            WHEN DD.cvStatus = 'RESCHEDULE_TBC' THEN 'RESCHEDULE TBC'
#            WHEN DD.cvStatus IS NULL THEN ''
#        END                                                       AS 'CVStatus',
       D.contractType                                            AS "Contract Type",
       D.contractSubtype										 AS "Contract Subtype",
       A.name                                                    AS "Artist",
       COALESCE(DD.customCountry, CO.country)                    AS "Country",
       COALESCE(DD.customCity, V.city)                           AS "City",
       CO.region                                              AS "Territory",
       V.name                                                    AS "Venue",
       V.capacity                                                AS "Capacity",
       DD.budgetedCapacity                                       AS "Budgeted Capacity",
       DD.fee                                                    AS "Fee",
	   COALESCE(ROUND(PF.amount/100,2),0)                        AS "Production Fee"
#        CU.code                                                   AS "Currency",
#        DD.notes                                                  AS "Notes",
#        DD.priceNotes                                             AS "Extra Notes",
#        DD.ticketPrice                                            AS "Ticket Price",
#        COALESCE(DD.tempPromoter, CONCAT(P.name, ' ', P.surname,' (',P.email,')')) AS "Promoter"
# #       CONCAT(BA.name,' ',BA.surname)                             AS "Booking Assistant"



FROM Deal_Date DD
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN User U ON A.agentID = U.id
         LEFT JOIN User BA ON A.bookingAssistantID = BA.id
         LEFT JOIN Venue V ON DD.venueID = V.id
         LEFT JOIN Country CO ON V.country = CO.id
         LEFT JOIN Currency CU ON DD.currencyID = CU.id
         LEFT JOIN Deal D ON DD.dealID = D.id
		 LEFT JOIN Contact P ON D.promoterID = P.id
		 LEFT JOIN (SELECT showID, category, SUM(amount) AS 'amount' FROM Contract_Extra WHERE category LIKE 'production_fee' GROUP BY showID) PF ON PF.showID = DD.id


WHERE DD.type NOT IN ('OFFER_REJECTED')
  AND DD.fee > 0
#   AND DD.date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, INTERVAL 24 MONTH)
#   AND DD.date BETWEEN '2021-01-01' AND '2021-12-31'
AND YEAR(DD.date) = 2023
  AND (COALESCE(D.cancelled, 0) + DD.cancelled = 0)
  AND V.id = 25062

ORDER BY Date