SELECT
    DD.date AS 'Date',
    DD.dealID AS 'Deal ID',
    A.name AS 'Artist',
    CONCAT(C.symbol, DD.fee) AS 'Fee',
    ROUND((DD.fee / COALESCE(DD.exchangeRate, C.rate)), 2) AS "Total Fees GBP",
    ROUND(
        (
            (
                DD.fee * COALESCE((DD.commissionRate / 100),(A.commissionRate / 100))
            ) / COALESCE(DD.exchangeRate, C.rate)
        ),
        2
    ) AS "Total Commission GBP",
    ROUND(
        (
            (
                DD.fee * COALESCE(((DD.commissionRate*0.25) / 100),((A.commissionRate*0.25) / 100))
            ) / COALESCE(DD.exchangeRate, C.rate)
        ),
        2
    ) AS "Corp Commission GBP",
    DD.type AS "Status",
    D.contractType AS "Contract Type",
    D.cancelled AS "Deal Cancelled",
    DD.cancelled AS "Show Cancelled",
    DD.exclusivityNotes "Exclusivity Notes"
FROM
    Deal_Date DD
    LEFT JOIN Currency C ON DD.currencyID = C.id
    LEFT JOIN Artist A ON DD.artistID = A.id
    LEFT JOIN Deal D ON DD.dealID = D.id
    LEFT JOIN Cancellation_Fee DCF ON DCF.dealID = D.id
    LEFT JOIN Cancellation_Fee DDCF ON DDCF.dealDateID = DD.id
WHERE
    YEAR(DD.date) = YEAR(CURDATE())
    AND DD.isCorporate = 1 AND DD.cancelled = 0


UNION

SELECT
    DD.date AS 'Date',
    DD.dealID AS 'Deal ID',
    A.name AS 'Artist',
    CONCAT(C.symbol, DD.fee) AS 'Fee',
    ROUND((DD.fee / COALESCE(DD.exchangeRate, C.rate)), 2) AS "Total Fees GBP",
    ROUND(
        (
            (
                COALESCE(DDCF.FEE, DCF.FEE, DD.fee) * COALESCE((DD.commissionRate / 100),(A.commissionRate/ 100))
            ) / COALESCE(DD.exchangeRate, C.rate)
        ),
        2
    ) AS "Total Commission GBP",
    ROUND(
        (
            (
                COALESCE(DDCF.FEE, DCF.FEE, DD.fee) * COALESCE(((DD.commissionRate*0.25) / 100),((A.commissionRate*0.25)/ 100))
            ) / COALESCE(DD.exchangeRate, C.rate)
        ),
        2
    ) AS "Corp Commission GBP",
    DD.type AS "Status",
    D.contractType AS "Contract Type",
    D.cancelled AS "Deal Cancelled",
    DD.cancelled AS "Show Cancelled",
    DD.exclusivityNotes "Exclusivity Notes"
FROM
    Deal_Date DD
    LEFT JOIN Currency C ON DD.currencyID = C.id
    LEFT JOIN Artist A ON DD.artistID = A.id
    LEFT JOIN Deal D ON DD.dealID = D.id
    LEFT JOIN Cancellation_Fee DCF ON DCF.dealID = D.id
    LEFT JOIN Cancellation_Fee DDCF ON DDCF.dealDateID = DD.id
WHERE
    YEAR(DD.date) = YEAR(CURDATE())
    AND DD.isCorporate = 1 AND DD.cancelled = 1

    ORDER BY DATE
