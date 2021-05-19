SELECT
		A.name AS 'Artist',
		DD.date AS 'Show Date',
        V.name AS 'Venue',
		A.companyName AS 'Payee',
		A.address AS 'Payee Address Line 1',
		A.address2 AS 'Payee Address Line 2',
		A.address3 AS 'Payee Address Line 3',
		A.city AS 'Payee Address Line 4',
		CO.country AS 'Payee Address Line 5',
		A.postcode AS 'Payee Postcode',
		SUM(P.amount) AS 'Total Amount Received During The Year',
#         P.amount AS 'Amount Received',
		CX.code AS 'Currency Code',
		CONCAT('05/04/2019') AS 'Period End Date',
		A.name AS 'Source Reference',
		CONCAT('Paradigm Agency LTD') AS 'Your Company/Organisation Name',
		CONCAT ('') AS 'Payee National Insurance Number (NINO)',
		CONCAT ('') AS 'Payee VAT Registration Number (VRN)',
		CONCAT ('') AS 'Payee Bank Sort Code',
		CONCAT ('') AS 'Payee Bank Account Number',
		CONCAT ('') AS 'Payee E-mail Address',
		CONCAT ('') AS 'Payee Telephone Number',
		CONCAT ('') AS 'Free Format Field 1',
		CONCAT ('') AS 'Free Format Field 2',
		CONCAT ('') AS 'Free Format Field 3'

FROM Payment P

LEFT JOIN Deal_Date DD on P.showID = DD.id
LEFT JOIN Currency CX on P.currencyID = CX.id
LEFT JOIN Artist A on DD.artistID = A.id
LEFT JOIN Venue V on DD.venueID = V.id
LEFT JOIN Country CO on A.country = CO.id

WHERE P.dateReceived BETWEEN '2019-04-06' AND '2020-04-05'
AND P.transferType = 'transfer'
AND A.name IN ('Tom Odell','Liam Gallagher','Andy C','Disclosure')
# GROUP BY A.id, CX.id
GROUP BY DD.id