trigger PaymentTrigger on Bill62__Payment__c (before insert, after update, before update) {
    
    if (Trigger.isBefore && Trigger.isInsert){
    
        RoundRobinTransactionHandler handler = new RoundRobinTransactionHandler();
        List<Bill62__Payment_Gateway__c> defaultGateList = [SELECT ID FROM Bill62__Payment_Gateway__c WHERE Bill62__Default__c = TRUE LIMIT 1];
        Bill62__Payment_Gateway__c defaultGate;
        if(defaultGateList.size() > 0){
            defaultGate = defaultGateList[0];
        }
        
        Set<Id> subLineSet = new Set<Id>();
        Set<Id> paymentMethodSet = new Set<Id>();
        Map<Id, Bill62__Subscription_Line__c> subLineMap;
        for (Bill62__Payment__c p : Trigger.new){
            if (p.Bill62__Subscription_Line__c != null){
                subLineSet.add(p.Bill62__Subscription_Line__c);
            }
            if (p.Bill62__Payment_Method__c != null){
                paymentMethodSet.add(p.Bill62__Payment_Method__c);
            }
        }
        subLineMap = new Map<Id, Bill62__Subscription_Line__c>([SELECT ID,
            Bill62__Subscription__r.Bill62__Customer__r.Account.Company_Brand__c,
            Bill62__Subscription__r.Bill62__Customer__r.AccountId,
            Bill62__Subscription__r.Do_Not_Auto_Bill__c,                                                    
            Bill62__Billing_Frequency__c 
            from Bill62__Subscription_Line__c
            WHERE ID IN: subLineSet]);
            
        Map<Id, Bill62__Payment_Method__c> paymentMethodMap = new Map<Id, Bill62__Payment_Method__c>
            ([SELECT ID, Bill62__Card_Type__c FROM Bill62__Payment_Method__c
            WHERE ID IN: paymentMethodSet]);
            
        for (Bill62__Payment__c p : Trigger.new){
            Bill62__Subscription_Line__c subLine = subLineMap.get(p.Bill62__Subscription_Line__c);
                Boolean assignRoundRobin = false;
                if (p.Bill62__Payment_Method__c != null){
                    if (paymentMethodMap.get(p.Bill62__Payment_Method__c).Bill62__Card_Type__c == 'American Express'){
                        p.Bill62__Payment_Gateway__c = Org_Defaults__c.getOrgDefaults().Amex_Gateway__c; //hard code using amex only gateway
                    }else if(paymentMethodMap.get(p.Bill62__Payment_Method__c).Bill62__Card_Type__c == 'Discover'){
                        p.Bill62__Payment_Gateway__c = Org_Defaults__c.getOrgDefaults().Discover_Gateway__c; //hard code using Discover capable gateway
                    } else {
                        assignRoundRobin = true;
                    }
                } else {
                    assignRoundRobin = true;
                }
                if (assignRoundRobin){
                //if (subLine.Bill62__Subscription__r.Bill62__Customer__r.Account.Company_Brand__c != null){
                    //String companyBrand = subLine.Bill62__Subscription__r.Bill62__Customer__r.Account.Company_Brand__c;
                    p.Bill62__Payment_Gateway__c = handler.assignPaymentGateway();
                //}
                }
                
                if(p.Bill62__Payment_Gateway__c == null && defaultGate != null) p.Bill62__Payment_Gateway__c = defaultGate.Id;
                
            if (subLine != null){
                if (subLine.Bill62__Subscription__r.Bill62__Customer__r.AccountId != null){
                    p.Bill62__Account__c = subLine.Bill62__Subscription__r.Bill62__Customer__r.AccountId;
                }
            }
        }
        
        //change one-time payments so that they don't get automagically billed
        for (Bill62__Payment__c p : Trigger.new){
            Bill62__Subscription_Line__c subLine = subLineMap.get(p.Bill62__Subscription_Line__c);
            if (subLine != null){
                if(subLine.Bill62__Billing_Frequency__c == 'One-Time' || subLine.Bill62__Subscription__r.Do_Not_Auto_Bill__c == true){
                    p.Bill62__Status__c = 'Manual';
                } 
            }
       }
/* following was put in to change order/sales order status when payment is first inserted; this turned out to not be the issue...probably
       //need to update order on first payment
       List<Id> subsList = new List<Id>();
       for (Bill62__Payment__c p : trigger.new){
           subsList.add(p.Bill62__Subscription__c);
       }
       Map<Id, Id> subsmap = new Map<Id, Id>();
       Map<Id, Id> subsMap2 = new Map<id, id>();
       List<Bill62__Subscription__c> subscrList = [select id, order__c, bill62__order__c from Bill62__Subscription__c where id in :subsList];
       for(Bill62__Subscription__c s : subscrList){
           subsMap.put(s.Id, s.order__c);
           subsmap2.put(s.id, s.bill62__order__c);
       }
       system.debug('entering order update section');
       List<Id> salesOrdersIdList = new List<Id>();
       Map<Id, String> salesOrdersIdPayTypeMap = new Map<Id, String>();
        
       List<Id> ordersIdList = new List<Id>();
       Map<Id, String> ordersIdPayTypeMap = new Map<Id, String>();
       for(Bill62__Payment__c p : trigger.new) {
            /*Payment Billing Frequency based on Recurring field value. 
             *If false, one-time payment and Opp Billing Status field should update to 'CC Paid'
             *Else, this is a recurring payment and Opp Billing Status field should not change
            *//*
            System.debug('Recurring? ' + p.recurring__c);
            if(p.recurring__c == FALSE){
                if(p.Bill62__Status__c == 'Paid') {
                    System.debug('A payment has been made to: ' + p.name);
                    system.debug(p.Bill62__Subscription__r.order__c);
                    system.debug(p.Bill62__Subscription__r.bill62__order__c);
                    system.debug(subsMap.get(p.Bill62__Subscription__c));
                    system.debug(subsMap2.get(p.bill62__subscription__c));
                    ordersIdList.add(subsMap2.get(p.Bill62__Subscription__c)); //Some payments Order Lookup field is blank, adding security blanket by getting Order from Subscription Order Lookup field based on Payment's Subscription Lookup field
                    ordersIdPayTypeMap.put(subsMap2.get(p.Bill62__Subscription__c), p.Bill62__Payment_Method_Type__c);
                    salesOrdersIdList.add(p.Bill62__Order__r.Bill62__Opportunity__c);
                    salesOrdersIdPayTypeMap.put(p.Bill62__Order__r.Bill62__Opportunity__c, p.Bill62__Payment_Method_Type__c);
                    system.debug('subscription: ' + p.Bill62__Subscription__c);
                    system.debug('order id list: ' + ordersIdList);
                    system.debug('order id map: ' + ordersidPaytypemap);
                    system.debug('salesorder id list: ' + salesordersidlist);
                    system.debug('salesorder id map: ' + salesordersidpaytypemap);
                }
            }
        }
        
        List<Bill62__Order__c> ordersList = [SELECT Id, Billing_Status__c FROM Bill62__Order__c WHERE Id in :ordersIdList];
        List<Opportunity> salesOrdersList = [SELECT Id, Billing_Status__c FROM Opportunity WHERE Id in : salesOrdersIdList];
        
        for(Bill62__Order__c order : ordersList){
            //order.Billing_Status__c = ((ordersIdPayTypeMap.get(order.Id) == 'Credit Card') ? 'CC Paid' : 'Behalf Paid');
            //Rich switched this logic at Hera's request 12/8/15
            order.Billing_Status__c = ((ordersIdPayTypeMap.get(order.Id) == 'Behalf') ? 'Behalf Paid' : 'CC Paid');

        }
        
        for(Opportunity so : salesOrdersList) {
            //so.Billing_Status__c = ((salesOrdersIdPayTypeMap.get(so.id) == 'Credit Card') ? 'CC Paid' : 'Behalf Paid');
            //Rich switched this logic at Hera's request 12/8/15
            so.Billing_Status__c = ((salesOrdersIdPayTypeMap.get(so.id) == 'Behalf') ? 'Behalf Paid' : 'CC Paid');
        }

        update ordersList;
        update salesOrdersList;
*/    

    //update the round robin handler
    handler.updateIndex();
    } else if (Trigger.isAfter && Trigger.isUpdate){
        
        Set<ID> paymentIDs = Trigger.OldMap.KeySet();
        Map<ID, Bill62__Payment__c> paymentMap = new Map<ID, Bill62__Payment__c>(
            [SELECT ID, Bill62__Subscription__r.Bill62__Order__c, Bill62__Subscription__r.Bill62__Account__c, Bill62__Order__r.Bill62__Opportunity__c, Bill62__Status__c FROM Bill62__Payment__c WHERE ID IN :paymentIDs]);
        
        List<Id> salesOrdersIdList = new List<Id>();
        Map<Id, String> salesOrdersIdPayTypeMap = new Map<Id, String>();
        
        List<Id> ordersIdList = new List<Id>();
        Map<Id, String> ordersIdPayTypeMap = new Map<Id, String>();
        
        //gather all Ids for Sales Orders to change
        for(Bill62__Payment__c p : trigger.new) {
            Bill62__Payment__c oldId = Trigger.oldMap.get(p.Id);
            Bill62__Payment__c oldIdInfo = paymentMap.get(p.Id);
            System.debug('Old Status: ' + oldId.Bill62__Status__c);
            System.debug('New Status: ' + p.Bill62__Status__c);
            /*Payment Billing Frequency based on Recurring field value. 
             *If false, one-time payment and Opp Billing Status field should update to 'CC Paid'
             *Else, this is a recurring payment and Opp Billing Status field should not change
            */
            System.debug('Recurring? ' + p.recurring__c);
            if(p.recurring__c == FALSE){
                if(p.Bill62__Status__c == 'Paid') {
                    //System.debug('A payment has been made to: ' + p.name);
                    if((oldIdInfo.Bill62__Subscription__c != null) && (oldIdinfo.Bill62__Subscription__r.Bill62__Order__c != null)){
                        ordersIdList.add(oldIdInfo.Bill62__Subscription__r.Bill62__Order__c); //Some payments Order Lookup field is blank, adding security blanket by getting Order from Subscription Order Lookup field based on Payment's Subscription Lookup field
                        ordersIdPayTypeMap.put(oldIdInfo.Bill62__Subscription__r.Bill62__Order__c, p.Bill62__Payment_Method_Type__c);
                        salesOrdersIdList.add(oldIdInfo.Bill62__Order__r.Bill62__Opportunity__c);
                        salesOrdersIdPayTypeMap.put(oldIdInfo.Bill62__Order__r.Bill62__Opportunity__c, p.Bill62__Payment_Method_Type__c);
                    } else if (oldIdInfo.Bill62__Order__c != null){
                        ordersIdList.add(oldIdInfo.Bill62__Order__c); //the preferred Order lookup is through subscription, this is a backup if the subscription is blank or subscription->order is blank
                        ordersIdPayTypeMap.put(oldIdInfo.Bill62__Order__c, p.Bill62__Payment_Method_Type__c);
                        salesOrdersIdList.add(oldIdInfo.Bill62__Order__r.Bill62__Opportunity__c);
                        salesOrdersIdPayTypeMap.put(oldIdInfo.Bill62__Order__r.Bill62__Opportunity__c, p.Bill62__Payment_Method_Type__c);
                    }
                }
            }
        }
        
        
        /*
        12-4-15 rich moved the Account updating logic to OrderTrigger and SalesOrderTrigger
        */
        List<Bill62__Order__c> ordersList = [SELECT Id, Billing_Status__c FROM Bill62__Order__c WHERE Id in :ordersIdList];
        List<Opportunity> salesOrdersList = [SELECT Id, Billing_Status__c FROM Opportunity WHERE Id in : salesOrdersIdList];
        
        for(Bill62__Order__c order : ordersList){
            //order.Billing_Status__c = ((ordersIdPayTypeMap.get(order.Id) == 'Credit Card') ? 'CC Paid' : 'Behalf Paid');
            //Rich switched this logic at Hera's request 12/8/15
            order.Billing_Status__c = ((ordersIdPayTypeMap.get(order.Id) == 'Behalf') ? 'Behalf Paid' : 'CC Paid');

        }
        
        for(Opportunity so : salesOrdersList) {
            //so.Billing_Status__c = ((salesOrdersIdPayTypeMap.get(so.id) == 'Credit Card') ? 'CC Paid' : 'Behalf Paid');
            //Rich switched this logic at Hera's request 12/8/15
            so.Billing_Status__c = ((salesOrdersIdPayTypeMap.get(so.id) == 'Behalf') ? 'Behalf Paid' : 'CC Paid');
        }

        update ordersList;
        update salesOrdersList;
        
    } else if (Trigger.isBefore && Trigger.isUpdate){
        
        //check payment status to see if it changed to 'queued retry'
        Set<String> queueRetry = new Set<String>();
        for(Bill62__Payment__c p : trigger.new){
            if(trigger.newMap.get(p.Id).Bill62__Status__c == 'Queued Retry' && trigger.oldMap.get(p.Id).Bill62__Status__c != 'Queued Retry'){
                queueRetry.add(p.Bill62__Customer__c);
            }
        }

        //check to see if there is a new payment method recently added
        Integer threshold = integer.valueof(Org_Defaults__c.getOrgDefaults().Payment_Method_Reset_Threshold__c);
        if(threshold == 0 || threshold == NULL){
            threshold = 3;
        }
        System.debug('threshold: ' + threshold);
        system.debug(org_defaults__c.getOrgdefaults().payment_method_reset_threshold__c);
        system.debug(integer.valueof(org_defaults__c.getOrgDefaults().payment_method_reset_threshold__c));
        List<Bill62__Payment_Method__c> changed = Database.query('SELECT Id, Bill62__Customer__c FROM Bill62__Payment_Method__c WHERE Bill62__Customer__c IN :queueRetry AND CreatedDate = Last_N_Days : ' + threshold);
        
        //if there are results, map customer to new pay method, then change the pay method for that customer
        if(changed.size()>=1){
            Map<String, Id> custMethod = new Map<String, Id>();
            for(Bill62__Payment_Method__C pm : changed){
                custMethod.put(pm.Bill62__Customer__c, pm.Id);
            }
            for(Bill62__Payment__c bp : trigger.new){
                if(trigger.newMap.get(bp.Id).Bill62__Status__c == 'Queued Retry' && trigger.oldMap.get(bp.Id).Bill62__Status__c != 'Queued Retry' && custMethod.containsKey(bp.Bill62__Customer__c)){
                    bp.Bill62__Payment_Method__c = custMethod.get(bp.Bill62__Customer__c);
                }
            }
        }
        
        //if user does not have Change Payment Paid Status permission, check to make sure status is not changing from 'Paid' to anything other than 'Refunded' or 'Partially Refunded'
        X1800Utilities.CustomPermissionsReader c = new X1800Utilities.CustomPermissionsReader();
        Boolean canChange = c.hasPermission('Change_Payment_Paid_Status');
        if(!canChange){
            for(Bill62__Payment__c pay : Trigger.New){
                if(trigger.oldMap.get(pay.Id).Bill62__Status__c == 'Paid' && trigger.newMap.get(pay.Id).Bill62__Status__c != 'Paid' && trigger.newMap.get(pay.Id).Bill62__Status__c != 'Refunded' && trigger.newMap.get(pay.Id).Bill62__Status__c != 'Partially Refunded' && trigger.newMap.get(pay.Id).Bill62__Status__c != 'Voided'){
                    pay.addError('You cannot change the status of Paid Payments.');
                }
            }
        }
        
        Bill62__C62Billing_Config__c bilLSettings = Bill62__C62Billing_Config__c.getOrgDefaults();
        Decimal numOfAttempts = bilLSettings.Bill62__Number_of_Payment_Attempts__c;    
        Set<String> paymentIDs = new Set<string>();
        
        //set automatic payments that have been rejected too many times to 'Collections' instead of 'Cancelled'
        for(Bill62__Payment__c pay: Trigger.New){
            paymentIDs.add(pay.Id);
            //if((Trigger.oldMap.get(pay.Id).Bill62__Status__c == 'Queued' || Trigger.oldMap.get(pay.Id).Bill62__Status__c == 'Queued Retry') && pay.Bill62__Status__c == 'Cancelled' && pay.Bill62__Number_of_Authorization_Attempts__c >= numOfAttempts){
            if((Trigger.oldMap.get(pay.Id).Bill62__Status__c == 'Queued' || Trigger.oldMap.get(pay.Id).Bill62__Status__c == 'Queued Retry') && Trigger.newMap.get(pay.Id).Bill62__Status__c == 'Cancelled' && Trigger.newMap.get(pay.Id).Bill62__Number_of_Authorization_Attempts__c >= numOfAttempts){
            system.debug('payment '+pay.Id+' changed to cancelled from queued, '+pay.Bill62__Number_of_Authorization_Attempts__c+' number of attempts');
                pay.Bill62__Status__c = 'Collections';
            }
        }
        
        //set the Payment Gateway to the only one that will take Discover cards if the card is Discover
        Map<ID,Bill62__payment__c> payMap = new Map<ID,Bill62__Payment__c>([SELECT ID, Bill62__Payment_Method__r.Bill62__Card_Type__c
            FROM Bill62__Payment__c WHERE ID IN :paymentIDs]);
        for(Bill62__Payment__c pay: Trigger.New){
            if(payMap.containsKey(pay.Id)){
                if(payMap.get(pay.Id).Bill62__Payment_Method__r.Bill62__Card_Type__c == 'Discover'){
                    pay.Bill62__Payment_Gateway__c = Org_Defaults__c.getOrgDefaults().Discover_Gateway__c;
                }
            }    
        }
    }

}