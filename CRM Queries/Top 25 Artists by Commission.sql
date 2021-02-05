SELECT
    A.name AS "Artist",
    SUM(SA.gross_commission) AS "Commission"
FROM
    Snapshots_Agent_Report SA
    LEFT JOIN Artist A on A.id = SA.artistId
WHERE
# Set snapshot date
	SA.date = '2019-12-31'
# Set year you want data for
AND SA.year= '2019'


GROUP BY
	A.id

ORDER BY
    Commission DESC
LIMIT
    100