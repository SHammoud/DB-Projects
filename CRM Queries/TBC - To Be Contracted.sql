SELECT
    CONCAT(U.name,' ',U.surname) AS 'Agent',
    DD.date AS 'Date',
       CASE
            WHEN DD.type ='DEALMEMO' THEN 'DRAFT'
            ELSE DD.type
        END    AS 'Status',
    CONCAT(LEFT(U.name,1),LEFT(U.surname,1),'/',DD.dealID) AS 'Contract Number',
    A.name AS 'Artist',
    V.name AS 'Venue',
    V.city AS 'City',
    C.country AS 'Country',
    DD.fee AS 'Fee',
    CX.currency AS 'Currency',
    DD.notes AS 'Notes',
    CONCAT(UA.name,' ',UA.surname) AS 'Assistant'

FROM Deal_Date DD

LEFT JOIN Artist A ON DD.artistID = A.id
LEFT JOIN User U ON A.agentID = U.id
LEFT JOIN Venue V on DD.venueID = V.id
LEFT JOIN Country C on V.country = C.id
LEFT JOIN Currency CX on DD.currencyID = CX.id
LEFT JOIN User UA on A.bookingAssistantID = UA.id

WHERE

A.name != 'Demo Artist'
AND DD.date > NOW()
AND DD.type IN ('CONFIRMED','DEALMEMO')
AND A.disabled IS NULL
# HAVING Agent IN ('Tom Schroeder')

ORDER BY A.name, DD.date