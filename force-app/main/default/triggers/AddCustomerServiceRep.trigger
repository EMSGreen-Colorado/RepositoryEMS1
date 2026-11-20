//AI generated code
trigger AddCustomerServiceRep on Opportunity (after insert) {
    // Get the Custom Setting values
    CSR_Settings_2__c customSettingValues = CSR_Settings_2__c.getInstance('csr');
    
    // Safety check: ensure custom setting record exists to avoid NullPointerException
    if (customSettingValues == null) {
        return;
    }
    
    String customerServiceRepUserID = customSettingValues.CSR_User_ID__c;
    Decimal oppMinimumValue = customSettingValues.Opp_Minimum_Value__c;
    
    // Use a Map to hold unique Accounts and prevent duplicate ID errors in DML
    Map<Id, Account> accountsMapToUpdate = new Map<Id, Account>();
    
    // Look at the new opportunities that are greater than or equal to the minimum value
    for (Opportunity opp : Trigger.new) {
        // Ensure AccountId is present and Amount is not null
        if (opp.AccountId != null && opp.Amount != null && opp.Amount >= oppMinimumValue) {
            Account acc = new Account();
            acc.Id = opp.AccountId;
            acc.CSR__c = customerServiceRepUserID;
            
            // Putting into a Map automatically overwrites duplicates if multiple 
            // opportunities point to the same account in the same transactionCustom
            accountsMapToUpdate.put(acc.Id, acc);
        }
    }
    
    // Perform DML update if there are accounts to update
    if (!accountsMapToUpdate.isEmpty()) {
        update accountsMapToUpdate.values();
    }
}