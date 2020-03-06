SELECT
       MAX(CONCAT(C.name,' ',C.surname)) AS 'Agent',
       S.dateOriginal AS 'Date',
       MAX(SSR.foreignId) AS 'Foreign Show ID',
       MAX(SSR.systemId) AS 'System ID',
       A.name AS 'Artist',
       A.id AS 'Artist ID',
       V.name AS 'Venue',
       V.id AS 'Venue ID',
       S.type AS 'Status',
       S.fee AS 'Fee',
       CU.code AS 'Currency',
       MAX(CONCAT(P.name,' ',P.surname)) AS 'Promoter Name',
       MAX(P.email) AS 'Promoter Email'
      

FROM `Show` S
LEFT JOIN ShowSourceRelation SSR ON S.id = SSR.showId
LEFT JOIN Contract D ON S.contractId = D.id
LEFT JOIN ContractContact CC ON D.id = CC.contractId
LEFT JOIN Contact P ON CC.contactId = P.id
LEFT JOIN Currency CU ON S.currencyId = CU.id
LEFT JOIN Artist A ON S.artistId = A.id
LEFT JOIN Venue V ON S.venueId = V.id
LEFT JOIN ArtistSourceRelation ASR ON A.id = ASR.artistId
LEFT JOIN ArtistContact AC ON A.id = AC.artistId
LEFT JOIN Contact C ON AC.contactId = C.id

WHERE
      AC.type IN ('agent')
AND P.type IN ('promoter')
GROUP BY S.id
