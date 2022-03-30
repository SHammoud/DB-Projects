SELECT A.name,DD.date,DD.type,DD.dealID, A.splitRate, DD.splitRate

FROM Deal_Date DD
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN Deal D on DD.dealID = D.id
WHERE DD.type = "CONTRACT"
  AND DD.date > "2021"
  AND DD.splitRate IS NULL
  AND D.cancelled = 0
 GROUP BY DD.id
ORDER BY DD.date
 