SELECT C.name,
       C.surname,
       C.email,
       AI.name,
       UAI.fieldPermissions,
       UAI.statusPermissions,
       U.expiredAt

FROM User U

LEFT JOIN Contact C ON U.contactId = C.id
LEFT JOIN UserArtistIntranet UAI ON U.id = UAI.userId
LEFT JOIN ArtistIntranet AI ON UAI.artistIntranetId = AI.id
WHERE C.type = 'external'