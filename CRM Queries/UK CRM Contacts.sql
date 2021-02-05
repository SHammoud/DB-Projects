SELECT
       C.name,
       C.surname,
       C.email

FROM Contact C

WHERE C.disabled IS NULL
AND C.name NOT REGEXP 'info|\\(|Aidan'
AND C.surname NOT REGEXP 'and|presents'
AND C.email NOT REGEXP 'paradigmagency.com|codaagency.com|accounts|info'
AND C.country = 223
AND C.email NOT LIKE ''
AND C.blackListed IS NULL
AND C.email REGEXP '^[^@]+@[^@]+\.[^@]{2,}$'
AND C.venueID = 0
AND C.artistID = 0
GROUP BY C.email
ORDER BY C.name