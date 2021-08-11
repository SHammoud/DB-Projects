SELECT
       CM.name                                AS 'Artist',
       G.name,
       CM.spotify                             AS 'Spotify URL',
	   GROUP_CONCAT(CONCAT(U.first_name,' ',U.last_name) SEPARATOR ', ') AS 'Agents'

FROM clients_music CM
LEFT JOIN clients_music_users CMU ON CM.id = CMU.clients_music_id
LEFT JOIN users U ON CMU.users_id = U.id
LEFT JOIN clients_music_agencies CMA ON CM.id = CMA.clients_music_id
LEFT JOIN genres G ON CM.genre_id_primary = G.id


WHERE CM.id IS NOT NULL
  AND CM.deleted_at IS NULL
  AND CM.inactive_date IS NULL
  AND CMA.agencies_id = 2
  AND CMU.roles_id = 1
  AND U.agencies_id = 2

GROUP BY CM.id
ORDER BY CM.name ASC
