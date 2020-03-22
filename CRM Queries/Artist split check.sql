SELECT

A.name AS 'Artist',
DD.date AS 'Date',
CONCAT(PA.initials,'/',D.id) AS 'Contract Number',
CONCAT(PA.name,' ',PA.surname) AS 'Primary Agent',
CONCAT(SA.name,' ',SA.surname) AS 'Secondary Agent',
CONCAT(DD.splitRate,'%') AS 'Split Rate',
CONCAT(DD.commissionRate,'%') AS 'Commission Rate'

FROM Deal_Date DD
LEFT JOIN Deal D ON DD.dealID = D.id
LEFT JOIN User PA ON D.userID = PA.id
LEFT JOIN User SA ON D.secondaryAgentID = SA.id
LEFT JOIN Artist A ON D.artistID = A.id

WHERE A.name = '' # <-- Artist name here


