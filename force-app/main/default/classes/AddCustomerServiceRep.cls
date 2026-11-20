@isTest
private class AddCustomerServiceRep {
    @isTest
    static void noCustomSettings (){ 

        Account testAccountX = New Account();
        testAccountX.Name = 'Test Account X';
        testAccountX.CSR__c = '005g700000BefELAAZ';
        insert testAccountX;
        
        Opportunity testOppX = New Opportunity();
        testOppX.Name = 'Test Opportunity X';
        testOppX.CloseDate = Date.today();
        testOppX.StageName = 'Prospecting';
        testOppX.Amount = 6000;
        testOppX.AccountId = testAccountX.Id;
        testOppX.Description = null; 
        
        Test.startTest();
         insert testOppX;
         Test.stopTest();        
        
        Account updatedTestAccountX = [SELECT CSR__c FROM Account WHERE Id = :testAccountX.Id];
        Assert.areEqual('005g700000BefELAAZ',updatedTestAccountX.CSR__C);
    }
    @isTest
    static void AddCustomerServiceRep(){

        CSR_Settings_2__c testSetting = new CSR_Settings_2__c(
        Name = 'csr',
        CSR_User_ID__c = '005g700000BefCbAAJ',
        Opp_Minimum_Value__c = 5000
        );        
        insert testSetting;

        List<Account> testAccounts = new List<Account>();

        Account testAccountA = New Account();
        testAccountA.Name = 'Test Account A';
        testAccountA.CSR__c = '005g700000BefELAAZ';
        testAccounts.add(testAccountA);

        Account testAccountB = New Account();
        testAccountB.Name = 'Test Account B';
        testAccountB.CSR__c = '005g700000BefELAAZ';
        testAccounts.add(testAccountB);
        
        Account testAccountC = New Account();
        testAccountC.Name = 'Test Account C';
        testAccountC.CSR__c = '005g700000BefELAAZ';
        testAccounts.add(testAccountC);

        Insert testAccounts;

        List<Opportunity> testOpportunities = new List<Opportunity>();

        Opportunity testOpp1 = New Opportunity();
        testOpp1.Name = 'Test Opportunity 1';
        testOpp1.CloseDate = Date.today();
        testOpp1.StageName = 'Prospecting';
        testOpp1.Amount = 300;
        testOpp1.AccountId = testAccountA.Id;
        testOpp1.Description = null;
        testOpportunities.add(testOpp1);
        
        Opportunity testOpp2 = New Opportunity();
        testOpp2.Name = 'Test Opportunity 2';
        testOpp2.CloseDate = Date.today();
        testOpp2.StageName = 'Prospecting';
        testOpp2.Amount = 6000;
        testOpp2.AccountId = testAccountB.Id;
        testOpp2.Description = null;       
        testOpportunities.add(testOpp2);


        Opportunity testOpp3 = New Opportunity();
        testOpp3.Name = 'Test Opportunity 3';
        testOpp3.CloseDate = Date.today();
        testOpp3.StageName = 'Prospecting';
        testOpp3.Amount = 4000;
        testOpp3.AccountId = testAccountC.Id;
        testOpp3.Description = null; 
        testOpportunities.add(testOpp3);


        Test.startTest();
         Insert testOpportunities;
         Test.stopTest();

        Account updatedTestAccountA = [SELECT CSR__c FROM Account WHERE Id = :testAccountA.Id];
        Account updatedTestAccountB = [SELECT CSR__c FROM Account WHERE Id = :testAccountB.Id];
        Account updatedTestAccountC = [SELECT CSR__c FROM Account WHERE Id = :testAccountC.Id];

        Assert.areEqual('005g700000BefELAAZ',updatedTestAccountA.CSR__C);
        Assert.areEqual('005g700000BefCbAAJ',updatedTestAccountB.CSR__C);
        Assert.areEqual('005g700000BefELAAZ',updatedTestAccountC.CSR__C);


    }
}