SELECT P.pname                            AS 'Artist',
#        S.svenue                           AS 'Venue',
        FROM_UNIXTIME(S.sdate, '%Y-%m-%d') AS 'Show Date',
		SUM(S.final) AS 'Final'

  

FROM shows S

         LEFT JOIN performers P on S.pid = P.pid
         LEFT JOIN tours T on S.tid = T.tid

# TODO UPDATE SO QUERY CAN BE EXECUTED FOR THIS MONTH OR LAST MONTH
# You need to add UNIX times here:
WHERE FROM_UNIXTIME(S.sdate, '%Y-%m-%d') BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY S.pid
ORDER BY final DESC