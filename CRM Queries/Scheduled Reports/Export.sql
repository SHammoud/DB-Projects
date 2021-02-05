SELECT
       DD.date                                                                     AS "From Date",
       A.name                                                                      AS 'Artist',
       A.id                                                                        AS 'Artist Id',
       DD.dealID                                                                   AS 'Deal Number',
       CONCAT(NULL)                                                                AS 'Billing',
       DD.type                                                                     AS "Status",
       CONCAT(NULL)                                                                AS 'Offer Date',
       IF(DD.announcementDate = 0000-00-00, CONCAT(NULL), DD.announcementDate)     AS 'Announce Date',
       D.contractType                                                              AS 'Show/Type',
       COALESCE(DD.tempPromoter, CONCAT(P.name, ' ', P.surname,' (',P.email,')'))  AS "Promoter",
       CU.code                                                                     AS "Currency",
       DD.fee                                                                      AS "Guarantee",
       IF(DD.dealType = "flatfee", CONCAT("Flat Guarantee"), DD.dealType)          AS "Deal Type",
       CONCAT(NULL)                                                                AS "Public Show",
	   COUNT(*)                                                                    AS "Number Shows",
       DD.budgetedCapacity                                                         AS "Total Ticket Quantity (For Sale Only)",
	   CONCAT(NULL)                                                                AS "Ave Ticket Price",
       DD.ticketPrice                                                              AS "Ticket Price",
       CONCAT(NULL)                                                                AS "Scaling List",
	   CONCAT(NULL)                                                                AS "Scaling Notes",
       DD.notes                                                                    AS "Deal Notes",
	   COALESCE(CONCAT(AB.name,' ',AB.surname),CONCAT(AR.name,' ',AR.surname))     AS "Agent-Booking",
	   CONCAT(AR.name,' ',AR.surname)                                              AS "Agent-Resp."


FROM Deal_Date DD
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN Venue V ON DD.venueID = V.id
         LEFT JOIN Country CO ON V.country = CO.id
         LEFT JOIN Currency CU ON DD.currencyID = CU.id
         LEFT JOIN Deal D ON DD.dealID = D.id
		 LEFT JOIN Contact P ON D.promoterID = P.id
        LEFT JOIN User AB ON D.userID = AB.id
		 LEFT JOIN User AR ON A.agentID = AR.id


WHERE DD.streamingType = 1
GROUP BY DD.dealID
ORDER BY DD.date,A.name
