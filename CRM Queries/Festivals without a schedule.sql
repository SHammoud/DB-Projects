SELECT F.id,
       F.name                                                                  AS "Festival",
       CONCAT("https://www.codacrm.com/index.php?page=HOME#/festivals/", F.id) AS "URL"
FROM Festivals F
         LEFT JOIN Payment_Schedule_Presets PS ON PS.festivalId = F.id
WHERE F.deleted_at IS NULL
  AND PS.id IS NULL
