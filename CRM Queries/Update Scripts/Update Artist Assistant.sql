UPDATE   Artist A

LEFT JOIN `User` UAS ON UAS.id = A.bookingAssistantID
LEFT JOIN `User` UAG ON UAG.id = A.agentID

SET A.bookingAssistantID = 3765

WHERE UAG.surname LIKE '%Harvey%'
AND A.disabled IS NULL