//DEPRECATED 12-21
trigger SubscriptionTrigger on Bill62__Subscription__c (before insert, before update, after insert) {
    
    // if (Trigger.isBefore && Trigger.isInsert){
    //     Set<Id> contactSet = new Set<Id>();
    //     Set<Id> productSet = new Set<Id>();
    //     for (Bill62__Subscription__c s : Trigger.new){
    //         system.debug('subscriptionTrigger1, Subscription: '+s);
    //         contactSet.add(s.Bill62__Customer__c);
    //         productSet.add(s.Bill62__Product__c);
    //     }
        
    //     Map<Id, Contact> conMap = new Map<Id, Contact>([SELECT ID, ACCOUNTID, OwnerId
    //         FROM CONTACT WHERE ID IN: contactSet]);
            
    //     Map<Id, Product2> prodMap = new Map<Id, Product2>([SELECT ID, Billing_Frequency__c, Name
    //         FROM Product2 WHERE ID IN: productSet]);
        
    //     for (Bill62__Subscription__c s : Trigger.new){
    //         if(conMap.containsKey(s.Bill62__Customer__c)) s.Bill62__Account__c = conMap.get(s.Bill62__Customer__c).AccountId;
    //         if (s.Bill62__Product__c != null) s.Bill62__Billing_Frequency__c = prodMap.get(s.Bill62__Product__c).Billing_Frequency__c;
    //         if (s.Bill62__Billing_Frequency__c == null) s.Bill62__Billing_Frequency__c = 'Annual';
    //     }
    // } else if (Trigger.isAfter && Trigger.isInsert){
    //     Set<Id> accountId = new Set<Id>();
    //     Set<Id> contactSet = new Set<Id>();
    //     Set<Id> productSet = new Set<Id>();
    //     Map<Id, Set<Id>> accountProdMap = new Map<Id, Set<Id>>();
    //     for (Bill62__Subscription__c s : Trigger.new){
    //         if (s.Bill62__Account__c != null){
    //             accountID.add(s.Bill62__Account__c);
    //             if (!accountProdMap.containsKey(s.Bill62__Account__c)){
    //                 accountProdMap.put(s.Bill62__Account__c, new Set<Id>());
    //             }
    //             accountProdMap.get(s.Bill62__Account__c).add(s.Bill62__Product__c);
    //         }
    //         contactSet.add(s.Bill62__Customer__c);
    //         productSet.add(s.Bill62__Product__c);
            
    //     }
    //     Map<Id, Contact> conMap = new Map<Id, Contact>([SELECT ID, ACCOUNTID, OwnerId
    //         FROM CONTACT WHERE ID IN: contactSet]);
        
    //     Map<Id, Product2> prodMap = new Map<Id, Product2>([SELECT ID, Billing_Frequency__c, Name,
    //         Product_Class__c, Remove_First_Month_Charge__c, Is_Split_Payment__c, Task_List__c
    //         FROM Product2 WHERE ID IN: productSet]);
        
    //     Map<Id, Account> updateAccount = new Map<Id, Account>([SELECT ID, ACCOUNT_STATUS__C
    //         FROM ACCOUNT
    //         WHERE ID IN: accountID]);
        
    //     for (String accID : accountProdMap.keyset()){
    //         Account thisAcc = updateAccount.get(accID);
    //         Boolean isVTOBusiness = false;
    //         Boolean isVTOPersonal = false;
    //         for (String prodID: accountProdMap.get(accID)){
    //             Product2 thisProd = prodMap.get(prodID);
    //             if (thisProd != null){
    //                 if (thisProd.Product_Class__c != null){
    //                     if (thisProd.Product_Class__c.contains('VTO Business')) isVTOBusiness = true;
    //                     if (thisProd.Product_Class__c.contains('VTO Personal')) isVTOPersonal = true;
    //                     if (thisProd.Product_Class__c.contains('VTO All')){
    //                         isVTOBusiness = true;
    //                         isVTOPersonal = true;
    //                     }
    //                 }
    //             }
    //         }
            
    //         //2015-01-19 Warren - comment this out as this will be handled by CCs being charged instead
    //         //thisAcc.Account_Status__c = 'Active';
    //     }
        
    //     update updateAccount.values();
        
    //     //look at products to insert tasks
    //     List<Task> insertTask = new List<Task>();
        
    //     for (Bill62__Subscription__c s : Trigger.new){
    //         system.debug('subscriptionTrigger2, Subscription: '+s);
    //         Product2 thisProd = prodMap.get(s.Bill62__Product__c);
    //         if (thisProd != null){
    //             if (thisProd.Task_List__c != null){
    //                 List<String> taskList = thisProd.Task_List__c.split(';');
    //                 for (String x : taskList){
    //                     Task c = new Task();
    //                     c.Type = 'Fulfillment';
    //                     c.Subject = x;
    //                     c.OwnerId = conMap.get(s.Bill62__Customer__c).OwnerId;
    //                     c.WhoId = s.Bill62__Customer__c;
    //                     c.Service_Package__c=s.Id;
    //                     insertTask.add(c);
    //                     system.debug('creating a task!');
    //                 }
    //             }
    //         }
    //     }
    //     /* //old logic
    //     List<Task> existingTasks = [SELECT ID, SUBJECT, WHOID
    //         FROM Task
    //         WHERE ISCLOSED = FALSE
    //         AND TYPE = 'Onboarding'
    //         AND WHOID IN: contactSet];
    //     Set<Id> contactsWithTasks = new Set<Id>();
    //     for (Task c : existingTasks){
    //         if (c.WhoId != null) contactsWithTasks.add(c.WhoId);
    //     }
    //     for (String x : contactSet){
    //         if (!contactsWithTasks.contains(x)){
    //             Task c = new Task();
    //             c.Type = 'Onboarding';
    //             c.Subject = 'Onboarding';
    //             c.OwnerId = conMap.get(x).OwnerId;
    //             c.WhoId = x;
    //             insertTask.add(c);
    //         }
    //     } */
        
    //     insert insertTask;
        
    //     //if we need to remove the first month call future method
    //     Set<Id> subsToDelFirstMonthOrSplitPayment = new Set<Id>();
    //     for (Bill62__Subscription__c s : Trigger.new){
    //         if (s.Bill62__Product__c != null){
    //             if (prodMap.containsKey(s.Bill62__Product__c)){
    //                 Product2 thisProd = prodMap.get(s.Bill62__Product__c);
    //                 if (thisProd.Remove_First_Month_Charge__c){
    //                     subsToDelFirstMonthOrSplitPayment.add(s.Id);
    //                 }
    //             }
    //         }
    //         system.debug('subscriptionTrigger3, Subscription: '+s);
    //     }
        
    //     if (subsToDelFirstMonthOrSplitPayment.size() > 0){
    //         system.debug(subsToDelFirstMonthOrSplitPayment);
    //         //the C62BatchRenewal creates subscriptions, firing this trigger,
    //         //causing an error; to keep future method, check for time
    //         DateTime dt = DateTime.now();
    //         Time tStart = time.newInstance(1, 55, 0, 0);
    //         Time tEnd = time.newInstance(2, 10, 0, 0);
    //         system.debug(dt.time());
    //         system.debug(tStart);
    //         system.debug(tEnd);
    //         system.debug(dt.time()>=tStart);
    //         system.debug(dt.time()<=tEnd);
    //         if(!(dt.time()>=tStart && dt.time()<=tEnd)){
    //             system.debug('entering the future method');
    //             //the time is outside of the schedule batch
    //             X1800Utilities.removeFirstMonthPackageChargeAndSplitPayment(subsToDelFirstMonthOrSplitPayment);
    //         } else {
    //             system.debug('avoiding the future method');
    //             //the time is within batch job run time; future method logic must be done here
    //             List<Bill62__Subscription__c> subList = [SELECT ID, NAME, Bill62__Start_Date__c,
    //                 Bill62__Order__c,
    //                 Bill62__Product__r.Remove_First_Month_Charge__c,
    //                 Bill62__Product__r.Remove_First_Month_Charge_Amount__c,
    //                 Bill62__Product__r.Is_Split_Payment__c,
    //                 Bill62__Product__r.Split_Payment_Amount__c,
    //                     (SELECT ID, Bill62__Amount__c,
    //                      Bill62__Billing_Frequency__c,Bill62__Category__c,Bill62__Cycle_End_Date__c,
    //                      Bill62__Cycle_Start_Date__c,Bill62__Full_Cycle_Amount__c,
    //                      Bill62__Full_Cycle_End_Date__c,Bill62__Full_Cycle_Start_Date__c,Bill62__Monthly_Amount__c,
    //                      Bill62__Payment_Received__c,Bill62__Schedule_Payment_Date__c,Bill62__Split_Monthly_Revenue__c,
    //                      Bill62__Subscription__c,Bill62__Type__c,Name,Bill62__Payment__c,Bill62__Days_In_Cycle__c
    //                      FROM BILL62__Subscription_Lines__R)
    //                 from Bill62__Subscription__c
    //                 WHERE ID IN: subsToDelFirstMonthOrSplitPayment
    //                 and (Bill62__Product__r.Remove_First_Month_Charge__c = TRUE)];
                    
    //             system.debug('subList in X1800 b4: '+subList);
    //             List<Bill62__Subscription_Line__c> delList = new List<Bill62__Subscription_Line__c>();

    //             for (Bill62__Subscription__c s : subList){
    //                 if (s.Bill62__Product__r.Remove_First_Month_Charge_Amount__c != null){
    //                     for (Bill62__Subscription_Line__c sl : s.BILL62__Subscription_Lines__R){
    //                         system.debug(s.Bill62__Start_Date__c == sl.Bill62__Cycle_Start_Date__c);
    //                         system.debug(sl);
    //                         system.debug(sl.Bill62__Billing_Frequency__c == 'Recurring');
    //                         system.debug(sl.Bill62__Days_In_Cycle__c < 190);
    //                         if (s.Bill62__Start_Date__c == sl.Bill62__Cycle_Start_Date__c 
    //                             && sl.Bill62__Billing_Frequency__c == 'Recurring'
    //                             && sl.Bill62__Days_In_Cycle__c < 190){
    //                             delList.add(sl);
    //                             system.debug(sl);
    //                             break;
    //                         }
    //                     }
    //                 }
    //             }

    //             List<ID> paymentIDs = new List<ID>();
    //             for(Bill62__Subscription_Line__c sl : delList){
    //                 paymentIDs.add(sl.Bill62__Payment__c);
    //             }

    //             delete delList;       
    //             system.debug('subList in X1800 after: '+subList);

    //             List<Bill62__Payment__c> payments = [SELECT ID,Bill62__Amount__c FROM Bill62__Payment__c WHERE ID IN :paymentIDs];
    //             Map <ID, List<Bill62__Subscription_Line__c>> payToSublines = new Map <ID, List<Bill62__Subscription_Line__c>>();
    //             List<Bill62__Subscription_Line__c> sls = [SELECT ID,Bill62__Payment__c
    //                 FROM Bill62__Subscription_Line__c WHERE Bill62__Payment__c IN :payments];

    //             for(Bill62__Subscription_Line__c sl: sls){
    //                 if(payToSublines.containsKey(sl.Bill62__Payment__c)){
    //                     List<Bill62__Subscription_Line__c> temp = payToSublines.get(sl.Bill62__Payment__c);
    //                     temp.add(sl);
    //                     payToSublines.put(sl.Bill62__Payment__c,temp);
    //                 }else{
    //                     List<Bill62__Subscription_Line__c> temp = new List<Bill62__Subscription_Line__c>();
    //                     temp.add(sl);
    //                     payToSublines.put(sl.Bill62__Payment__c,temp);
    //                 }
    //             }

    //             for(Bill62__Payment__c pay: payments){
    //                 List<Bill62__Subscription_Line__c> subLines = payToSublines.get(pay.ID);
    //                 Double total = 0;
    //                 for(Bill62__Subscription_Line__c sl: subLines){
    //                     total = total + sl.Bill62__Amount__c;
    //                 }
    //                 pay.Bill62__Amount__c = total;
    //             }

    //             update payments;
    //         }
            
    //     }
    // }
}