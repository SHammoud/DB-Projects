SELECT A.name,
       U.email,
       UA.email


FROM Artist A
LEFT JOIN ArtistAgent AA ON A.id = AA.artistId
LEFT JOIN User U ON U.id = A.agentID
LEFT JOIN User UA ON UA.id = A.accountantId

WHERE U.email IN ('alex.hardee@teamwass.com','cris.hearn@teamwass.com','mike.malak@teamwass.com')
AND A.disabled IS NOT NULL
ORDER BY A.name


# UPDATE   Artist A
# LEFT JOIN ArtistAgent AA ON A.id = AA.artistId
# LEFT JOIN User U ON U.id = A.agentID
# LEFT JOIN User UA ON UA.id = A.accountantId
#
# SET A.accountantId = 4771
#
# WHERE U.email IN ('alex.hardee@teamwass.com','cris.hearn@teamwass.com','mike.malak@teamwass.com')
# AND A.disabled IS NOT NULL
