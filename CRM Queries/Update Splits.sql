# Update splits
# Set split rate to 100% for specific artist ID

UPDATE Deal_Date DD
LEFT JOIN Artist A ON DD.artistID = A.id
    SET DD.splitRate = 100
WHERE A.id = % # <-- Add artist ID here
AND YEAR(DD.date) > 2020
AND dealID IS NOT NULL
AND DD.splitRate != 100