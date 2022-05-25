SELECT COUNT(*) AS Contracts

FROM
    Deal D
WHERE
    DATE_FORMAT(D.firstDate, "%Y") = {{Year}}
    AND D.cancelled = 0

    