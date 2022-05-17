SELECT *
FROM User U
WHERE U.email LIKE '%@teamwass.com'
AND U.disabled IS NULL


# UPDATE User U
# SET
#     U.email = REPLACE(U.email,'@paradigmagency.com','@teamwass.com')
