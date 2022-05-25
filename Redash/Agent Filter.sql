SELECT
U.id AS 'value',
CONCAT(U.name,' ',U.surname) AS 'name'
FROM User U
WHERE U.usertypeID = 87
AND U.disabled IS NULL
AND U.subtypeID IS NULL
ORDER BY U.name