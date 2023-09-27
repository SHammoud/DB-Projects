SELECT
COUNT(*) AS "Shows",
MAX(DD.date) AS "Last",
C.name AS "Name",
C.surname AS "Surname",
C.email AS "Email",
MAX(DD.worth)/CU.rate AS "Fee"

FROM Contact C
LEFT JOIN Deal D ON C.id = D.promoterID
LEFT JOIN Deal_Date DD ON D.id = DD.dealID
LEFT JOIN Venue V ON V.id = DD.venueID
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Territory T on CO.territoryID = T.id
LEFT JOIN Currency CU ON DD.currencyID = CU.id

WHERE DD.dealID IS NOT NULL
AND C.disabled IS NULL
AND DD.corporateRate IS NULL
# AND CO.region = 'Europe'
AND CO.country IN ('Egypt', 'Georgia', 'Iran', 'Iraq', 'Israel', 'Jordan', 'Lebanon', 'Libya', 'Morocco', 'Oman', 'Saudi Arabia', 'Sudan', 'Tunisia', 'Turkey', 'UAE', 'Yemen', 'Yemen')
# AND T.name IN ('Asia Pacific')
# AND DD.artistID = 1664
AND C.name NOT REGEXP 'test|PT|and|/|AEG|behalf|\\(|C.O|/'
AND C.surname NOT REGEXP 'not use|and|behalf|\\(|/'
AND C.email NOT REGEXP 'paradigmagency.com|codaagency.com|teamwass.com|accounts|info|contracts'
AND (COALESCE(D.cancelled, 0) + DD.cancelled = 0)
GROUP BY C.email
# HAVING Shows > 1 AND Fee > '10000' AND Last >  '2020'
HAVING Shows > 1
ORDER BY Shows DESC
