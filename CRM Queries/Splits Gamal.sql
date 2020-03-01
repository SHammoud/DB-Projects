SELECT

A.name AS 'Artist',
CONCAT(PA.name,' ',PA.surname) AS 'Primary Agent',
CONCAT(SA.name,' ',SA.surname) AS 'Secondary Agent',
CONCAT(A.splitRate,'%') AS 'Split Rate',
SUM(SAR.commissions)

FROM Artist A
LEFT JOIN User PA ON A.agentID = PA.id
LEFT JOIN User SA ON A.secondaryAgentID = SA.id
LEFT JOIN Snapshots_Artist_Report SAR ON SAR.artistId = A.id
WHERE A.disabled IS NULL
AND SAR.date = '2020-03-01'
AND SAR.year = 2020
GROUP BY A.id
ORDER BY A.name