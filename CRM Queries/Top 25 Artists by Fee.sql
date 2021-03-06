# Imported from Cluvio
SELECT
    A.name AS "Artist",
    SUM(SA.fees) AS "Fees"
FROM
    Snapshots_Agent_Report SA
    LEFT JOIN Artist A on A.id = SA.artistId
WHERE
# Set snapshot date
	SA.date = '2019-12-31'
# Set year you want data for
AND SA.year= '2019'
# Add agent ID if required
#   AND SA.agentId=39
GROUP BY
    SA.date,
    SA.artistId
HAVING Fees > 0
ORDER BY
    Fees DESC
LIMIT
    25