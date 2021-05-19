SELECT
       DD.date                                                                    AS 'Show Date',
       A.name                                                                     AS 'Artist',
       CONCAT(U.initials, '/', DD.dealID)                                         AS 'Contract Number',
       IF(DD.cancelled,'YES', 'NO')                                               AS 'Show Cancelled',
       IF(DD.cancelled,'YES', 'NO')                                               AS 'Deal Cancelled',
       CASE
           WHEN V.name LIKE 'Brand%' THEN 'BRAND PARTNERSHIP'
           WHEN D.contractType = 'CORPORATE' THEN 'CORPORATE'
           WHEN D.contractType = 'BRANDPARTNERSHIP' THEN 'BRAND PARTNERSHIP'
           ELSE 'STANDARD' END                                                    AS 'Type',
       CASE
       WHEN DD.cvStatus = 'PRESUMED_CANCELLATION' THEN 'PRESUMED CANCELLED'
       WHEN DD.cvStatus = 'RESCHEDULE' THEN 'RESCHEDULE'
       WHEN DD.cvStatus = 'SUCCESSFULLY_RESCHEDULED' THEN 'SUCCESSFULLY RESCHEDULED'
       WHEN DD.cvStatus = 'RESCHEDULE_TBC' THEN 'RESCHEDULE TBC'
       END                                                                        AS 'CV Status',
       V.name                                                                     AS 'Venue',
       CASE
           WHEN V.isFestival THEN 'YES'
           WHEN D.contractType = 'FESTIVAL' THEN 'YES'
           ELSE 'NO' END                                                          AS 'Festival',
       V.city                                                                     AS 'City',
       C.country                                                                  AS 'Country',
       T.name                                                                     AS 'Territory',
       CX.code                                                                    AS 'Currency',
       COALESCE(DDCF.fee, DCF.fee, DD.fee)                                        AS 'Fee',
       ROUND(OV.amount / 100, 2)                                                  AS 'Commissionable_Extras',
       COALESCE(DD.commissionRate, A.commissionRate) / 100                        AS 'Commission Rate',
       COALESCE(DD.exchangeRate, 1)                                               AS 'Exchange Rate',
       ROUND((COALESCE(DDCF.fee, DCF.fee, DD.fee) + COALESCE((OV.amount / 100),0)) / COALESCE(DD.exchangeRate, 1)      ,2) AS 'Total Fee GBP',
       ROUND((((COALESCE(DDCF.fee, DCF.fee, DD.fee) + COALESCE((OV.amount / 100),0)) * COALESCE(DD.commissionRate, A.commissionRate) / 100)) / COALESCE(DD.exchangeRate, 1)      ,2) AS 'Total Commision GBP',
       AL.created_at,
       AL.email AS 'created_by',
       AL.type,
       AL.action,
       AL.info AS 'log'

FROM Deal_Date DD
	LEFT JOIN Activity_Log AL ON AL.showId = DD.id
         LEFT JOIN Deal D ON D.id = DD.dealID
         LEFT JOIN Cancellation_Fee DCF ON DCF.dealID = DD.dealID
         LEFT JOIN Cancellation_Fee DDCF ON DDCF.dealDateID = DD.id
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN Venue V ON V.id = DD.venueID
         LEFT JOIN Country C ON C.id = V.country
         LEFT JOIN Country AC ON A.country = AC.id
         LEFT JOIN Territory T ON C.territoryID = T.id
         LEFT JOIN Currency CX ON CX.id = DD.currencyID
         LEFT JOIN `User` U ON U.id = D.userID
         LEFT JOIN (SELECT showID, category, SUM(amount) AS 'amount'
                    FROM Contract_Extra
                    WHERE TYPE LIKE 'above_line'
                    GROUP BY showID) OV ON OV.showID = DD.id


WHERE AL.type = "Show"
      AND AL.action IN ("create")
      AND YEAR(DD.date) >=2020
#       AND YEAR(AL.created_at) >= 2020
      AND (A.agentID = 1624 OR A.secondaryAgentID = 1624)
	  AND DD.fee > 0
ORDER BY DD.date