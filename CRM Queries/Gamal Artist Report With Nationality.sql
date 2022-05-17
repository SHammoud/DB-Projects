SELECT

       A.name 'Artist',
       N.nationality,
       A.address,
       A.address2,
       A.address3,
       A.city,
       A.postcode,
	   (DD.worth/COALESCE(DD.exchangeRate,CX.rate)) AS 'Total Fee In GBP',
       (DD.worth*(COALESCE(DD.commissionRate,A.commissionRate)/100)/COALESCE(DD.exchangeRate,CX.rate)) AS 'Total Commission In GBP',
       DD.cvStatus

       

FROM Deal_Date DD


LEFT JOIN Deal D ON DD.dealID = D.id
LEFT JOIN Currency CX ON D.currencyId = CX.id
LEFT JOIN Artist A ON D.artistID = A.id
LEFT JOIN Nationality N on A.nationalityID = N.id

# 	LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount"
# 	FROM Contract_Extra
# 	WHERE category LIKE "production_fee"
# 	GROUP BY showID) OV ON OV.showID = DD.id




WHERE DD.date BETWEEN '2021-10-01' AND '2021-12-31'
AND DD.dealID IS NOT NULL
AND (COALESCE(D.cancelled, 0) + DD.cancelled = 0)
ORDER BY DD.date,A.name
