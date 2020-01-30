SELECT DD.date                                                AS 'Date',
       DD.type                                                AS 'Status',
       DD.dealID                                              AS "Contract No",
       A.name                                                 AS 'Artist',
       V.name                                                 AS 'Venue',
       V.city                                                 AS 'City',
       CONCAT(C.symbol, DD.fee)                               AS 'Fee',
       ROUND((DD.fee / COALESCE(DD.exchangeRate, C.rate)), 2) AS "Total Fees GBP",
       ROUND(
               (
                       (
                           DD.fee / COALESCE(DD.commissionRate, A.commissionRate)
                           ) / COALESCE(DD.exchangeRate, C.rate)
                   ),
               2
           )                                                  AS "Total Commission GBP"
FROM Deal_Date DD
         LEFT JOIN Currency C ON DD.currencyID = C.id
         LEFT JOIN Artist A ON DD.artistID = A.id
         LEFT JOIN Venue V ON DD.venueID = V.id
WHERE DD.date > "2020"
  AND A.agentID = "2067"
  AND DD.fee > 0
  AND DD.type NOT IN ("OFFER_REJECTED")
ORDER BY DD.date ASC
