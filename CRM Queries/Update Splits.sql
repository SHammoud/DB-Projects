# Update splits
# Set split rate to 100% for specific artist ID

UPDATE Deal_Date DD
LEFT JOIN Artist A ON DD.artistID = A.id
LEFT JOIN User U ON DD.userID = U.id
    SET DD.splitRate = A.splitRate
WHERE A.id = % # <-- Add artist ID here
AND YEAR(DD.date) > 2022
AND dealID IS NOT NULL
AND DD.splitRate IS NULL