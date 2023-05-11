public class EventNotifyMissedCall implements Database.Batchable<sObject>, Schedulable {
    private void setQueryString(){   
        this.eventQuery = 
          'SELECT Id, StartDateTime, EndDateTime, Portal_Event_Owner__c, Customer_Number__c, Account_Status__c, OwnerId, WhoId, WhatId, Owner.Name,   '
        +'TYPEOF Who ' 
        +'WHEN Contact '
        +'THEN Phone,Name '
        +'WHEN Lead '
        +'THEN Phone '  
        +'END ' 
        + 'FROM Event '
        + 'WHERE StartDateTime >= TODAY '
        + 'AND StartDateTime <= TOMORROW '
        + 'AND Portal_Event_Owner__c != null '
        + 'AND Type_of_Appointment__c = \'Discovery Call\' '
        + 'AND Secondary_Disposition_Details__c != \'Timer Started\' '
        ;
    }
    public string eventQuery;

    public EventNotifyMissedCall() {
        setQueryString();
    }
    public Database.QueryLocator start(Database.BatchableContext bc)  {
        return Database.getQueryLocator(this.eventQuery);
    }
    public void execute(SchedulableContext context) {
        EventNotifyMissedCall sendEmail = new EventNotifyMissedCall();
        Database.executeBatch(sendEmail, 200);
    }
    public void execute(Database.BatchableContext bc, List<Event> events){
        this.execute(events);
    }
    public void execute(List<Event> events) {
        //Filter events by finding events with 7 minutes after startTime
        long todaysDate = DateTime.now().getTime(); //GMT
        long eventDueDate;
        long timeDifference;
        long timeDifferenceMinutes;
        
        // this is our master event list
        System.debug(todaysDate);
        EmailTemplate emailTemplate = [
            SELECT Id, Subject, Description, HtmlValue, DeveloperName, Body 
            FROM EmailTemplate 
            WHERE name = 'Missed Discovery Appointment'
        ];
        Map<Id, Id> portalOwnerIdsToEvent = new Map<Id, Id>();
        Map<String, Id> portalOwnerNamesToEvent = new Map<String, Id>();

        for(Event e : events){
            if(e.Portal_Event_Owner__c instanceOf Id){
                portalOwnerIdsToEvent.put(e.Portal_Event_Owner__c, e.Id);
            } else {
                portalOwnerNamesToEvent.put(e.Portal_Event_Owner__c, e.Id);
            }
        }

        List<Mitel_Team_Email__mdt> getEmailAddresses = [
            SELECT Id, Label, Mitel_Team__c, Email_Address__c
            FROM Mitel_Team_Email__mdt
        ];
        Map<String, String> mitelToEmail = new Map<String, String>();
        for(Mitel_Team_Email__mdt md : getEmailAddresses){
            mitelToEmail.put(md.Mitel_Team__c, md.Email_Address__c);
        }
        Map<Id, User> portalOwners = new Map<Id, User>([
            SELECT Id, Name, Mitel_Team__c
            FROM User
            WHERE Id IN: portalOwnerIdsToEvent.keySet()
            OR Name IN: portalOwnerNamesToEvent.keySet()
        ]);
        Map<String, Id> eventToUser = new Map<String, Id>();
        for(User u : portalOwners.values()){
            String eventIdName = portalOwnerNamesToEvent.get(u.Name);
            Id eventId = portalOwnerIdsToEvent.get(u.Id);
            if(null != eventIdName){
                eventToUser.put(eventIdName, u.Id);
            } else if(null != eventId){
                eventToUser.put(eventId, u.Id);
            }
        }


        // loop through initial events to check to see if the timing matches the criteria
        for(event ev: events){
            
            // calculations based upon time difference
            eventDueDate = ev.StartDateTime.getTime();
             System.debug(eventDueDate);

            timeDifference =  todaysDate - eventDueDate;
            timeDifferenceMinutes = ( (timeDifference/1000) /60);
            
            system.debug(timeDifferenceMinutes);
                
            // does the timing meet our criteria? note for Drew, the lower threshold of 6 and 10 can be adjusted to expand the timing (previously 6 and 9, I just adjusted to 6 and 10)
            if( (timeDifferenceMinutes >= 6) && (timeDifferenceMinutes <= 10) ){
                
                system.debug('Difference in minutes between events due date and current time: '+timeDifferenceMinutes); 
                Messaging.SingleEmailMessage message = Messaging.renderStoredEmailTemplate(emailTemplate.Id, null, null);
                //Getting the mitel team to find the mapped email address
                String mitelTeam = portalOwners.get(eventToUser.get(ev.Id)).Mitel_Team__c;
                String emailAddress = mitelToEmail.get(mitelTeam);

                message.toAddresses = new String[] { emailAddress  };
                message.setSubject('Overdue Call on Discovery');
                message.setHtmlBody(message.getHtmlBody().replace('eventlink', 'https://1800accountant.lightning.force.com/lightning/r/Event/'+ev.Id+'/view').replace('portalEventOwner', ev.Portal_Event_Owner__c).replace('clientName', ev.Who.Name).replace('CustNumber', ev.Customer_Number__c).replace('clientPhone', ev.Who.Phone).replace('apptStart', string.valueof(ev.StartDateTime)).replace('acctStatus', ev.Account_Status__c));
    
                //Send email and save Link to the Opportunity
                if(!Test.isRunningTest()){
                    Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{message});
                }
                
            }
        }
                    
                
        
    }

    public void finish(Database.BatchableContext bc){}     
}