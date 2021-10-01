SELECT DD.dealID,
       DD.date                  AS 'Date',
       A.name                   AS 'Artist Name',
       COALESCE(F.name, V.name) AS 'Venue',
       COALESCE(F.city, V.city) AS 'City'

FROM Deal_Date DD
         LEFT JOIN Artist A ON A.id = DD.artistID
         LEFT JOIN Venue V ON V.id = DD.venueID
         LEFT JOIN Festival_Stages FS ON DD.festivalStageID = FS.id
         LEFT JOIN Festivals F ON FS.festivalID = F.id
         LEFT JOIN Deal D ON DD.dealID = D.id

WHERE DD.dealID IS NOT NULL
  AND DD.fee > 0
  AND DD.date > CURRENT_DATE()
  AND (COALESCE(D.cancelled, 0) + DD.cancelled = 0)
  AND DD.exchangeRate IS NULL
ORDER BY A.name, DD.date