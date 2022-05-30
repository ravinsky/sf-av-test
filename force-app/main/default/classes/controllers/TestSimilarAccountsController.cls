@isTest
private class TestSimilarAccountsController {
    static testMethod void run() {

        List<AccountOrg1__x> accountsOrg1 = new List<AccountOrg1__x>(); 
        AccountOrg1__x accountOrg1 = new AccountOrg1__x(
             Account_Name__c = 'Test Data',
             Website__c = 'https://test.com/'
         );
         accountsOrg1.add(accountOrg1);
         ObjectManager.setMock(new MockInterfaceOverride(accountsOrg1));

        Test.startTest();
        List<AccountOrg1__x> result = SimilarAccountsController.getSimilarAccountsAction('Test', 'test');
        Test.stopTest();

        System.assertEquals(1, result.size());
    }
}