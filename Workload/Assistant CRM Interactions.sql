SELECT
        DATE_FORMAT(AL.created_at, '%Y-%m-%d') AS 'Date',
		CONCAT(U.name,' ',U.surname) AS'User',
        UT.usertype AS 'Role',
       CASE
		WHEN CONCAT(UCASE(LEFT(AL.action,1)),SUBSTRING(AL.action,2),' - ',AL.type) = 'Delete - DateSheets Show' THEN  'Delete - Show'
        ELSE CONCAT(UCASE(LEFT(AL.action,1)),SUBSTRING(AL.action,2),' - ',AL.type)
       END AS 'Actions',
       COUNT(AL.type) AS 'Count'

FROM Activity_Log AL
LEFT JOIN User U ON AL.userID = U.id
LEFT JOIN Website_Usertype UT ON U.usertypeID = UT.id
WHERE DATE_FORMAT(AL.created_at,'%Y-%m-%d') BETWEEN '2020-03-30' AND '2020-04-05'
GROUP BY Date, U.name, AL.type