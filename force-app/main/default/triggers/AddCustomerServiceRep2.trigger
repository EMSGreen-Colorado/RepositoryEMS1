//Eric generated code
trigger AddCustomerServiceRep2 on Opportunity (after insert){
    CSR_Settings_2__c customSettingValues = CSR_Settings_2__c.getInstance('csr');
    if (customSettingValues ==null){
        return;
    }

    String customerServiceRepUserId = customSettingValues.CSR_User_ID__c;
    Decimal oppMinimumValue = customSettingValues.Opp_minimum_Value__c;

    Map<Id, Account> accountsMapToUpdate = new Map<Id, Account>();

    for (Opportunity opp : Trigger.new){
        if(opp.AccountId != null && opp.Amount != null && opp.Amount >= oppMinimumValue) {
            Account acc = new Account();
            acc.Id = opp.AccountId;
            acc.CSR__c = customerServiceRepUserId;

            accountsMapToUpdate.put(acc.id, acc);
        }
    }

    if (!accountsMapToUpdate.isEmpty()){
        update accountsMapToUpdate.values();
    }
}