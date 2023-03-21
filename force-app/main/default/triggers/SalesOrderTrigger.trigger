trigger SalesOrderTrigger on Opportunity (after update) {

    if(Trigger.isAfter && Trigger.isUpdate){
        //Update the 'Sold By', 'Merchant Sales Owner', and 'Corp Sales Owner' on the Account when an Opportunity is closed
        Set<String> accountIDs = new Set<String>();
        Set<String> oppIds = new Set<String>();
        /* Rich deprecated this code 12-8-15 to account for additonal stage changing logic, not just 'Onboarding'
        Set<String> continueStatuses = new Set<String>{'CC Paid','Behalf Paid','Behalf Paid - Need Monthly CC'};
        for(Opportunity o: Trigger.New){
            //filter down to ones that have been closed
            if(!continueStatuses.contains(Trigger.oldMap.get(o.Id).Billing_Status__c) && continueStatuses.contains(o.Billing_Status__c)){
                accountIDs.add(o.AccountID);
                oppIds.add(o.Id);
            }
            if(!continueStatuses.contains(Trigger.oldMap.get(o.Id).Upsell_Status__c) && continueStatuses.contains(o.Upsell_Status__c)){
                accountIDs.add(o.AccountID);
                oppIds.add(o.Id);
            }
        }*/
        for(Opportunity o: Trigger.New){
            if(Trigger.oldMap.get(o.Id).Billing_Status__c != o.Billing_Status__c){
                accountIDs.add(o.AccountID);
                oppIds.add(o.Id);
            }
        }
        
        //get all the data we need and map it.  Bulk friendly, mothertruckers!
        Map<ID, Account> accountMap = new Map<ID, Account>([SELECT ID,Corp_Sales_Owner__c,Sales_Rep__c,Merchant_Sales_Owner__c,Account_Status__c,Onboarding_Date__c 
            FROM Account WHERE ID IN :accountIDs]);
        List<OpportunityLineItem> oppLines = [SELECT ID, PriceBookEntry.Product2.Family, OpportunityID FROM OpportunityLineItem WHERE OpportunityId IN :oppIds];
        Map<String, List<OpportunityLineItem>> oppToLineMap = new Map<String, List<OpportunityLineItem>>();
        for(OpportunityLineItem sobj: oppLines){
            if(oppToLineMap.containsKey(sobj.OpportunityId)){
                List<OpportunityLineItem> temp = oppToLineMap.get(sobj.OpportunityId);
                temp.add(sobj);
                oppToLineMap.put(sobj.OpportunityId, temp);
            }else{
                List<OpportunityLineItem> temp = new List<SObject>();
                temp.add(sobj);
                oppToLineMap.put(sobj.OpportunityId, temp);
            }
        }
        Set<String> SoldByFamilies = new Set<String>{'Accounting Package','A La Carte','Sam\'s Club'};
        Set<String> CorpFamilies = new Set<String>{'Corp'};
        Set<String> MerchantFamilies = new Set<String>{'Merchant Processing'};
        
        //functionality to prevent updating Accounts for upsells (second Order and beyond)
        Set<ID> triggerKeyset = Trigger.newMap.keyset();
        List<Opportunity> existingOpps = [SELECT ID, AccountID FROM Opportunity WHERE AccountID IN :accountIDs and ID NOT IN :triggerKeyset];
        Set<String> badAccountIDs = new Set<String>();
        for(Opportunity o: existingOpps){
            badAccountIDs.add(o.AccountId);
        }
        
        //now do the actual setting of the fields
        Set<String> paidStatuses = new Set<String>{'CC Paid','Behalf Paid','Behalf Paid - Need Monthly CC'};
        Set<String> rejectedStatuses = new Set<String>{'CC Rejected','Behalf Rejected','Not Billed','Corp Offer - In Progress','Corp Offer - Do Not Contact'};
        Set<String> cancelledStatuses = new Set<String>{'CC Refunded','Behalf Refunded'};
        for(Opportunity o: Trigger.New){
            //Update Order's Account Account Status
            if(accountMap.containsKey(o.AccountID) /*&& accountMap.get(o.AccountId).Account_Status__c != 'Onboarding'*/ && !badAccountIDs.contains(o.AccountId)){
                if(paidStatuses.contains(o.Billing_Status__c)){
                    accountMap.get(o.AccountId).Account_Status__c = 'Onboarding';
                    accountMap.get(o.AccountId).Onboarding_Date__c = System.Date.today();
                }else if(rejectedStatuses.contains(o.Billing_Status__c)){
                    accountMap.get(o.AccountId).Account_Status__c = 'No Sale';
                }else if(cancelledStatuses.contains(o.Billing_Status__c)){
                    accountMap.get(o.AccountId).Account_Status__c = 'Cancelled';
                }
            }
        
            if(!oppToLineMap.containsKey(o.Id)) continue;
            for(OpportunityLineItem oli: oppToLineMap.get(o.Id)){
                if(SoldByFamilies.contains(oli.PriceBookEntry.Product2.Family)){ 
                    accountMap.get(o.AccountId).Sales_Rep__c = o.OwnerId;
                }
                if(CorpFamilies.contains(oli.PriceBookEntry.Product2.Family)){ 
                    accountMap.get(o.AccountId).Corp_Sales_Owner__c = o.OwnerId;
                }
                if(MerchantFamilies.contains(oli.PriceBookEntry.Product2.Family)){ 
                    accountMap.get(o.AccountId).Merchant_Sales_Owner__c = o.OwnerId;
                }
            } 
        }
        
        if(accountMap.values().size() > 0) update accountMap.values();
    } //end of Account updating code
}