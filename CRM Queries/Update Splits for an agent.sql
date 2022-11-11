
# UPDATE Deal_Date DD
LEFT JOIN Artist A ON DD.artistID = A.id
LEFT JOIN User U ON DD.userID = U.id
LEFT JOIN Deal D on DD.dealID = D.id
#     SET
#         DD.splitRate = A.splitRate
#         AND D.isComplete = 0
WHERE DD.userID IN (1330, 40, 69, 2606, 3799, 2067, 1121, 78, 71, 2601, 2101, 42, 2757, 1370, 103, 3598, 79, 67, 83, 84, 41, 95, 87, 1201, 2859, 39, 2556, 2632)
AND YEAR(DD.date) = 2021 # < Enter year
AND DD.type = 'CONTRACT'
AND DD.splitRate IS NULL