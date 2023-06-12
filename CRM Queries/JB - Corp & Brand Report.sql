SELECT
    CONCAT(U.initials,'/',DD.dealID) AS 'Contract ID',
    D.contractType 'Contract Type',
    DD.date AS 'Date',
    A.name AS 'Artist',
    V.name AS 'Venue',
    V.city AS 'City',
    CO.country AS 'Country',
    CX.code AS 'Currency',
    DD.worth AS 'Fee',
    CONCAT(P.name,' ',P.name) AS 'Promoter',
    P.email AS 'Promoter Email',
    P.companyName AS 'Company'

FROM Deal_Date DD
LEFT JOIN Deal D on DD.dealID = D.id
LEFT JOIN User U on DD.userID = U.id
LEFT JOIN Artist A on DD.artistID = A.id
LEFT JOIN Venue V on DD.venueID = V.id
LEFT JOIN Country CO on V.country = CO.id
LEFT JOIN Contact P on D.promoterID = P.id
LEFT JOIN Currency CX on DD.currencyID = CX.id

WHERE YEAR(DD.date) IN (2018,2019)
AND DD.dealID IS NOT NULL
AND D.contractType IN ('BRANDPARTNERSHIP', 'CORPORATE')
AND D.cancelled = 0
AND A.name not LIKE 'Demo%'
AND P.email NOT LIKE '%@genio.io'

ORDER BY DD.date