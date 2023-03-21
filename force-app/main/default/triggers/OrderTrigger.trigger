trigger OrderTrigger on Bill62__Order__c (before insert, before update/*, after update*/) {
    
    Set<String> oppIds = new Set<String>();
    for(Bill62__Order__c s : Trigger.new){
        if(s.Bill62__Opportunity__c != NULL){
            oppIds.add(s.Bill62__Opportunity__c);
        }
    }
    
    List<Bill62__Order__c> orderList = [SELECT Id, Bill62__Opportunity__c FROM Bill62__Order__c WHERE Bill62__Opportunity__c IN :oppIds];
    
    Set<String> orderOpps = new Set<String>();
    for(Bill62__Order__c order : orderList){
        orderOpps.add(order.Bill62__Opportunity__c);
    }
    
    //this error needs to happen for either update or insert, so no Trigger.isWhatever block here
    for(Bill62__Order__c s : Trigger.new){
        if(Trigger.isInsert){
            if(orderOpps.contains(s.Bill62__Opportunity__c)){ 
                s.addError('This Opportunity is already set on another Order ');
            }
        }else if(Trigger.isUpdate){
            if(orderOpps.contains(s.Bill62__Opportunity__c) && (s.Bill62__Opportunity__c != Trigger.oldMap.get(s.Id).Bill62__Opportunity__c)){
                s.addError('This Opportunity is already set on another Order ');
            }
        }
    }
    
    if(Trigger.isInsert){
        Set<Id> contactSet = new Set<Id>();
        for (Bill62__Order__c s : Trigger.new){
            if(s.Bill62__Customer__c != null) contactSet.add(s.Bill62__Customer__c);
            //if(s.Billing_Status__c == 'CC Paid') accountsIdList.add(s.Bill62__Account__c);
        }
        
        Map<Id, Contact> conMap = new Map<Id, Contact>([SELECT ID, ACCOUNTID
            FROM CONTACT WHERE ID IN: contactSet]); 
        for (Bill62__Order__c s : Trigger.new){
            if(conMap.containsKey(s.Bill62__Customer__c)){
                s.Bill62__Account__c = conMap.get(s.Bill62__Customer__c).AccountId;
            }
        }
    }else if(Trigger.isUpdate){
        //Update Order's Account Account Status
         //Set<String> continueStatuses = new Set<String>{'CC Paid','Behalf Paid','Behalf Paid - Need Monthly CC'};
        
        Set<String> accountsIdList = new Set<String>();
        for(Bill62__Order__c order : Trigger.new){
            Bill62__Order__c oldId = Trigger.oldMap.get(order.Id);
            //if(!continueStatuses.contains(oldId.Billing_Status__c) && continueStatuses.contains(order.Billing_Status__c)){
            if(oldId.Billing_Status__c != order.Billing_Status__c){
                accountsIdList.add(order.Bill62__Account__c);
            }
        }
        
        //List<Account> accountsList = [SELECT Id, Account_Status__c, Onboarding_Date__c FROM Account WHERE Id IN: accountsIdList];
        Map<Id, Account> accountMap = new Map<ID, Account>([SELECT Id, Account_Status__c, Onboarding_Date__c FROM Account WHERE Id IN: accountsIdList]);
        
        //functionality to prevent the Account from being updated by upsells (second Order and beyond)
        Set<ID> triggerKeyset = Trigger.Newmap.Keyset();
        List<Bill62__Order__c> existingOrders = [SELECT ID, Bill62__Account__c FROM Bill62__Order__c WHERE Bill62__Account__c IN :accountsIdList AND ID NOT IN :triggerKeyset];
        Set<String> badAccountIDs = new Set<String>();
        for(Bill62__Order__c ord: existingOrders){
            badAccountIDs.add(ord.Bill62__Account__c);
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        /*Rich deprecated this code 12-8-15 to account for additonal Billing Status updates
        for(Account a : accountsList){
            if(!badAccountIDs.contains(a.Id)){
                a.Account_Status__c = 'Onboarding';
                a.Onboarding_Date__c = System.Date.today();
                accountsToUpdate.add(a);
            }
        }*/
        Set<String> paidStatuses = new Set<String>{'CC Paid','Behalf Paid','Behalf Paid - Need Monthly CC'};
        Set<String> rejectedStatuses = new Set<String>{'CC Rejected','Behalf Rejected','Not Billed','Corp Offer - In Progress','Corp Offer - Do Not Contact'};
        Set<String> cancelledStatuses = new Set<String>{'CC Refunded','Behalf Refunded'};
        Set<String> processedAccounts = new Set<String>();
        for(Bill62__Order__c o: Trigger.New){
            //Update Order's Account Account Status
            if(accountMap.containsKey(o.Bill62__Account__c) /*&& accountMap.get(o.AccountId).Account_Status__c != 'Onboarding'*/ && !badAccountIDs.contains(o.Bill62__Account__c)){
                Account a = accountMap.get(o.Bill62__Account__c);
                if(processedAccounts.contains(a.ID)) continue; //prevent duplicates
                if(paidStatuses.contains(o.Billing_Status__c)){
                    a.Account_Status__c = 'Onboarding';
                    a.Onboarding_Date__c = System.Date.today();
                    accountsToUpdate.add(a);
                    processedAccounts.add(a.ID);
                }else if(rejectedStatuses.contains(o.Billing_Status__c)){
                    a.Account_Status__c = 'No Sale';
                    accountsToUpdate.add(a);
                    processedAccounts.add(a.ID);
                }else if(cancelledStatuses.contains(o.Billing_Status__c)){
                    a.Account_Status__c = 'Cancelled';
                    accountsToUpdate.add(a);
                    processedAccounts.add(a.ID);
                }
            }
        }
        
        if(accountsToUpdate.size() > 0) update accountsToUpdate;
    }
}