# Requested by Madie

SELECT
       CONCAT(U.name,' ',U.surname)                              AS "Agent",
       A.name                                                    AS "Artist",
       DD.date                                                   AS "Date",
       COALESCE(DD.customCountry, CO.country)                    AS "Country",
       COALESCE(DD.customCity, V.city)                           AS "City",
       V.name                                                    AS "Venue",
       V.capacity                                                AS "Capacity",
       DD.budgetedCapacity                                       AS "Budgeted Capacity",
       DD.fee                                                    AS "Fee",
       CU.code                                                   AS "Currency",
       DD.type                                                   AS "Status",
       DD.notes                                                  AS "Notes",
       DD.ticketPrice                                            AS "Ticket Price",

       COALESCE(DD.tempPromoter, CONCAT(P.name, ' ', P.surname,' (',P.email,')')) AS "Promoter"


FROM Deal_Date DD
         LEFT JOIN  Artist A ON DD.artistID = A.id
         LEFT JOIN User U ON U.id = A.agentID
         LEFT JOIN Venue V ON DD.venueID = V.id
         LEFT JOIN Country CO ON V.country = CO.id
         LEFT JOIN Currency CU ON DD.currencyID = CU.id
         LEFT JOIN Deal D ON DD.dealID = D.id
		 LEFT JOIN Contact P ON D.promoterID = P.id


WHERE DD.dealType IN ('plusdealcross', 'plusdeal')

  AND DD.date LIKE "2020%"
ORDER BY U.name, A.name, DD.date
