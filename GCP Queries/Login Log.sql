SELECT
       AL.created_at,
       CONCAT(C.name,' ',C.surname),
       C.email,
       AL.description,
       AL.properties

FROM ActivityLog AL

LEFT JOIN User U ON U.id = AL.causer_id
LEFT JOIN Contact C on U.contactId = C.id

WHERE AL.created_at > '2020-01-01'
AND AL.description LIKE 'Login%'