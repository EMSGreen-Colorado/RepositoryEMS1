@isTest
private class TestProposalEmail {
    @isTest
    static void TestProposalEmail(){

        List<Account> testAccounts = new List<Account>();

        Account testAccountA = New Account();
        testAccountA.Name = 'Test Account A';
        testAccounts.add(testAccountA);

        

        List<Contact> testContacts = new List<Contact>();

        Contact testContact1 = New Contact();
        testContact1.FirstName = 'Tom';
        testContact1.LastName = 'Jones';
        testContact1.Email = 'Tom.Jones@topbuttonopptional.com';
        testContact1.AccountId = testAccountA.Id;
        testContacts.add(testContact1);
        
        Test.startTest();
         Insert testContacts;
         System.assertEquals (1, Limits.getEmailInvocations(),'The trigger did not sent exactly one email.');
         Test.stopTest();

         System.assertNotEquals (null,testContact1.Id,'The contact was not successfully inserted.');
    }
}