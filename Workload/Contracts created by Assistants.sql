SELECT
    CONCAT(U.name, ' ', U.surname) AS Assistant,
    SUM(DATE_FORMAT(DA.createdDate, "%M") = 'January') AS 'January',
    SUM(DATE_FORMAT(DA.createdDate, "%M") = 'February')AS 'February',
    SUM(DATE_FORMAT(DA.createdDate, "%M") = 'March')AS 'March',
    SUM(DATE_FORMAT(DA.createdDate, "%M") = 'April')AS 'April'
    # COUNT(*) AS 'Contracts'
FROM
    Deal_Audit DA
    LEFT JOIN User U ON DA.createdBy = U.id
WHERE
    YEAR(DA.createdDate) = 2020
    AND U.id NOT IN ('2037','2286','2074','2040')
    AND U.usertypeID = 88
    
GROUP BY
    U.id
ORDER BY
    U.name ASC