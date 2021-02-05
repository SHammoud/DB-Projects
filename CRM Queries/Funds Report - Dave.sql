SELECT
       CONCAT(U.name,' ',U.surname) AS 'Agent',
       CONCAT(U.initials,'/',D.id) 'Deal ID',
       DD.date AS 'Show Date',
       A.name 'Artist',
       V.name 'Venue',
       V.city 'City',
       CO.country 'Country',
       DD.worth AS 'Total Fee',
        CX.code AS 'Currency',
       (DD.worth/COALESCE(DD.exchangeRate,CX.rate)) AS 'Total Fee In GBP',
       (DD.worth*(COALESCE(DD.commissionRate,A.commissionRate)/100)/COALESCE(DD.exchangeRate,CX.rate)) AS 'Total Commission In GBP',
#        DATE_FORMAT(BT.entryDate,'%Y-%m-%d') AS 'Transaction Date',
# 	  GROUP_CONCAT(BT.receiptNo SEPARATOR ' ') AS 'Receipt No',
       SUM( P.amount) 'Received',
#        GROUP_CONCAT(P.id),
       DD.cvStatus AS 'CV Status',
       D.cancelled 'Deal Cancelled',
       DD.cancelled 'Show Cancelled',
       D.isComplete 'Contract Completed',
        CASE
           WHEN ACX.code = CX.code  THEN SUM(DISTINCT PA.amount/100)
           WHEN SUM(DISTINCT PA.amount/100) IS NULL THEN SUM( PA.amount)
           ELSE ROUND(SUM(DISTINCT (PA.amount/PA.currencyExchangeRate)/100),2)
        END  AS 'Paid to Artist',
       ACX.code AS 'Statement Currency',
        CASE
           WHEN ACX.code = CX.code  THEN CONCAT('YES')
           WHEN SUM(DISTINCT PA.amount/100) IS NULL THEN CONCAT(NULL)
           ELSE CONCAT('NO')
        END  AS 'Currency Match'

		
		
       

FROM Bank_Transaction BT

LEFT JOIN  Currency CX ON BT.currencyId = CX.id
LEFT JOIN Payment P ON BT.id = P.bankTransactionId
LEFT JOIN Deal_Date DD ON P.showID = DD.id

	LEFT JOIN (SELECT id, showID, contractId, SUM(amount) AS "amount", currencyId,currencyExchangeRate
	FROM Payment_Artist
	GROUP BY showID) PA ON DD.id = PA.showId

LEFT JOIN Currency ACX ON PA.currencyId = ACX.id
LEFT JOIN Venue V ON DD.venueID = V.id
LEFT JOIN Country CO ON V.country = CO.id
LEFT JOIN Deal D ON DD.dealID = D.id
LEFT JOIN Artist A ON D.artistID = A.id
LEFT JOIN Contact C ON D.promoterID = C.id
LEFT JOIN User U ON D.userID = U.id
LEFT JOIN Cancellation_Fee DCF ON DCF.dealID = DD.dealID

	LEFT JOIN (SELECT showID, category, SUM(amount) AS "amount"
	FROM Contract_Extra
	WHERE category LIKE "production_fee"
	GROUP BY showID) OV ON OV.showID = DD.id



WHERE

D.id IN (98045,100341,100268,100296,94466,99964,94916,95390,95867,99687,99687,95599,97289,100216,92458,92456,94541,92609,97754,99963,95784,97564,100326,100326,97564,92504,97564,91426,97564,91426,100326,100326,91426,96570,99896,92622,99730,99734,99740,91932,92504,99643,91424,91679,92460,91422,92460,92576,93427,93786,95513,95526,96005,91419,92460,92640,91420,97662,94274,91423,92460,97567,91423,92624,92625,94599,97323,94599,94600,96105,92626,93663,93665,94601,94636,94683,96318,96363,92881,93172,99250,92881,93173,99181,99182,92243,93876,93176,97662,94599,94600,93169,94599,95937,97468,94070,94670,99561,92574,99123,92619,92881,92894,99312,92286,92894,96011,92362,92621,92480,96014,92479,93681,92479,94576,92336,92476,91498,92987,88310,92987,92987,92889,94497,94689,95026,95562,95765,90813,94254,94785,95275,96418,96434,96438,96459,90813,93287,91622,95242,90813,90813,91609,91828,95107,90813,93040,93454,94140,96368,96842,93197,90813,90813,93197,93197,90813,94282,95940,90560,90813,94282,95289,95398,96295,96503,97094,93760,94185,96250,96289,99814,90560,93198,90813,93198,95398,99317,90560,90813,93090,93757,94182,95303,90560,96326,100309,95339,96620,96992,99711,90674,90677,90679,90680,93041,94027,93811,96065,96972,93644,94513,95316,96971,97115,97321,99308,93039,93861,96976,99310,99535,99809,95897,96973,92003,94618,92340,93529,97258,99362,91726,93538,94078,94661,99429,94036,94779,94780,94960,95274,95722,96276,97757,98026,96946,94090,92193,93504,93685,93953,94595,95782,99497,93504,94482,95138,95652,95782,96534,97819,98954,100252,92736,92788,93153,95364,95659,96473,96621,98954,99313,100039,94761,95675,96621,99497,92032,93504,94353,95782,93278,95566,98954,90020,92032,94641,94928,95253,95785,96560,96661,97279,98954,100188,92086,95322,96324,96798,97006,99497,99904,100054,100251,95941,99435,99436,99437,95966,92386,92827,92832,93490,93491,95128,92386,93731,93871,93873,93875,94672,94675,99403,99426,92785,92785,95633,96037,97125,92814,93897,94717,94744,96044,97212,99404,99438,99590,99843,93082,93470,94091,94127,94649,95473,95925,96190,97113,97232,97997,99699,99761,99783,93231,94330,97193,99784,99464,99700,95139,95220,99412,93831,93914,95703,96786,97123,93842,94409,95171,95172,95357,97184,93676,93705,93948,94569,94738,95208,95709,95906,96275,96442,96525,97643,93125,93400,93828,93880,94671,95263,95670,95780,95861,96579,95777,98822,92977,93134,94798,93189,93508,99572,93488,93489,93815,95932,97419,94349,95109,95427,96174,96175,97354,93029,95010,95451,100014,100325,99541,99628,96659,96851,96940,99637,91239,93046,94589,94598,95563,95810,97110,97597,98463,100020,94580,94635,94921,97461,94593,94622,100021,94099,94512,95317,96498,94100,94193,94194,96683,94074,95306,95350,95361,95740,95808,96815,97273,98264,98684,100019,96747,98368,98757,100270,92124,93032,94643,94475,94505,94507,96499,93404,93543,94104,95305,96227,96317,97869,93046,93113,93862,95680,97645,93864,95222,95522,96826,99360,96316,97027,97650,91870,95061,95147,95150,96118,96845,97058,97172,95658,96938,91871,95420,96556,96262,96392,96514,98308,94987,95793,95843,89932,93509,97947,99451,91858,94338,94377,96672,97946,98051,99121,100395,95188,96492,91552,96278,91552,91737,91736,91552,91552,92069,98152,91552,93347,93572,94369,99230,99831,92069,92467,94154,95104,98647,91735,92069,96731,92069,95255,95725,98178,95671,92071,92071,95609,98831,95539,97720,93407,95548,96444,96682,96930,98637,95548,98534,95991,95118,95542,94433,96307,92916,94147,94210,96996,97223,99247,90597,93175,93224,91642,93177,91642,91562,94711,94792,96319,91562,93171,92008,91562,91562,91562,93171,96334,91674,95088,91282,93171,99287,94882,94882,92291,94881,96042,96042,94881,99476,92290,94914,90852,94924,90852,95535,90462,90853,90854,92307,92735,99228,89628,92701,89628,89628,96435,96435,89628,92706,89628,92706,89627,89625,89625,97958,98163,89625,97958,90293,99527,95543,94783)
AND YEAR(DD.date) = 2021
GROUP BY DD.id
ORDER BY DD.date, D.id