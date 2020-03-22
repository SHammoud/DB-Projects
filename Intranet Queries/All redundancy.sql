SELECT

	CONCAT(U.first_name,' ',U.last_name) AS 'Name',
    U.title 'Title',
    L.name AS 'Location',
    DATE_FORMAT(U.inactive_date, '%Y-%m-%d') AS 'Inactive Date'
    

FROM users U
LEFT JOIN LOCATIONS L ON U.office = L.id

WHERE U.inactive_date = '2020-03-20 00:00:00'
ORDER BY Name