trigger RelatedAccountsTrigger on Account (after insert) {
    List<Id> accountIds = new List<Id>();
    for (Account account : Trigger.New) {
        accountIds.add(account.id);
    }

    if (accountIds.size() == 1){
        RelatedAccounts.updateRelatedAccountsFuture(accountIds[0]);
    } else {
        RelatedAccountsBatch relatedBatch = new RelatedAccountsBatch(); 
        relatedBatch.accountIds = accountIds;
        Database.executeBatch(relatedBatch, 10);
    }
}