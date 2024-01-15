SELECT
       F.name AS "Festival",
       PS.year AS 'Schedule Year',
       GROUP_CONCAT(CONCAT(ROUND(PSPI.percent),'%')ORDER BY PSPI.id SEPARATOR '/') AS 'Percentage',
       CASE
       WHEN PSPI.`trigger` ='festivalStart' THEN GROUP_CONCAT(CONCAT(PSPI.period,' ',PSPI.periodType,' ',PSPI.direction,' ',REPLACE(PSPI.`trigger`,'festivalStart', 'the start of the festival'))ORDER BY PSPI.id SEPARATOR '/')
       WHEN PSPI.`trigger` ='festivalEnd' THEN GROUP_CONCAT(CONCAT(PSPI.period,' ',PSPI.periodType,' ',PSPI.direction,' ',REPLACE(PSPI.`trigger`,'festivalEnd', 'the end of the festival'))ORDER BY PSPI.id SEPARATOR '/')
        END  AS 'Schedule',
        GROUP_CONCAT(IF(PSPI.priorToAnnouncement,'Yes','No')ORDER BY PSPI.id SEPARATOR '/') AS 'Prior Announcement',
        V.contractSubtype 'Agreed Terms',
       CONCAT("https://www.codacrm.com/festivals/", F.id) AS "URL"

FROM Festivals F
        LEFT JOIN Payment_Schedule_Presets PS ON PS.festivalId = F.id
        LEFT JOIN Payment_Schedule_Preset_Items PSPI ON PS.id = PSPI.presetId
        LEFT JOIN Payment_Schedule_Preset_Amounts PSA ON PSPI.amountId = PSA.presetId
        LEFT JOIN Venue V ON V.festivalId = F.id
WHERE F.deleted_at IS NULL AND PS.year IS NOT NULL
GROUP BY F.id, PS.year
ORDER BY F.name, PS.year


