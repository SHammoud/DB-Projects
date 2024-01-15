SELECT * FROM

ShowAgents SA
LEFT JOIN Deal_Date DD ON SA.showId = DD.id

WHERE DD.artistID = 3531
    AND YEAR(DD.date) > 2022
