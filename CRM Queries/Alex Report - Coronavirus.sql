SELECT
       DD.date                                                   AS "Date",
       A.name                                                    AS "Artist",
       COALESCE(DD.customCountry, CO.country)                    AS "Country",
       COALESCE(DD.customCity, V.city)                           AS "City",
       V.name                                                    AS "Venue",
       V.capacity                                                AS "Capacity",
       DD.budgetedCapacity                                       AS "Budgeted Capacity",
       DD.fee                                                    AS "Fee",
       CU.code                                                   AS "Currency",
       DD.type                                                   AS "Status",
       CONCAT(U.initials,'/',D.id)                               AS 'Deal ID',
       DD.notes                                                  AS "Notes",
       DD.ticketPrice                                            AS "Ticket Price",

       COALESCE(DD.tempPromoter, CONCAT(P.name, ' ', P.surname,' (',P.email,')')) AS "Promoter"


FROM Deal_Date DD
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN User U ON A.agentID = U.id
         LEFT JOIN Venue V ON DD.venueID = V.id
         LEFT JOIN Country CO ON V.country = CO.id
         LEFT JOIN Currency CU ON DD.currencyID = CU.id
         LEFT JOIN Deal D ON DD.dealID = D.id
		 LEFT JOIN Contact P ON D.promoterID = P.id


WHERE DD.type = 'CONTRACT'
  AND DD.date BETWEEN CURRENT_DATE AND '2020-04-30'
  AND D.cancelled = 0
  AND DD.cancelled = 0
  AND (A.agentID = 40 OR A.secondaryAgentID = 40)

ORDER BY DD.date,A.name
