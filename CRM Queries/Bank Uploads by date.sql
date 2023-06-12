SELECT
    BT.created_at AS 'Uploaded at',
    BF.fileName AS 'Upload File Name',
    CONCAT(U.name,' ',U.surname) AS 'Uploaded & Allocated By',
    DATE_FORMAT(BT.entryDate,'%Y-%m-%d') AS 'Transaction Date',
    BTC.name AS 'Category',
    BT.receiptNo AS 'Receipt Number',
    CX.code AS 'Currency',
    BT.amount AS 'Amount',
    BT.type AS 'Type',
    COALESCE(NULLIF(BT.memo,''),BT.name) AS 'Note'
    
    
    

FROM Bank_Transaction BT
LEFT JOIN Bank_File BF on BT.bankFileId = BF.id
LEFT JOIN User U on BF.userId = U.id
LEFT JOIN Bank_Transaction_Category BTC ON BT.bankTransactionCategoryId = BTC.id
LEFT JOIN Currency CX ON BT.currencyId = CX.id and BF.currencyId = CX.id
WHERE YEAR(BT.created_at) = 2023
AND MONTH(BT.created_at) = 1