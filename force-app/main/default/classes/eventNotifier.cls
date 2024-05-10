public class eventNotifier implements Database.Batchable<sObject>, Database.Stateful { //I don't think state is being used -mc
    // custom data structure
    public class taskWrapper{
        public String managerId {get;set;}
        public String taskAgent {get;set;}
        public String whoId {get;set;}
        public String eventId {get;set;}
        public String agentEmail {get;set;}
        public String managerEmail {get;set;}
        public String agentName {get;set;}
        public String eventLink {get;set;}
        public String leadName {get;set;}
    }
    
    // list to hold custom data structure
    public List<taskWrapper> masterList {get;set;}
    @TestVisible private static Integer emailNumber = 1;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id,StartDateTime,OwnerId,whoId FROM event where StartDateTime >= today AND StartDateTime <= tomorrow ' +
            'AND (type_of_appointment__c LIKE \'Tax Savings Analysis\' OR type_of_appointment__c LIKE \'BNA\' OR type_of_appointment__c LIKE \'Formation Consultation\') '+
            'AND Appointment_Disposition__c != \'Rescheduled\' AND Appointment_Disposition__c != \'Cancelled\' AND (NOT Subject LIKE \'%Live%\')' 
        );
    }
    // process each batch of records    
    public void execute(Database.BatchableContext bc, List<event> events){
        // initiate list within the method for local use
        masterList = new List<taskWrapper>();
        
        //2- filter events by finding events with 7 minutes after starTime
        long todaysDate = DateTime.now().getTime(); //GMT
        long eventDueDate;
        long timeDifference;
        long timeDifferenceMinutes;
        
        // this is our master event list
        event [] events10 = new List<event>();
        
        // loop through initial events to check to see if the timing matches the criteria
        for(event ev: events){
            // calculations based upon time difference
            //this can be done with datetime methods instead of long arithmetic --mc
            eventDueDate = ev.StartDateTime.getTime();
            timeDifference =  todaysDate - eventDueDate;
            timeDifferenceMinutes = ( (timeDifference/1000) /60);
            system.debug(timeDifferenceMinutes);
             
            // does the timing meet our criteria? note for Drew, the lower threshold of 6 and 10 can be adjusted to expand the timing (previously 6 and 9, I just adjusted to 6 and 10)
            if( (timeDifferenceMinutes >= 6) && (timeDifferenceMinutes <= 10) ){
                //get events with 7 minutes passed
                events10.add(ev);
                system.debug('Difference in minutes between events due date and current time: '+timeDifferenceMinutes); 
            }
        }
        //3- get the whoids from the events with 7 minutes passed after the startTime
        list<string> whoids =  new list<string>();
        for(event ev: events10){ //no need for this to be a separate loop --mc
            whoids.add(ev.whoid);
        }
        system.debug(whoids);
        //4- find task with same whoIds as the remaining events(events10) and check if
        //Vonage_Trigger__c != null 
        //CallType = outbound
        //calldurationinseconds != null
        
        // intiate some lists here for later use
        //list<task> tasks =  new list<task>();
        List<NVMContactWorld__InteractionEvent__c> interactions = new List<NVMContactWorld__InteractionEvent__c>();
        list<user> agents =  new list<user>();
        list<user> managers = new list<user>(); 
        list<string> managersids = new list<string>();
        list<string> taskagents = new list<string>();
        list<string> blockwhoids = new list<string>();
        
        // do we have any events?
        if(events10.size() > 0){
            //find related tasks to passeddue events by whoId
            //tasks = [SELECT whoId, ownerid, id, createddate from task where whoid IN:whoids AND createddate = today AND ( Vonage_Trigger__c  != null OR (CallType = 'outbound' AND calldurationinseconds != null) ) order by createddate desc];
            interactions = [SELECT Id, OwnerId, NVMContactWorld__Agent__c, NVMContactWorld__Who__c, CreatedDate FROM NVMContactWorld__InteractionEvent__c WHERE NVMContactWorld__Who__c IN :whoids order by createddate desc];
            system.debug(interactions);
            
            //4-..........send email to the agents of those tasks.....................//
            //check on each lead if has a task where the createddate  is <= 7(within) of the events starttime     
            //get whoId from the tasks
            long timeDiff;
            long timeDifferenceinMin;
            list<string> leadIds =  new list<string>();
            
            // looping through events that met criteria
            for(event ev: events10){
                // we are agregating taskagents and leadids here for later use in SOQL queries
                taskagents.add(ev.OwnerId);
                leadIds.add(ev.whoId);
                //.......................check for events with tasks..........................................//
                //if(tasks.size()>0){ 
                if(interactions.size()>0){    
                    //for(task tsk: tasks ){
                    for(NVMContactWorld__InteractionEvent__c interaction: interactions){    
                        //find task related to events and make sure that it doesn't send the email twice if alredy listed 
                        //if( ev.whoid == tsk.whoId ){
                        if( ev.whoid == interaction.NVMContactWorld__Who__c ){    
                            //check if the task was created within 9 minutes of events start time
                            //timeDiff = tsk.createddate.getTime() - ev.StartDateTime.getTime(); //absolute value
                            timeDiff = interaction.createddate.getTime() - ev.StartDateTime.getTime(); //absolute value
                            timeDifferenceinMin =   ((timeDiff/1000)/60) ;
                            system.debug(timeDifferenceinMin);
                            
                            if (timeDifferenceinMin >=-5 && timeDifferenceinMin <= 10) { //within 9 minutes, note for Drew, I adjusted this to 10 minutes, you can change this in concert with the other value
                                // changed this check to prevent sending based on whoid rather than ownerid so we don't supress other messages to rep
                                //if(!blockwhoids.contains(tsk.whoId)){  
                                if(!blockwhoids.contains(interaction.NVMContactWorld__Who__c)){
                                    //system.debug('task '+tsk.id+' was created ' + timeDifferenceinMin +' minutes after the eventsstartdate' );
                                    system.debug('task was created by agent..no reminder needed');
                                    blockwhoids.add(interaction.NVMContactWorld__Who__c);
                                }
                            } 
                        }  
                    }
                } 
            }
            
            //query contact name, initiate out here due to soql restrictions
            list<contact> contacts = [SELECT id,name from contact where id IN:leadIds];
            
            //query lead name, initiate out here due to soql restrictions
            list<lead> leads = [SELECT id,name from lead where id IN:leadIds]; 
            
            // query for agent details, initiate out here due to soql restrictions
            agents = [SELECT id,managerid,email,name from user where id IN:taskagents];
            
            // loop to get manager ids
            for(user u: agents){
                managersids.add(u.managerid);
                system.debug('agent: '+u.name);
            }
            
            // query for manager details, initiate out here due to soql restrictions
            managers = [SELECT id,email from user where Id IN:managersids];
            
            //check if in production or sandbox to dynamically compose the events link
            Organization org = [SELECT IsSandbox FROM Organization LIMIT 1];
            
            // make final list
            for(event ev: events10){ 
                // check to make sure we aren't blocked
                if(!blockwhoids.contains(ev.whoId)){
                    // initiate data structure row
                    taskWrapper wrapTask = new taskWrapper();
                    
                    wrapTask.whoId = ev.whoId;
                    wrapTask.eventId = ev.Id;
                    wrapTask.taskAgent = ev.OwnerId; // this was previously using the task ownerid, this didn't seem reliable so I have switched to the event owner id
                    
                    // defaults to blank
                    wrapTask.leadName = '';
                    wrapTask.agentEmail = '';
                    wrapTask.managerEmail = '';
                    wrapTask.agentName = '';
                    wrapTask.eventLink = '';
                    
                    // generate link based on org
                    //can use System.URL.getOrgDomainUrl().toExternalForm() instead --mc
                    if(org.IsSandbox == true){
                        wrapTask.eventLink = 'https://1800accountant--uat.lightning.force.com/lightning/r/Event/'+ev.Id+'/view';
                        system.debug('events url: '+wrapTask.eventLink);
                    } else if(org.IsSandbox == false){
                        wrapTask.eventLink = 'https://1800accountant.lightning.force.com/lightning/r/Event/'+ev.Id+'/view';
                        system.debug('events url: '+wrapTask.eventLink);
                    }
                    // get contact name
                    for(contact c: contacts){
                        if (c.id == ev.whoId) {
                            wrapTask.leadName = c.name;
                            system.debug('contact: '+c.name);
                        }
                    }
                    // get lead name
                    for(lead l:leads){
                        if (l.id == ev.whoId) {
                            wrapTask.leadName = l.name;
                            system.debug('lead: '+l.name);
                        }
                    }
                    // get agent and manager details
                    for(user u: agents){
                        if (u.id == ev.OwnerId) {
                            wrapTask.agentEmail = u.email;
                            wrapTask.agentName = u.name;
                            system.debug('agent: '+u.name);
                            for(user mem: managers){
                                if (mem.id == u.managerid) {
                                    wrapTask.managerEmail = mem.email;
                                }
                            }
                        }
                    }
                    // add wrapTask to list
                    masterList.add(wrapTask);
                }
            }
            // loop through data structure and send emails
            for(taskWrapper masterItem : masterList){
                // send email to agent if fields are filled out
                if (masterItem.agentEmail != '') {
                    sendEmail(masterItem.agentEmail,masterItem.eventLink,masterItem.agentName,masterItem.leadName);
                }
                // send email to manager if fields are filled out
                if (masterItem.managerEmail != '') {
                    sendEmail(masterItem.managerEmail,masterItem.eventLink,masterItem.agentName,masterItem.leadName);
                }
            }
        }
    }
            
    public void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
            system.debug(job);
    }
        
    // this method actually sends the email    
    public static void sendEmail(string emaill,string eventslink,string agetsname,string leadsname){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        String[] toAddresses = new String[] {emaill}; 
        
        mail.setToAddresses(toAddresses);
        mail.setSenderDisplayName('Salesforce Support');
        mail.setSubject('Overdue Call on 1on1 Sales Appointment');
        mail.setPlainTextBody('A TSA appointment for one of your team members was not called or rejected on time. Please reassign this appointment right away.\n Sales Specialist:'+agetsname+' \n'+'Name of Lead:  '+leadsname+'\n'+eventslink);
        
        if(!Test.isRunningTest()){
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        
        
        system.debug('a reminder email has been sent to the agent');
        system.debug('email invocations: '+Limits.getEmailInvocations());
        emailNumber = Limits.getEmailInvocations();
    }
}