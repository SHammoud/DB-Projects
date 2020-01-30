SELECT DD.id                                                                      AS 'Show ID',
       DD.date                                                                    AS 'Show Date',
       A.name                                                                     AS 'Artist',
       CONCAT(LEFT(U.name, 1), LEFT(U.surname, 1), "/", DD.dealID)                AS 'Contract Number',
       IF(DD.rowColor NOT IN ("", "hot_rowClear"), "Jim O'Regan", "Sandy Marris") AS "Agent",
/* 	   DD.rowColor, */
       V.name                                                                     AS 'Venue',
       V.city                                                                     AS 'City',
       C.country                                                                  AS 'Country',
       CX.symbol                                                                  AS 'Currency',
       COALESCE(DDCF.fee, DCF.fee, DD.fee)                                        AS "Fee",
       ROUND(OV.amount / 100, 2)                                                  AS "Commissionable Extras",
       COALESCE(DD.commissionRate, A.commissionRate) / 100                        AS "Commission",
       IF(DD.isCorporate, "0.75", "1")                                            AS "AFTER Corp Slice",
       COALESCE(DD.splitRate, A.splitRate) / 100                                  AS "Split Rate",
       COALESCE(DD.exchangeRate, CX.rate)                                         AS "Exchange Rate"

FROM Deal_Date DD
         LEFT JOIN Deal D ON D.id = DD.dealID
         LEFT JOIN Cancellation_Fee DCF ON DCF.dealID = DD.dealID
         LEFT JOIN Cancellation_Fee DDCF ON DDCF.dealDateID = DD.id
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN Venue V ON V.id = DD.venueID
         LEFT JOIN Country C ON C.id = V.country
         LEFT JOIN Country AC ON A.country = AC.id
         LEFT JOIN Currency CX ON CX.id = DD.currencyID
         LEFT JOIN `User` U ON U.id = D.userID
         LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount"
                    FROM Contract_Extra
                    WHERE TYPE LIKE "above_line"
                    GROUP BY showID) OV ON OV.showID = DD.id

         LEFT JOIN Payment PY ON PY.showID = DD.id
WHERE A.agentID IN ("87", "2757")
  AND DD.date BETWEEN '2019-01-01' AND '2019-12-31'
  AND DD.fee > 0
  AND DD.notes NOT LIKE "%tom%"

UNION

SELECT DD.id                                                                      AS 'Show ID',
       DD.date                                                                    AS 'Show Date',
       A.name                                                                     AS 'Artist',
       CONCAT(LEFT(U.name, 1), LEFT(U.surname, 1), "/", DD.dealID)                AS 'Contract Number',
       IF(DD.rowColor NOT IN ("", "hot_rowClear"), "Jim O'Regan", "Sandy Marris") AS "Agent",
/* 	   DD.rowColor, */
       V.name                                                                     AS 'Venue',
       V.city                                                                     AS 'City',
       C.country                                                                  AS 'Country',
       CX.symbol                                                                  AS 'Currency',
       COALESCE(DDCF.fee, DCF.fee, DD.fee)                                        AS "Fee",
       ROUND(OV.amount / 100, 2)                                                  AS "Commissionable Extras",
       COALESCE(DD.commissionRate, A.commissionRate) / 100                        AS "Commission",
       IF(DD.isCorporate, "0.75", "1")                                            AS "After Corp Slice",
       COALESCE(DD.splitRate, A.splitRate) / 100                                  AS "Split Rate",
       COALESCE(DD.exchangeRate, CX.rate)                                         AS "Exchange Rate"

FROM Deal_Date DD
         LEFT JOIN Deal D ON D.id = DD.dealID
         LEFT JOIN Cancellation_Fee DCF ON DCF.dealID = DD.dealID
         LEFT JOIN Cancellation_Fee DDCF ON DDCF.dealDateID = DD.id
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN Venue V ON V.id = DD.venueID
         LEFT JOIN Country C ON C.id = V.country
         LEFT JOIN Country AC ON A.country = AC.id
         LEFT JOIN Currency CX ON CX.id = DD.currencyID
         LEFT JOIN `User` U ON U.id = D.userID
         LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount"
                    FROM Contract_Extra
                    WHERE TYPE LIKE "above_line"
                    GROUP BY showID) OV ON OV.showID = DD.id

         LEFT JOIN Payment PY ON PY.showID = DD.id
WHERE A.secondaryAgentID IN ("87", "2757")
  AND DD.date BETWEEN '2019-01-01' AND '2019-12-31'
  AND DD.fee > 0
  AND DD.notes NOT LIKE "%tom%"
  
  
