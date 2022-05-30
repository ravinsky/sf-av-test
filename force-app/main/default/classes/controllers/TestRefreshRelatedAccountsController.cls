@isTest
private class TestRefreshRelatedAccountsController {
    static testMethod void run() {
        Account accountModel = new Account(
            Name = 'Test Data',
            Website = 'https://test.com/'
        );
        insert accountModel;

        List<AccountOrg1__x> accountsOrg1 = new List<AccountOrg1__x>(); 
        AccountOrg1__x accountOrg1 = new AccountOrg1__x(
            Account_Name__c = 'Test Data',
            Website__c = 'https://test.com/'
        );
        accountsOrg1.add(accountOrg1);
        ObjectManager.setMock(new MockInterfaceOverride(accountsOrg1));

        Apexpages.StandardController stdController = new Apexpages.StandardController(accountModel);

        ApexPages.currentPage().getParameters().put('accountId', accountModel.Id);
        RefreshRelatedAccountsController controller = new RefreshRelatedAccountsController(stdController);
        Test.startTest();
        controller.RefreshRelatedAccounts();
        List<Related_Account_from_Org1__c> relatedAccounts = [Select Id from Related_Account_from_Org1__c Where Account_Id__c =: accountModel.Id];
        Test.stopTest();

        System.assertEquals(1, relatedAccounts.size());
    }
}