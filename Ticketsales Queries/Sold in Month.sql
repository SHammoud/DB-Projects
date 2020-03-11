SELECT P.pname                            AS 'Artist',
       S.svenue                           AS 'Venue',
       FROM_UNIXTIME(S.sdate, '%Y-%m-%d') AS 'Show Date',
       CASE
           WHEN
               MAX(D.datavalue) = MIN(D.datavalue) THEN ABS(MAX(D.datavalue))
           ELSE
               ABS(MAX(D.datavalue) - MIN(D.datavalue))
           END                            AS 'Sold',
		S.final


FROM data_sale_dates DSD

         LEFT JOIN data D on D.sale_date_id = DSD.id
         LEFT JOIN shows S on S.sid = D.show_id
         LEFT JOIN performers P on S.pid = P.pid
         LEFT JOIN tours T on DSD.tour_id = T.tid

# TODO UPDATE SO QUERY CAN BE EXECUTED FOR THIS MONTH OR LAST MONTH
# You need to add UNIX times here:
WHERE DSD.time BETWEEN 1580515200 AND 1583020800
GROUP BY S.sid
ORDER BY P.pname