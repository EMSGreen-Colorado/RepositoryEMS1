@isTest
private class OldVsNew {
    @isTest
    static void OldVsNew(){

        List<Account> testAccounts = new List<Account>();

        Account testAccountA = New Account();
        testAccountA.Name = 'Test Account A';
        testAccounts.add(testAccountA);

        Account testAccountB = New Account();
        testAccountB.Name = 'Test Account B';
        testAccounts.add(testAccountB);

        
        Account testAccountC = New Account();
        testAccountC.Name = 'Test Account C';
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
        testOpp2.Amount = 90;
        testOpp2.AccountId = testAccountB.Id;
        testOpp2.Description = null;        
        testOpportunities.add(testOpp2);


        Opportunity testOpp3 = New Opportunity();
        testOpp3.Name = 'Test Opportunity 3';
        testOpp3.CloseDate = Date.today();
        testOpp3.StageName = 'Prospecting';
        testOpp3.Amount = 150;
        testOpp3.AccountId = testAccountC.Id;
        testOpp3.Description = null; 
        testOpportunities.add(testOpp3);

        Insert testOpportunities;

        Test.startTest();
         testOpp1.StageName = 'Qualification';
         testOpp2.StageName = 'Closed Won';
         update testOpp1;
         update testOpp2;
         Test.stopTest();

         Opportunity updatedTestOpp1 = [SELECT Description FROM Opportunity WHERE Id = :testOpp1.Id];
         Opportunity updatedTestOpp2 = [SELECT Description FROM Opportunity WHERE Id = :testOpp2.Id];
         Opportunity updatedTestOpp3 = [SELECT Description FROM Opportunity WHERE Id = :testOpp3.Id];
         
        Assert.areEqual(null,updatedTestOpp1.Description);
        Assert.areEqual('An APEX Win!',updatedTestOpp2.Description);

    }
}