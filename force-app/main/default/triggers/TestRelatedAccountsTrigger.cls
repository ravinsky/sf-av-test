@isTest 
private class TestRelatedAccountsTrigger {
    static testMethod void testAfterInsert() {
            Account accountModel = new Account(
                Name = 'Test Data',
                Website = 'https://test.com/'
            );
            Test.startTest();
            insert accountModel;
            Test.stopTest();
    }
}