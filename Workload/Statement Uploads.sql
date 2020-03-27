SELECT
	DATE_FORMAT(D.created_at,'%Y-%m-%d') AS 'Date',
    A.name AS 'Artist Name',
	CONCAT(U.name,' ',U.surname) AS' Client Accountant'

FROM Document_Artist DA
LEFT JOIN Document D ON D.id = DA.documentID
LEFT JOIN Artist A ON A.id = DA.artistID
LEFT JOIN User U ON A.accountantId = U.id

WHERE  DATE_FORMAT(D.created_at,'%Y-%m-%d') BETWEEN '2020-02-10' AND '2020-02-14'
AND D.type = 'FINANCE'
AND D.fileName LIKE '%STM%'