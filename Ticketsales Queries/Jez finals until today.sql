SELECT
P.pagent AS 'Agent',
P.pname AS 'Band',
T.tname AS 'Tour Name',
# DATE_ADD(FROM_UNIXTIME(S.sdate, '%Y-%m-%d'),INTERVAL 1 DAY) AS 'Date',
FROM_UNIXTIME(S.sdate, '%Y-%m-%d') AS 'Date',
S.stown AS 'Town',
S.svenue AS 'Venue',
S.scap AS 'Cap',
S.final AS 'Final Count'

FROM shows S

LEFT JOIN performers P ON S.pid = P.pid
LEFT JOIN tours T on S.tid = T.tid

# WHERE YEAR(FROM_UNIXTIME(S.sdate, '%Y-%m-%d')) = 2023
WHERE FROM_UNIXTIME(S.sdate, '%Y-%m-%d') < NOW()
AND S.final = 0
AND T.archived = 0
ORDER BY S.sdate,P.pname ASC
