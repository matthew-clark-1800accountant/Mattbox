public without sharing class SyncEventsToCalls {
    public static TriggerControlPanels__mdt isActive = [SELECT Id, IsActive__c FROM TriggerControlPanels__mdt WHERE Label = 'SyncEventsToCalls' LIMIT 1];

    public static void syncEvents(List<Id> eventIds){
        try{
            if(isActive.IsActive__c || Test.isRunningTest()){
                if(System.isFuture() || System.isBatch()){
                    syncEventsSync(eventIds);
                } else {
                    syncEventsFuture(eventIds);
                }
            } else {
                System.debug('trigger control panel deactivated');
            }    
        } catch(Exception ex){
            System.debug(ex.getMessage());
        }            
    }

    @future
    public static void syncEventsFuture(List<Id> eventIds){
        syncEventsSync(eventIds);
    }

    public static void syncEventsSync(List<Id> eventIds){
        try{
            Map<String, List<Event>> phoneToEventList = new Map<String, List<Event>>();
            Map<String, Event> phoneToEventMap = new Map<String, Event>();
            Map<NVMStatsSF__NVM_Call_Summary__c, Event> callToEventMap = new Map<NVMStatsSF__NVM_Call_Summary__c, Event>();
            List<String> disposToOverride = new List<String>{'Cancelled', 'Rescheduled'};
            List<String> appointmentTypes = new List<String>{'Tax Savings Analysis', 'Formation Consultation', 'BNA',  'Discovery Call', 'Onboarding Follow-Up'};

            //query the relevant events
            List<Event> events = [
                SELECT Id, StartDateTime, EndDateTime, Appointment_Disposition__c, Secondary_Disposition_Details__c,
                Subject, Type_of_Appointment__c, OwnerId, Original_Assigned_to__c, WhatId,
                //TYPEOF Who WHEN Lead THEN phone WHEN contact THEN Numeric_Phone__c END 
                TYPEOF Who WHEN Lead THEN Invoca_Phone__c WHEN contact THEN Invoca_Phone__c END
                FROM Event 
                WHERE Who.Type IN ('Lead', 'Contact') 
                AND Id IN :eventIds
                AND Type_of_Appointment__c IN :appointmentTypes
                ORDER BY CreatedDate ASC
            ];
    
            //collect the phone numbers of the who records and tie them to the events
            for(Event e : events){
                String phoneNumber = '';
                if(e.who instanceof Lead){phoneNumber = formatPhone(((Lead)e.who).Invoca_Phone__c);}
                if(e.who instanceof Contact){phoneNumber = formatPhone(((Contact)e.who).Invoca_Phone__c);}
                if(phoneToEventList.containsKey(phoneNumber)){
                    phoneToEventList.get(phoneNumber).add(e);
                } else {
                    phoneToEventList.put(phoneNumber, new List<Event>{e});
                }            
            }
            // for(String phone : phoneToEventList.keySet()){
            //     System.debug(phone+': '+phoneToEventList.get(phone));
            // }
            
    
            //query all call summaries with matching phone numbers
            List<NVMStatsSF__NVM_Call_Summary__c> summaries = [SELECT Id, NVMStatsSF__CLID__c, NVMStatsSF__CallTime__c, CreatedDate FROM NVMStatsSF__NVM_Call_Summary__c WHERE NVMStatsSF__CLID__c IN :phoneToEventList.keySet() AND NVMStatsSF__CallEndTime__c != null];
            
            //we can now connect each summary to a list of events, but we need to narrow it down to one event per summary
            for(NVMStatsSF__NVM_Call_Summary__c summary : summaries){
                for(Event e : phoneToEventList.get(summary.NVMStatsSF__CLID__c)){
                    if(summary.NVMStatsSF__CallTime__c > e.StartDateTime.addMinutes(-15) && summary.NVMStatsSF__CallTime__c < e.EndDateTime.addMinutes(15)){
                        if(!callToEventMap.containsKey(summary) || disposToOverride.contains(callToEventMap.get(summary).Appointment_Disposition__c)){
                            callToEventMap.put(summary, e);
                        }
                    }
                }
            }
    
            // for(NVMStatsSF__NVM_Call_Summary__c summary : callToEventMap.keySet()){
            //     System.debug(summary.NVMStatsSF__CLID__c+': '+callToEventMap.get(summary));
            // }
            // System.debug(callToEventMap);
            //filter out any calls that don't have matching events
            summaries = new List<NVMStatsSF__NVM_Call_Summary__c>(callToEventMap.keySet());
            
            //stamp each summary with the data from the matching event
            for(NVMStatsSF__NVM_Call_Summary__c summary : summaries){
                Event e = callToEventMap.get(summary);
                summary.Event_Assigned_To__c = e.OwnerId;
                summary.Event_Disposition__c = e.Appointment_Disposition__c;
                if(String.valueOf(e.WhatId.getSObjectType()) == 'Opportunity'){summary.Event_Opportunity__c = e.WhatId;}
                summary.Event_Original_Assigned_To__c = (Id) e.Original_Assigned_to__c;
                summary.Event_Secondary_Disposition__c = e.Secondary_Disposition_Details__c;
                summary.Event_Start_Time__c = e.StartDateTime;
                summary.Event_Subject__c = e.Subject;
                summary.Event_Type__c = e.Type_of_Appointment__c;
                summary.Event_URL__c = URL.getOrgDomainURL().toExternalForm() + '/' + e.Id;
            }
    
            update summaries;
        } catch(Exception ex){
            System.debug(ex.getMessage());
        }
        
    }

    public static void syncCalls(List<Id> callIds){
        try{
            if(isActive.IsActive__c || Test.isRunningTest()){
                if(System.isFuture() || System.isBatch()){
                    syncCallsSync(callIds);
                } else {
                    syncCallsFuture(callIds);
                }
            } else {
                System.debug('trigger control panel deactivated');
            }            
        } catch(Exception ex){
            System.debug(ex.getMessage());
        }  
        
    }

    public static void syncCallsSync(List<Id> callIds){
        try{
            List<String> disposToOverride = new List<String>{'Cancelled', 'Rescheduled'};
            List<String> appointmentTypes = new List<String>{'Tax Savings Analysis', 'Formation Consultation', 'BNA',  'Discovery Call', 'Onboarding Follow-Up'};
            Map<NVMStatsSF__NVM_Call_Summary__c, Event> callToEventMap = new Map<NVMStatsSF__NVM_Call_Summary__c, Event>();
    
            List<NVMStatsSF__NVM_Call_Summary__c> summaries = [SELECT Id, NVMStatsSF__CLID__c, NVMStatsSF__CallTime__c, CreatedDate FROM NVMStatsSF__NVM_Call_Summary__c WHERE Id IN :callIds AND NVMStatsSF__CallEndTime__c != null];
            Map<String, List<NVMStatsSF__NVM_Call_Summary__c>> phoneToSummaries = new Map<String, List<NVMStatsSF__NVM_Call_Summary__c>>();
            for(NVMStatsSF__NVM_Call_Summary__c summary : summaries){
                String phone = summary.NVMStatsSF__CLID__c.substring(2);
                if(!phoneToSummaries.containsKey(phone)){phoneToSummaries.put(phone, new List<NVMStatsSF__NVM_Call_Summary__c>());}
                phoneToSummaries.get(phone).add(summary);
            }
    
            List<Id> whoIds = new List<Id>();
            for(Contact con : [SELECT Id FROM Contact WHERE Invoca_Phone__c IN :phoneToSummaries.keySet() OR Phone IN :phoneToSummaries.keySet()]){
                whoIds.add(con.Id);
            }
            for(Lead l : [SELECT Id FROM Lead WHERE Invoca_Phone__c IN :phoneToSummaries.keySet() OR Phone IN :phoneToSummaries.keySet()]){
                whoIds.add(l.Id);
            }
    
            List<Event> events = [
                SELECT Id, StartDateTime, EndDateTime, Appointment_Disposition__c, Secondary_Disposition_Details__c,
                Subject, Type_of_Appointment__c, OwnerId, Original_Assigned_to__c, WhatId,
                TYPEOF Who WHEN Lead THEN Invoca_Phone__c WHEN contact THEN Invoca_Phone__c END
                FROM Event 
                WHERE WhoId IN :whoIds
                AND Type_of_Appointment__c IN :appointmentTypes
                ORDER BY CreatedDate ASC
            ];
    
            for(Event e : events){
                String phoneNumber = '';
                if(e.who instanceof Lead){phoneNumber = ((Lead)e.who).Invoca_Phone__c;}
                if(e.who instanceof Contact){phoneNumber = ((Contact)e.who).Invoca_Phone__c;}
                for(NVMStatsSF__NVM_Call_Summary__c summary : phoneToSummaries.get(phoneNumber)){
                    if(summary.NVMStatsSF__CallTime__c > e.StartDateTime.addMinutes(-15) && summary.NVMStatsSF__CallTime__c < e.EndDateTime.addMinutes(15)){
                        if(!callToEventMap.containsKey(summary) || disposToOverride.contains(callToEventMap.get(summary).Appointment_Disposition__c)){
                            callToEventMap.put(summary, e);
                        }
                    }
                }
            }
    
             //filter out any calls that don't have matching events
             summaries = new List<NVMStatsSF__NVM_Call_Summary__c>(callToEventMap.keySet());
            
             //stamp each summary with the data from the matching event
             for(NVMStatsSF__NVM_Call_Summary__c summary : summaries){
                Event e = callToEventMap.get(summary);
                summary.Event_Assigned_To__c = e.OwnerId;
                summary.Event_Disposition__c = e.Appointment_Disposition__c;
                if(String.valueOf(e.WhatId.getSObjectType()) == 'Opportunity'){summary.Event_Opportunity__c = e.WhatId;}
                summary.Event_Original_Assigned_To__c = (Id) e.Original_Assigned_to__c;
                summary.Event_Secondary_Disposition__c = e.Secondary_Disposition_Details__c;
                summary.Event_Start_Time__c = e.StartDateTime;
                summary.Event_Subject__c = e.Subject;
                summary.Event_Type__c = e.Type_of_Appointment__c;
                summary.Event_URL__c = URL.getOrgDomainURL().toExternalForm() + '/' + e.Id;
             }
    
            update summaries;
        } catch(Exception ex){
            System.debug(ex.getMessage());
        }
        
    }

    @future
    public static void syncCallsFuture(List<Id> callIds){
        syncCallsSync(callIds);
    }

    public static string formatPhone(String phoneNum){
        return '+1'+phoneNum.deleteWhitespace().remove('(').remove(')').remove('-');
    }
}