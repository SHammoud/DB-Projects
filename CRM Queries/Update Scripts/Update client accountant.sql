SELECT A.name,
       U.email,
       UA.email


FROM Artist A
LEFT JOIN ArtistAgent AA ON A.id = AA.artistId
LEFT JOIN User U ON U.id = A.agentID
LEFT JOIN User UA ON UA.id = A.accountantId

WHERE U.email IN ('adele.slater@teamwass.com','clementine.bunel@teamwass.com','james.whitting@teamwass.com','ryan.penty@teamwass.com','tom.taaffe@teamwass.com')
AND A.disabled IS  NULL
ORDER BY A.name


UPDATE   Artist A
LEFT JOIN ArtistAgent AA ON A.id = AA.artistId
LEFT JOIN User U ON U.id = A.agentID
LEFT JOIN User UA ON UA.id = A.accountantId

SET A.accountantId = 3702

WHERE U.email IN ('adele.slater@teamwass.com','clementine.bunel@teamwass.com','james.whitting@teamwass.com','ryan.penty@teamwass.com','tom.taaffe@teamwass.com')
AND A.disabled IS NULL
