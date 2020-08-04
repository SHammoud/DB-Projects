SELECT
        FROM_UNIXTIME(S.sdate, '%Y-%m-%d') AS 'Show date',
#         FROM_UNIXTIME(DSD.time, '%Y-%m-%d') AS 'Sales Date',
        P.pname AS 'Artist',
        S.stown AS 'City',
        IFNULL(WeekA.Values,0) AS 'Week A',
        MAX(D.datavalue) AS 'Week B',
		MAX(D.datavalue) - IFNULL(WeekA.Values,0) AS 'Total Sold'

FROM shows S
    LEFT JOIN data D ON D.show_id = S.sid
	LEFT JOIN data_sale_dates DSD ON D.sale_date_id = DSD.id
	LEFT JOIN performers P ON S.pid = P.pid
	LEFT JOIN (SELECT S.sid, MAX(D.datavalue) AS 'Values' FROM shows S LEFT JOIN data D ON D.show_id = S.sid LEFT JOIN data_sale_dates DSD ON D.sale_date_id = DSD.id WHERE FROM_UNIXTIME(DSD.time, '%Y-%m-%d') BETWEEN '2020-04-20' AND '2020-04-26' AND D.datavalue != 'No data' GROUP BY S.sid) WeekA ON WeekA.sid = S.sid
 

# TODO UPDATE SO QUERY CAN BE EXECUTED FOR THIS MONTH OR LAST MONTH
# You need to add UNIX times here:
WHERE FROM_UNIXTIME(DSD.time, '%Y-%m-%d') BETWEEN '2020-04-27' AND '2020-05-03'
AND D.datavalue != 'No data'
GROUP BY S.sid
ORDER BY P.pname,S.sdate

