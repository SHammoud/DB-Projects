SELECT

A.name AS 'Artist',
DD.date AS 'Date',
CONCAT(PA.initials,'/',DD.dealID) AS 'Contract Number',
CONCAT(PA.name,' ',PA.surname) AS 'Primary Agent',
CONCAT(SA.name,' ',SA.surname) AS 'Secondary Agent',
CONCAT(A.splitRate,'%') AS '[ARTIST] Split Rate',
CONCAT(DD.splitRate,'%') AS 'Split Rate',
CONCAT(A.commissionRate,'%') AS '[ARTIST] Commission Rate',
CONCAT(DD.commissionRate,'%') AS 'Commission Rate'

FROM Deal_Date DD
LEFT JOIN Deal D ON D.id = DD.dealID
LEFT JOIN User PA ON DD.userID = PA.id
LEFT JOIN User SA ON  D.secondaryAgentID = SA.id
LEFT JOIN Artist A ON D.artistID = A.id

WHERE DD.dealID IS NOT NULL
  AND (DD.splitRate IS NULL OR DD.splitRate IS NULL)
  AND YEAR(DD.date) = 2021
AND (DD.userID = 40 OR D.secondaryAgentID = 40)


  


