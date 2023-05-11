public class AccountDeleteRelatedRecords {
    private List<Id> accountIds;
    public AccountDeleteRelatedRecords(List<Id> accountIds){this.accountIds = accountIds;}
    public void deleteRelatedRecords() {
        //Each list can only hold 10 different object types so if you have more than 10 you need to make another list
        List<SObject> relatedRecordsToDelete = new List<SObject>();
        List<SObject> relatedRecordsToDelete2 = new List<SObject>();
        List<SObject> relatedRecordsToDelete3 = new List<SObject>();

        //10
        relatedRecordsToDelete.addAll(this.deleteRecords('ChargeOver_Subscription_Line_Item__c', 'Account__c'));
        relatedRecordsToDelete.addAll(this.deleteRecords('ChargeOver_Quote_Line_Item__c', 'Account__c'));
        relatedRecordsToDelete.addAll(this.deleteRecords('Active_Subscriptions__c', 'Account__c'));
        relatedRecordsToDelete.addAll(this.deleteRecords('GetFeedback_Survey_Response__c', 'Account__c'));
        relatedRecordsToDelete.addAll(this.deleteRecords('Sales_GetFeedback_Surveys__c', 'Account__c'));
        relatedRecordsToDelete.addAll(this.deleteRecords('Legal_Plan_Surveys__c', 'Account__c'));
        relatedRecordsToDelete.addAll(this.deleteRecords('Survey__c', 'Account__c'));
        relatedRecordsToDelete.addAll(this.deleteRecords('SMS_Schedule__c', 'Account__c'));
        relatedRecordsToDelete.addAll(this.deleteRecords('ChargeOver_Invoice__c', 'Account__c'));
        relatedRecordsToDelete.addAll(this.deleteRecords('ChargeOver_Invoice_Line_Item__c', 'Account__c'));
        //20
        relatedRecordsToDelete2.addAll(this.deleteRecords('ChargeOver_Quote__c', 'Account__c'));
        relatedRecordsToDelete2.addAll(this.deleteRecords('ChargeOver_Subscription__c', 'Account__c'));
        relatedRecordsToDelete2.addAll(this.deleteRecords('ChargeOver_Transaction__c', 'Account__c'));
        relatedRecordsToDelete2.addAll(this.deleteRecords('ChargeOver_Transaction_Applied__c', 'Account__c'));
        relatedRecordsToDelete3.addAll(this.deleteRecords('Bill62__Payment_Method__c', 'Bill62__Account__c '));
        relatedRecordsToDelete3.addAll(this.deleteRecords('Bill62__Payment__c', 'Bill62__Account__c '));
        relatedRecordsToDelete3.addAll(this.deleteRecords('Bill62__Subscription__c', 'Bill62__Account__c '));
        relatedRecordsToDelete3.addAll(this.deleteRecords('Bill62__Order__c', 'Bill62__Account__c'));
        relatedRecordsToDelete3.addAll(this.deleteRecords('Business__c', 'Account__c'));
        relatedRecordsToDelete3.addAll(this.deleteRecords('Shareholder__c', 'Account__c'));
        //30  
        relatedRecordsToDelete3.addAll(this.deleteRecords('X1099_Form__c', 'Payee_Account__c'));      
        relatedRecordsToDelete2.addAll(this.deleteRecords('Case', 'AccountId'));
        relatedRecordsToDelete2.addAll(this.deleteRecords('Event', 'WhatId'));
        relatedRecordsToDelete2.addAll(this.deleteRecords('Task', 'WhatId'));
        relatedRecordsToDelete2.addAll(this.deleteRecords('Contact', 'AccountId'));
        relatedRecordsToDelete2.addAll(this.deleteRecords('Opportunity', 'AccountId'));
        relatedRecordsToDelete2.addAll(this.deleteRecords('Lead', 'ConvertedAccountId'));
        /* Instructions on adding additional objects to delete: 
        *  Use the following code snippet but replace the parameters, then add it in below
        *  relatedRecordsToDelete3.addAll(this.deleteRecords('X1099_Form__c', 'Payee_Account__c'));
        *  1st Parameter: Object's API name eg Business__c
        *  2nd Parameter: The name of the field on the object that relates it to account eg Account__c
        *  Note: If you are adding more than 10 types of objects to a list you need to make a new one
        */

        delete relatedRecordsToDelete;
        delete relatedRecordsToDelete2;
        delete relatedRecordsToDelete3;

    }

    private List<sObject> deleteRecords(String objectToDelete, String relationshipName){
        String queryString = 'SELECT Id FROM '+objectToDelete+' WHERE '+relationshipName+' IN :accountIds';
        return Database.query(queryString);
    }
}