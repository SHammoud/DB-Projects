SELECT
        DATE_FORMAT(AL.created_at, '%Y-%m-%d') AS 'Date',
		CONCAT(U.name,' ',U.surname) AS' Client Accountant',
       COUNT(*) AS 'Interactions'

FROM Activity_Log AL
LEFT JOIN User U ON AL.userID = U.id
WHERE DATE_FORMAT(AL.created_at,'%Y-%m-%d') BETWEEN '2020-02-10' AND '2020-02-14'
AND U.usertypeID = 88
GROUP BY Date, U.name