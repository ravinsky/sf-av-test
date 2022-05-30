global class RelatedAccountsBatch implements Database.Batchable<sObject> {

    global List<Id> accountIds;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Name, Website FROM Account WHERE Id IN (' + '\'' + String.join(accountIds, '\', \'') + '\')';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<Account> accounts){
        for (Account accountRecord : accounts) {
            RelatedAccounts.updateRelatedAccounts(accountRecord);
        }
    }

    global void finish(Database.BatchableContext bc){
    }
}