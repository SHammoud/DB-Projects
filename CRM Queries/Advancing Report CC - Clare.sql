SELECT
       DATE_FORMAT(DD.date, '%a %b %e %Y') AS 'Date',
       DD.dealID,
       DD.id,
       C.code AS 'Country',
       V.city AS 'City',
       V.name AS 'Venue',
       COALESCE(NULLIF(DD.budgetedCapacity,'0'),V.capacity) AS 'Capacity',
/*        ROUND(OV.amount/100,2) AS 'Commissionable Extras', */
       COALESCE(DD.tempPromoter,CONCAT(P.name,' ',P.surname,' <',P.email,'>')) AS 'Promoter',
       CCAPD.description AS 'Advancing Contacts',
       CX.code AS 'Currency',
       COALESCE(DDCF.fee,DCF.fee,DD.fee) AS 'Fee',
CASE
    WHEN DD.dealType = 'vsdeal' THEN CONCAT('VS ',DD.percentageAmount,'%')
    WHEN DD.dealType = 'flatfee' THEN 'Flat Guarantee'
    WHEN DD.dealType = 'vsdealcross' THEN CONCAT('VS Cross ',DD.percentageAmount,'%')
    WHEN DD.dealType = 'plusdeal' THEN CONCAT('Plus ',DD.percentageAmount,'%')
    WHEN DD.dealType = 'plusdealcross' THEN CONCAT('Plus AFTER ',DD.percentageAmount,'%')
    ELSE 'Flat Guarantee'
END AS 'Deal Type'

FROM Deal_Date DD
LEFT JOIN Deal D ON D.id = DD.dealID
LEFT JOIN Cancellation_Fee DCF ON DCF.dealID = DD.dealID
LEFT JOIN Cancellation_Fee DDCF ON DDCF.dealDateID = DD.id
LEFT JOIN Artist A ON DD.artistID = A.id
LEFT JOIN Venue V ON V.id = DD.venueID
LEFT JOIN Country C ON C.id = V.country
LEFT JOIN Contact P ON D.promoterID = P.id
LEFT JOIN Country AC ON A.country = AC.id
LEFT JOIN Currency CX ON CX.id = DD.currencyID
LEFT JOIN `User` U ON U.id = D.userID
LEFT JOIN (SELECT showID, category, SUM(amount) AS 'amount' FROM Contract_Extra WHERE TYPE LIKE 'above_line' GROUP BY showID) OV ON OV.showID = DD.id
LEFT JOIN CC_Promoter_To_Provide_Data CCPTP ON CCPTP.showId = DD.id
LEFT JOIN CC_Complimentary_Tickets_Data CCCTD ON CCCTD.showId = DD.id
LEFT JOIN CC_Merchandise_Data CCMD ON CCMD.showId = DD.id
LEFT JOIN CC_Artist_Performance_Data CCAPD ON CCAPD.showId = DD.id
# LEFT JOIN CC_Billing_Data CCBD ON CCBD.showId = DD.id
# LEFT JOIN Payment PY ON PY.showID = DD.id

WHERE DD.artistID = 2162
  AND DD.fee > 0
  AND DD.dealID IS NOT NULL
  AND DD.date > '2020'
  AND D.isComplete = 0
GROUP BY DD.id
ORDER BY DD.date ASC





