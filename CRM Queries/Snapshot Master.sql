SET @snapDate := '2019-12-31';
SET @reportYear := 2019;
SELECT CONCAT(U.name, ' ', U.surname)                                                      AS 'Agent',

       MAX(CASE WHEN SMR.month = '1' THEN NULLIF(FORMAT(SMR.gross_commission, 0), 0) END)  AS 'January',
       MAX(CASE WHEN SMR.month = '2' THEN NULLIF(FORMAT(SMR.gross_commission, 0), 0) END)  AS 'February',
       MAX(CASE WHEN SMR.month = '3' THEN NULLIF(FORMAT(SMR.gross_commission, 0), 0) END)  AS 'March',
       MAX(CASE WHEN SMR.month = '4' THEN NULLIF(FORMAT(SMR.gross_commission, 0), 0) END)  AS 'April',
       MAX(CASE WHEN SMR.month = '5' THEN NULLIF(FORMAT(SMR.gross_commission, 0), 0) END)  AS 'May',
       MAX(CASE WHEN SMR.month = '6' THEN NULLIF(FORMAT(SMR.gross_commission, 0), 0) END)  AS 'June',
       MAX(CASE WHEN SMR.month = '7' THEN NULLIF(FORMAT(SMR.gross_commission, 0), 0) END)  AS 'July',
       MAX(CASE WHEN SMR.month = '8' THEN NULLIF(FORMAT(SMR.gross_commission, 0), 0) END)  AS 'August',
       MAX(CASE WHEN SMR.month = '9' THEN NULLIF(FORMAT(SMR.gross_commission, 0), 0) END)  AS 'September',
       MAX(CASE WHEN SMR.month = '10' THEN NULLIF(FORMAT(SMR.gross_commission, 0), 0) END) AS 'October',
       MAX(CASE WHEN SMR.month = '11' THEN NULLIF(FORMAT(SMR.gross_commission, 0), 0) END) AS 'November',
       MAX(CASE WHEN SMR.month = '12' THEN NULLIF(FORMAT(SMR.gross_commission, 0), 0) END) AS 'December'


FROM Snapshots_Master_Report SMR
         LEFT JOIN `User` U ON U.id = SMR.agentId

WHERE SMR.date = @snapDate
  AND SMR.year = @reportYear
GROUP BY SMR.agentId

UNION

SELECT CONCAT('Corporate Commission')                                                         AS 'Agent',

       FORMAT(SUM(CASE WHEN SMR.month = '1' THEN SMR.corporate_remaining_commission END), 0)  AS 'January',
       FORMAT(SUM(CASE WHEN SMR.month = '2' THEN SMR.corporate_remaining_commission END), 0)  AS 'February',
       FORMAT(SUM(CASE WHEN SMR.month = '3' THEN SMR.corporate_remaining_commission END), 0)  AS 'March',
       FORMAT(SUM(CASE WHEN SMR.month = '4' THEN SMR.corporate_remaining_commission END), 0)  AS 'April',
       FORMAT(SUM(CASE WHEN SMR.month = '5' THEN SMR.corporate_remaining_commission END), 0)  AS 'May',
       FORMAT(SUM(CASE WHEN SMR.month = '6' THEN SMR.corporate_remaining_commission END), 0)  AS 'June',
       FORMAT(SUM(CASE WHEN SMR.month = '7' THEN SMR.corporate_remaining_commission END), 0)  AS 'July',
       FORMAT(SUM(CASE WHEN SMR.month = '8' THEN SMR.corporate_remaining_commission END), 0)  AS 'August',
       FORMAT(SUM(CASE WHEN SMR.month = '9' THEN SMR.corporate_remaining_commission END), 0)  AS 'September',
       FORMAT(SUM(CASE WHEN SMR.month = '10' THEN SMR.corporate_remaining_commission END), 0) AS 'October',
       FORMAT(SUM(CASE WHEN SMR.month = '11' THEN SMR.corporate_remaining_commission END), 0) AS 'November',
       FORMAT(SUM(CASE WHEN SMR.month = '12' THEN SMR.corporate_remaining_commission END), 0) AS 'December'


FROM Snapshots_Master_Report SMR
         LEFT JOIN `User` U ON U.id = SMR.agentId

WHERE SMR.date = @snapDate
  AND SMR.year = @reportYear
GROUP BY SMR.year

ORDER BY CASE WHEN Agent = 'Corporate Commission' THEN 2 END, Agent