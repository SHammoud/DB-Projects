# Table size
SELECT table_name AS "Table",
ROUND(((data_length + index_length) / 1024 / 1024), 2) AS "Size (MB)"
FROM information_schema.TABLES
WHERE table_schema = 'ticketsystem' # Insert Database Name here
ORDER BY (data_length + index_length) DESC;