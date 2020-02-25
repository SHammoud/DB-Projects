SELECT
       V.id 'id',
       V.name AS 'Name',
       V.address AS 'Address',
       V.city AS 'City',
       CO.country AS 'Country'

FROM Venue V
LEFT JOIN Country CO ON V.country = CO.id
WHERE V.disabled IS NULL