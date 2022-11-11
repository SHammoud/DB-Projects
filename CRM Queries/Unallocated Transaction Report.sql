SELECT DATE_FORMAT(BT.created_at,'%d/%m/%Y') AS 'Upload date',
       DATE_FORMAT(BT.entryDate,'%d/%m/%Y') AS 'Transaction Date',
       BTC.name AS 'Category',
       BT.receiptNo AS 'Receipt No.',
       COALESCE(NULLIF(BT.memo,''),BT.name) AS 'Note',
       BT.status AS 'Status',
       C.currency 'Currency',
       CONCAT(C.symbol,BT.amount/100) 'Amount',
       BT.exchangeRate

FROM Bank_Transaction BT
LEFT JOIN Currency C on BT.currencyId = C.id
LEFT JOIN Bank_Transaction_Category BTC ON BT.bankTransactionCategoryId = BTC.id
WHERE BT.status IN ('UNALLOCATED','PARTALLOCATED')
AND BT.entryDate > '2022-01-01 00:00:00'
AND BTC.name = 'Promoter'
ORDER BY BT.entryDate