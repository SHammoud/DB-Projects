# Remove production contract
# Set the prod variable below

SET @prod =104950  ; # <-- ADD production contract ID here

UPDATE Deal D
SET D.paymentSchedulePresetId = NULL , D.nextCodaPaymentScheduleID = NULL , D.nextPaymentScheduleID = NULL
WHERE D.id = @prod;

DELETE FROM Payment_Schedule
WHERE Payment_Schedule.dealID = @prod;

DELETE FROM Contract_Extra
WHERE Contract_Extra.contractID = @prod;

DELETE FROM Deal_Account
WHERE Deal_Account.dealID = @prod;

DELETE FROM Contract_Revision
WHERE Contract_Revision.dealID = @prod;

DELETE FROM Contract_Revisions
WHERE Contract_Revisions.contractId = @prod;

DELETE FROM Contract_Data
WHERE Contract_Data.contractID = @prod;

DELETE FROM Deal
WHERE Deal.id = @prod;

SET @prod = null;