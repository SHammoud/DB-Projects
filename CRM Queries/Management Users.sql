# Requested by Tom Schroeder, all management users for his active roster
# All contacts attached to artists
# Whose primary agent is specified
# And the artist and user is not disabled

SELECT A.name                                      AS 'Artist',
       CONCAT(U.name, ' ', U.surname)              AS 'Name',
       U.email                                     AS 'Email',
       UA.datesheet_allowed                        AS 'Datesheets Visible'
FROM Artist A
         LEFT JOIN v2_project_coda.User_Artist UA ON UA.artistID = A.id
         LEFT JOIN `User` U ON U.id = UA.userID

WHERE
    A.agentID = # ADD AGENT ID HERE
    AND A.disabled IS NULL
    AND U.disabled IS NULL
    AND U.email NOT LIKE '%@disabled.%'

ORDER BY A.name ASC
