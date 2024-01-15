SELECT
    A.name,
    GROUP_CONCAT(U.name,' ',U.surname,' ' SEPARATOR '- ') AS 'Agents',
    CONCAT(ROUND(AA.splitRate),'%') AS 'Split',
    CONCAT(ROUND(AAC.commissionRate),'%') 'Commisison'



FROM Artist A
LEFT JOIN v2_project_coda.ArtistAgent AA on A.id = AA.artistId
LEFT JOIN User U ON AA.agentId = U.id
LEFT JOIN v2_project_coda.ArtistAgentConditions AAC on AA.conditionId = AAC.id
LEFT JOIN v2_project_coda.ArtistAgentConditionCountry AACC on AAC.id = AACC.conditionId
LEFT JOIN v2_project_coda.ArtistAgentConditionTerritory AACT on AAC.id = AACT.conditionId
WHERE A.disabled IS NULL
AND AACC.countryId IS NULL
AND AACT.territoryId IS NULL
AND AAC.deleted_at IS NULL
AND AAC.end IS NULL

GROUP BY A.id
ORDER BY A.name