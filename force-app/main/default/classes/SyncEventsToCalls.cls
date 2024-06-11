public with sharing class SyncEventsToCalls {
    public SyncEventsToCalls() {

    }

    @future
    public static void syncEvents(List<Id> eventIds){
        //Set<Id> eventIds = new Map<Id, Event>(eventList).keySet();
        List<String> appointmentTypes = new List<String>{'Tax Savings Analysis', 'Formation Consultation', 'BNA',  'Discovery Call', 'Onboarding Follow-Up'};
        List<Event> events = [
            SELECT Id, StartDateTime, EndDateTime, Appointment_Disposition__c, Secondary_Disposition_Details__c,
            Subject, Type_of_Appointment__c, OwnerId, Original_Assigned_to__c, WhatId,
            TYPEOF Who WHEN Lead THEN phone WHEN contact THEN Numeric_Phone__c END 
            FROM Event 
            WHERE Who.Type IN ('Lead', 'Contact') 
            AND Id IN :eventIds
            AND Type_of_Appointment__c IN :appointmentTypes
        ];

        Map<String, Event> phoneToEventMap = new Map<String, Event>();
        List<String> disposToOverride = new List<String>{'Cancelled', 'Rescheduled'};

        for(Event e : events){
            String phoneNumber = '';
            if(e.who instanceof Lead){phoneNumber = formatPhone(e.who.phone);}
            if(e.who instanceof Contact){phoneNumber = formatPhone(((Contact)e.who).Numeric_Phone__c);}
            if(!phoneToEventMap.containsKey(phoneNumber) 
                || disposToOverride.contains(phoneToEventMap.get(phoneNumber).Appointment_Disposition__c) 
                || disposToOverride.contains(phoneToEventMap.get(phoneNumber).Secondary_Disposition_Details__c)){
                    phoneToEventMap.put(phoneNumber, e);
            }
        }

        List<NVMStatsSF__NVM_Call_Summary__c> summaries = [SELECT Id FROM NVMStatsSF__NVM_Call_Summary__c WHERE NVMStatsSF__CLID__c IN :phoneToEventMap.keySet() AND NVMStatsSF__CallEndTime__c != null];
        for(NVMStatsSF__NVM_Call_Summary__c summary : summaries){
            Event e = phoneToEventMap.get(summary.NVMStatsSF__CLID__c);
            if(summary.CreatedDate > e.StartDateTime.addMinutes(-15) && summary.CreatedDate < e.EndDateTime.addMinutes(15)){
                summary.Event_Assigned_To__c = e.OwnerId;
                summary.Event_Disposition__c = e.Appointment_Disposition__c;
                summary.Event_Opportunity__c = e.WhatId;
                summary.Event_Original_Assigned_To__c = (Id) e.Original_Assigned_to__c;
                summary.Event_Secondary_Disposition__c = e.Secondary_Disposition_Details__c;
                summary.Event_Start_Time__c = e.StartDateTime;
                summary.Event_Subject__c = e.Subject;
                summary.Event_Type__c = e.Type_of_Appointment__c;
                summary.Event_URL__c = URL.getOrgDomainURL().toExternalForm() + '/' + e.Id;
            }
        }

        update summaries;
    }

    public static string formatPhone(String phoneNum){
        return '+1'+phoneNum.deleteWhitespace().remove('(').remove(')').remove('-');
    }
}