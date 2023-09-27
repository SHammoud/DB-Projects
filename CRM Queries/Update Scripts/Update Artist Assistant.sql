UPDATE   Artist A

LEFT JOIN `User` UAS ON UAS.id = A.bookingAssistantID
LEFT JOIN `User` UAG ON UAG.id = A.agentID

SET A.bookingAssistantID = 2921

WHERE UAG.id = 1370
AND A.disabled IS NULL