SELECT A.name AS 'Artist',
       CONCAT(UAS.name,' ',UAS.surname) AS 'Assistant',
       A.bookingAssistantID

FROM Artist A
LEFT JOIN `User` UAS ON UAS.id = A.bookingAssistantID
LEFT JOIN `User` UAG ON UAG.id = A.agentID
WHERE UAG.surname LIKE '%Harvey%'
AND A.disabled IS NULL