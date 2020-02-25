SELECT

A.name AS 'Artist',
CONCAT(PA.name,' ',PA.surname) AS 'Primary Agent',
CONCAT(SA.name,' ',SA.surname) AS 'Secondary Agent',
ROUND(A.splitRate) AS 'Split Rate'

FROM Artist A
LEFT JOIN User PA ON A.agentID = PA.id
LEFT JOIN User SA ON A.secondaryAgentID = SA.id
WHERE A.disabled IS NULL