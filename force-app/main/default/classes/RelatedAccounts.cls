public class RelatedAccounts {
    
    public static List<AccountOrg1__x> getSimilarExternalAccounts(String accountName, String accountWebsite){
        accountName = '%' + accountName + '%';
        String accountsQuery = 'SELECT Account_Name__c, Website__c FROM AccountOrg1__x WHERE Account_Name__c  LIKE :accountName';
        if (String.isEmpty(accountWebsite) == false){
            accountWebsite = '%' + accountWebsite + '%';
            accountsQuery += ' OR Website__c like :accountWebsite';
        }
        accountsQuery += ' LIMIT 20';
        return ObjectManager.records(Database.query(accountsQuery));
    }

    public static void updateRelatedAccounts(Account account){

        List<AccountOrg1__x> similarExternalAccounts = RelatedAccounts.getSimilarExternalAccounts(account.Name, account.Website);

        List<Related_Account_from_Org1__c> oldRelatedAccounts = [Select Id from Related_Account_from_Org1__c Where Account_Id__c =: account.Id];
        if (oldRelatedAccounts.size() > 0){
            delete oldRelatedAccounts;
        }

        List<Related_Account_from_Org1__c> relatedAccountsToInsert = new List<Related_Account_from_Org1__c>();

        for (AccountOrg1__x externalAccount : similarExternalAccounts){
            Related_Account_from_Org1__c relatedAccount = new Related_Account_from_Org1__c(
                Account_Id__c = account.id,
                External_Account_Id__c = externalAccount.Id,
                Name = externalAccount.Account_Name__c,
                Account_Website__c = externalAccount.Website__c
            );
            relatedAccountsToInsert.add(relatedAccount);
        }
        if (relatedAccountsToInsert.size() > 0){
            insert relatedAccountsToInsert;
        }
    }

    @future(callout = true)
    public static void updateRelatedAccountsFuture(String accountId){
        Account account = [Select Name, Website from Account Where Id =: accountId];
        RelatedAccounts.updateRelatedAccounts(account);
    }

}