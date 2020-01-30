SELECT 
       DD.date AS 'Show Date',    
       A.name AS 'Artist',
       CONCAT(LEFT(U.name,1), LEFT(U.surname,1),"/",DD.dealID) AS 'Contract Number',
       N.nationality AS 'Nationality',
       CONCAT(U.name," ",U.surname) AS 'Agent',       
       AC.country AS 'Company Country',
       V.name AS 'Venue',
       C.country AS 'Country',
       CX.symbol AS 'Currency',
       ROUND(DD.fee,2) AS 'Fee',
       ROUND(DD.fee*DD.vatRate) AS 'VAT',       
       ROUND(OV.amount/100,2) AS 'Overage',
       ROUND(EX.amount/100,2) AS 'Extras',
       ROUND(WHT.amount/100,2) AS 'Withholding',
       COALESCE(SUM(PY.amount),0) AS 'Received'     

FROM Deal_Date DD
LEFT JOIN Deal D ON D.id = DD.dealID
LEFT JOIN Artist A ON D.artistID = A.id
LEFT JOIN Venue V ON V.id = DD.venueID
LEFT JOIN Country C ON C.id = V.country
LEFT JOIN Nationality N ON A.nationalityID = N.id
LEFT JOIN Country AC ON A.country = AC.id
LEFT JOIN Currency CX ON CX.id = DD.currencyID
LEFT JOIN `User` U ON U.id = D.userID
LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount" FROM Contract_Extra WHERE category LIKE "show_overage" GROUP BY showID) OV ON OV.showID = DD.id
LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount" FROM Contract_Extra WHERE TYPE LIKE "below_line" AND category NOT IN ("withholding_tax")GROUP BY showID) EX ON EX.showID = DD.id
LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount" FROM Contract_Extra WHERE category LIKE "withholding_tax" GROUP BY showID) WHT ON WHT.showID = DD.id
LEFT JOIN Payment PY ON PY.showID = DD.id
WHERE (A.nationalityID NOT IN (27,
                               191,
                               155,
                               134)
       OR A.country !=223)
  AND DD.date BETWEEN '2019-07-01' AND '2019-07-31'
  AND DD.type IN ('CONTRACT','DEALMEMO','CONFIRMED')
  AND V.country =223
  GROUP BY DD.id
  ORDER BY DD.date