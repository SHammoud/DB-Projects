SELECT
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
       CASE
           WHEN DD.cvStatus = 'PRESUMED_CANCELLATION' THEN 'PRESUMED CANCELLED'
           WHEN DD.cvStatus = 'RESCHEDULE' THEN 'RESCHEDULE'
           WHEN DD.cvStatus = 'SUCCESSFULLY_RESCHEDULED' THEN 'SUCCESSFULLY RESCHEDULED'
           WHEN DD.cvStatus = 'RESCHEDULE_TBC' THEN 'RESCHEDULE TBC'
           WHEN DD.cvStatus IS NULL THEN ''
       END                                                       AS 'CVStatus',
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


WHERE YEAR(DD.date) > 2020
  AND DD.venueID IN ('7337', '7338', '7340', '7341', '9028', '22610', '24219', '24220', '24221', '24222', '22608', '22609', '19476', '9129', '21033', '24554', '2064', '971', '4113', '1372', '6841', '6854', '8673', '3812', '1945', '3202', '10038', '12517', '18471', '9161', '9151', '10802', '7133', '4781', '4829', '4830', '1708', '7226', '10506', '9257', '9159', '5553', '7379', '11467', '5302', '19281', '21536', '19345', '625', '20819', '1037', '1136', '2438', '1979', '9243', '1208', '12293', '1217', '20222', '1042', '1327', '18243', '24531', '10143', '6806', '4803', '1323')
  AND (COALESCE(D.cancelled, 0) + DD.cancelled = 0)
ORDER BY DD.date,A.name
