SELECT
       F.name AS "Festival",
       F.city AS 'City',
       C.country AS 'Country',
			DATE_FORMAT(COALESCE(F.nextStartDate,F.startDate,FP.startDate), '%d %M') AS 'Festival Start',
            DATE_FORMAT(COALESCE(F.nextEndDate,F.endDate,FP.endDate), '%d %M') AS 'End',
       CONCAT("https://www.codacrm.com/festivals/", F.id) AS "URL"

FROM Festivals F
LEFT JOIN Festival_Periods FP ON F.id = FP.festivalID
LEFT JOIN Country C ON F.country = C.code
LEFT JOIN Territory T ON C.territoryID = T.id

WHERE F.deleted_at IS NULL
# AND T.name = 'Europe'
AND DATE_FORMAT(COALESCE(F.nextStartDate,F.startDate,FP.startDate), '%m-%d') BETWEEN '06-23' AND '07-15'

GROUP BY F.id
ORDER BY  DATE_FORMAT(COALESCE(F.nextStartDate,F.startDate,FP.startDate), '%m-%d')