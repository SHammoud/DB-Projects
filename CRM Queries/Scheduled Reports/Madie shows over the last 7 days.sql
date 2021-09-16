SELECT
       DD.date                                                                    AS 'Date',
       A.name                                                                     AS 'Artist',
       CONCAT(P.name,' ',P.surname,' (',P.companyName,')')                        AS 'Promoter',
       CONCAT(U.initials, '/', DD.dealID)                                         AS 'Contract',
#        CASE
#            WHEN V.name LIKE 'Brand%' THEN 'BRAND PARTNERSHIP'
#            WHEN D.contractType = 'CORPORATE' THEN 'CORPORATE'
#            WHEN D.contractType = 'BRANDPARTNERSHIP' THEN 'BRAND PARTNERSHIP'
#            ELSE 'STANDARD' END                                                    AS 'Type',
       CASE
           WHEN DD.cancelled + D.cancelled > 0 THEN 'YES'
           ELSE 'NO'
       END                                                                        AS 'Cancelled',
       V.name                                                                     AS 'Venue',
#        CASE
#            WHEN V.isFestival THEN 'YES'
#            WHEN D.contractType = 'FESTIVAL' THEN 'YES'
#            ELSE 'NO' END                                                          AS 'Festival',
#        V.city                                                                     AS 'City',
#        C.country                                                                  AS 'Country',
#        T.name                                                                     AS 'Territory',
       CX.code                                                                    AS 'Currency',
       CASE WHEN DD.cancelled + D.cancelled > 0 THEN COALESCE(DDCF.fee, DCF.fee, '0') + COALESCE(ROUND(OV.amount / 100, 2),'0')
            ELSE DD.fee + COALESCE(ROUND(OV.amount / 100, 2),'0')
       END                                                                        AS 'Fee',
       COALESCE(DD.commissionRate, A.commissionRate) / 100                        AS 'Commission Rate',
       COALESCE(DD.exchangeRate,CX.rate)                                               AS 'Exchange Rate',
       CASE WHEN DD.cancelled + D.cancelled > 0 THEN ROUND((COALESCE(DDCF.fee, DCF.fee,'0') + COALESCE((OV.amount / 100),0)) / COALESCE(DD.exchangeRate, CX.rate)      ,2)
            ELSE ROUND((COALESCE(DD.fee) + COALESCE((OV.amount / 100),0)) / COALESCE(DD.exchangeRate, CX.rate)      ,2)
       END AS 'Total Fee GBP',
       ROUND((((COALESCE(DDCF.fee, DCF.fee, DD.fee) + COALESCE((OV.amount / 100),0)) * COALESCE(DD.commissionRate, A.commissionRate) / 100)) / COALESCE(DD.exchangeRate, CX.rate)      ,2) AS 'Total Commision GBP'

FROM Deal_Date DD
         LEFT JOIN Deal D ON D.id = DD.dealID
         LEFT JOIN Cancellation_Fee DCF ON DCF.dealID = DD.dealID
         LEFT JOIN Cancellation_Fee DDCF ON DDCF.dealDateID = DD.id
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN Contact P ON D.promoterID = P.id
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
WHERE DD.date BETWEEN DATE_SUB(NOW(), INTERVAL 12 DAY) AND DATE_SUB(NOW(), INTERVAL 5 DAY)
AND DD.dealID IS NOT NULL
HAVING Fee > 0
ORDER BY DD.date