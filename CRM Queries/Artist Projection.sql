SET @YEAR = '2020';
SET @DATE = '2022-06-16';

SELECT A.name                      AS 'Artist',
	   ROUND(SUM(IF(SAR.month = '1', SAR.commissions, NULL)),0) AS 'Jan',
       ROUND(SUM(IF(SAR.month = '2', SAR.commissions, NULL)),0) AS 'Feb',
       ROUND(SUM(IF(SAR.month = '3', SAR.commissions, NULL)),0) AS 'Mar',
       ROUND(SUM(IF(SAR.month = '4', SAR.commissions, NULL)),0) AS 'Apr',
       ROUND(SUM(IF(SAR.month = '5', SAR.commissions, NULL)),0) AS 'May',
       ROUND(SUM(IF(SAR.month = '6', SAR.commissions, NULL)),0) AS 'Jun',
       ROUND(SUM(IF(SAR.month = '7', SAR.commissions, NULL)),0) AS 'Jul',
       ROUND(SUM(IF(SAR.month = '8', SAR.commissions, NULL)),0) AS 'Aug',
       ROUND(SUM(IF(SAR.month = '9', SAR.commissions, NULL)),0) AS 'Sept',
       ROUND(SUM(IF(SAR.month = '10', SAR.commissions, NULL)),0) AS 'Oct',
       ROUND(SUM(IF(SAR.month = '11', SAR.commissions, NULL)),0) AS 'Nov',
       ROUND(SUM(IF(SAR.month = '12', SAR.commissions, NULL)),0) AS 'Dec',
       ROUND(SUM(SAR.commissions),0) AS 'Total'


FROM Snapshots_Artist_Report SAR
         LEFT JOIN Artist A ON A.id = SAR.artistId

WHERE SAR.date = @DATE
  AND SAR.year = @YEAR
  AND A.disabled IS NULL

GROUP BY A.id




