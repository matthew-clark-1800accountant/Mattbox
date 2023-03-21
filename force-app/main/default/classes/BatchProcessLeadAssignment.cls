/*Deprecated
@Name            : BatchProcessLeadAssignment 
@Author          : jarbegast@huronconsultinggroup.com
@Date            : 11/06/15
@Description     : batch class to move leads through lead assignment rules on daily basis
@Last Modify     : 11/06/15
*/
global class BatchProcessLeadAssignment implements Database.Batchable<sObject>, Schedulable, Database.Stateful { //
    
    String query = '';
    // global Boolean doDML = true;
    // global String overrideQuery;
    // global String errorMessages;
    // global BatchProcessLeadAssignment(){
    //     errorMessages = '';
    // }
    // global BatchProcessLeadAssignment(Boolean doWeDoDML){
    //     doDML = doWeDoDML;
    // }
    // global BatchProcessLeadAssignment(String newQuery){
    //     overrideQuery = newQuery;
    // }
    
    // //method that gets the query
    global Database.querylocator start(Database.BatchableContext BC){
        
    //     //query for the leads

    //     if(overrideQuery != null){
    //         return Database.getQueryLocator(overrideQuery);
    //     } else {
    //         //get the Mature and Dead queues
    //         List<String> notNeededQueues = new List<String>{'Mature', 'Dead'};
    //         Set<Id> notNeededQueueIds = new Set<Id>();
    //         for(Group g : [select id from group where developername in : notNeededQueues]){
    //             notNeededQueueIds.add(g.Id);
    //         }
    //     }
        
    //     query = 'SELECT Id, OwnerId, CreatedDate, LastTransferDate FROM Lead WHERE LastTransferDate < LAST_N_DAYS:14 AND ownerId not in : notNeededQueueIds AND isConverted = false';
        return Database.getQueryLocator(query);
    }
    
    global void execute(SchedulableContext sc) {
        BatchProcessLeadAssignment u = new BatchProcessLeadAssignment();
        Database.executebatch(u,200);
    }
    
    // //method that processes the batch
    global void execute(Database.BatchableContext BC, List<Lead> leadList) {
    
    //     // get capTeam users
    //     List<User> capTeams = [SELECT Id FROM User WHERE manager.name = 'Gerard Finegan'];
    //     System.debug(capTeams.size());
    //     Set<Id> capIds = (new Map<Id, User>(capTeams)).keyset();
    //     System.debug(capIds.size());

    //     //get queue info
    //     Set<String> queueFullNames = new Set<String>{'X4_Week_Transfer_Q', 'CAP_Queue', 'Mature_Leads'};
    //     List<Group> queueList = [SELECT Id, developerName FROM Group WHERE developerName in : queueFullNames];

    //     //map queue info fullname:id
    //     Map<String, Id> devNameToId = new Map<String, ID>();
    //     for(Group g : queueList){
    //         devNameToId.put(g.developerName, g.ID);
    //     }
    //     system.debug('Queue name and Id map: ' + devNameToId);

    //     //moves based on created date
    //     List<Lead> reassigned = new List<Lead>();
    //     List<Lead> reM = new List<Lead>();
    //     List<Lead> reD = new List<Lead>();
    //     List<Lead> reC = new List<Lead>();
    //     List<Lead> reF = new List<Lead>();
    //     List<Lead> notReassigned = new List<Lead>();
    //     Date todayDate = Date.today();
    //     for(Lead l : leadList){
    //         Integer age = todayDate.daysBetween(l.createddate.date());
    //         age *= -1;
    //         if(age > 90){
    //             l.ownerId = devNameToId.get('Mature_Leads');
    //             reassigned.add(l);
    //             reM.add(l);
    //         } else if(age>60){
    //             l.ownerId = devNameToId.get('X4_Week_Transfer_Q');
    //             reassigned.add(l);
    //             reD.add(l);
    //         } else if(age>44 && !capIds.contains(l.ownerid)){
    //             l.ownerId = devNameToId.get('CAP_Queue');
    //             reassigned.add(l);
    //             reC.add(l);
    //         } else if(age>15){
    //             l.ownerId = devNameToId.get('X4_Week_Transfer_Q');
    //             reassigned.add(l);
    //             reF.add(l);
    //         } else {
    //             notReassigned.add(l);
    //         }
    //     }
    //     System.debug('Mature: ' + reM.size());
    //     System.debug('Dead: ' + reD.size());
    //     System.debug('CAP: ' + reC.size());
    //     System.debug('Four: ' + reF.size());
    //     System.debug('Not Reassigned: ' + notReassigned.size());

    //     if(doDml){
    //         Database.SaveResult[] srList = Database.update(reassigned, false);
    //         Integer recordId = 0;
    //         //go through the list of save results and find errors, adding them to the large string
    //         for(Database.SaveResult sr : srList){
    //             if(!sr.isSuccess()){
    //                 errorMessages += reassigned[recordId].Id + ' failed with error message: ' + sr.getErrors()[0].getMessage() + '<br/>';
    //             }
    //             recordId ++;
    //         }
    //     }

    }
    
    // //method that runs after execute
    global void finish(Database.BatchableContext BC){
    //     if((errorMessages != '') && (errorMessages != null)){
    //         //get all addresses to receive the email
    //         List<String> emails = new List<String>();
    //         for(ReceiveBatchAssignmentEmails__c rbae : ReceiveBatchAssignmentEmails__c.getAll().values()){
    //             emails.add(rbae.email_address__c);
    //         }
    //         //create and send the email
    //         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    //         for(ReceiveBatchAssignmentEmails__c rbae : ReceiveBatchAssignmentEmails__c.getAll().values()){
    //             mail.setToAddresses(emails);
    //             mail.setSubject('Errors in Lead Assignment Batch');
    //             mail.setHtmlBody('The following records were not reassigned due to errors: <br/>' + errorMessages);
    //             Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
    //         }
    //     }
    }

}