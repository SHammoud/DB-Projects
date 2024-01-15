SELECT
P.pname AS 'Band',
T.tname AS 'Tour Namer',
DATE_ADD(FROM_UNIXTIME(S.sdate, '%Y-%m-%d'),INTERVAL 1 DAY) AS 'Date',
S.stown AS 'Town',
S.svenue AS 'Venue',
S.scap AS 'Cap',
S.final AS 'Final Count'

FROM shows S

LEFT JOIN performers P ON S.pid = P.pid
LEFT JOIN tours T on S.tid = T.tid

WHERE DATE_ADD(FROM_UNIXTIME(S.sdate, '%Y-%m-%d'),INTERVAL 1 DAY) BETWEEN '2022-02-01' AND '2023-01-31'
AND T.archived = 0
ORDER BY S.sdate,P.pname ASC