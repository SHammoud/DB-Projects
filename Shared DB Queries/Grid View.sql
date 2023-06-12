SELECT
    D.start_date_tz AS 'Date',
    DM.name AS 'Venue',
    DM.city AS 'City',
    DM.state AS 'State',
    DM.country AS 'Country',
    DM.guarantee_currencyID AS 'Currency',
    DM.guarantee AS 'Fee',
    DM.contact AS 'Promoter',
    DM.promoter_name AS 'Company',
	DM.promoter_email AS 'Promoter @'


FROM deal_memo DM
LEFT JOIN dates D on DM.dmID = D.dmID

WHERE DM.artistID = 176525
AND YEAR(D.start_date_tz) = 2023
ORDER BY D.start_date_tz ASC