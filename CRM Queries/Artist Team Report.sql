# Requested by Dave Blackgrove, all artist team for his active roster
# All contacts attached to artists
# Whose primary agent is specified
# And the artist is not disabled

SELECT A.name                                      AS 'Artist',
       CONCAT(C.name, ' ', C.surname)              AS 'NAME',
       C.email                                     AS 'Email',
       AC.contactType                              AS 'Role',
       IF(AC.receivesDealMemo > 0, 'YES', 'NO')    AS 'Receives Deal Memo',
       IF(AC.receivesDealMemoBCC > 0, 'YES', 'NO') AS 'Receives Deal Memo BCC',
       IF(AC.receivesContract > 0, 'YES', 'NO')    AS 'Receives Contract',
       IF(AC.receivesContractBCC > 0, 'YES', 'NO') AS 'Receives Contract BCC'
FROM Artist A
         LEFT JOIN Artist_Contact AC ON AC.artistID = A.id
         LEFT JOIN Contact C ON C.id = AC.contactID

WHERE
    A.agentID = 725 # ADD AGENT ID HERE
    AND A.disabled IS NULL
    AND C.disabled IS NULL


ORDER BY A.name ASC
