SELECT
   DATE_FORMAT(BT.entryDate,'%Y-%m-%d') AS 'Date',
       COUNT(*) AS 'Receipts'
       

FROM Bank_Transaction BT
WHERE DATE_FORMAT(BT.entryDate,'%Y-%m-%d') BETWEEN '2020-02-10' AND '2020-02-14'
AND BT.type = 'CREDIT'

GROUP BY Date