
SET @snapDate := '2020-01-05'; // <--- Set the date of the snapshot here
SET @reportYear := '2020'; // <--- Set the year you want the numbers for


SELECT
    CONCAT(U.name,' ',U.surname) AS 'Agent',
    A.name AS "Artist",
    SUM(SA.gross_commission) AS "Commission"

FROM Snapshots_Agent_Report SA
    LEFT JOIN Artist A on A.id = SA.artistId
	LEFT JOIN User U ON SA.agentId = U.id

WHERE
    SA.date = @snapDate
    AND SA.year = @reportYear

GROUP BY U.name, A.name
