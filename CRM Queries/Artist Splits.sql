SELECT

A.name AS 'Artist',
CONCAT(PA.name,' ',PA.surname) AS 'Primary Agent',
CONCAT(SA.name,' ',SA.surname) AS 'Secondary Agent',
ROUND(A.splitRate) AS 'Split Rate',
A.created_at

FROM Artist A
LEFT JOIN User PA ON A.agentID = PA.id
LEFT JOIN User SA ON A.secondaryAgentID = SA.id
WHERE A.disabled IS NULL
AND (A.agentID = 1624 OR A.secondaryAgentID = 1624 )
ORDER BY A.name