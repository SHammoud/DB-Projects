SELECT
    DATE_FORMAT(P.dateEntered, '%Y-%m-%d') AS 'Date',
       CONCAT(U.name,' ',U.surname) AS' User',
        COUNT(*) AS 'Allocations'
       

FROM Payment P
LEFT JOIN User U ON U.id = P.userID
WHERE DATE_FORMAT(P.dateEntered,'%Y-%m-%d') BETWEEN '2020-02-10' AND '2020-02-14'
AND P.bankTransactionId IS NOT NULL

GROUP BY Date, P.userID