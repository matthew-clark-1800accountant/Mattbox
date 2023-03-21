/*
@Name               : C62BatchGenerateDirectPayments
@Author             : customersuccess@cloud62.com
@Date               : July 29, 2014
@Description        : Batch to create member dues from member subscription
*/
global class C62GenerateNewPayments implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'Select Bill62__Subscription__r.Bill62__Customer__r.Email,Bill62__Subscription__r.Bill62__Start_Date__c, '
        + 'Bill62__Subscription__r.Bill62__End_Date__c, Bill62__Subscription__r.Bill62__Number_of_Cycles_Billed__c,'
        + 'Bill62__Subscription__r.Bill62__Previous_Billed_Through_Date__c,Bill62__Subscription__r.Bill62__Customer__r.Name,'
        + 'Bill62__Subscription__r.Bill62__Billing_Frequency__c,Bill62__Subscription__r.Bill62__Customer__c, Bill62__Subscription__r.Bill62__Payment_Method__c, '
        + 'Bill62__Subscription__r.Bill62__Account__c, Bill62__Subscription__r.Bill62__Active__c, '
        + 'Bill62__Amount__c, Bill62__Schedule_Payment_Date__c, Bill62__Subscription__c, Bill62__Cycle_Start_Date__c,(SELECT ID FROM Bill62__Payments__r)'
        + ' From Bill62__Subscription_Line__c'
        + ' Where (Bill62__current_Cycle__c = true or Bill62__Cycle_End_Date__c<TODAY or Bill62__Schedule_Payment_Date__c <= TODAY '
        + ' or(Bill62__Billing_Frequency__c=\'Monthly\' and Bill62__Next_Cycle__c=true)) '
        //+ ' and Bill62__Dues__c=null)'
        + ' and Bill62__Type__c!=\'Initiation\''
        + ' and Bill62__Subscription__r.Bill62__Suspended__c !=true'
        + ' and Bill62__Payment_Received__c = false'
        + ' and Bill62__Subscription__r.Bill62__Active__c = true'
        + ' and Bill62__Subscription__r.Bill62__Status__c IN (\'Active\',\'Pending\') '
        //+ ' and Bill62__Subscription__r.RecordType.Name =\'Direct Payment Subscription\''
        + ' ORDER BY Bill62__Cycle_Start_Date__c';
        if(Test.isRunningTest()) query += ' LIMIT 200';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<Bill62__Subscription_Line__c> scopeList = (List<Bill62__Subscription_Line__c>)scope;
        
        List<Bill62__Subscription_Line__c> passOnList = new List<Bill62__Subscription_Line__c>();
        Bill62__C62Billing_Config__c billSettings = Bill62__C62Billing_Config__c.getOrgDefaults();
        for(Bill62__Subscription_Line__c sl: scopeList){
            if(billSettings.Bill62__Initiation_Fee_Required__c){
                if(sl.Bill62__Subscription__r.Bill62__Active__c) passOnList.add(sl);
            } else {
                passOnList.add(sl);
            }
        }
        
        List<Bill62__Payment__c> insertPayList = new List<Bill62__Payment__c>();
        for (Bill62__Subscription_Line__c sl : passOnList){
            if (sl.Bill62__Payments__r.size() == 0){
                Bill62__Payment__c newPay = new Bill62__Payment__c();
                newPay.Bill62__Amount__c = sl.Bill62__Amount__c;
                //newPay.Bill62__Next_Payment_Attempt_Date__c = sl.Bill62__Subscription__r.Bill62__Start_Date__c;
                if(sl.Bill62__Schedule_Payment_Date__c == null){
                    newPay.Bill62__Payment_Date__c = sl.Bill62__Cycle_Start_Date__c;// don't know why this was here: Bill62__Subscription__r.Bill62__Start_Date__c;
                }else{
                    newPay.Bill62__Payment_Date__c = sl.Bill62__Schedule_Payment_Date__c;
                }
                newPay.Bill62__Account__c = sl.Bill62__Subscription__r.Bill62__Account__c;
                newPay.Bill62__Subscription_Line__c = sl.Id;
                newPay.Bill62__Customer__c = sl.Bill62__Subscription__r.Bill62__Customer__c;
                newPay.Bill62__Status__c = 'Queued';
                newPay.Bill62__Payment_Method__c = sl.Bill62__Subscription__r.Bill62__Payment_Method__c;
                newPay.Bill62__Subscription__c = sl.Bill62__Subscription__c;
                insertPayList.add(newPay);
            }
        }
        insert insertPayList;
    }
    
    public void finish(Database.BatchableContext BC) {

    }
    
}