public with sharing class RollupCallsBatchable implements Database.Batchable<sObject>{
    public final String Query;
    public final String Type;
    public final Date Boundary;
 
    public RollupCallsBatchable(Date boundary, String type){
        System.debug('constructor');
        System.debug(boundary);
        System.debug(type);
        this.Boundary = boundary;
        this.Type = type;
        if(type == 'Lead'){
        this.Query = 'SELECT Id, Distribute_Date__c, Pitched_Date__c FROM Lead WHERE IsConverted = false AND Distribute_Date__c >= :bound';
        } else if(type == 'Contact'){
        this.Query = 'SELECT Id, Account.Id, Account.ChargeOver_Initial_Payment_Date__c, Distribute_Date__c, Consulted_Date__c FROM Contact WHERE Distribute_Date__c >= :bound';
        }              
    }
 
    public Database.QueryLocator start(Database.BatchableContext BC){
        System.debug('start');
        Date bound = this.Boundary;
        System.debug(bound);
       return Database.getQueryLocator(this.Query);
    }
 
    public void execute(Database.BatchableContext BC, List<sObject> scope){       
        System.debug('type: '+this.Type);
        if(this.Type == 'Lead'){
            for(Sobject s : scope){
                rollupLeadCalls((Lead) s);
            }
        } else if(this.Type == 'Contact') {
            for(Sobject s : scope){
                rollupContactCalls((Contact) s);
            }
        }
         
    }
 
    public void finish(Database.BatchableContext BC){
 
    }

    public void rollupLeadCalls(Lead relatedLead){  
        System.debug('Lead: '+relatedLead.Id);
        //System.debug('rollupCalls ' + curWhoId);   
            //task.NVMContactWorld__CW_Call_Start_Time__c >= who.Distribute_Date__c && task.NVMContactWorld__CW_Call_Start_Time__c <= who.Pitched_Date__c
            Integer preTSACalls = 0;
            
            Date distributeDate;
            Datetime pitchedDate;
            Datetime callDate;
            //Date initialPaymentDate;

            //check the type of the WhoId and query the relevant record

            //List<Lead> relatedLeads = [SELECT Id, Distribute_Date__c, Pitched_Date__c FROM Lead WHERE ID = :curWhoId];
            
            //for each new task, query all other related calls 
            //note that this includes the current task
            List<Task> relatedTasks = [SELECT Id, NVMContactWorld__CW_Call_Start_Time__c
            FROM Task WHERE CallType = 'Outbound' AND CallDurationInSeconds != null AND WhoId = :relatedLead.Id];
            System.debug(relatedTasks.size()+' relatedTasks');
            
                //System.debug('relatedLeads: '+relatedLeads);
                //Lead relatedLead = relatedLeads.get(0);
            distributeDate = relatedLead.Distribute_Date__c;
            pitchedDate = relatedLead.Pitched_Date__c;
            for(Task relatedTask : relatedTasks){
                callDate = relatedTask.NVMContactWorld__CW_Call_Start_Time__c;
                System.debug(callDate);
                System.debug(distributeDate);
                System.debug(pitchedDate);
                if((callDate==null || callDate >= distributeDate) && (pitchedDate == null || callDate <= pitchedDate.addMinutes(-1))){
                    preTSACalls += 1;
                }
                //no postTSACalls if whoid is a lead
            }
            relatedLead.of_Pre_TSA_Calls__c = preTSACalls;
            update relatedLead;
            
    }

    public static void rollupContactCalls(Contact relatedContact){  
        //System.debug('rollupCalls ' + curWhoId);   
        System.debug('Contact: '+relatedContact.Id);
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
            FROM Task WHERE CallType = 'Outbound' AND CallDurationInSeconds != null AND WhoId = :relatedContact.Id];

            System.debug(relatedTasks.size()+' relatedTasks');
           // List<Contact> relatedContacts = [SELECT Id, Account.Id, Account.ChargeOver_Initial_Payment_Date__c, Distribute_Date__c, Consulted_Date__c FROM Contact WHERE ID = :curWhoId];
            //if(!relatedContacts.isEmpty()) {
                //System.debug('relatedContacts'+relatedContacts);
                //Contact relatedContact = relatedContacts.get(0);
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
                //update relatedContact;

                Account relatedAccount = new Account(Id = relatedContact.Account.Id);
                relatedAccount.of_Pre_TSA_Calls__c = preTSACalls;
                relatedAccount.of_TSA_Follow_Up_Calls__c = postTSACalls;
                //update relatedAccount;
                update new List<SObject>{relatedContact, relatedAccount};
            //}
    }
 
 }