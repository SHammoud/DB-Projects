SELECT COUNT(*) AS Shows

FROM
    Deal_Date DD
    LEFT JOIN Deal D on DD.dealID = D.id
WHERE
    DATE_FORMAT(DD.date, "%Y")={{Year}}
    AND DD.dealID IS NOT NULL
    AND DD.cancelled = 0
    AND D.cancelled = 0
    