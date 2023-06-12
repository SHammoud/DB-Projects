SELECT
       CONCAT(PA.name,' ',PA.surname) AS 'Agent',
       CONCAT(PA.initials, '/', DD.dealID)                                         AS 'Deal ID',
       DD.date                                                                    AS 'Show Date',
       A.name                                                                     AS 'Artist',
       ACC.country                                                                     AS 'Artist Country',
#        AT.name                                                                     AS 'Artist Territory',
       V.name                                                                     AS 'Venue',
	   V.city                                                                     AS 'City',
       VC.country                                                                     AS 'Country',
#        VT.name                                                                     AS 'Territory',
#        CASE
#            WHEN V.name LIKE 'Brand%' THEN 'BRAND PARTNERSHIP'
#            WHEN D.contractType = 'CORPORATE' THEN 'CORPORATE'
#            WHEN D.contractType = 'BRANDPARTNERSHIP' THEN 'BRAND PARTNERSHIP'
#            ELSE 'STANDARD' END                                                    AS 'Type',
#            CASE
#        WHEN DD.cvStatus = 'PRESUMED_CANCELLATION' THEN 'PRESUMED CANCELLED'
#        WHEN DD.cvStatus = 'RESCHEDULE' THEN 'RESCHEDULE'
#        WHEN DD.cvStatus = 'SUCCESSFULLY_RESCHEDULED' THEN 'SUCCESSFULLY RESCHEDULED'
#        WHEN DD.cvStatus = 'RESCHEDULE_TBC' THEN 'RESCHEDULE TBC'
#        END AS 'CV Status',
       CX.code                                                                    AS 'Currency',
       COALESCE(DD.worth)                                        AS 'Fee',
       COALESCE(DD.commissionRate, A.commissionRate) / 100                        AS 'Commission Rate',
       ROUND(COALESCE(DD.splitRate, A.splitRate)/100,2)                                    AS 'Split Rate',
       COALESCE(DD.exchangeRate,CX.rate) AS 'Exchange Rate',
		IFNULL(ROUND(DD.corporateRate/100,2),0) AS 'Corp Carve Out'


FROM Deal_Date DD
         LEFT JOIN Deal D ON D.id = DD.dealID
         LEFT JOIN Cancellation_Fee DCF ON DCF.dealID = D.id
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN ArtistCompanies AC ON AC.artistID = A.id
         LEFT JOIN Venue V ON V.id = DD.venueID
         LEFT JOIN Country VC ON VC.id = V.country
         LEFT JOIN Country ACC ON AC.country = ACC.id
         LEFT JOIN Territory VT ON VC.territoryID = VT.id
         LEFT JOIN Territory AT ON ACC.territoryID = AT.id
         LEFT JOIN Currency CX ON CX.id = DD.currencyID
         LEFT JOIN `User` PA ON PA.id = DD.userID
         LEFT JOIN `User` SA ON SA.id = D.secondaryAgentID
         LEFT JOIN `User` AA ON AA.id = A.secondaryAgentID
         LEFT JOIN (SELECT showID, category, SUM(amount) AS 'amount'
                    FROM Contract_Extra
                    WHERE TYPE LIKE 'above_line'
                    GROUP BY showID) OV ON OV.showID = DD.id




WHERE DD.date BETWEEN '2022-01-01' AND '2022-12-31'
AND DD.worth > 0
AND DD.dealID IS NOT NULL
AND (COALESCE(D.cancelled, 0) + DD.cancelled =1)
GROUP BY DD.id
# AND CX.id IS NULL
ORDER BY DD.date