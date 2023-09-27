SELECT

       A.name 'Artist',
       AC.companyName 'Company Name',
       IF(AC.artistDefault,'YES','NO') 'Use for Artist Contract',
       IF(AC.productionDefault,'YES','NO') 'Use for Production Contract',
       N.nationality 'Nationality',
       AC.address 'Address',
       AC.address2 'Address 2',
       AC.address3 'Address 3',
       AC.city 'City',
       AC.postcode 'Postcode',
       CO.country 'Country',
	   (DD.worth/COALESCE(DD.exchangeRate,CX.rate)) AS 'Total Fee In GBP',
       (DD.worth*(COALESCE(DD.commissionRate,A.commissionRate)/100)/COALESCE(DD.exchangeRate,CX.rate)) AS 'Total Commission In GBP',
       DD.cvStatus 'CV Status'

       

FROM Deal_Date DD


LEFT JOIN Deal D ON DD.dealID = D.id
LEFT JOIN Currency CX ON D.currencyId = CX.id
LEFT JOIN Artist A ON D.artistID = A.id
LEFT JOIN ArtistCompanies AC ON AC.artistId = A.id
LEFT JOIN Country CO ON CO.id = AC.country
LEFT JOIN Nationality N on A.nationalityID = N.id


# 	LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount"
# 	FROM Contract_Extra
# 	WHERE category LIKE "production_fee"
# 	GROUP BY showID) OV ON OV.showID = DD.id




WHERE DD.date BETWEEN '2022-01-01' AND '2022-12-31'
AND AC.disabled IS NULL
AND DD.dealID IS NOT NULL
AND (COALESCE(D.cancelled, 0) + DD.cancelled = 0)
ORDER BY DD.date,A.name
