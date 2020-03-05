# ALL PRIVILEGES – Grants all privileges to a user account.
# CREATE – The user account is allowed to create databases and tables.
# DROP - The user account is allowed to drop databases and tables.
# DELETE - The user account is allowed to delete rows from a specific table.
# INSERT - The user account is allowed to insert rows into a specific table.
# SELECT – The user account is allowed to read a database.
# UPDATE - The user account is allowed to update table rows.

# All permissions
GRANT ALL PRIVILEGES ON database.* TO 'user'@'host';

# Read only permissions
GRANT SELECT ON database.* TO 'user'@'host';