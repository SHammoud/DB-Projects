SELECT
A.name AS "Name",
CONCAT(PA.name,' ',PA.surname) AS "Primary Agent",
CONCAT(SA.name,' ',SA.surname) AS "Secondary Agent",
CONCAT(A.commissionRate,'%') AS "Commision",
CASE WHEN A.splitRate = 100.000 THEN NULL
    ELSE CONCAT(ROUND(A.splitRate,0),"%")
    END AS "Split Rate",
N.nationality AS "Nationality",
CO.country AS "Country"

FROM Artist A
LEFT JOIN User PA ON A.agentID = PA.id
LEFT JOIN User SA ON A.secondaryAgentID = SA.id
LEFT JOIN Country CO ON A.country = CO.id
LEFT JOIN Nationality N ON A.nationalityID = N.id

WHERE A.disabled IS NULL
AND A.name NOT LIKE ''
 AND A.name NOT LIKE '%(Paradigm)%'

ORDER BY A.name