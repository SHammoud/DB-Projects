SELECT D.*

FROM deal_memo DM
LEFT JOIN artists A ON DM.artistID = A.artistID
LEFT JOIN dates D ON DM.dmID = D.dmID

WHERE A.artistID = 412468
AND YEAR(D.start_date_tz) = 2024