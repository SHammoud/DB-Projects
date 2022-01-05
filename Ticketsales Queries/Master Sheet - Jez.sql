SELECT
P.pname AS 'Band',
S.stown AS 'Town',
S.svenue AS 'Venue',
DATE_ADD(FROM_UNIXTIME(S.sdate, '%Y-%m-%d'),INTERVAL 1 DAY) AS 'Date',
CONCAT ('') AS 'Meeting',
S.scap AS 'Costed Cap'

FROM shows S

LEFT JOIN performers P ON S.pid = P.pid

WHERE DATE_ADD(FROM_UNIXTIME(S.sdate, '%Y-%m-%d'),INTERVAL 1 DAY) > '2021-07-01'
ORDER BY S.sdate,P.pname ASC