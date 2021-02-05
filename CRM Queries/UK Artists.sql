SELECT A.name
FROM Artist A
LEFT JOIN Country C on A.country = C.id

WHERE C.country = "United Kingdom"
AND A.disabled IS NULL