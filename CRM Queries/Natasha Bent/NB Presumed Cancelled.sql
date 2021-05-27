SELECT DD.date AS 'Date',
       DD.id AS 'Show ID',
       D.id AS 'Contract ID',
       DD.type AS 'Type',
       DD.cvStatus AS 'CV Status',
       A.name AS 'Artist',
       V.city AS 'City',
       CO.country AS 'Country',
       CX.code AS 'Currency',
       DD.fee AS 'Fee',
       DD.notes AS 'Notes',
       DD.priceNotes

FROM Deal_Date DD

LEFT JOIN Deal D ON DD.dealID = D.id
LEFT JOIN Artist A ON DD.artistID = A.id
LEFT JOIN Venue V ON DD.venueID = V.id
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Contact P ON D.promoterID = P.id
LEFT JOIN Currency CX on DD.currencyID = CX.id

WHERE DD.artistID IN (1831) AND DD.date > "2021-06-01" AND DD.fee > 0