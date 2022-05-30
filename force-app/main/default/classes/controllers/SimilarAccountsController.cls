public with sharing class SimilarAccountsController {

    @AuraEnabled(cacheable=false)
    public static List<AccountOrg1__x> getSimilarAccountsAction(String accountName, String accountWebsite) {
        
        return RelatedAccounts.getSimilarExternalAccounts(accountName, accountWebsite);
    }
}