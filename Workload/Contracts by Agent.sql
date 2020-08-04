SELECT
    CONCAT(U.name, ' ', U.surname) AS Agent,
    SUM(DATE_FORMAT(D.firstDate, "%M") = 'January') AS 'January',
    SUM(DATE_FORMAT(D.firstDate, "%M") = 'February')AS 'February',
    SUM(DATE_FORMAT(D.firstDate, "%M") = 'March')AS 'March',
    SUM(DATE_FORMAT(D.firstDate, "%M") = 'April')AS 'April',
    SUM(DATE_FORMAT(D.firstDate, "%M") = 'May')AS 'May',
    SUM(DATE_FORMAT(D.firstDate, "%M") = 'June')AS 'June',
    SUM(DATE_FORMAT(D.firstDate, "%M") = 'July')AS 'July',
    SUM(DATE_FORMAT(D.firstDate, "%M") = 'August')AS 'August',
    SUM(DATE_FORMAT(D.firstDate, "%M") = 'September')AS 'September',
    SUM(DATE_FORMAT(D.firstDate, "%M") = 'October')AS 'October',
    SUM(DATE_FORMAT(D.firstDate, "%M") = 'November')AS 'November',
    SUM(DATE_FORMAT(D.firstDate, "%M") = 'December')AS 'December'
    # COUNT(*) AS 'Contracts'
FROM
    Deal D
    LEFT JOIN User U ON D.userID = U.id
WHERE
    DATE_FORMAT(D.firstDate, "%Y") = 2018
    AND U.id NOT IN ('745', '2132')
    AND U.usertypeID = 87
	AND D.cancelled = 0
 
GROUP BY
    U.id
ORDER BY
    U.name ASC