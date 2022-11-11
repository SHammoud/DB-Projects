SET @YEAR = '2022';
SET @DATE = '2021-10-06';

SELECT A.name                      AS 'Artist',
	   ROUND(SUM(IF(SAR.month = '1', SAR.gross_commission, NULL)),0) AS 'Jan',
       ROUND(SUM(IF(SAR.month = '2', SAR.gross_commission, NULL)),0) AS 'Feb',
       ROUND(SUM(IF(SAR.month = '3', SAR.gross_commission, NULL)),0) AS 'Mar',
       ROUND(SUM(IF(SAR.month = '4', SAR.gross_commission, NULL)),0) AS 'Apr',
       ROUND(SUM(IF(SAR.month = '5', SAR.gross_commission, NULL)),0) AS 'May',
       ROUND(SUM(IF(SAR.month = '6', SAR.gross_commission, NULL)),0) AS 'Jun',
       ROUND(SUM(IF(SAR.month = '7', SAR.gross_commission, NULL)),0) AS 'Jul',
       ROUND(SUM(IF(SAR.month = '8', SAR.gross_commission, NULL)),0) AS 'Aug',
       ROUND(SUM(IF(SAR.month = '9', SAR.gross_commission, NULL)),0) AS 'Sept',
       ROUND(SUM(IF(SAR.month = '10', SAR.gross_commission, NULL)),0) AS 'Oct',
       ROUND(SUM(IF(SAR.month = '11', SAR.gross_commission, NULL)),0) AS 'Nov',
       ROUND(SUM(IF(SAR.month = '12', SAR.gross_commission, NULL)),0) AS 'Dec',
       ROUND(SUM(SAR.gross_commission),0) AS 'Total'


FROM Snapshots_Agent_Report SAR
         LEFT JOIN Artist A ON A.id = SAR.artistId
		 LEFT JOIN User U ON U.id = SAR.agentId

WHERE SAR.date = @DATE
  AND SAR.year = @YEAR
  AND A.disabled IS NULL
  AND SAR.agentId = 40

GROUP BY A.id




