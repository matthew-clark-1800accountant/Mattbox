/*
DEPRECATED 12-21
@ Name          : SubscriptionExtras
@ Author        : customersuccess@cloud62.com
@ Date          : 21 Apr, 2015
@ Description   : Updates related fulfillment tasks.
*/

trigger SubscriptionExtras on Bill62__Subscription__c (after insert, after update) {
    
    // set<Id> subscriptionIds = new set<Id>();
    // set<Id> customerIds = new set<Id>();    
    // set<Id> orderIds = new set<Id>();
    // set<Id> opptyIds = new set<Id>();
    // set<Id> tasksToSuspend = new set<Id>();
    // set<Id> tasksToDiscard = new set<Id>();
    // set<Id> tasksToReactivate = new set<Id>();    
    // map<Id,Id> fulfillingAccountantMap = new map<Id,Id>();    
    // map<Id,Id> salesRepMap = new map<Id,Id>();
    // list<Bill62__Subscription__c> theSubscriptions = new list<Bill62__Subscription__c>();
    
    // system.debug('subscriptionExtras');
    // //if(X1800Utilities.semaphoreSet.contains('firstRun'))return;
    //     //X1800Utilities.semaphoreSet.add('firstRun');
    
    // //Determine tasks statuses
    // for(Bill62__Subscription__c s : trigger.new ){      
    //     system.debug('looking at a sub.  suspended: '+s.Bill62__Suspended__c); 
    //     customerIds.add(s.Bill62__Customer__c);     
    //     orderIds.add(s.Bill62__Order__c);
    //     subscriptionIds.add(s.Id);
        
    //     if(s.Bill62__Termination_Date__c!=null){
    //         tasksToDiscard.add(s.Id);
    //         system.debug('discard');
    //     }else if(s.Bill62__Suspended__c==true){
    //         tasksToSuspend.add(s.Id);
    //         system.debug('suspend');
    //     }else if(!trigger.isinsert){
    //         if(trigger.oldmap.get(s.Id).Bill62__Suspended__c==true && s.Bill62__Suspended__c==false){
    //             tasksToReactivate.add(s.Id);
    //             system.debug('reactivate');
    //         }
    //     }
        
    // }
    
    // //Gather fulfilling acountants
    // if(customerIds.size()>0){      
    //     list<Contact> customers = [SELECT  Id, Account.OwnerId FROM Contact WHERE Id IN :customerIds];
        
    //     for(contact c : customers){
    //         fulfillingAccountantMap.put(c.Id,c.Account.OwnerId);
    //     }
        
    // }
    
    // //Gather sales rep Ids
    // if(orderIds.size()>0){
        
    //     list<Bill62__Order__c> orders = [SELECT  Id, Bill62__Opportunity__r.OwnerId FROM    Bill62__Order__c WHERE   Id IN :orderIds];
        
    //     for(Bill62__Order__c o : orders){
    //         salesRepMap.put(o.Id,o.Bill62__Opportunity__r.OwnerId);
    //     }
        
    // }
    
    // //Assign sales reps and fulfilling accountants
    // for(Bill62__Subscription__c s2 : trigger.new){
    //     Id fulfillingAccountant;
    //     Id salesRep;
    //     system.debug('subscriptionExtras2, Subscription: '+s2);
    //     if(s2.Fulfilling_Accountant__c==null && fulfillingAccountantMap!=null){
    //         fulfillingAccountant=fulfillingAccountantMap.get(s2.Bill62__Customer__c);
    //     }
        
    //     system.debug('Sales rep Id: '+salesRepMap.get(s2.Bill62__Order__c));
        
    //     if(s2.Sales_Rep__c==null && salesRepMap!=null){
    //         salesRep=salesRepMap.get(s2.Bill62__Order__c);
    //     }

    //     if(salesRep != null || fulfillingAccountant != null)theSubscriptions.add(new Bill62__Subscription__c(Id=s2.Id,Sales_Rep__c=salesRep,Fulfilling_Accountant__c=fulfillingAccountant));     
        
    // }
    
    // //Update related tasks       
    // list<Task> tasksToUpdate = new list<Task>();
    
    // for(Task t : [SELECT Id, Status, Description, Service_Package__c FROM Task WHERE Service_Package__c IN :subscriptionIds]){
    //    system.debug('Iterating through tasks'+t.Id);
    //    if(tasksToDiscard.contains(t.Service_Package__c) && t.Status!='Discard'){
    //         if(t.Description==null){t.Description='This task was terminated on'+System.today()+'. Previous status: ' + t.Status;}
    //         else{t.Description=t.Description+'\r\n This task was terminated on'+System.today()+'. Previous status: ' + t.Status;}
    //         t.Status='Discard';
    //         tasksToUpdate.add(t);
    //         system.debug('task to discard: '+t.id);
    //     }
    //     if(tasksToSuspend.contains(t.Service_Package__c) && t.Status!='Suspended'){
    //         if(t.Description==null){t.Description='This task was suspended on '+System.today()+'. Previous status: ' + t.Status;}
    //         else{t.Description=t.Description+'\r\n This task was suspended on '+System.today()+'. Previous status: ' + t.Status;}
    //         t.Status='Suspended';
    //         tasksToUpdate.add(t);
    //         system.debug('task to suspend: '+t.id);
    //     }
    //     if(tasksToReactivate.contains(t.Service_Package__c) && t.Status=='Suspended'){
    //         if(t.Description==null){t.Description='This task was reactivated on '+System.today()+'. Previous status: ' + t.Status;}
    //         else{t.Description=t.Description+'\r\n This task was reactivated on '+System.today()+'. Previous status: ' + t.Status;}
    //         t.Status='Reactivated';
    //         tasksToUpdate.add(t);
    //         system.debug('task to reactivate: '+t.id);            
    //     }
        
    // }
    
    // system.debug('tasks to update: '+tasksToUpdate.size());
    // if(tasksToUpdate.size()>0){
    //     update tasksToUpdate;
    // }
    
    // update theSubscriptions;
    
}