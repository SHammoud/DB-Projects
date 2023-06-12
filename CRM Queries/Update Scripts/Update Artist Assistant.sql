UPDATE   Artist A

LEFT JOIN `User` UAS ON UAS.id = A.bookingAssistantID
LEFT JOIN `User` UAG ON UAG.id = A.agentID

SET A.bookingAssistantID = 4266

WHERE UAG.id = 2757
AND A.disabled IS NULL