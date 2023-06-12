SELECT DD.date                                                     AS 'Show Date',
       A.name                                                      AS 'Artist',
       A.id                                                        AS 'Artist Id',
       IF(A.disabled IS NULL,'YES','NO') AS 'Active',
       CONCAT( RA.initials,'/', DD.dealID) AS 'Contract Number',
       DD.dealID AS 'Deal Id',
      IF(D.cancelled=1,'YES','NO')                                  AS 'Deal Cancelled',
       GROUP_CONCAT(DISTINCT CONCAT(SHAU.name, " ", SHAU.surname,' (',ROUND(SHA.splitRate),'%)'))                           AS 'Agents',
       ACO.country                                                  AS 'Company Country',
       V.name                                                      AS 'Venue',
       V.id AS 'Venue Id',
       C.country                                                   AS 'Country',
       CX.code                                                   AS 'Currency',
       COALESCE(DD.exchangeRate,CX.rate) AS 'FX Rate',
       IF(D.cancelled=1,ROUND(IFNULL(DCF.fee,0), 2),ROUND(DD.fee+IFNULL(OV.amount,0) / 100, 2))                                           AS 'Show Commissionable Gross',
       ROUND(IF(D.cancelled=1,ROUND(IFNULL(DCF.fee,0), 2),ROUND(DD.fee+IFNULL(OV.amount,0) / 100, 2)) / COALESCE(DD.exchangeRate,CX.rate),2) AS 'Show Commissionable Gross GBP'
       

FROM Deal_Date DD
         LEFT JOIN Deal D ON D.id = DD.dealID
         LEFT JOIN ShowAgents SHA ON SHA.showId = DD.id
         LEFT JOIN User SHAU ON SHAU.id = SHA.agentId
         LEFT JOIN Cancellation_Fee DCF ON D.id = DCF.dealID
         LEFT JOIN Artist A ON D.artistID = A.id
         LEFT JOIN Venue V ON V.id = DD.venueID
         LEFT JOIN Country C ON C.id = V.country
         LEFT JOIN Nationality N ON A.nationalityID = N.id
         LEFT JOIN ArtistCompanies AC ON AC.id = D.artistCompanyId
         LEFT JOIN Country ACO ON AC.country = ACO.id
         LEFT JOIN Currency CX ON CX.id = DD.currencyID
         LEFT JOIN `User` RA ON RA.id = D.userID
         LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount"
                    FROM Contract_Extra
                    WHERE category IN ('show_overage','show_fee_increase','bonus','show_fee_decrease')
                    GROUP BY showID) OV ON OV.showID = DD.id
         LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount"
                    FROM Contract_Extra
                    WHERE TYPE LIKE "below_line"
                      AND category NOT IN ("withholding_tax")
                    GROUP BY showID) EX ON EX.showID = DD.id
         LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount"
                    FROM Contract_Extra
                    WHERE category LIKE "withholding_tax"
                    GROUP BY showID) WHT ON WHT.showID = DD.id
         LEFT JOIN Payment PY ON PY.showID = DD.id
WHERE DD.date BETWEEN '2023-01-01' AND '2023-12-31'
  AND DD.type IN ('CONTRACT')
GROUP BY DD.id
ORDER BY DD.date