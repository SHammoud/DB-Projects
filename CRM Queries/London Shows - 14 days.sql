SELECT DD.date AS 'Date',
       A.name AS 'Artist Name',
       COALESCE(F.name,V.name) AS 'Venue'
FROM Deal_Date DD
    LEFT JOIN Artist A ON A.id = DD.artistID
    LEFT JOIN Venue V ON V.id = DD.venueID
    LEFT JOIN Festival_Stages FS ON DD.festivalStageID = FS.id
    LEFT JOIN Festivals F ON FS.festivalID = F.id
    LEFT JOIN Deal D ON DD.dealID = D.id
WHERE V.city LIKE 'London' AND DD.type = 'CONTRACT'
  AND DD.date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE, INTERVAL +20  DAY)
  AND D.cancelled = 0
  AND DD.cancelled = 0
  AND DD.isCorporate = 0
ORDER BY DD.date ASC