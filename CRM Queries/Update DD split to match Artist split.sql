UPDATE Deal_Date DD
    LEFT JOIN Artist A ON DD.artistID = A.id

SET DD.splitRate = A.splitRate

WHERE DD.type = "CONTRACT"
  AND DD.date > "2019"
  AND DD.splitRate IS NULL
