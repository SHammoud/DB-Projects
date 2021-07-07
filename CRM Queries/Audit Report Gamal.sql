SELECT
       DD.date                                                                    AS 'Show Date',
       A.name                                                                     AS 'Artist',
       AC.country                                                                     AS 'Artist Country',
       AT.name                                                                     AS 'Artist Territory',
       V.name                                                                     AS 'Venue',
	   V.city                                                                     AS 'City',
       VC.country                                                                     AS 'Country',
       VT.name                                                                     AS 'Territory',
       CONCAT(PA.initials, '/', DD.dealID)                                         AS 'Contract Number',
       CASE
           WHEN V.name LIKE 'Brand%' THEN 'BRAND PARTNERSHIP'
           WHEN D.contractType = 'CORPORATE' THEN 'CORPORATE'
           WHEN D.contractType = 'BRANDPARTNERSHIP' THEN 'BRAND PARTNERSHIP'
           ELSE 'STANDARD' END                                                    AS 'Type',
       CX.code                                                                    AS 'Currency',
       COALESCE(DD.worth)                                        AS 'Fee',
       COALESCE(DD.commissionRate, A.commissionRate) / 100                        AS 'Commission Rate',
       ROUND(COALESCE(DD.splitRate, A.splitRate)/100,2)                                    AS 'Split Rate',
       COALESCE(DD.exchangeRate,CX.rate) AS 'Exchange Rate',
       CASE
           WHEN DD.isCorporate = 1 THEN '0.25'
		   ELSE '0.00' END AS 'Corp Carve Out'


FROM Deal_Date DD
         LEFT JOIN Deal D ON D.id = DD.dealID
         LEFT JOIN Cancellation_Fee DCF ON DCF.dealID = D.id
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN Venue V ON V.id = DD.venueID
         LEFT JOIN Country VC ON VC.id = V.country
         LEFT JOIN Country AC ON A.country = AC.id
         LEFT JOIN Territory VT ON VC.territoryID = VT.id
         LEFT JOIN Territory AT ON AC.territoryID = AT.id
         LEFT JOIN Currency CX ON CX.id = DD.currencyID
         LEFT JOIN `User` PA ON PA.id = DD.userID
         LEFT JOIN `User` SA ON SA.id = D.secondaryAgentID
         LEFT JOIN `User` AA ON AA.id = A.secondaryAgentID
         LEFT JOIN (SELECT showID, category, SUM(amount) AS 'amount'
                    FROM Contract_Extra
                    WHERE TYPE LIKE 'above_line'
                    GROUP BY showID) OV ON OV.showID = DD.id




WHERE DD.date BETWEEN '2020-01-01' AND '2020-12-31'
AND DD.worth > 0
AND DD.dealID IS NOT NULL
AND (COALESCE(D.cancelled, 0) + DD.cancelled = 0)
# AND CX.id IS NULL
ORDER BY DD.date