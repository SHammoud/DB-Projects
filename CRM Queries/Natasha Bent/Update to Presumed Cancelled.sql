UPDATE Deal_Date DD

LEFT JOIN Deal D ON DD.dealID = D.id
LEFT JOIN Artist A ON DD.artistID = A.id
LEFT JOIN Venue V ON DD.venueID = V.id
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Contact P ON D.promoterID = P.id
LEFT JOIN Currency CX on DD.currencyID = CX.id

SET DD.cvStatus = 'PRESUMED_CANCELLATION'

WHERE DD.artistID IN (1827,3074,1826,2824,1279,2491,2037,3007,2047,2271,2379,2705,2049,2912,1907,3123) AND DD.date > "2021-06-01" AND DD.fee > 0

