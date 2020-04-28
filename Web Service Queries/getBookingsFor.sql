SELECT
            B.DealID As dealID,
            B.id as bookingID,
            CR.maxRevision As contractRevision,
            CRN.maxRevisionNew As contractRevisionNew,
            D.userID As agentCRMID,
            U.name As agentName,
            U.surname As agentSurname,
            U.initials As agentInitials,
            D.isOverseas,
            D.secondaryAgentID As secondaryAgentID,
            D.artistID, A.name As artistName,
            A.vatRegistered As artistVAT,
            B.commissionRate As bookingCommissionRate,
            B.splitRate AS bookingSplitRate,
            P.name As promoterName,
            P.surname As promoterSurname,
            P.email As promoterEmail,
            B.date,
            COALESCE(V.name,CONCAT(F.name,':',FS.name)) As venueName,
            COALESCE(V.city,F.city) As venueCity,
            COALESCE(CO.country,FC.country) As venueCountry,
            COALESCE(CO.code,F.country) As countryCode,
            C.code As currencyCode,
            ROUND(B.fee *100,0) + COALESCE(BACKOUT.backoutsum, 0) AS bookingFee,
            SHOW_FEE.total AS show_fee,
            ROUND((SHOW_ABOVE_LINE.total / (1+COALESCE(B.vatRate, 0)))) as show_above_line,
            CFDD.fee As dealDateCancellationFee,
            CFD.fee As dealCancellationFee,
            COALESCE(D.cancelled,B.cancelled) as cancelled,
            SPLIT.id as child_contract_id,
            SPLIT.total as child_contract_fee,
            B.isCorporate
    	FROM Deal_Date B
        LEFT JOIN Deal D        ON D.id = B.DealID
            LEFT JOIN User U        ON D.userID = U.id
            LEFT JOIN Artist A      ON A.id = D.artistID
            LEFT JOIN Contact P     ON P.id = D.promoterID
            LEFT JOIN Venue V       ON V.id = B.venueID
            LEFT JOIN Festival_Stages FS   ON FS.id = B.festivalStageID
            LEFT JOIN Festivals F   ON F.id = FS.festivalID
            LEFT JOIN Country FC   ON F.country = FC.code
            LEFT JOIN Country CO    ON V.country = CO.id
            LEFT JOIN Currency C    ON C.id = B.currencyID
            LEFT JOIN Cancellation_Fee CFDD on B.id = CFDD.dealDateID
            LEFT JOIN Cancellation_Fee CFD on D.id = CFD.dealID
            LEFT JOIN (SELECT dealID, MAX(revision) As maxRevision FROM `Contract_Revision` GROUP By dealID) CR ON CR.DealID = B.DealID
            LEFT JOIN (SELECT contractID, MAX(revision) As maxRevisionNew FROM `Contract_Data` GROUP By contractID) CRN ON CRN.contractID = B.DealID
            LEFT JOIN (SELECT dealID, relID, Sum(`amount`) AS total FROM `Deal_Account` GROUP BY `dealID`,`relID` ) SHOW_FEE ON SHOW_FEE.dealID = B.DealID AND SHOW_FEE.relID = B.id
            LEFT JOIN (
              SELECT
                DA.dealID,
                DA.relID,
                CE.showId AS showId,
                Sum(DA.`amount`) AS backoutsum
              FROM `Deal_Account` AS DA
              LEFT JOIN Contract_Extra as CE ON CE.id = DA.relID
              where DA.rel='BCK1'
              GROUP BY DA.`dealID`, showId
            ) BACKOUT ON BACKOUT.dealID = B.DealID AND BACKOUT.showId = B.id
            LEFT JOIN (
                select
                  showID,
                  sum(SHOW_EXTRAS.total) as total,
                  contractID
                FROM Contract_Extra
                LEFT JOIN (
                    SELECT
                        dealID,
                        relID,
                        Sum(`amount`) AS total
                    FROM `Deal_Account`
                    GROUP BY `dealID`,`relID`
                ) SHOW_EXTRAS on SHOW_EXTRAS.relID = Contract_Extra.id AND SHOW_EXTRAS.dealID = Contract_Extra.contractID
                WHERE  Contract_Extra.type = 'above_line'
                GROUP BY showID, contractID
            ) SHOW_ABOVE_LINE ON SHOW_ABOVE_LINE.showID = B.id and SHOW_ABOVE_LINE.contractID = B.DealID
            LEFT JOIN
                (SELECT
                   Deal.id as id,
                   FEE.showID as showId,
                   FEE.total as total,
                   Deal.parentId as parentId
                 FROM Deal
                   LEFT JOIN
                   (SELECT
                      showID,
                      contractID,
                      sum(SHOW_EXTRAS_2.total) AS total
                    FROM Contract_Extra
                      LEFT JOIN (
                                  SELECT
                                    dealID,
                                    relID,
                                    Sum(`amount`) AS total
                                  FROM `Deal_Account`
                                  GROUP BY `dealID`, `relID`
                                ) SHOW_EXTRAS_2
                        ON SHOW_EXTRAS_2.relID = Contract_Extra.id
                           AND SHOW_EXTRAS_2.dealID = Contract_Extra.contractID
                   WHERE Contract_Extra.category = 'production_fee'
                    GROUP BY `showID`, `contractID`
                   ) FEE ON Deal.id = FEE.contractID
                 GROUP BY Deal.id, FEE.showID
                ) SPLIT on SPLIT.parentId = B.dealID and SPLIT.showId = B.id
# ADD ARTIST ID HERE
# IN THE WHERE STATEMENT
# BELOW
    	WHERE D.draft != 1
            AND D.isComplete != 1
            AND ( D.cancelled != 1 OR (D.cancelled = 1 AND (CFDD.fee IS NOT NULL OR CFD.fee IS NOT NULL)))
            AND ( B.cancelled != 1 OR (B.cancelled = 1 AND (CFDD.fee IS NOT NULL OR CFD.fee IS NOT NULL)))
    	ORDER by B.DealID, B.date, CO.country ASC