SELECT
    CASE WHEN LENGTH(CONCAT(P.name, ' ', P.surname)) >20 THEN CONCAT(LEFT(CONCAT(P.name, ' ', P.surname),20),'...') ELSE CONCAT(P.name, ' ', P.surname) END AS 'Promoter',
    CASE WHEN LENGTH(P.companyName) >20 THEN CONCAT(LEFT(P.companyName,20),'...') ELSE P.companyName END AS 'Company',
COUNT(*) AS Contracts
FROM
    Deal_Date DD
    LEFT JOIN Deal D on DD.dealID = D.id
    LEFT JOIN Contact P on D.promoterID = P.id
    LEFT JOIN Country CO on P.country = CO.id
WHERE
    YEAR(DD.date) = {{Year}}
    AND DD.dealID IS NOT NULL
    AND DD.cancelled = 0
    AND D.cancelled = 0
GROUP BY
    P.id
ORDER BY
    Contracts DESC
LIMIT
    100