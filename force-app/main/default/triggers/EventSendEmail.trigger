trigger EventSendEmail on Event (after update) {
    Map<Id, Id> sendEmailIdsToEvent = new Map<Id, Id>();
    for(Event e : Trigger.new){
        Event oldEvent = Trigger.oldMap.get(e.Id);
        //If the Event's appointment disposition is changing...
        if(oldEvent.Appointment_Disposition__c != e.Appointment_Disposition__c &&
        //To no show....
        'No Show' == e.Appointment_Disposition__c &&
        //And meets the following criteria:
        // '1on1 Sales Appointment' == e.Subject &&
        e.subject.containsIgnoreCase('1on1') &&
        'Tax Savings Analysis' == e.Type_of_Appointment__c &&
        'Sale' != e.Secondary_Disposition_Details__c){
            //Get the Lead to send out the Pre-Tsa email
            if(null != e.WhoId &&
            'Lead' == e.WhoId.getSObjectType().getDescribe().getName()){
                sendEmailIdsToEvent.put(e.WhoId, e.Id);
            }
            //Get the Account to send out the Pre-Tsa email
            if(null != e.WhatId &&
                'Account' == e.WhatId.getSObjectType().getDescribe().getName()){
                sendEmailIdsToEvent.put(e.WhatId, e.Id);
            }
        }
    }
    //Queueable class to send Pre-Tsa email
    if(!sendEmailIdsToEvent.isEmpty()){
        EventSendEmail sendPreTsaEmail = new EventSendEmail(sendEmailIdsToEvent);
        System.enqueueJob(sendPreTsaEmail);
    }
}