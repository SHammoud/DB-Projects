SELECT
       CONCAT(U.name,' ',U.surname)                              AS "Agent",
       DD.date                                                   AS "Date",
       A.name AS 'Artist',
       COALESCE(DD.customCountry, CO.country)                    AS "Country",
       COALESCE(DD.customCity, V.city)                           AS "City",
       V.name                                                    AS "Venue",
       V.capacity                                                AS "Capacity",
       DD.budgetedCapacity                                       AS "Budgeted Capacity",
       DD.fee                                                    AS "Fee",
       CU.code                                                   AS "Currency",
       CASE
            WHEN DD.type ='DEALMEMO' THEN 'DRAFT'
            ELSE DD.type
        END                                                      AS "Status",
       DD.notes                                                  AS "Notes",
       DD.ticketPrice                                            AS "Ticket Price",

       COALESCE(DD.tempPromoter, CONCAT(P.name, ' ', P.surname,' (',P.email,')')) AS "Promoter"


FROM Deal_Date DD
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN Venue V ON DD.venueID = V.id
         LEFT JOIN Country CO ON V.country = CO.id
         LEFT JOIN Currency CU ON DD.currencyID = CU.id
         LEFT JOIN Deal D ON DD.dealID = D.id
		 LEFT JOIN Contact P ON D.promoterID = P.id
		 LEFT JOIN User U ON A.agentID = U.id


WHERE YEAR(DD.date) = 2022
AND MONTHNAME(DD.date) IN ('January', 'February', 'March')
AND DD.artistID NOT IN (1764)
AND DD.type NOT IN ('DEALMEMO', 'CONTRACT', 'OFFER_REJECTED', 'CANCELLED')
AND DD.fee > 0
#   AND (A.agentID = 1330 OR A.secondaryAgentID = 1330)
ORDER BY Agent,A.name,DD.date
