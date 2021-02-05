SELECT
       C.name,
       C.surname,
       C.email

FROM Contact C
LEFT JOIN Artist_Contact AC ON AC.contactID = C.id
LEFT JOIN Artist A ON A.id = AC.artistID

WHERE A.disabled IS NULL
AND C.disabled IS NULL
AND AC.contactType IN ('Management')
AND C.name NOT REGEXP 'info|\\(|Aidan'
AND C.surname NOT REGEXP 'and|presents'
AND C.email NOT REGEXP 'paradigmagency.com|codaagency.com|accounts|info'
AND C.country = 223
AND C.email NOT LIKE ''
AND C.blackListed IS NULL
AND C.updated_at > "2017"
AND C.email REGEXP '^[^@]+@[^@]+\.[^@]{2,}$'
AND C.venueID = 0
AND C.artistID = 0
GROUP BY C.email
ORDER BY C.name