SELECT
        FROM_UNIXTIME(S.sdate, '%Y-%m-%d') AS 'Date',
        P.pname                            AS 'Artist',
        S.svenue                           AS 'Venue',
        S.stown                             AS 'City',
        S.scap                              AS 'Cap',
        MAX(CAST(D.datavalue AS DECIMAL )) AS 'Last Sold',
		S.final AS 'Final'

  

FROM shows S
    LEFT JOIN data D ON D.show_id = S.sid
	LEFT JOIN data_sale_dates DSD ON D.sale_date_id = DSD.id
	LEFT JOIN performers P ON S.pid = P.pid
	
# TODO UPDATE SO QUERY CAN BE EXECUTED FOR THIS MONTH OR LAST MONTH
# You need to add UNIX times here:
WHERE P.pname LIKE '%Bon Iver%'
AND D.datavalue != 'No data'
GROUP BY S.sid
ORDER BY S.sdate