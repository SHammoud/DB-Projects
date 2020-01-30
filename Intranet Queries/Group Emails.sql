SELECT REPLACE(CM.slug, '-', '')                              AS "Artist",
       GROUP_CONCAT(U.email SEPARATOR ', ') AS "Team",
       CM.created_at AS "Created at",
       CM.updated_at AS "Updated at",
       CM.inactive_date AS "Inactive at"


FROM users U
     LEFT JOIN clients_music_users CMU ON CMU.users_id = U.id
     LEFT JOIN clients_music CM ON CM.id = CMU.clients_music_id
GROUP BY CMU.clients_music_id
