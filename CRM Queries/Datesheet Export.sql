SELECT DD.date                                                   AS "Date",
       COALESCE(DD.customCountry, CO.country)                    AS "Country",
       COALESCE(DD.customCity, V.city)                           AS "City",
       V.name                                                    AS "Venue",
       V.capacity                                                AS "Capacity",
       DD.budgetedCapacity                                       AS "Budgeted Capacity",
       DD.fee                                                    AS "Fee",
       CU.code                                                   AS "Currency",
       DD.type                                                   AS "Status",
       DD.notes                                                  AS "Notes",
       COALESCE(DD.tempPromoter, CONCAT(P.name, " ", P.surname)) AS "Promoter"


FROM Deal_Date DD
         LEFT JOIN Venue V ON DD.venueID = V.id
         LEFT JOIN Country CO ON V.country = CO.id
         LEFT JOIN Currency CU ON DD.currencyID = CU.id
         LEFT JOIN Deal D ON DD.dealID = D.id
         LEFT JOIN Contact P ON D.promoterID = P.id


WHERE DD.artistID = 1631
  AND DD.date LIKE "2020%"
ORDER BY DD.date
