/*Deprecated

@Name            : BatchProcessAccountAssignment 
@Author          : jarbegast@huronconsultinggroup.com
@Date            : 11/10/15
@Description     : batch class to move accounts through account assignment rules on daily basis
@Last Modify     : 11/10/15
*/
global class BatchProcessAccountAssignment implements Database.Batchable<sObject>, Schedulable, Database.stateful {
    
    String query = '';
    // global String overrideQuery;
    // global String errorMessages;
    // global Boolean doDML = true;
    // global BatchProcessAccountAssignment(){
    //     errorMessages = '';
    // }
    // global BatchProcessAccountAssignment(Boolean doWeDoDML){
    //     doDML = doWeDoDML;
    // }
    // global BatchProcessAccountAssignment(String newQuery){
    //     overrideQuery = newQuery;
    // }
    // global BatchProcessAccountAssignment(Boolean doWeDoDML, String newQuery){
    //     doDML = doWeDoDML;
    //     overrideQuery = newQuery;
    // }
    
    // //method that gets the query
    global Database.querylocator start(Database.BatchableContext BC){
        
    //     //query for the accounts desired

    //     if(overrideQuery != null){
    //         system.debug('Query: ' + overrideQuery);
    //         return Database.getQueryLocator(overrideQuery);
    //     } else {
    //         //only certain statuses are needed
    //         List<String> accountStatuses = new List<String>{
    //             'BTP','Business LP','No Sale'
    //         };
    
    //         //get the Mature and Dead user / users
    //         List<String> aliasesToIgnore = new List<String>{'Mature', 'Dead'};
    //         List<User> matureUsers = [select Id from User where alias IN : aliasesToIgnore];
    //         Set<Id> matureUserIds = new Set<Id>();
    //         for(User u : matureUsers){
    //             matureUserIds.add(u.Id);
    //         }
    
    //         //collect the profiles that we care about
    //         Set<Id> profileIds = new Set<Id>();
    //         for(Profile p : [select Id from Profile where Name = 'CAP User' or name = 'InsideSalesUser']){
    //             profileIds.add(p.Id);
    //         }
    
    //         query = 'SELECT Id, OwnerId, Owner.alias, CreatedDate, Last_Transfer_Date__c FROM Account WHERE Last_Transfer_Date__c   < LAST_N_DAYS:14 AND Account_Status__c in :accountStatuses '
    //             +' AND Active_Products__c = \'None\' AND Canceled_Suspended_Products__c = \'None\' AND ownerId not in :matureUserIds AND Owner.ProfileId in :profileIds';
    //     }
        
    //     system.debug(query);
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(SchedulableContext sc) {
        BatchProcessAccountAssignment u = new BatchProcessAccountAssignment();
        Database.executebatch(u,200);
    }
    
    // //method that processes the batch
    global void execute(Database.BatchableContext BC, List<Account> accountList) {
    
    //     System.debug('entering execution');
    //     System.debug('accountList: ' + accountList.size());

    //     //get User Info for CAP Teams and makeshift Queues
    //     Set<String> aliasList = new Set<String>{'4week', 'CAP', 'Dead', 'Mature'};
    //     List<User> capTeams = [SELECT Id, alias FROM User WHERE manager.name = 'Gerard Finegan' OR alias IN :aliasList];
    //     Set<Id> capIds = (new Map<Id, User>(capTeams)).keySet();
    //     System.debug('capIds: ' + capIds);
        
    //     Map<String, Id> aliasToId = new Map<String, Id>();
    //     for(User u : capTeams){
    //         if(aliasList.contains(u.alias)){
    //             aliasToId.put(u.alias, u.Id);
    //         }
    //     }
    //     System.debug('aliasToIdMap: ' + aliasToId);
        
    //     //moves based on created date
    //     Date todayDate = Date.today();
    //     List<Account> reassigned = new List<Account>();
    //     List<Account> reM = new List<Account>();
    //     List<Account> reD = new List<Account>();
    //     List<Account> reC = new List<Account>();
    //     List<Account> reF = new List<Account>();
    //     List<Account> notReassigned = new List<Account>();
    //     for(Account a : accountList){
    //         Integer age = todayDate.daysBetween(a.createddate.date());
    //         age *= -1;
    //         if(age > 90){
    //             a.ownerId = aliasToId.get('Mature');
    //             reassigned.add(a);
    //             reM.add(a);
    //         } else if(age>60){
    //             a.ownerId = aliasToId.get('4week');
    //             reassigned.add(a);
    //             reD.add(a);
    //         } else if(age>44 && !capIds.contains(a.ownerId)){
    //             a.ownerId = aliasToId.get('CAP');
    //             reassigned.add(a);
    //             reC.add(a);
    //         } else if(age>15){
    //             a.ownerId = aliasToId.get('4week');
    //             reassigned.add(a);
    //             reF.add(a);
    //         } else {
    //             system.debug(age);
    //             notReassigned.add(a);
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
    //             mail.setSubject('Errors in Account Assignment Batch');
    //             mail.setHtmlBody('The following records were not reassigned due to errors: <br/>' + errorMessages);
    //             Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
    //         }
    //     }
    }

}