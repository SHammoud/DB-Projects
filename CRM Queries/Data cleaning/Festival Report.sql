SELECT
F.name AS "Festival",
F.city AS "City",
CO.country AS "Country",
DATE_FORMAT(COALESCE(F.nextStartDate,F.startDate,FP.startDate), '%d %M') AS 'Festival Start',
DATE_FORMAT(COALESCE(F.nextEndDate,F.endDate,FP.endDate), '%d %M') AS 'End'

FROM Festivals F
LEFT JOIN Country CO ON F.country = CO.code
LEFT JOIN Festival_Periods FP ON F.id = FP.festivalID

WHERE F.deleted_at IS NULL
GROUP BY F.id
ORDER BY F.name