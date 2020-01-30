SELECT A.name                                      AS "Artist",
       CONCAT(C.name, " ", C.surname)              AS "NAME",
       C.email                                     AS "Email",
       AC.contactType                              AS "Role",
       IF(AC.receivesDealMemo > 0, "YES", "NO")    AS "Receives Deal Memo",
       IF(AC.receivesDealMemoBCC > 0, "YES", "NO") AS "Receives Deal Memo BCC",
       IF(AC.receivesContract > 0, "YES", "NO")    AS "Receives Contract",
       IF(AC.receivesContractBCC > 0, "YES", "NO") AS "Receives Contract BCC"
FROM Artist A
         LEFT JOIN Artist_Contact AC ON AC.artistID = A.id
         LEFT JOIN Contact C ON C.id = AC.contactID

WHERE A.agentID = 79
  AND A.disabled IS NOT NULL

ORDER BY A.name ASC
