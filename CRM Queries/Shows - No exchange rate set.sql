SELECT CONCAT(U.initials,'/',DD.dealID) AS 'Contract Number',
       DD.date                  AS 'Date',
       A.name                   AS 'Artist Name',
       COALESCE(F.name, V.name) AS 'Venue',
       COALESCE(F.city, V.city) AS 'City',
       CX.code AS 'Currency',
       DD.exchangeRate AS 'FX Rate',
       DD.cvStatus AS CV

FROM Deal_Date DD
         LEFT JOIN Artist A ON A.id = DD.artistID
         LEFT JOIN Venue V ON V.id = DD.venueID
         LEFT JOIN Festival_Stages FS ON DD.festivalStageID = FS.id
         LEFT JOIN Festivals F ON FS.festivalID = F.id
         LEFT JOIN Deal D ON DD.dealID = D.id
	     LEFT JOIN User U ON U.id = DD.userID
		 LEFT JOIN Currency CX ON CX.id = DD.currencyID

WHERE DD.dealID IS NOT NULL
  AND DD.currencyID !=1
  AND DD.fee > 0
#   AND DD.date > CURRENT_DATE()
  AND DD.date BETWEEN '2022-01-01' AND '2022-09-30'
  AND (COALESCE(D.cancelled, 0) + DD.cancelled = 0)
  AND DD.exchangeRate IS NULL
ORDER BY DD.date, A.name