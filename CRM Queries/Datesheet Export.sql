SELECT
       CONCAT(RA.name,' ',RA.surname)                              AS "Responsible Agent",
       GROUP_CONCAT(CONCAT(PA.name,' ',PA.surname,' (',ROUND(SA.splitRate),'%)')ORDER BY PA.name DESC SEPARATOR ',')                          AS "Agents",
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
		 LEFT JOIN User RA ON RA.id = D.userID
         LEFT JOIN ShowAgents SA ON SA.showId = DD.id
		 LEFT JOIN User PA ON PA.id = SA.agentId


WHERE YEAR(DD.date) >2022
# AND MONTHNAME(DD.date) IN ('January', 'February', 'March','April', 'May', 'June','July','August')
AND DD.fee > 0
AND PA.subtypeID = 13
#   AND (A.agentID = 2757 OR A.secondaryAgentID = 2757)

AND DD.dealID IS NOT NULL
GROUP BY DD.id
ORDER BY DD.date
