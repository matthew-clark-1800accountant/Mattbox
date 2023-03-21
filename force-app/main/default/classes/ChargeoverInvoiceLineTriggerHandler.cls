public with sharing class ChargeoverInvoiceLineTriggerHandler {
    public static void afterUpdate(Map<Id, ChargeOver_Invoice_Line_Item__c> oldItems, List<ChargeOver_Invoice_Line_Item__c> newItems){
        List<ChargeOver_Invoice_Line_Item__c> toggledItems = new List<ChargeOver_Invoice_Line_Item__c>();
        for(ChargeOver_Invoice_Line_Item__c item : newItems){
            if(oldItems.get(item.Id).ASL_Renewal_Trigger__c != item.ASL_Renewal_Trigger__c){
                toggledItems.add(item);
            }
        }
        if(!toggledItems.isEmpty()){
            afterInsert(toggledItems);
        }
    }

    public static void afterInsert(List<ChargeOver_Invoice_Line_Item__c> items){
        System.debug('ChargeoverInvoiceLineTriggerHandler.afterInsert()');
        List<Id> yearlyItemIds = new List<Id>();
        List<Id> monthlyItemIds = new List<Id>();
        for(ChargeOver_Invoice_Line_Item__c item : items){
            Boolean isRenewal = (item.Payment_Type__c == 'Renewal' || (item.Payment_Terms__c != 'Monthly' && !item.Is_Obligation__c && item.First_Obligation_ID__c != null));
            Boolean isMonthly = (item.Payment_Terms__c == 'Monthly' && item.Number_of_Recurs__c > 1 && Math.mod((Integer)item.Number_of_Recurs__c, 12)==1);
            
            if(isRenewal || isMonthly){ 
                System.debug('added item: '+item.Id+' '+item.Payment_Type__c+' '+item.Payment_Terms__c);
                yearlyItemIds.add(item.Id);                
            } else {
                System.debug('item not added: '+item.Id+' '+item.Payment_Type__c+' '+item.Payment_Terms__c);
            }
        }

        for(Id itemId : yearlyItemIds){
            syncAnnualItem(itemId);
        }
    }


    @future
    public static void syncAnnualItem(Id itemId){
        System.debug('ChargeoverInvoiceLineTriggerHandler.syncAnnualItem()');
        ChargeOver_Invoice_Line_Item__c item = 
        [SELECT Id,
        Rate__c,
        Quantity__c,
        Account__r.Id,
        Product__r.Id,
        Product__r.Fulfillable_Product_for_Renewal__c,
        Product__r.Family, //category
        Product__r.Billing_Frequency__c,
        ChargeOver_Subscription_Line_Item__r.Id,
        ChargeOver_Subscription_Line_Item__r.Status__c,
        ChargeOver_Subscription_Line_Item__r.Subscription_Start_Date__c,
        ChargeOver_Subscription_Line_Item__r.Active_Subscription__r.Id,
        ChargeOver_Subscription_Line_Item__r.Active_Subscription__r.Name,
        ChargeOver_Subscription_Line_Item__r.Active_Subscription__r.Customer_Number__c,
        ChargeOver_Subscription_Line_Item__r.Chargeover_Subscription__r.Id
        FROM ChargeOver_Invoice_Line_Item__c 
        WHERE Id = :itemId LIMIT 1];
        System.debug(item);

        Boolean isTaxPrep = (item.Product__r.Billing_Frequency__c == 'Annual' && item.Product__r.Fulfillable_Product_for_Renewal__c);

        if(isTaxPrep){
            List<Active_Subscription_Line__c> newAsls = new List<Active_Subscription_Line__c>();
            for(integer i=0; i<item.Quantity__c; i++){
                Active_Subscription_Line__c newAsl = new Active_Subscription_Line__c(
                    Name = item.ChargeOver_Subscription_Line_Item__r.Active_Subscription__r.Name,
                    Account__c = item.Account__r.Id,
                    Customer_Number__c = item.ChargeOver_Subscription_Line_Item__r.Active_Subscription__r.Customer_Number__c,
                    ChargeOver_Subscription__c = item.ChargeOver_Subscription_Line_Item__r.Chargeover_Subscription__r.Id,
                    ChargeOver_Subscription_Line_Item__c = item.ChargeOver_Subscription_Line_Item__r.Id,
                    Active_Subscription__c = item.ChargeOver_Subscription_Line_Item__r.Active_Subscription__r.Id,
                    Unique_Identifier__c = item.Product__r.Id+''+item.Account__r.Id,
                    Status__c = item.ChargeOver_Subscription_Line_Item__r.Status__c,
                    Product__c = item.Product__r.Id,
                    Category__c = item.Product__r.Family,
                    Subscription_Amount__c = item.Rate__c,
                    Start_Date__c = item.ChargeOver_Subscription_Line_Item__r.Subscription_Start_Date__c.date(),
                    Created_by_Renewal__c = true
                );
                newAsls.add(newAsl);
            }
            
    
            System.debug(newAsls);
            //Savepoint sp = Database.setSavepoint();
            List<Database.SaveResult> res = Database.insert(newAsls);
            for(Database.SaveResult sr : res){
                System.debug(res);
            }            
            //manually trigger rollup logic
            //ChargeOver_ActiveSubTriggerHandler.updateTotalQuantity(new List<Active_Subscriptions__c>{new Active_Subscriptions__c(Id=item.ChargeOver_Subscription_Line_Item__r.Active_Subscription__r.Id)});
            //Database.rollback(sp);
            Active_Subscriptions__c sub = new Active_Subscriptions__c(Id = item.ChargeOver_Subscription_Line_Item__r.Active_Subscription__r.Id);
            update sub;
    
            //ChargeOver_Invoice_Line_Item__c.Unique_Identifier__c = 
            //   ChargeOver_Invoice_Line_Item__c.Product__c + ChargeOver_Invoice_Line_Item__c.Account__c
        } else {
            System.debug('item not tax prep: '+item.Id+' '+item.Product__r.Billing_Frequency__c+' '+ item.Product__r.Fulfillable_Product_for_Renewal__c);
        }
        
    }
}