SELECT
       F.name AS "Festival",
       PS.year AS 'Schedule Year',
       CONCAT(ROUND(PSPI.percent),'%') AS 'Percentage',
       CASE
       WHEN PSPI.`trigger` ='festivalStart' THEN CONCAT(PSPI.period,' ',PSPI.periodType,' ',PSPI.direction,' ',REPLACE(PSPI.`trigger`,'festivalStart', 'the start of the festival'))
       WHEN PSPI.`trigger` ='festivalEnd' THEN CONCAT(PSPI.period,' ',PSPI.periodType,' ',PSPI.direction,' ',REPLACE(PSPI.`trigger`,'festivalEnd', 'the end of the festival'))
        END  AS 'Schedule',
        IF(PSPI.priorToAnnouncement,'Yes','No') AS 'Prior Announcement',
       CONCAT("https://www.codacrm.com/index.php?page=HOME#/festivals/", F.id) AS "URL"

FROM Festivals F
        LEFT JOIN Payment_Schedule_Presets PS ON PS.festivalId = F.id
        LEFT JOIN Payment_Schedule_Preset_Items PSPI ON PS.id = PSPI.presetId
        LEFT JOIN Payment_Schedule_Preset_Amounts PSA ON PSPI.amountId = PSA.presetId
WHERE F.deleted_at IS NULL AND PS.year IS NOT NULL


