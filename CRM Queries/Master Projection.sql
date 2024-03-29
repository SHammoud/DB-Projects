SET @YEAR = '2023';
SET @DATE = '2023-12-31';

SELECT CONCAT(U.name, ' ', U.surname)                       AS 'Agent',
	   ROUND(SUM(IF(SMR.month = '1', SMR.agent_commission, NULL)),0) AS 'Jan',
       ROUND(SUM(IF(SMR.month = '2', SMR.agent_commission, NULL)),0) AS 'Feb',
       ROUND(SUM(IF(SMR.month = '3', SMR.agent_commission, NULL)),0) AS 'Mar',
       ROUND(SUM(IF(SMR.month = '4', SMR.agent_commission, NULL)),0) AS 'Apr',
       ROUND(SUM(IF(SMR.month = '5', SMR.agent_commission, NULL)),0) AS 'May',
       ROUND(SUM(IF(SMR.month = '6', SMR.agent_commission, NULL)),0) AS 'Jun',
       ROUND(SUM(IF(SMR.month = '7', SMR.agent_commission, NULL)),0) AS 'Jul',
       ROUND(SUM(IF(SMR.month = '8', SMR.agent_commission, NULL)),0) AS 'Aug',
       ROUND(SUM(IF(SMR.month = '9', SMR.agent_commission, NULL)),0) AS 'Sept',
       ROUND(SUM(IF(SMR.month = '10', SMR.agent_commission, NULL)),0) AS 'Oct',
       ROUND(SUM(IF(SMR.month = '11', SMR.agent_commission, NULL)),0) AS 'Nov',
       ROUND(SUM(IF(SMR.month = '12', SMR.agent_commission, NULL)),0) AS 'Dec',
       ROUND(SUM(SMR.agent_commission),0) AS 'Total'


FROM Snapshots_Master_Report SMR
         LEFT JOIN `User` U ON U.id = SMR.agentId

WHERE SMR.date = @DATE
  AND SMR.year = @YEAR
  AND U.id NOT IN ('2606', '1977', '87', '2132', '2632', '3305')
  AND U.disabled IS NULL

GROUP BY U.id
HAVING Total > 0


UNION

SELECT CONCAT('Corporate Commission')                                                         AS 'Agent',
	   ROUND(SUM(IF(SMR.month = '1', SMR.corporate_remaining_commission, NULL)),0) AS 'Jan',
       ROUND(SUM(IF(SMR.month = '2', SMR.corporate_remaining_commission, NULL)),0) AS 'Feb',
       ROUND(SUM(IF(SMR.month = '3', SMR.corporate_remaining_commission, NULL)),0) AS 'Mar',
       ROUND(SUM(IF(SMR.month = '4', SMR.corporate_remaining_commission, NULL)),0) AS 'Apr',
       ROUND(SUM(IF(SMR.month = '5', SMR.corporate_remaining_commission, NULL)),0) AS 'May',
       ROUND(SUM(IF(SMR.month = '6', SMR.corporate_remaining_commission, NULL)),0) AS 'Jun',
       ROUND(SUM(IF(SMR.month = '7', SMR.corporate_remaining_commission, NULL)),0) AS 'Jul',
       ROUND(SUM(IF(SMR.month = '8', SMR.corporate_remaining_commission, NULL)),0) AS 'Aug',
       ROUND(SUM(IF(SMR.month = '9', SMR.corporate_remaining_commission, NULL)),0) AS 'Sept',
       ROUND(SUM(IF(SMR.month = '10', SMR.corporate_remaining_commission, NULL)),0) AS 'Oct',
       ROUND(SUM(IF(SMR.month = '11', SMR.corporate_remaining_commission, NULL)),0) AS 'Nov',
       ROUND(SUM(IF(SMR.month = '12', SMR.corporate_remaining_commission, NULL)),0) AS 'Dec',
       ROUND(SUM(SMR.corporate_remaining_commission),0) AS 'Total'


FROM Snapshots_Master_Report SMR
         LEFT JOIN `User` U ON U.id = SMR.agentId

WHERE SMR.date = @DATE
  AND SMR.year = @YEAR

HAVING Total > 0


