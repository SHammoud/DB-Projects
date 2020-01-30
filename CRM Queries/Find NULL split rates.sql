SELECT DD.dealID, A.splitRate, DD.splitRate

FROM Deal_Date DD
         LEFT JOIN Artist A ON DD.artistID = A.id
WHERE DD.type = "CONTRACT"
  AND DD.date > "2019"
  AND DD.splitRate IS NULL