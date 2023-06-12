SELECT
	   CONCAT(U.initials,'/',D.id) AS 'Contract Number',
       A.name AS 'Artist',
       CU.code AS 'Currency',
       D.worth AS 'Fee',
 
CASE
    WHEN PS.amount IS NULL THEN
	GROUP_CONCAT(
	  DISTINCT CONCAT(ROUND(PS.percent),'% to ',COALESCE(PS.receivingThirdParty,'Wasserman on'),' ',PS.due_at)
	  ORDER BY PS.due_at
	  SEPARATOR ', '
	)
ELSE
	GROUP_CONCAT(
	  DISTINCT CONCAT(CONCAT(CU.symbol,PS.amount),' to ',COALESCE(PS.receivingThirdParty,'Wasserman on '),PS.due_at)
	  ORDER BY PS.due_at
	  SEPARATOR ', '
	)
END AS 'Schedule'

FROM Deal D

LEFT JOIN Artist A ON D.artistID = A.id
LEFT JOIN Payment_Schedule PS ON D.id = PS.dealID
LEFT JOIN Deal_Date DD ON D.id = DD.dealID
LEFT JOIN Venue V ON DD.venueID = V.id
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN User U ON D.userID = U.id
LEFT JOIN Currency CU ON D.currencyID = CU.id

WHERE D.firstDate  BETWEEN '2020-01-01' AND '2023-04-30'
AND D.cancelled = 0
AND PS.receivingThirdParty IS NOT NULL
GROUP BY D.id
ORDER BY D.firstDate

