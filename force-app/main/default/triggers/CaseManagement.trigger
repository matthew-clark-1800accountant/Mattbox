/*
@ Name          : CaseManagement
@ Author        : customersuccess@cloud62.com
@ Date          : 13 Apr, 2015
@ Description   : Updates payment processing when a service package is associated to a cancellation case and other case-related post change functions.
*/

trigger CaseManagement on Case (after insert, after update, after undelete) {
    
    Database.DMLOptions dlo = new Database.DMLOptions();
    dlo.EmailHeader.triggerUserEmail = false;
        
    map<Id, String> servicePackageAction=new map<Id,String>(); //Map of service packages and a description of the action to take (suspend, terminate, reactivate)
    set<Id> saveAttemptIds=new set<Id>();
    list<Task> theTasks = new list<Task>();
    integer i = 0;
    
    //if(X1800Utilities.semaphoreSet.contains('firstRun'))return;
    //X1800Utilities.semaphoreSet.add('firstRun');
    
    
    list<Case> theCases=[SELECT Id,
                                RecordType.Name,
                                Status,
                                Contact.Name,
                                Account.Sales_Rep__c,
                                Service_Package_Name__c,
                                Service_Package__c,  
                                Service_Package__r.Sales_Rep__c,
                                Service_Package__r.Fulfilling_Accountant__r.Email
                         FROM   Case
                         WHERE  Id IN :trigger.newMap.keyset()];
    
    for(Case c : theCases){
        
        /***********Begin actions for cancellation cases***************************************/       
        if(c.RecordType.Name=='Cancellation'){
            system.debug('yup cancellation case');
            
          
            //Populate service package map with actions to be taken          
            if( c.Service_Package__c!=null){
                
                if(!Trigger.isdelete){
                    system.debug('Case status='+c.status);
                    //Reactivate if status is closed-saved
                    If(c.Status=='Closed-Saved'){
                        
                        servicePackageAction.put(c.Service_Package__c,'Reactivate');   
                    }    
                    //Terminate if refunded or cancelled                
                    else if(c.Status=='Closed-Refund' || c.Status=='Closed-Cancelled'){
                        servicePackageAction.put(c.Service_Package__c,'Terminate');       
                    }
                    //Suspend payment processing
                    else{                    
                        servicePackageAction.put(c.Service_Package__c,'Suspend');      
                    }
                }
            }
            
            //If closed, update save attempt tasks
            If(c.Status=='Closed-Cancelled'||c.Status=='Closed-Refund'||c.Status=='Closed-Saved')saveAttemptIds.add(c.Id);
        }    
        /***********End actions for cancellation cases**************************************/      
    }
    
    //Compare existing service packages list of actions required and add those that need to be updated  
    if(!servicePackageAction.isEmpty()){
        
        //Get list of service packages affectected by cases in trigger.new        
        list<Bill62__Subscription__c> servicePackageUnchanged=[SELECT  Id,
                                                                       Bill62__Termination_Date__c,
                                                                       Bill62__Suspended__c
                                                               FROM    Bill62__Subscription__c
                                                               WHERE   Id IN :servicePackageAction.keySet()];
        
        list <Bill62__Subscription__c> servicePackageUpdate=new list<Bill62__Subscription__c>();
        
        //Iterate through list and add changes to update list if applicable
        for(Bill62__Subscription__c s : servicePackageUnchanged){
            if(servicePackageAction.get(s.Id)=='Reactivate' && s.Bill62__Suspended__c==True){    
                servicePackageUpdate.add(new Bill62__Subscription__c(Id=s.Id,Bill62__Suspended__c=False));    
            }else if(servicePackageAction.get(s.Id)=='Terminate' && s.Bill62__Termination_Date__c==Null){    
                servicePackageUpdate.add(new Bill62__Subscription__c(Id=s.Id,Bill62__Termination_Date__c=date.today()));    
            }else if(servicePackageAction.get(s.Id)=='Suspend' && s.Bill62__Suspended__c==False){    
                servicePackageUpdate.add(new Bill62__Subscription__c(Id=s.Id,Bill62__Suspended__c=True));  
            } 
        }
        
        //Update service packages
        if(servicePackageUpdate.size()>0){ 
            update servicePackageUpdate;   
        }
    }
    
    //Update save attempt tasks
    If(saveAttemptIds.size()>0){
        
        list<Task> saveAttemptTasks = [SELECT Id,
                                              Status,
                                              Description
                                       FROM   Task
                                       WHERE  Type='Save Attempt' AND WhatId IN :saveAttemptIds];
        
        if(saveAttemptTasks.size()>0){
            for(task t : saveAttemptTasks){
                t.Status=        'Discard';
                t.Description=   t.Description+' Case closed, task discarded.';
            }
            
            update saveAttemptTasks;
                   
        }
    }
}