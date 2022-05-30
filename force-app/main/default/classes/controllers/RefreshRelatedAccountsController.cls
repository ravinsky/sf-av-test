public class RefreshRelatedAccountsController {
    public RefreshRelatedAccountsController( ApexPages.StandardController controller ) {}
    
    public void RefreshRelatedAccounts(){
        Id accountId = Apexpages.currentPage().getParameters().get('accountId');
        Account account = [Select Name, Website from Account Where Id =: accountId];
        RelatedAccounts.updateRelatedAccounts(account);
    }

}