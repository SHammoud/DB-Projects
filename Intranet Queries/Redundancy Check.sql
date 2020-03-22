SELECT CM.name 'Artist',
        GROUP_CONCAT(DISTINCT CONCAT(PU.first_name,' ',PU.last_name) SEPARATOR ', ') AS 'US Agents',
	   GROUP_CONCAT(DISTINCT CONCAT(CU.first_name,' ',CU.last_name) SEPARATOR ', ') AS 'UK Agents'

FROM clients_music CM

LEFT JOIN clients_music_users PCMU ON CM.id = PCMU.clients_music_id
LEFT JOIN users PU ON PCMU.users_id = PU.id
LEFT JOIN clients_music_users CCMU ON CM.id = CCMU.clients_music_id
LEFT JOIN users CU ON CCMU.users_id = CU.id

WHERE PU.slug IN ('ali-hedrick', 'sam-alpert', 'amanda-ances', 'ethan-berlin', 'marshall-betts', 'john-bongiorno', 'chris-burke', 'christine-cao', 'ryan-craven', 'amy-davidman', 'phil-egenthal', 'doug-foley', 'ira-goldenring', 'rae-grabowski', 'zachary-hartley', 'allison-hedrick', 'nate-herweyer', 'emma-hoser', 'dave-kaplan', 'kevin-kastrup', 'matt-korn', 'jason-kupperman', 'devin-landau', 'jessica-lawson', 'meryl-luzzi', 'patrick-mcauliff', 'avery-mctaggart', 'mike-mori', 'michael-morris', 'karl-morse', 'kristin-oneill', 'keith-richards', 'matt-runner', 'taylor-schultz', 'erik-selz', 'eddie-sena', 'jeremy-shpizner', 'paolo-suarez', 'josh-swann', 'randall-uritsky', 'andrew-whitaker', 'clint-wiley', 'fred-zahedinia' )
AND CCMU.roles_id = 1
AND CU.agencies_id = 2
AND CM.inactive_date IS NULL
GROUP BY CM.id
ORDER BY CM.name