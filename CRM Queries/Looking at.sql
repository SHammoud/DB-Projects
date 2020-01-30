SELECT SM.date,
       CONCAT(U.name, " ", U.surname) AS "Agent",
       SUM(SM.gross_commission)       AS "Commission",
       SUM(SM.corporate_remaining_commission)

FROM Snapshots_Master_Report SM
         LEFT JOIN `User` U ON U.id = SM.agentId
WHERE SM.year = 2019
  AND SM.date = "2018-12-01"

GROUP BY SM.date, SM.agentId
HAVING Commission > 0    