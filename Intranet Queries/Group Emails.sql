SELECT
       CM.id AS 'ID',
       REPLACE(CM.slug, '-', '') AS "Artist",
       CHAR_LENGTH(REPLACE(CM.slug, '-', '')) AS "Count",
       GROUP_CONCAT(U.email SEPARATOR ', ') AS "Team",
       CM.created_at AS "Created",
       CM.updated_at AS "Updated",
       CM.inactive_date AS "Inactive"


FROM users U
     LEFT JOIN clients_music_users CMU ON CMU.users_id = U.id
     LEFT JOIN clients_music CM ON CM.id = CMU.clients_music_id
WHERE CM.id IS NOT NULL
GROUP BY CMU.clients_music_id
