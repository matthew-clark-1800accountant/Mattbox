public without sharing class TaskTriggerHandler {

    public static void afterInsert(List<Task> taskList){
        System.debug('TaskTriggerHandler.afterInsert()');

        //List<Task> outboundCalls = new List<Task>();
        System.debug(taskList);
        List<Id> whoIdList = new List<Id>();
        for(Task curTask : taskList){
            if(curTask.CallType == 'Outbound' && curTask.CallDurationInSeconds != null && curTask.WhoId != null){
                //outboundCalls.add(curTask);
                whoIdList.add(curTask.WhoId);
            }
        }
        for(Id curWhoId : whoIdList){
            rollupCalls(curWhoId);
        }
        // if(!outboundCalls.isEmpty()){
        //     rollupCalls(outboundCalls);
        // }
    }

    @future
    public static void rollupCalls(Id curWhoId){  
        System.debug('TaskTriggerHandler.rollupCalls ' + curWhoId);   
            //task.NVMContactWorld__CW_Call_Start_Time__c >= who.Distribute_Date__c && task.NVMContactWorld__CW_Call_Start_Time__c <= who.Pitched_Date__c
            Integer preTSACalls = 0;
            //task.NVMContactWorld__CW_Call_Start_Time__c >= who.Account.Pitched_Date__c && task.NVMContactWorld__CW_Call_Start_Time__c <= who.Account.ChargeOver_Initial_Payment_Date__c
            Integer postTSACalls = 0;

            Date distributeDate;
            Datetime pitchedDate;
            Datetime callDate;
            Datetime initialPaymentDate;

            //check the type of the WhoId and query the relevant record


            //for each new task, query all other related calls 
            //note that this includes the current task
            List<Task> relatedTasks = [SELECT Id, NVMContactWorld__CW_Call_Start_Time__c
            FROM Task WHERE CallType = 'Outbound' AND CallDurationInSeconds != null AND WhoId = :curWhoId];

            //whoid can be lead or contact
            List<Lead> relatedLeads = [SELECT Id, Distribute_Date__c, Pitched_Date__c FROM Lead WHERE IsConverted = false AND ID = :curWhoId];
            List<Contact> relatedContacts = [SELECT Id, Account.Id, Account.ChargeOver_Initial_Payment_Date__c, Distribute_Date__c, Consulted_Date__c FROM Contact WHERE ID = :curWhoId];
            if(!relatedLeads.isEmpty()){
                System.debug('relatedLeads: '+relatedLeads);
                Lead relatedLead = relatedLeads.get(0);
                distributeDate = relatedLead.Distribute_Date__c;
                pitchedDate = relatedLead.Pitched_Date__c;
                for(Task relatedTask : relatedTasks){
                    callDate = relatedTask.NVMContactWorld__CW_Call_Start_Time__c;
                    if((callDate==null || callDate >= distributeDate) && (pitchedDate == null || callDate <= pitchedDate)){
                        preTSACalls += 1;
                    }
                    //no postTSACalls if whoid is a lead
                }
                relatedLead.of_Pre_TSA_Calls__c = preTSACalls;
                update relatedLead;
            } else {
                System.debug('relatedContacts'+relatedContacts);
                Contact relatedContact = relatedContacts.get(0);
                distributeDate = relatedContact.Distribute_Date__c;
                pitchedDate = relatedContact.Consulted_Date__c;
                initialPaymentDate = relatedContact.Account.ChargeOver_Initial_Payment_Date__c;
                for(Task relatedTask : relatedTasks){
                    callDate = relatedTask.NVMContactWorld__CW_Call_Start_Time__c;
                    if(callDate >= distributeDate && (pitchedDate == null || callDate <= pitchedDate.addMinutes(-1))){
                        preTSACalls += 1;
                    } else if ((pitchedDate != null && callDate >= pitchedDate.addMinutes(60)) && (initialPaymentDate == null || callDate <= initialPaymentDate)){
                        postTSACalls += 1;
                    }
                }
                relatedContact.of_Pre_TSA_Calls__c = preTSACalls;
                relatedContact.of_TSA_Follow_Up_Calls__c = postTSACalls;
                update relatedContact;

                Account relatedAccount = new Account(Id = relatedContact.Account.Id);
                relatedAccount.of_Pre_TSA_Calls__c = preTSACalls;
                relatedAccount.of_TSA_Follow_Up_Calls__c = postTSACalls;
                update relatedAccount;
                
                
            }
    }
}