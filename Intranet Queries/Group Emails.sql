SELECT
       CM.id AS 'ID',
       CASE
            WHEN CM.name IN('M.O') THEN REPLACE(CM.slug, '-', '.')
			ELSE REPLACE(CM.slug, '-', '')
            END AS "Artist",
#        CHAR_LENGTH(REPLACE(CM.slug, '-', '')) AS "Slug Count",
       GROUP_CONCAT(U.email SEPARATOR ', ') AS "Team",
       CM.created_at AS "Created",
       CM.updated_at AS "Updated",
       CM.inactive_date AS "Inactive",
       CM.deleted_at AS "Deleted"


FROM users U
     LEFT JOIN clients_music_users CMU ON CMU.users_id = U.id
     LEFT JOIN clients_music CM ON CM.id = CMU.clients_music_id
WHERE
      CM.id IS NOT NULL
AND   CM.deleted_at IS NULL
AND   CM.inactive_date IS NULL

GROUP BY CMU.clients_music_id
ORDER BY Artist
