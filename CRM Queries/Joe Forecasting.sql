SELECT
    A.name AS 'Artist Filed As',
    DD.artistID AS 'Artist ID',
    CASE
        WHEN DD.type IN ('PENDING','PENCIL1','PENCIL2','PENCIL3','PENCIL4') AND DD.date > CURRENT_DATE() THEN 'Pending (In CRM)'
        WHEN DD.type IN ('PENDING','PENCIL1','PENCIL2','PENCIL3','PENCIL4') AND DD.date < CURRENT_DATE() THEN 'Not Happening'
        WHEN DD.type IN ('OFFER') AND DD.date > CURRENT_DATE() THEN 'Offer (In CRM)'
        WHEN DD.type IN ('CONFIRMED', 'DEALMEMO','CONTRACT') THEN 'Confirmed or Better (Guaranteed Portion)'
		ELSE DD.type
	END AS 'Deal Type',
    DD.type,
    DD.date,
	DD.id
    
#     ROUND(SUM(IF(MONTH(DD.date) = '1', (DD.feeInGbp*(COALESCE(DD.commissionRate,A.commissionRate)/100)), NULL)),0) AS 'January',
# 	ROUND(SUM(IF(MONTH(DD.date) = '2', (DD.feeInGbp*(COALESCE(DD.commissionRate,A.commissionRate)/100)), NULL)),0) AS 'February',
# 	ROUND(SUM(IF(MONTH(DD.date) = '3', (DD.feeInGbp*(COALESCE(DD.commissionRate,A.commissionRate)/100)), NULL)),0) AS 'March',
# 	ROUND(SUM(IF(MONTH(DD.date) = '4', (DD.feeInGbp*(COALESCE(DD.commissionRate,A.commissionRate)/100)), NULL)),0) AS 'April',
# 	ROUND(SUM(IF(MONTH(DD.date) = '5', (DD.feeInGbp*(COALESCE(DD.commissionRate,A.commissionRate)/100)), NULL)),0) AS 'May',
# 	ROUND(SUM(IF(MONTH(DD.date) = '6', (DD.feeInGbp*(COALESCE(DD.commissionRate,A.commissionRate)/100)), NULL)),0) AS 'June',
# 	ROUND(SUM(IF(MONTH(DD.date) = '7', (DD.feeInGbp*(COALESCE(DD.commissionRate,A.commissionRate)/100)), NULL)),0) AS 'July',
# 	ROUND(SUM(IF(MONTH(DD.date) = '8', (DD.feeInGbp*(COALESCE(DD.commissionRate,A.commissionRate)/100)), NULL)),0) AS 'August',
# 	ROUND(SUM(IF(MONTH(DD.date) = '9', (DD.feeInGbp*(COALESCE(DD.commissionRate,A.commissionRate)/100)), NULL)),0) AS 'September',
# 	ROUND(SUM(IF(MONTH(DD.date) = '10', (DD.feeInGbp*(COALESCE(DD.commissionRate,A.commissionRate)/100)), NULL)),0) AS 'October',
# 	ROUND(SUM(IF(MONTH(DD.date) = '11', (DD.feeInGbp*(COALESCE(DD.commissionRate,A.commissionRate)/100)), NULL)),0) AS 'November',
# 	ROUND(SUM(IF(MONTH(DD.date) = '12', (DD.feeInGbp*(COALESCE(DD.commissionRate,A.commissionRate)/100)), NULL)),0) AS 'December'

FROM Deal_Date DD
	LEFT JOIN `User` U ON U.id = DD.userID
	LEFT JOIN Artist A ON A.id = DD.artistID

WHERE YEAR(DD.date) = 2023
  	AND DD.type NOT IN ('OFFER_REJECTED')
    AND IF (DD.type IN ('PENDING','PENCIL1','PENCIL2','PENCIL3','PENCIL4') AND DD.date > CURRENT_DATE(), DD.date, DD.date) BETWEEN '2023-01-01' AND '2023-12-31'
	AND DD.feeInGbp > 0
AND DD.feeInGbp > 0
AND DD.artistID = 2520
# GROUP BY DD.artistID
