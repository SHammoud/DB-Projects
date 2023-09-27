SELECT
        FROM_UNIXTIME(S.sdate, '%Y-%m-%d') AS 'Date',
        P.pname                            AS 'Artist',
        S.svenue                           AS 'Venue',
        S.stown                             AS 'City',
        S.scap                              AS 'Cap',
#         MAX(CAST(D.datavalue AS DECIMAL )) AS 'Last Sold',
		S.final As 'Final'

  

FROM shows S
    LEFT JOIN data D ON D.show_id = S.sid
	LEFT JOIN data_sale_dates DSD ON D.sale_date_id = DSD.id
	LEFT JOIN performers P ON S.pid = P.pid
	LEFT JOIN tours T ON S.tid = T.tid
	
# TODO UPDATE SO QUERY CAN BE EXECUTED FOR THIS MONTH OR LAST MONTH
# You need to add UNIX times here:
WHERE P.pname LIKE '%Omar apollo%'
# WHERE T.tid = 7908
AND D.datavalue != 'No data'
GROUP BY S.sid
ORDER BY S.sdate