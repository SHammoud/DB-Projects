SELECT
       DD.date AS 'Show Date',
       CASE
           WHEN DD.type IN ('PENDING', 'PENCIL1', 'PENCIL2', 'PENCIL3', 'OTHER', '') THEN CONCAT('Pending')
           WHEN DD.type = 'CONFIRMED' THEN CONCAT('Confirmed')
           ELSE CONCAT('Contract')
      END AS 'Status',
       CONCAT(PA.initials,'/',DD.dealID) 'Deal ID',
       A.name 'Artist',
       V.name 'Venue',
       V.city 'City',
       CO.country 'Country',
       CX.code AS 'Currency',
       DD.worth AS 'Total Fee',
       (DD.worth/COALESCE(DD.exchangeRate,CX.rate)) AS 'Total Fee In GBP',
       (DD.worth*(COALESCE(DD.commissionRate,A.commissionRate)/100)/COALESCE(DD.exchangeRate,CX.rate)) AS 'Total Commission In GBP',
       IFNULL(D.cancelled,0) AS 'Cancelled'
FROM Deal_Date DD


LEFT JOIN Venue V ON DD.venueID = V.id
LEFT JOIN Country CO ON V.country = CO.id

LEFT JOIN  Currency CX ON DD.currencyId = CX.id
LEFT JOIN Artist A ON DD.artistID = A.id
LEFT JOIN User PA ON DD.userID = PA.id
LEFT JOIN Deal D on DD.dealID = D.id

# 	LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount"
# 	FROM Contract_Extra
# 	WHERE category LIKE "production_fee"
# 	GROUP BY showID) OV ON OV.showID = DD.id




WHERE
YEAR(DD.date) = 2022
AND MONTHNAME(DD.date) ='March'
AND DD.type NOT IN ('OFFER_REJECTED')
AND DD.cancelled = 0
GROUP BY DD.id

# UNION
#
# SELECT
#        DD.date AS 'Show Date',
#        CONCAT(PA.initials,'/',D.id) 'Deal ID',
#        A.name 'Artist',
#        V.name 'Venue',
#        V.city 'City',
#        CO.country 'Country',
#        CX.code AS 'Currency',
#        COALESCE(IFNULL(DCF.fee/SD.ShowCount,0),DD.worth) AS 'Total Fee',
#        (COALESCE(IFNULL(DCF.fee/SD.ShowCount,0),DD.worth)/COALESCE(DD.exchangeRate,CX.rate)) AS 'Total Fee In GBP',
#        (COALESCE(IFNULL(DCF.fee/SD.ShowCount,0),DD.worth)*(COALESCE(DD.commissionRate,A.commissionRate)/100)/COALESCE(DD.exchangeRate,CX.rate)) AS 'Total Commission In GBP',
#
#        CONCAT(PA.name,' ',PA.surname) AS 'Primary Agent',
#        (COALESCE(IFNULL(DCF.fee/SD.ShowCount,0),DD.worth)/COALESCE(DD.exchangeRate,CX.rate)) * (DD.splitRate/100) 'Primary Agent Fee',
#        ((COALESCE(IFNULL(DCF.fee/SD.ShowCount,0),DD.worth)/COALESCE(DD.exchangeRate,CX.rate)) * (DD.splitRate/100))*(COALESCE(DD.commissionRate,A.commissionRate)/100) AS 'Primary Agent Commission',
#
#        CONCAT(SA.name,' ',SA.surname) AS 'Secondary Agent',
#        (COALESCE(IFNULL(DCF.fee/SD.ShowCount,0),DD.worth)/COALESCE(DD.exchangeRate,CX.rate)) - ((COALESCE(IFNULL(DCF.fee/SD.ShowCount,0),DD.worth)/COALESCE(DD.exchangeRate,CX.rate)) * (DD.splitRate/100)) 'Secondary Agent Fee',
# 	   ((COALESCE(IFNULL(DCF.fee/SD.ShowCount,0),DD.worth)/COALESCE(DD.exchangeRate,CX.rate)) - ((COALESCE(IFNULL(DCF.fee/SD.ShowCount,0),DD.worth)/COALESCE(DD.exchangeRate,CX.rate))* (DD.splitRate/100)))*(COALESCE(DD.commissionRate,A.commissionRate)/100) AS 'Secondary Agent Commission',
#
#        D.cancelled 'Deal Cancelled',
#        DD.cancelled 'Show Cancelled',
#        D.isComplete 'Contract Completed',
#        DD.cvStatus 'CV Status'
#
#
#
# FROM Deal_Date DD
#
#
# LEFT JOIN Venue V ON DD.venueID = V.id
# LEFT JOIN Country CO ON V.country = CO.id
# LEFT JOIN Deal D ON DD.dealID = D.id
# LEFT JOIN  Currency CX ON D.currencyId = CX.id
# LEFT JOIN Artist A ON D.artistID = A.id
# LEFT JOIN Contact C ON D.promoterID = C.id
# LEFT JOIN User PA ON D.userID = PA.id
# LEFT JOIN User SA ON D.secondaryAgentID = SA.id
# LEFT JOIN Cancellation_Fee DCF ON DCF.dealID = DD.dealID
#
# # 	LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount"
# # 	FROM Contract_Extra
# # 	WHERE category LIKE "production_fee"
# # 	GROUP BY showID) OV ON OV.showID = DD.id
#
# 	LEFT JOIN (SELECT DD2.dealID, count(*) AS 'ShowCount'
# 	FROM Deal_Date DD2
# 	WHERE
# 	YEAR(DD2.date) = 2022
# 	GROUP BY DD2.dealID) SD ON SD.dealID = DD.dealID
#
#
#
# WHERE
# YEAR(DD.date) = 2022
# GROUP BY DD.id
