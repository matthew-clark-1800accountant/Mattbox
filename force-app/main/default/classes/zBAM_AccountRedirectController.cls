public with sharing class zBAM_AccountRedirectController {

    private Account acc;

    public zBAM_AccountRedirectController(ApexPages.StandardController controller) {
        acc = (Account)controller.getRecord();
    }

    public PageReference onLoad(){
        List<Zuora__CustomerAccount__c> billingAccounts = [
        SELECT
            Id
        FROM
            Zuora__CustomerAccount__c
        WHERE
            Zuora__Account__c = :acc.Id
        AND
            Zuora__Status__c = 'Active'
        LIMIT 1];

        if (!billingAccounts.isEmpty()){
            return new PageReference('/apex/Manage_Billing_Account?id=' + billingAccounts[0].Id + '&retId=' + acc.Id);
        }

        return new PageReference('/' + acc.Id);
    }
}