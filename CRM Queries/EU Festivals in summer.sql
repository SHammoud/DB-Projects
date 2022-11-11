SELECT
       F.name AS "Festival",
       F.city AS 'City',
       C.country AS 'Country'
# 			DATE_FORMAT(COALESCE(F.nextStartDate,F.startDate,FP.startDate), '%d %M') AS 'Festival Start',
#             DATE_FORMAT(COALESCE(F.nextEndDate,F.endDate,FP.endDate), '%d %M') AS 'End',
#
#        COALESCE(MAX(P.email),MAX(CP.email)) AS 'Promoter'
# #        CONCAT("https://www.codacrm.com/festivals/", F.id) AS "URL"

FROM Festivals F
LEFT JOIN Festival_Periods FP ON F.id = FP.festivalID
LEFT JOIN Country C ON F.country = C.code
LEFT JOIN Territory T ON C.territoryID = T.id
LEFT JOIN Contact CP ON F.contactID = CP.id
LEFT JOIN Venue V on F.id = V.festivalId
LEFT JOIN Deal_Date DD on V.id = DD.venueID
LEFT JOIN Deal D on DD.dealID = D.id
LEFT JOIN Contact P ON D.promoterID = P.id

WHERE F.deleted_at IS NULL
AND T.name IN ('Europe', 'United Kingdom')
# AND DATE_FORMAT(COALESCE(F.nextStartDate,F.startDate,FP.startDate), '%m-%d') BETWEEN '08-12' AND '08-30'

GROUP BY F.id
ORDER BY  DATE_FORMAT(COALESCE(F.nextStartDate,F.startDate,FP.startDate), '%m-%d')