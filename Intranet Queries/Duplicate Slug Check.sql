SELECT CM.id                                  AS 'ID',
       REPLACE(CM.slug, '-', '')              AS "Artist",
       COUNT(*)                               AS 'Count',
       CHAR_LENGTH(REPLACE(CM.slug, '-', '')) AS "Slug Count",
       CM.created_at                          AS "Created",
       CM.updated_at                          AS "Updated",
       CM.inactive_date                       AS "Inactive",
       CM.deleted_at                          AS "Deleted"


FROM clients_music CM
WHERE CM.id IS NOT NULL
  AND CM.deleted_at IS NULL
  AND CM.inactive_date IS NULL
  AND CM.name NOT IN ('M.O')

GROUP BY Artist
HAVING Count > 1

