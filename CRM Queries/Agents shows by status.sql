# Requested by Madie to help understand potential accountant workload
# A count of all entries in datesheets
# Grouped by agent then status
# This year

SELECT CONCAT(U.name, ' ', U.surname) AS 'Agent',
       DD.type                        AS 'Status',
       COUNT(*)
FROM Deal_Date DD

         LEFT JOIN `User` U ON DD.userID = U.id
         LEFT JOIN Artist A ON DD.artistID = A.id

WHERE YEAR(DD.date) = YEAR(CURRENT_DATE)
  AND DD.fee > 0
  AND DD.cancelled = 0
GROUP BY DD.userID, DD.type
ORDER BY Agent, 'Status'

