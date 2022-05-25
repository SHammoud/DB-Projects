SELECT
    CONCAT(U.name, ' ', U.surname) AS Agent,
    SUM(DATE_FORMAT(DD.date, "%M") = 'January') AS 'January',
    SUM(DATE_FORMAT(DD.date, "%M") = 'February')AS 'February',
    SUM(DATE_FORMAT(DD.date, "%M") = 'March')AS 'March',
    SUM(DATE_FORMAT(DD.date, "%M") = 'April')AS 'April',
    SUM(DATE_FORMAT(DD.date, "%M") = 'May')AS 'May',
    SUM(DATE_FORMAT(DD.date, "%M") = 'June')AS 'June',
    SUM(DATE_FORMAT(DD.date, "%M") = 'July')AS 'July',
    SUM(DATE_FORMAT(DD.date, "%M") = 'August')AS 'August',
    SUM(DATE_FORMAT(DD.date, "%M") = 'September')AS 'September',
    SUM(DATE_FORMAT(DD.date, "%M") = 'October')AS 'October',
    SUM(DATE_FORMAT(DD.date, "%M") = 'November')AS 'November',
    SUM(DATE_FORMAT(DD.date, "%M") = 'December')AS 'December'
    # COUNT(*) AS 'Contracts'
FROM
    Deal_Date DD
    LEFT JOIN Deal D ON DD.dealID = D.id
    LEFT JOIN User U ON DD.userID = U.id
WHERE
    YEAR(DD.date) = 2022
    AND U.disabled IS NULL
    AND U.id NOT IN ('2632', '2132')
    AND U.usertypeID = 87
	AND DD.cancelled + D.cancelled < 1
 
GROUP BY
    U.id
ORDER BY
    U.name