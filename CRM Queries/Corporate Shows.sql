SELECT COUNT(*),
       SUM(CASE WHEN DD.feeInGbp = 0 THEN DD.fee ELSE DD.feeInGbp END)

FROM Deal_Date DD
LEFT JOIN Deal D on DD.dealID = D.id

WHERE
    (DD.corporateRate IS NOT NULL OR D.contractType = 'BRANDPARTNERSHIP')
AND YEAR(DD.date) = 2022
AND D.cancelled = 0
GROUP BY YEAR(DD.date)