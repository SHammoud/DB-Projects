SELECT
       DD.date                                                   AS "Date",
       A.name AS 'Artist',
       COALESCE(DD.customCountry, CO.country)                    AS "Country",
       COALESCE(DD.customCity, V.city)                           AS "City",
       V.name                                                    AS "Venue",
       V.capacity                                                AS "Capacity",
       D.contractType                                            AS "Contract Type",
       V.isFestival                                              AS "Is Festival"


FROM Deal_Date DD
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN Venue V ON DD.venueID = V.id
         LEFT JOIN Country CO ON V.country = CO.id
         LEFT JOIN Currency CU ON DD.currencyID = CU.id
         LEFT JOIN Deal D ON DD.dealID = D.id
		 LEFT JOIN Contact P ON D.promoterID = P.id


WHERE YEAR(DD.date) = 2019
  AND DD.artistID NOT IN (1764)
  AND DD.dealID IS NOT NULL
ORDER BY DD.date,A.name
