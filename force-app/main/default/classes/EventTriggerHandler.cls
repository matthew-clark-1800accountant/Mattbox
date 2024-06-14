/**
 *  About
 *  -----
 *  Author: Appluent
 *  Create date: 02nd Oct 2017
 *  
 *  Details
 *  -----
 *  This class is handler class of trigger 'EventTrigger'. 
 *  It will do following operations :
 *
 *  1. Whenever a new event is created or updated it will create 3 SMS Schedule records. 
 *  (2 records 24hr prior(with 1 min diffrence) and one record 1 hrs prior messaging)
 *  Only if Event subject contains Discovery call or Advisory #1 or Advisory #2
 *  
 *  Update History
 *  4-1-2022 Took off ZenBusiness Restrictions -Koby Campbell
 *  
 *  Issues / TODOs
 *  ----- 
 *
**/
public without sharing class EventTriggerHandler{

    //Static variable to make sure trigger only run once
    public static Boolean createSMSRunOnce = false;
    public static Boolean updateInvoiceRunOnce = false;

    /**
    *  About
    *  -----
    *  Author: Appluent
    *
    *  Details
    *  -----
    *  Method to handle after Insert trigger operations.
    *  1.Whenever a new event is created ,it will create 3 SMS Schedule records.
    *  Only if Event subject contains Discovery call or Advisory #1 or Advisory #2
    *
    **/

    public static void afterInsert(List<Event> listNewRecords){
        System.debug('EventTriggerHandler.afterInsert()');
        
        List<Event> eventsToSync = new List<Event>();
        
        Event[] toProcess = new Event[0];
        if(!EventTriggerHandler.createSMSRunOnce){
            for(Event evt : listNewRecords){
                if(NULL != evt.WhoId || NULL != evt.WhatId){
                    toProcess.add(evt);
                }
            }



            createSMSScheduleRecords(toProcess);
        }
        
        for (Event newEvent : listNewRecords){
            
            if (newEvent.ShowAs != 'Free') {
            
                if(newEvent.StartDateTime > Datetime.now().addDays(-1) || newEvent.EndDateTime > Datetime.now().addDays(-1)){
                    
                    eventsToSync.add(newEvent);
                
                }
                
            }
            
        }
        
        if(!eventsToSync.isEmpty()){
            System.debug('eventsToSync: '+eventsToSync);
            syncToSchedulerApi(eventsToSync, false);
        }
        
    }

    /**
    *  About
    *  -----
    *  Author: S.Reyes
    *
    *  Details
    *  -----
    *  Method to handle before insert trigger operations.
    *  1. Update email campaign record.
    *
    **/

    public static void beforeInsert(List<Event> triggerNew){
        updateEmailCampaignId(triggerNew);
    }


    /**
    *  About
    *  -----
    *  Author: Appluent
    *
    *  Details
    *  -----
    *  Method to handle after Delete trigger operations.
    *  1.Whenever an event is Deleted ,it will delete 3 SMS Schedule
    *  records associated with that event.
    *
    **/

    public static void afterDelete(Map<Id,Event> mapOldRecords){
        System.debug('EventTriggerHandler.afterDelete()');
        deleteSMSScheduleRecords(mapOldRecords);
        //List<ApiCalloutWrapper> eventWrappers = new List<ApiCalloutWrapper>();
        List<Event> blocksToSync = new List<Event>();
        List<Event> eventsToSync = new List<Event>();
        for(Event oldEvent : mapOldRecords.values()){
            //if(oldEvent.CreatedDate < Datetime.now().addDays(-30) && oldEvent.Type_of_Appointment__c == 'Calendar Block'){
            if(oldEvent.Type_of_Appointment__c == 'Calendar Block'){
                // ApiCalloutWrapper wrapper = new ApiCalloutWrapper();
                // wrapper.eventId = oldEvent.Id;
                // wrapper.isUpdate = false;
                // wrapper.eventData = new EventWrapper(oldEvent);
                // eventWrappers.add(wrapper);
                //syncToApi(JSON.serialize(wrapper));
                blocksToSync.add(oldEvent);
            }
            if (oldEvent.ShowAs != 'Free') {
                eventsToSync.add(oldEvent);
            }
            
        }
        if(!blocksToSync.isEmpty()){
            System.debug('blocksToSync: '+blocksToSync);
            syncToApi(blocksToSync, false);
        }
        if(!eventsToSync.isEmpty()){
            System.debug('eventsToSync: '+eventsToSync);
            syncToSchedulerApi(eventsToSync, false);
        }
    }

    /**
    *  About
    *  -----
    *  Author: Appluent
    *
    *  Details
    *  -----
    *  AFTER UPDATE TRIGGER
    *  This method will run if the event start date is changed and will eventually delete the
    *  earlier 3 SMS schedule records for the event and
    *  will create 3 new SMS Schedule records.
    *  Two records to schedule messaging 24 hour prior to event(5 min difference between each)
    *  and another record to schedule messaging 1 hour prior to event
    *  Only if Event subject contains Discovery call or Advisory #1 or Advisory #2
    **/
    public static void afterUpdate(List<Event> listNewRecords, Map<Id,Event> mapOldRecords) {
    System.debug('EventTriggerHandler.afterUpdate()');
        Event[] eventRecords = new Event[0];
        if(!updateInvoiceRunOnce)
        {
            for(Event evt : listNewRecords)
            {
                Event oldEvent = mapOldRecords.get(evt.Id);
                if(evt != oldEvent)
                {
                    eventRecords.add(evt);
                }
            }

            updateInvoicePaymentAmount(eventRecords);
        }

        System.debug(LoggingLevel.FINE, 'Inside Update Trigger Method');
        List<Event> eventsToInsert = new List<Event>();
        Map<Id, Event> eventIdToEventMap = new Map<Id, Event>();
        List<Event> eventsWithNewOwner = new List<Event>();

        Map<Id, Id> accountIdToEventId = new Map<Id, Id>();
        Map<Id, Id> eventIdToOwnerId = new Map<Id, Id>();
        Map<Id, Event> cancelledEvents = new Map<Id, Event>();
        List<Id> eventsToSyncToCalls = new List<Id>();

        
        Map<Event_Field_Update__c, Event> fieldUpdateToEventMap = new Map<Event_Field_Update__c, Event>();
        List<Id> eventIds = new List<Id>();
        Map<Id, String> updatedByMap = new Map<Id, String>();
        List<Event_Tracking_Fields__mdt> fieldsToTrack = [SELECT Id, Field_Name__c, IsDate__c, MasterLabel FROM Event_Tracking_Fields__mdt WHERE IsActive__c = true];
        //List<ApiCalloutWrapper> eventWrappers = new List<ApiCalloutWrapper>();
        List<Event> blocksToSync = new List<Event>();
        List<Event> eventsToSync = new List<Event>();
        for (Event newEvent : listNewRecords){ eventIds.add(newEvent.Id); }
        for (Event ev : [SELECT Id, LastModifiedBy.Name FROM Event WHERE Id IN :eventIds]){
            updatedByMap.put(ev.Id, ev.LastModifiedBy.Name);
        }

        
        for (Event newEvent : listNewRecords){

            Event oldEvent = mapOldRecords.get(newEvent.Id);
            Boolean updatedBySetter = null;
            if(updatedByMap.containsKey(newEvent.Id)){
                updatedBySetter = updatedByMap.get(newEvent.Id) == newEvent.Appointment_Setter__c;
            }

            if (newEvent.StartDateTime != oldEvent.StartDateTime) {
                eventIdToEventMap.put(newEvent.Id, newEvent);
                eventsToInsert.add(newEvent);
            }

            if (newEvent.Appointment_Disposition__c != oldEvent.Appointment_Disposition__c) {
               eventsToSyncToCalls.add(newEvent.Id);
            }
            
            if(newEvent.CreatedDate < Datetime.now().addDays(-30) && newEvent.Type_of_Appointment__c == 'Calendar Block'){
            //if(newEvent.Type_of_Appointment__c == 'Calendar Block'){
                // ApiCalloutWrapper wrapper = new ApiCalloutWrapper();
                // wrapper.eventId = newEvent.Id;
                // wrapper.isUpdate = true;
                // wrapper.eventData = new EventWrapper(newEvent);
                // //syncToApi(JSON.serialize(wrapper));
                // eventWrappers.add(wrapper);
                blocksToSync.add(newEvent);
            }
            
            if (newEvent.ShowAs != 'Free' || oldEvent.ShowAs != 'Free') {
            
                if(newEvent.StartDateTime > Datetime.now().addDays(-1) || newEvent.EndDateTime > Datetime.now().addDays(-1) || oldEvent.StartDateTime > Datetime.now().addDays(-1) || oldEvent.EndDateTime > Datetime.now().addDays(-1)){
                    
                    eventsToSync.add(newEvent);
                
                }
                
            }
            
            for(Event_Tracking_Fields__mdt field : fieldsToTrack){
                String fieldName = field.Field_Name__c;
                if(newEvent.get(fieldName) != oldEvent.get(fieldName)){
                    String oldValue;
                    String newValue;
                    if(field.IsDate__c){
                        newValue = String.valueOf(((Datetime)newEvent.get(fieldName)).formatGMT('yyyy-MM-dd HH:mm:ss'))+' UTC+0';
                        oldValue = String.valueOf(((Datetime)oldEvent.get(fieldName)).formatGMT('yyyy-MM-dd HH:mm:ss'))+' UTC+0';
                    } else {
                        newValue = (String) newEvent.get(fieldName);
                        oldValue = (String) oldEvent.get(fieldName);
                    }
                    Datetime curTime = Datetime.now();
                    Boolean withinChangeWindow = (curTime > oldEvent.StartDateTime.addMinutes(-15) && curTime < oldEvent.EndDateTime);
                    

                    System.debug(field.MasterLabel+' changed');
                    fieldUpdateToEventMap.put(new Event_Field_Update__c(
                        Updated_Field__c = field.MasterLabel,
                        New_Value__c = newValue,
                        Old_Value__c = oldValue,
                        Updated_By__c = newEvent.LastModifiedById,
                        Update_Time__c = DateTime.now(),
                        Updated_by_Setter__c = updatedBySetter,
                        Update_made_in_change_window__c = withinChangeWindow
                        ), newEvent);
                }
            }


            if (newEvent.Portal_Event_Owner__c != oldEvent.Portal_Event_Owner__c && 'Discovery Call'.equalsIgnoreCase(newEvent.Type_of_Appointment__c)){
                System.debug('portal event owner changed to '+newEvent.Portal_Event_Owner__c);
                eventsWithNewOwner.add(newEvent);
            }

            //removed else --mc
            if((('Cancelled'.equalsIgnoreCase(newEvent.Appointment_Disposition__c)) || 
            ('Rescheduled'.equalsIgnoreCase(newEvent.Appointment_Disposition__c)) ||
            ('No Show'.equalsIgnoreCase(newEvent.Appointment_Disposition__c))) &&
            newEvent.Appointment_Disposition__c != oldEvent.Appointment_Disposition__c)
            {
                System.debug('event added to cancelledEvents: '+newEvent.Appointment_Disposition__c);
                if(('No Show'.equalsIgnoreCase(newEvent.Appointment_Disposition__c))){
                    eventsToInsert.add(newEvent);
                }
                cancelledEvents.put(newEvent.Id, newEvent);
            } else {
                System.debug('event not added to cancelledEvents: '+newEvent.Appointment_Disposition__c);
            }

            System.debug('checkpoint1');
            //Putting logic for update event whatId to opportunity
            if((null != newEvent.Type_of_Appointment__c &&
            ('Tax Savings Analysis' == newEvent.Type_of_Appointment__c
            || 'BNA' == newEvent.Type_of_Appointment__c)
            || 'Formation Consultation' == newEvent.Type_of_Appointment__c) &&

            null != newEvent.Appointment_Disposition__c &&
            'Consulted' == newEvent.Appointment_Disposition__c &&

            ('Sale' == newEvent.Secondary_Disposition_Details__c ||
            'Follow-Up' == newEvent.Secondary_Disposition_Details__c) &&

            (null != newEvent.WhoId && 
            'Contact' == newEvent.WhoId.getSobjectType().getDescribe().getName()) && 
            (null != newEvent.WhatId && 
            'Account' == newEvent.WhatId.getSobjectType().getDescribe().getName())){
                //If the disposition changes and it meets the conditions above update the whoId
                System.debug('checkpoint2');
                if(newEvent.Appointment_Disposition__c != oldEvent.Appointment_Disposition__c){
                    System.debug('checkpoint3');
                    accountIdToEventId.put(newEvent.WhatId, newEvent.Id);
                    eventIdToOwnerId.put(newEvent.Id, newEvent.OwnerId);
                }
            }
        }

        if(!blocksToSync.isEmpty()){
            syncToApi(blocksToSync, true);  
        }
        
        if(!eventsToSync.isEmpty()){
            syncToSchedulerApi(eventsToSync, true);  
        }

        if(!eventsToSyncToCalls.isEmpty() && !Test.isRunningTest()){
            SyncEventsToCalls.syncEvents(eventsToSyncToCalls);
        }

        //Insert any Event History and Event Field Update records that are needed
        if(!fieldUpdateToEventMap.isEmpty()){
            System.enqueueJob(new InsertFieldUpdateQueueable(fieldUpdateToEventMap));
        }
        
        if (!eventIdToEventMap.isEmpty()){
            deleteSMSScheduleRecords(eventIdToEventMap);
        }

        if(!cancelledEvents.isEmpty()){
            deleteSMSScheduleRecords(cancelledEvents);
        }

        if (!createSMSRunOnce && !eventsToInsert.isEmpty()){
            createSMSScheduleRecords(eventsToInsert);
        }

        if(!eventsWithNewOwner.isEmpty()){
            for(Event ev : eventsWithNewOwner){
                updateOwnerPhone(ev.Id);
            }            
        }

        if(!accountIdToEventId.isEmpty()){
            updateWhatIdToOpportunity(accountIdToEventId, eventIdToOwnerId);
        }
    }

    public class ApiCalloutWrapper{
        public Id eventId;
        public Boolean isUpdate;
        public EventWrapper eventData;
    }
    public class EventWrapper{
        public Id OwnerId;
        public Datetime StartDateTime;
        public Datetime EndDateTime;
        public String ShowAs;
        public String Type_of_Appointment;

        public EventWrapper(Event ev){
                this.OwnerId = ev.OwnerId;
                this.StartDateTime = ev.StartDateTime;
                this.EndDateTime = ev.EndDateTime;
                this.ShowAs = ev.ShowAs;
                this.Type_of_Appointment = ev.Type_of_Appointment__c;
        }
    }
    
    public static void syncToSchedulerApi(List<Event> eventsToSync, Boolean isUpdate){
    
        List<Calendar_Event__e> events = new List<Calendar_Event__e>();
        
        for(Event e : eventsToSync){
            events.add(new Calendar_Event__e(
                Event_Record_Id__c=e.Id,
                IsUpdate__c=isUpdate,
                OwnerId__c=e.OwnerId,
                StartDateTime__c=e.StartDateTime,
                EndDateTime__c=e.EndDateTime,
                ShowAs__c=e.ShowAs,
                Subject__c=e.Subject,
                Type_of_appointment__c=e.Type_of_Appointment__c
                ));
        }
        
        System.debug('events: '+events);
        
        EventBus.publish(events);
        
    }

    public static void syncToApi(List<Event> eventsToSync, Boolean isUpdate){
        List<Delete_Calendar_Block__e> blocks = new List<Delete_Calendar_Block__e>();
        for(Event e : eventsToSync){
            blocks.add(new Delete_Calendar_Block__e(
                Event_Record_Id__c=e.Id,
                IsUpdate__c=isUpdate,
                OwnerId__c=e.OwnerId,
                StartDateTime__c=e.StartDateTime,
                EndDateTime__c=e.EndDateTime,
                ShowAs__c=e.ShowAs,
                Type_of_Appointment__c=e.Type_of_Appointment__c
                ));
        }
        System.debug('blocks: '+blocks);
        EventBus.publish(blocks);
        // if(System.isBatch() || System.isFuture()){
        //     List<ApiCalloutWrapper> eventWrappers = new List<ApiCalloutWrapper>();
        //     for(Event e : eventsToSync){
        //         ApiCalloutWrapper wrapper = new ApiCalloutWrapper();
        //         wrapper.eventId = e.Id;
        //         wrapper.isUpdate = false;
        //         wrapper.eventData = new EventWrapper(e);
        //         eventWrappers.add(wrapper);
        //     }
        //     syncToApiSynch(eventWrappers);
        // } else {
        //     syncToApiFuture(new Map<Id, Event>(eventsToSync).keySet());
        // }
    }
    
    // @future(callout=true)
    // public static void syncToApiFuture(Set<Id> eventIds){
    //     List<Event> eventsToSync = [SELECT Id, OwnerId, StartDateTime, EndDateTime, ShowAs, Type_of_Appointment__c
    //     FROM Event WHERE Id IN :eventIds];
    //     List<ApiCalloutWrapper> eventWrappers = new List<ApiCalloutWrapper>();
    //         for(Event e : eventsToSync){
    //             ApiCalloutWrapper wrapper = new ApiCalloutWrapper();
    //             wrapper.eventId = e.Id;
    //             wrapper.isUpdate = false;
    //             wrapper.eventData = new EventWrapper(e);
    //             eventWrappers.add(wrapper);
    //         }
    //     syncToApiSynch(eventWrappers);
    // }

    // public static void syncToApiSynch(List<ApiCalloutWrapper> events){
    //     while(events.size() > 0){
    //         List<ApiCalloutWrapper> sublist = new List<ApiCalloutWrapper>();
    //         Integer eventsSize = events.size();
    //         for(Integer i=0; i<(Math.min(100, eventsSize)); i++){
    //             sublist.add(events.remove(0));
    //         }
    //         makeApiCallout(JSON.serialize(sublist));
    //     }
    // }

    public static void makeApiCallout(String body){
        System.debug(body);
        String endPoint = 'callout:X1800Accountant_SFAPI/schedule/eventcache.php';
        //String escapedQuery = EncodingUtil.urlEncode(query, 'UTF-8');
        HttpRequest req; 
        HttpResponse res; 
        Http h; 


        req = new HttpRequest(); 
        req.setEndpoint(endPoint); 
        req.setMethod('POST'); 
        req.setBody(body);
        h = new Http(); 
        res = h.send(req); 
        System.debug(res.getBody());
    }

    public static void updateWhatIdToOpportunity(Map<Id, Id> accountIdToEventId, Map<Id, Id> eventIdToOwnerId){
        System.debug('EventTriggerHandler.updateWhatIdToOpportunity()');
        System.debug(accountIdToEventId);
        System.debug(eventIdToOwnerId);
        List<Opportunity> oppys = [
            SELECT Id, Name, AccountId, OwnerId
            FROM Opportunity
            WHERE AccountId IN :accountIdToEventId.keySet()
            AND OwnerId IN :eventIdToOwnerId.values()
            AND CreatedDate = LAST_N_DAYS:14
            ORDER BY CreatedDate DESC
        ];
        System.debug('oopys: '+oppys);
        //Get the most recent by created date
        Map<Id, Opportunity> opportunities = new Map<Id, Opportunity>();
        for(Opportunity o : oppys) {
            if(null == opportunities.get(o.AccountId)) {
                opportunities.put(o.AccountId, o);
            }
        }
        System.debug(opportunities);
        Map<Id, Event> toUpdateEvents = new Map<Id, Event>();
        for(Opportunity opportunity : opportunities.values()){
            if(opportunity.OwnerId == eventIdToOwnerId.get(accountIdToEventId.get(opportunity.AccountId))){
                Event event = new Event(
                    Id = accountIdToEventId.get(opportunity.AccountId),
                    WhatId = opportunity.Id
                );
                toUpdateEvents.put(event.Id, event);
            }
        }
        System.debug('toUpdateEvents: '+toUpdateEvents);
        update toUpdateEvents.values();
    }

    //update sms records when the Portal Event Owner changes
    @future
    public static void updateOwnerPhone(Id eventId){
        Event updatedEvent = [SELECT Id, StartDateTime, Portal_Event_Owner__c, Account.Primary_Contact__r.Name FROM Event WHERE Id = :eventId LIMIT 1];
        String contactName = updatedEvent.Account.Primary_Contact__r.Name;
        List<String> smsTypes = new List<String>{'Advisory Reminder'};
        Datetime startTime = updatedEvent.StartDateTime.addMinutes(-15);
        if(updatedEvent.Portal_Event_Owner__c != null){
            User portalEventOwner = [SELECT Id, Name, Phone FROM User WHERE Name = :updatedEvent.Portal_Event_Owner__c];
            SMS_Schedule__c smsRecord = [SELECT Id, Type__c FROM SMS_Schedule__c WHERE EventId__c = :eventId AND Type__c IN :smsTypes AND Schedule_Date__c = :startTime LIMIT 1];
            String ownerPhone = portalEventOwner.Phone;
            String ownerName = portalEventOwner.Name;
            
            String baseString;
            if(ownerPhone == null){
                baseString = 'Hi {0}, you have a meeting with {1} your 1-800Accountant Advisor in a few minutes. We look forward to speaking with you!';
                //smsScheduleJustPriorRecord.Message__c = String.format(baseString, new List<String>{eventRecord.Account.Primary_Contact__r.Name, eventRecord.Account.PortalAccountOwner__r.Name});
                smsRecord.Message__c = String.format(baseString, new List<String>{contactName, ownerName});
            } else {
                baseString = 'Hi {0}, you have a meeting with {1} your 1-800Accountant Advisor in a few minutes. Watch for the call from this number: {2}. We look forward to speaking with you!';
                smsRecord.Message__c = String.format(baseString, new List<String>{contactName, ownerName, ownerPhone});
            }
            if(!Test.isRunningTest()){
                update smsRecord;
            }
            
        }
        
    }

    /**
    *  About
    *  -----
    *  Author: Appluent
    *
    *  Details
    *  -----
    *  it will create two SMS Schedule records.
    *  Two records to schedule messaging 24 hour prior to event(1 min diffrence between each)
    *  and another reocrd to schedule messaging 1 hour prior to event
    *  Only if Event subject contains Discovery call or Advisory #1 or Advisory #2
    **/

    public static void deleteSMSScheduleRecords(Map<Id,Event> mapOldRecords) {
        System.debug('EventTriggerHandler.deleteSMSScheduleRecords()');
        //There is no relationship between event and SMS_Schedule__c ,
        //SMS_Schedule__c  only have a text field which is having event ID.
        System.debug('deleteSMSScheduleRecords trigger method entered...');
        //List of all SMS Records to be deleted

        Set<Id> eventIds = new Set<Id>();
        Set<Id> accountIds = new Set<Id>();
        Set<Id> contactIds = new Set<Id>();
        Set<Id> leadIds = new Set<Id>();

        String leadPrefix = Schema.SObjectType.Lead.getKeyPrefix();

        for (Event evt : mapOldRecords.values()){
            if (String.isNotBlank(evt.AccountId)){
                eventIds.add(evt.Id);
                accountIds.add(evt.AccountId);
            }else if(String.isNotBlank(evt.WhoId) && ((String)evt.WhoId).startsWith(leadPrefix)){
                leadIds.add(evt.WhoId);
                eventIds.add(evt.Id);
            }
        }

        Boolean haveAccountIds = (accountIds.isEmpty());
        Boolean haveLeadIds = (leadIds.isEmpty());

        if(haveAccountIds || haveLeadIds)
        {
            SMS_Schedule__c[] listSMSrecordsToDelete = new SMS_Schedule__c[0];

            for(Account act : [SELECT Id, Primary_Contact__c
            FROM Account
            WHERE Id IN :accountIds
            AND Primary_Contact__c != NULL])
            {
                contactIds.add(act.Primary_Contact__c);
            }

            for(SMS_Schedule__c sms : [SELECT EventID__c
            FROM SMS_Schedule__c
            WHERE Status__c = 'Pending'
            AND (Contact__c IN :contactIds OR Lead__c IN :leadIds)
            AND EventId__c IN :eventIds])
            {
                listSMSrecordsToDelete.add(sms);
            }

            if(!listSMSrecordsToDelete.isEmpty())
            {
                System.debug(LoggingLevel.FINE, 'valid SMS records set for deletion per criteria... ' + listSMSrecordsToDelete);
                for(Database.DeleteResult dr : Database.delete(listSMSrecordsToDelete)){
                    if(!dr.isSuccess()){
                        System.debug(LoggingLevel.ERROR, 'An error has occurred deleting the SMS Schedule record.');
                        for(Database.Error err : dr.getErrors()){
                            System.debug(LoggingLevel.ERROR, err.getStatusCode() + ': ' + err.getMessage());
                            System.debug(LoggingLevel.ERROR, err.getFields());
                        }
                    }
                }
            }
        }
    }


    /**
    *  About
    *  -----
    *  Author: Appluent
    *
    *  Details
    *  -----
    *  it will create 3 SMS Schedule records.
    *  Two records to schedule messaging 24 hour prior to event(1 min diffrence between each)
    *  and another reocrd to schedule messaging 1 hour prior to event
    *  Only if Event subject contains Discovery call or Advisory #1 or Advisory #2
    **/
    public static void createSMSScheduleRecords(List<Event> listEventRecords) {
        System.debug('EventTriggerHandler.createSMSScheduleRecords()');
        EventTriggerHandler.createSMSRunOnce = true;
        System.debug(LoggingLevel.FINE, 'createSMSScheduleRecords METHOD');
        Set<Id> eventIds = new Map<Id, Event>(listEventRecords).keySet();
        if(!System.isFuture() && !System.isBatch()){
            createSMSHelper(eventIds);
        }
    }

    @future
    public static void createSMSHelper(Set<Id> eventIds) {
    System.debug('EventTriggerHandler.createSMSHelper()');
        List<Event> listEventRecords = [SELECT Id, WhatId, WhoId FROM Event WHERE Id IN :eventIds];
        EventTriggerHandler.createSMSRunOnce = true;
        System.debug(LoggingLevel.FINE, 'createSMSScheduleRecords METHOD');
        //List of SMS_Schedule__c  That will be inserted
        List<SMS_Schedule__c > smsScheduleRecordsToInsert = new List<SMS_Schedule__c >();

        //Set of Event Ids
        Set<Id> setEventIds = new Set<Id>();
        Set<Id> setLeadEventIds = new Set<Id>();
        Set<Id> setLeadIds = new Set<Id>();

        //List of all Event Records Including their Related account feilds
        //Which will be used to create Schedule SMS record.
        List<Event> listDetailedEventRecords = new List<Event>();
        List<Event> listLeadEventRecords = new List<Event>();

        //Map of Primary Contact Detail Records of the account related to Event
        //Map<Id,Contact> mapPrimaryContacts;


        //Creating Set of all Event Ids that has been inserted or Updated
        //And also related to accounts only
        String accountPrefix = Schema.SObjectType.Account.getKeyPrefix();
        String leadPrefix = Schema.SObjectType.Lead.getKeyPrefix();

        for (Event eventRecord : listEventRecords){
            if(String.isNotBlank(eventRecord.WhatId) && ((String)eventRecord.WhatId).startsWith(accountPrefix)){
                setEventIds.add(eventRecord.Id);
            }else if(String.isNotBlank(eventRecord.WhoId) && ((String)eventRecord.WhoId).startsWith(leadPrefix)){
                setLeadIds.add(eventRecord.WhoId);
                setLeadEventIds.add(eventRecord.Id);
            }
        }

        System.debug(LoggingLevel.DEBUG, 'setLeadIds:-->' + setLeadIds);

        listDetailedEventRecords  = [SELECT WhoId, WhatId, Portal_Event_Owner__c, Owner.Name, Owner.FirstName, Appointment_Disposition__c, Type_of_Appointment__c ,AccountId, Account.Primary_Contact__c, Subject, StartDateTime,
                Account.Primary_Contact__r.Name, Account.Name, Account.Primary_Contact__r.FirstName, Account.Primary_Contact__r.Phone, Local_Start_Time__c, Account.PortalAccountOwner__r.Phone, Account.PortalAccountOwner__r.Name
        FROM Event WHERE Id IN :setEventIds AND Account.Primary_Contact__c != NULL];

        listLeadEventRecords = [SELECT WhoId, WhatId, Portal_Event_Owner__c, Owner.Name, Owner.FirstName, Subject, StartDateTime, Local_Start_Time__c, Appointment_Disposition__c, Type_of_Appointment__c
        FROM Event WHERE Id IN :setLeadEventIds];

        //To Get Contact Record Details
        if(!listDetailedEventRecords.isEmpty()){

            /*for(Event eventRecord : listDetailedEventRecords){
                setContactIds.add(eventRecord.Account.Primary_Contact__c);
            }
            mapPrimaryContacts =new Map<Id,Contact>([SELECT Name,Phone FROM Contact
                                                     WHERE Id IN :setContactIds ]); */

            for(Event eventRecord : listDetailedEventRecords){
                System.debug('eventRecord.Portal_Event_Owner__c: '+eventRecord.Portal_Event_Owner__c);
                List<User> portalEventOwners = [SELECT Id, Name, Phone FROM User WHERE Name = :eventRecord.Portal_Event_Owner__c LIMIT 1];
                User portalEventOwner;
                if(!portalEventOwners.isEmpty()){
                    portalEventOwner = portalEventOwners[0];
                }
                //No Show Block for Contacts and Accounts
                if('No Show'.equalsIgnoreCase(eventRecord.Appointment_Disposition__c)){
                    if( 'Tax Savings Analysis'.equalsIgnoreCase(eventRecord.Type_of_Appointment__c) ||
                        'Formation Consultation'.equalsIgnoreCase(eventRecord.Type_of_Appointment__c) ||
                        'BNA'.equalsIgnoreCase(eventRecord.Type_of_Appointment__c) ||
                        'Discovery Call'.equalsIgnoreCase(eventRecord.Type_of_Appointment__c)
                    ){
                        System.debug(LoggingLevel.FINE, 'valid no show record.');

                        SMS_Schedule__c  smsScheduleADayPriorRecord01 = new SMS_Schedule__c ();

                        if('Tax Savings Analysis'.equalsIgnoreCase(eventRecord.Type_of_Appointment__c)) {
                            smsScheduleADayPriorRecord01.Message__c = '1-800Accountant reminder: We attempted to call for your Tax Savings appointment. Sorry we missed you. Please reschedule here https://1800accountant.com/sfapi/t/?w=' + eventRecord.WhatId + '&c=SMS-TSA or contact us at 929-342-0731. Reply STOP to stop tax savings msgs';
                            smsScheduleADayPriorRecord01.Name = 'Account TSA No Show ' + eventRecord.Account.Name;
                            smsScheduleADayPriorRecord01.Type__c = 'TSA No Show';
                        } else if ('Formation Consultation'.equalsIgnoreCase(eventRecord.Type_of_Appointment__c)){
                            smsScheduleADayPriorRecord01.Message__c = '1-800Accountant reminder: We attempted to call for your Entity Formation Consultation. Sorry we missed you. Please reschedule here https://1800accountant.com/sfapi/f/?w=' + eventRecord.WhatId + '&c=SMS-EF or contact us at 323-617-5385. Reply STOP to stop entity msgs';
                            smsScheduleADayPriorRecord01.Name = 'Account EF No Show ' + eventRecord.Account.Name;
                            smsScheduleADayPriorRecord01.Type__c = 'EF No Show';
                        } else if ('BNA'.equalsIgnoreCase(eventRecord.Type_of_Appointment__c)){
                            smsScheduleADayPriorRecord01.Message__c = '1-800Accountant reminder: We attempted to call for your Business Needs Analysis. Sorry we missed you. Please reschedule here https://1800accountant.com/sfapi/b/?w=' + eventRecord.WhatId + '&c=SMS-BNA or contact us at 727-241-5190. Reply STOP to stop appt msgs';
                            smsScheduleADayPriorRecord01.Name = 'Account BNA No Show ' + eventRecord.Account.Name;
                            smsScheduleADayPriorRecord01.Type__c = 'BNA No Show';
                        } else if ('Discovery Call'.equalsIgnoreCase(eventRecord.Type_of_Appointment__c)){ //-MC 12/9/22                     
                            String baseString; 
                            String firstName = eventRecord.Account.Primary_Contact__r.FirstName;
                            //User portalEventOwner = [SELECT Phone FROM User WHERE Name = :eventRecord.Portal_Event_Owner__c LIMIT 1];
                            String ownerPhone = portalEventOwner?.Phone;
                            String ownerName = eventRecord.Portal_Event_Owner__c;
                            //String ownerPhone = eventRecord.Account.PortalAccountOwner__r.Phone;
                            //String ownerName = eventRecord.Account.PortalAccountOwner__r.Name;
                            if(ownerPhone == null){
                                baseString = 'Hi {0}, this is {1} your 1-800Accountant Advisor. I tried to call you for our scheduled Discovery/Advisory appointment. I will attempt to call you again in 5 minutes. I look forward to speaking with you.';
                                smsScheduleADayPriorRecord01.Message__c = String.format(baseString, new List<String>{firstName, ownerName});
                            } else {
                                baseString = 'Hi {0}, this is {1} your 1-800Accountant Advisor. I tried to call you for our scheduled Discovery/Advisory appointment. I will attempt to call you again in 5 minutes. The number I will be calling from is {2}. I look forward to speaking with you.';
                                smsScheduleADayPriorRecord01.Message__c = String.format(baseString, new List<String>{firstName, ownerName, ownerPhone});
                            }
                            smsScheduleADayPriorRecord01.Name = 'Account Advisory No Show ' + eventRecord.Account.Name;
                            smsScheduleADayPriorRecord01.Type__c = 'Advisory No Show';
                        }


                        smsScheduleADayPriorRecord01.Schedule_Date__c= Datetime.now().addMinutes(2);
                        smsScheduleADayPriorRecord01.To_Phone_Number__c = eventRecord.Account.Primary_Contact__r.Phone;
                        smsScheduleADayPriorRecord01.Object_Id__c = (String)eventRecord.WhoId;
                        smsScheduleADayPriorRecord01.Reference_Id__c = (String)eventRecord.WhatId;
                        smsScheduleADayPriorRecord01.Contact__c=eventRecord.Account.Primary_Contact__c;
                        smsScheduleADayPriorRecord01.EventID__c= (String)eventRecord.Id;
                        smsScheduleADayPriorRecord01.Account__c = eventRecord.AccountId;
                        smsScheduleADayPriorRecord01.Status__c = 'Pending';
                        smsScheduleADayPriorRecord01.Priority__c = 2;

                        System.debug('adding record "no show" to list :: ' + smsScheduleADayPriorRecord01);
                        smsScheduleRecordsToInsert.add(smsScheduleADayPriorRecord01);
                        continue;
                    }
                }

                //Creating Date Time Suffix
                String eventDateTime=eventRecord.StartDateTime.format('MMddyyyy_HHmm');
                if(eventRecord.Subject.containsIgnoreCase('Discovery call')
                        || eventRecord.Subject.containsIgnoreCase('Tax Planning Appointment')
                        || eventRecord.Subject.containsIgnoreCase('Payroll Appointment')
                        || eventRecord.Subject.containsIgnoreCase('Bookkeeping Appointment')
                        || eventRecord.Subject.containsIgnoreCase('Bookkeeping Advisory Appointment')
                        || eventRecord.Subject.containsIgnoreCase('Advisory #1')
                        ||eventRecord.Subject.containsIgnoreCase('Advisory #2')){

                    //Create a record 1 for notification before 1 Day
                    SMS_Schedule__c  smsScheduleADayPriorRecord01 = new SMS_Schedule__c ();
                    smsScheduleADayPriorRecord01.Schedule_Date__c= eventRecord.StartDateTime.addDays(-1);
                    smsScheduleADayPriorRecord01.Message__c='1-800Accountant alert: A friendly reminder - your meeting with your advisor is tomorrow at '+ eventRecord.StartDateTime.format('MM/dd/yyyy @ h:mm a') + ' EDT. Reply STOP to end account alerts';
                    smsScheduleADayPriorRecord01.Object_Id__c = (String) eventRecord.Account.Primary_Contact__c;
                    smsScheduleADayPriorRecord01.Reference_Id__c = eventRecord.Account.Primary_Contact__r.Name+'-'+eventDateTime;
                    smsScheduleADayPriorRecord01.To_Phone_Number__c = eventRecord.Account.Primary_Contact__r.Phone;
                    smsScheduleADayPriorRecord01.Name =  eventRecord.Account.Primary_Contact__r.Name+'_'+eventDateTime;
                    smsScheduleADayPriorRecord01.Contact__c=eventRecord.Account.Primary_Contact__c;
                    smsScheduleADayPriorRecord01.EventID__c=eventRecord.Id;
                    smsScheduleADayPriorRecord01.Account__c = eventRecord.AccountId;
                    smsScheduleADayPriorRecord01.Status__c = 'Pending';
                    smsScheduleADayPriorRecord01.Priority__c = 3;
                    smsScheduleADayPriorRecord01.Type__c = 'Advisory Reminder';

                    System.debug(LoggingLevel.FINE, 'CP 00'+(eventRecord.StartDateTime.getTime()-Datetime.now().getTime())/3600000);

                    if(eventRecord.StartDateTime.addDays(-1) > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleADayPriorRecord01);
                    }

                    //Create a record 2 for notification before 1 Day (After 1 min)
                    SMS_Schedule__c  smsScheduleADayPriorRecord02 = new SMS_Schedule__c ();
                    smsScheduleADayPriorRecord02.Schedule_Date__c= eventRecord.StartDateTime.addDays(-1).addMinutes(5);
                    smsScheduleADayPriorRecord02.Message__c='If possible, please be in front of a computer during our call and collect any relevant documents for review.';
                    smsScheduleADayPriorRecord02.Object_Id__c = (String) eventRecord.Account.Primary_Contact__c;
                    smsScheduleADayPriorRecord02.Reference_Id__c = eventRecord.Account.Primary_Contact__r.Name+'-'+eventDateTime;
                    smsScheduleADayPriorRecord02.To_Phone_Number__c = eventRecord.Account.Primary_Contact__r.Phone;
                    smsScheduleADayPriorRecord02.Name =  eventRecord.Account.Primary_Contact__r.Name+'_'+eventDateTime;
                    smsScheduleADayPriorRecord02.Contact__c=eventRecord.Account.Primary_Contact__c;
                    smsScheduleADayPriorRecord02.EventID__c=eventRecord.Id;
                    smsScheduleADayPriorRecord02.Account__c = eventRecord.AccountId;
                    smsScheduleADayPriorRecord02.Status__c = 'Pending';
                    smsScheduleADayPriorRecord02.Priority__c = 3;
                    smsScheduleADayPriorRecord02.Type__c = 'Advisory Reminder';


                    if(eventRecord.StartDateTime.addDays(-1) > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleADayPriorRecord02);
                    }

                    //Create a record for notification before 1 Hour
                    SMS_Schedule__c  smsScheduleAnHourPriorRecord = new SMS_Schedule__c ();
                    smsScheduleAnHourPriorRecord.Schedule_Date__c= eventRecord.StartDateTime.addHours(-1);
                    smsScheduleAnHourPriorRecord.Object_Id__c= (String)eventRecord.Account.Primary_Contact__c;
                    smsScheduleAnHourPriorRecord.Reference_Id__c =eventRecord.Account.Primary_Contact__r.Name+'-'+eventDateTime;
                    smsScheduleAnHourPriorRecord.To_Phone_Number__c=eventRecord.Account.Primary_Contact__r.Phone;
                    smsScheduleAnHourPriorRecord.Name =  eventRecord.Account.Primary_Contact__r.Name+'_'+eventDateTime;
                    smsScheduleAnHourPriorRecord.Contact__c=eventRecord.Account.Primary_Contact__c;
                    smsScheduleAnHourPriorRecord.Message__c='1-800Accountant alert: A friendly reminder - your meeting with your advisor is in one hour - '+ eventRecord.StartDateTime.format('MM/dd/yyyy @ h:mm a') + ' EDT.';
                    smsScheduleAnHourPriorRecord.EventID__c=eventRecord.Id;
                    smsScheduleAnHourPriorRecord.Account__c = eventRecord.AccountId;
                    smsScheduleAnHourPriorRecord.Status__c = 'Pending';
                    smsScheduleAnHourPriorRecord.Priority__c = 3;
                    smsScheduleAnHourPriorRecord.Type__c = 'Advisory Reminder';

                    if(eventRecord.StartDateTime.addHours(-1) > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleAnHourPriorRecord);
                    }

                    if(eventRecord.Subject.containsIgnoreCase('Discovery call')){
                        //Create a record for notification 15 minutes before the appointment
                        //-MC 12/9/22
                        SMS_Schedule__c  smsScheduleJustPriorRecord = new SMS_Schedule__c ();
                        smsScheduleJustPriorRecord.Schedule_Date__c= eventRecord.StartDateTime.addMinutes(-15);
                        smsScheduleJustPriorRecord.Object_Id__c= (String)eventRecord.Account.Primary_Contact__c;
                        smsScheduleJustPriorRecord.Reference_Id__c =eventRecord.Account.Primary_Contact__r.Name+'-'+eventDateTime;
                        smsScheduleJustPriorRecord.To_Phone_Number__c=eventRecord.Account.Primary_Contact__r.Phone;
                        smsScheduleJustPriorRecord.Name =  eventRecord.Account.Primary_Contact__r.Name+'_'+eventDateTime;
                        smsScheduleJustPriorRecord.Contact__c=eventRecord.Account.Primary_Contact__c;
                        //String ownerPhone = eventRecord.Account.PortalAccountOwner__r.Phone;
                        // String ownerPhone = portalEventOwner.Phone;
                        // String ownerName = portalEventOwner.Name;
                        String ownerPhone = portalEventOwner?.Phone;
                        String ownerName = eventRecord.Portal_Event_Owner__c;
                        
                        String baseString;
                        if(ownerPhone == null){
                            baseString = 'Hi {0}, you have a meeting with {1} your 1-800Accountant Advisor in a few minutes. We look forward to speaking with you!';
                            //smsScheduleJustPriorRecord.Message__c = String.format(baseString, new List<String>{eventRecord.Account.Primary_Contact__r.Name, eventRecord.Account.PortalAccountOwner__r.Name});
                            smsScheduleJustPriorRecord.Message__c = String.format(baseString, new List<String>{eventRecord.Account.Primary_Contact__r.Name, ownerName});
                        } else {
                            baseString = 'Hi {0}, you have a meeting with {1} your 1-800Accountant Advisor in a few minutes. Watch for the call from this number: {2}. We look forward to speaking with you!';
                            smsScheduleJustPriorRecord.Message__c = String.format(baseString, new List<String>{eventRecord.Account.Primary_Contact__r.Name, ownerName, ownerPhone});
                        }
                        //smsScheduleJustPriorRecord.Message__c= String.format(baseMessage, new List<String>{eventRecord.Account.Primary_Contact__r.Name, eventRecord.Account.PortalAccountOwner__r.Name, eventRecord.Account.PortalAccountOwner__r.Phone});
                        smsScheduleJustPriorRecord.EventID__c=eventRecord.Id;
                        smsScheduleJustPriorRecord.Account__c = eventRecord.AccountId;
                        smsScheduleJustPriorRecord.Status__c = 'Pending';
                        smsScheduleJustPriorRecord.Priority__c = 3;
                        smsScheduleJustPriorRecord.Type__c = 'Advisory Reminder';

                        if(eventRecord.StartDateTime.addMinutes(-15) > System.now()){
                            smsScheduleRecordsToInsert.add(smsScheduleJustPriorRecord);
                        }
                    }
                    

                }

                //for 1on1 Sales Appointment
                if(eventRecord.Subject.containsIgnoreCase('1on1 Sales Appointment')){

                    //Create a record 1 for notification before 1 Day
                    SMS_Schedule__c  smsScheduleADayPriorRecord01 = new SMS_Schedule__c ();
                    smsScheduleADayPriorRecord01.Schedule_Date__c = System.now().addMinutes(2);
                    smsScheduleADayPriorRecord01.Message__c = '1-800Accountant confirmation: You have a Tax Savings Analysis appointment with a tax expert on ' + eventRecord.Local_Start_Time__c + '. Reply STOP to stop tax savings msgs';
                    smsScheduleADayPriorRecord01.Object_Id__c = (String) eventRecord.Account.Primary_Contact__c;
                    smsScheduleADayPriorRecord01.Reference_Id__c = eventRecord.Account.Primary_Contact__r.Name+'-'+eventDateTime;
                    smsScheduleADayPriorRecord01.To_Phone_Number__c = eventRecord.Account.Primary_Contact__r.Phone;
                    smsScheduleADayPriorRecord01.Name =  eventRecord.Account.Primary_Contact__r.Name+'_TSA_'+eventDateTime;
                    smsScheduleADayPriorRecord01.Contact__c = eventRecord.Account.Primary_Contact__c;
                    smsScheduleADayPriorRecord01.EventID__c = eventRecord.Id;
                    smsScheduleADayPriorRecord01.Account__c = eventRecord.AccountId;
                    smsScheduleADayPriorRecord01.Status__c = 'Pending';
                    smsScheduleADayPriorRecord01.Priority__c = 3;
                    smsScheduleADayPriorRecord01.Type__c = 'TSA Reminder';

                    System.debug(LoggingLevel.FINE, 'CP 0' + (eventRecord.StartDateTime.getTime()-Datetime.now().getTime())/3600000);

                    if(eventRecord.StartDateTime > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleADayPriorRecord01);
                    }

                    //Create a record for notification before 1 Hour
                    SMS_Schedule__c  smsScheduleAnHourPriorRecord = new SMS_Schedule__c ();
                    smsScheduleAnHourPriorRecord.Schedule_Date__c = eventRecord.StartDateTime.addHours(-1);
                    smsScheduleAnHourPriorRecord.Object_Id__c = (String)eventRecord.Account.Primary_Contact__c;
                    smsScheduleAnHourPriorRecord.Reference_Id__c = eventRecord.Account.Primary_Contact__r.Name+'-'+eventDateTime;
                    smsScheduleAnHourPriorRecord.To_Phone_Number__c = eventRecord.Account.Primary_Contact__r.Phone;
                    smsScheduleAnHourPriorRecord.Name =  eventRecord.Account.Primary_Contact__r.Name+'_TSA_'+eventDateTime;
                    smsScheduleAnHourPriorRecord.Contact__c = eventRecord.Account.Primary_Contact__c;
                    smsScheduleAnHourPriorRecord.Message__c = '1-800Accountant reminder: Your Tax Savings Analysis begins in 1 hour. We look forward to discussing your business taxes and important upcoming tax deadlines. If needed, reschedule here: https://1800accountant.com/sfapi/t/?w=' + eventRecord.WhatId + '&c=SMS-TSA';
                    smsScheduleAnHourPriorRecord.EventID__c=eventRecord.Id;
                    smsScheduleAnHourPriorRecord.Account__c = eventRecord.AccountId;
                    smsScheduleAnHourPriorRecord.Status__c = 'Pending';
                    smsScheduleAnHourPriorRecord.Priority__c = 3;
                    smsScheduleAnHourPriorRecord.Type__c = 'TSA Reminder';

                    if(eventRecord.StartDateTime.addHours(-1) > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleAnHourPriorRecord);
                    }

                }

                //for BNA
                if(eventRecord.Subject.containsIgnoreCase('Business Needs Analysis')){

                    //Create a record 1 for notification before 1 Day
                    SMS_Schedule__c  smsScheduleADayPriorRecord01 = new SMS_Schedule__c ();
                    smsScheduleADayPriorRecord01.Schedule_Date__c = System.now().addMinutes(2);
                    smsScheduleADayPriorRecord01.Message__c = '1-800Accountant confirmation: You have a call scheduled with an accounting services expert on ' + eventRecord.Local_Start_Time__c + '. Reply STOP to stop appt msgs';
                    smsScheduleADayPriorRecord01.Object_Id__c = (String) eventRecord.Account.Primary_Contact__c;
                    smsScheduleADayPriorRecord01.Reference_Id__c = eventRecord.Account.Primary_Contact__r.Name+'-'+eventDateTime;
                    smsScheduleADayPriorRecord01.To_Phone_Number__c = eventRecord.Account.Primary_Contact__r.Phone;
                    smsScheduleADayPriorRecord01.Name =  eventRecord.Account.Primary_Contact__r.Name+'_BNA_'+eventDateTime;
                    smsScheduleADayPriorRecord01.Contact__c = eventRecord.Account.Primary_Contact__c;
                    smsScheduleADayPriorRecord01.EventID__c = eventRecord.Id;
                    smsScheduleADayPriorRecord01.Account__c = eventRecord.AccountId;
                    smsScheduleADayPriorRecord01.Status__c = 'Pending';
                    smsScheduleADayPriorRecord01.Priority__c = 3;
                    smsScheduleADayPriorRecord01.Type__c = 'BNA Reminder';

                    System.debug(LoggingLevel.FINE, 'CP 0' + (eventRecord.StartDateTime.getTime()-Datetime.now().getTime())/3600000);

                    if(eventRecord.StartDateTime > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleADayPriorRecord01);
                    }

                    //Create a record for notification before 1 Hour
                    SMS_Schedule__c  smsScheduleAnHourPriorRecord = new SMS_Schedule__c ();
                    smsScheduleAnHourPriorRecord.Schedule_Date__c = eventRecord.StartDateTime.addHours(-1);
                    smsScheduleAnHourPriorRecord.Object_Id__c = (String)eventRecord.Account.Primary_Contact__c;
                    smsScheduleAnHourPriorRecord.Reference_Id__c = eventRecord.Account.Primary_Contact__r.Name+'-'+eventDateTime;
                    smsScheduleAnHourPriorRecord.To_Phone_Number__c = eventRecord.Account.Primary_Contact__r.Phone;
                    smsScheduleAnHourPriorRecord.Name =  eventRecord.Account.Primary_Contact__r.Name+'_BNA_'+eventDateTime;
                    smsScheduleAnHourPriorRecord.Contact__c = eventRecord.Account.Primary_Contact__c;
                    smsScheduleAnHourPriorRecord.Message__c = '1-800Accountant reminder: Your accounting services expert will call you at the scheduled time in 1 hour. We look forward to discussing your growing business needs. If needed, reschedule here: https://1800accountant.com/sfapi/b/?w=' + eventRecord.WhatId + '&c=SMS-BNA Reply STOP to stop all appt msgs. Msg & Data Rates May Apply';
                    smsScheduleAnHourPriorRecord.EventID__c=eventRecord.Id;
                    smsScheduleAnHourPriorRecord.Account__c = eventRecord.AccountId;
                    smsScheduleAnHourPriorRecord.Status__c = 'Pending';
                    smsScheduleAnHourPriorRecord.Priority__c = 3;
                    smsScheduleAnHourPriorRecord.Type__c = 'BNA Reminder';

                    if(eventRecord.StartDateTime.addHours(-1) > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleAnHourPriorRecord);
                    }

                }
                //for Entity Formation Consultation
                if(eventRecord.Subject.containsIgnoreCase('Formation Consultation')){

                    //Create a record 1 for notification before 1 Day
                    SMS_Schedule__c  smsScheduleADayPriorRecord01 = new SMS_Schedule__c ();
                    smsScheduleADayPriorRecord01.Schedule_Date__c = System.now().addMinutes(2);
                    smsScheduleADayPriorRecord01.Message__c = '1-800Accountant confirmation: You have an Entity Formation Consultation on ' + eventRecord.StartDateTime.format('MM/dd/yyyy @ h:mm a') + ' EDT. Reply STOP to stop entity msgs';
                    smsScheduleADayPriorRecord01.Object_Id__c = (String) eventRecord.Account.Primary_Contact__c;
                    smsScheduleADayPriorRecord01.Reference_Id__c = eventRecord.Account.Primary_Contact__r.Name+'-'+eventDateTime;
                    smsScheduleADayPriorRecord01.To_Phone_Number__c = eventRecord.Account.Primary_Contact__r.Phone;
                    smsScheduleADayPriorRecord01.Name =  eventRecord.Account.Primary_Contact__r.Name+'_EF_'+eventDateTime;
                    smsScheduleADayPriorRecord01.Contact__c = eventRecord.Account.Primary_Contact__c;
                    smsScheduleADayPriorRecord01.EventID__c = eventRecord.Id;
                    smsScheduleADayPriorRecord01.Account__c = eventRecord.AccountId;
                    smsScheduleADayPriorRecord01.Status__c = 'Pending';
                    smsScheduleADayPriorRecord01.Priority__c = 3;
                    smsScheduleADayPriorRecord01.Type__c = 'EF Reminder';

                    System.debug(LoggingLevel.FINE, 'CP 0' + (eventRecord.StartDateTime.getTime()-Datetime.now().getTime())/3600000);

                    if(eventRecord.StartDateTime > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleADayPriorRecord01);
                    }

                    //Create a record for notification before 1 Hour
                    SMS_Schedule__c  smsScheduleAnHourPriorRecord = new SMS_Schedule__c ();
                    smsScheduleAnHourPriorRecord.Schedule_Date__c = eventRecord.StartDateTime.addHours(-1);
                    smsScheduleAnHourPriorRecord.Object_Id__c = (String)eventRecord.Account.Primary_Contact__c;
                    smsScheduleAnHourPriorRecord.Reference_Id__c = eventRecord.Account.Primary_Contact__r.Name+'-'+eventDateTime;
                    smsScheduleAnHourPriorRecord.To_Phone_Number__c = eventRecord.Account.Primary_Contact__r.Phone;
                    smsScheduleAnHourPriorRecord.Name =  eventRecord.Account.Primary_Contact__r.Name+'_EF_'+eventDateTime;
                    smsScheduleAnHourPriorRecord.Contact__c = eventRecord.Account.Primary_Contact__c;
                    smsScheduleAnHourPriorRecord.Message__c = '1-800Accountant reminder: Your Entity Formation Consultation begins in 1 hour. We look forward to discussing your new business. If needed, reschedule here: https://1800accountant.com/sfapi/f/?w=' + eventRecord.WhatId + '&c=SMS-EF Reply STOP to stop all entity msgs. Msg & Data Rates May Apply';
                    smsScheduleAnHourPriorRecord.EventID__c=eventRecord.Id;
                    smsScheduleAnHourPriorRecord.Account__c = eventRecord.AccountId;
                    smsScheduleAnHourPriorRecord.Status__c = 'Pending';
                    smsScheduleAnHourPriorRecord.Priority__c = 3;
                    smsScheduleAnHourPriorRecord.Type__c = 'EF Reminder';

                    if(eventRecord.StartDateTime.addHours(-1) > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleAnHourPriorRecord);
                    }

                }

            }
        }


        //To Get Lead Record Details
        if(!listLeadEventRecords.isEmpty()){

            System.debug('listLeadEventRecords:-->' + listLeadEventRecords);

            Map<Id, Lead> mapLead = new Map<Id, Lead>([SELECT Id, Name, FirstName, Phone FROM Lead WHERE Id IN: setLeadIds]);

            System.debug('mapLead:-->' + mapLead);

            for(Event eventRecord : listLeadEventRecords){

                Lead l = mapLead.get(eventRecord.WhoId);
                System.debug('l:-->' + l);

                //No Show Block for Leads
                if('No Show'.equalsIgnoreCase(eventRecord.Appointment_Disposition__c)){
                    if( 'Tax Savings Analysis'.equalsIgnoreCase(eventRecord.Type_of_Appointment__c) ||
                            'Formation Consultation'.equalsIgnoreCase(eventRecord.Type_of_Appointment__c)
                            ){
                        SMS_Schedule__c  smsScheduleADayPriorRecord01 = new SMS_Schedule__c ();
                        if('Tax Savings Analysis'.equalsIgnoreCase(eventRecord.Type_of_Appointment__c)) {
                            smsScheduleADayPriorRecord01.Message__c='1-800Accountant reminder: We attempted to call for your Tax Savings appointment. Sorry we missed you. Please reschedule here http://1800accountant.com/sfapi/t/?w=' + eventRecord.WhoId + '&c=SMS or contact us at 929-342-0731. Reply STOP to stop tax savings msgs';
                            smsScheduleADayPriorRecord01.Name =  'Lead TSA No Show '+ l.Name;
                            smsScheduleADayPriorRecord01.Type__c = 'TSA No Show';
                        } else if ('Formation Consultation'.equalsIgnoreCase(eventRecord.Type_of_Appointment__c)){
                            smsScheduleADayPriorRecord01.Message__c='1-800Accountant reminder: We attempted to call for your Entity Formation Consultation. Sorry we missed you. Please reschedule here http://1800accountant.com/sfapi/f/?w=' + eventRecord.WhoId + '&c=SMS or contact us at 323-617-5385. Reply STOP to stop entity msgs';
                            smsScheduleADayPriorRecord01.Name =  'Lead EF No Show '+ l.Name;
                            smsScheduleADayPriorRecord01.Type__c = 'EF No Show';
                        }

                        smsScheduleADayPriorRecord01.Schedule_Date__c = Datetime.now().addMinutes(2);
                        smsScheduleADayPriorRecord01.To_Phone_Number__c = l.Phone;
                        smsScheduleADayPriorRecord01.Object_Id__c = (String) eventRecord.WhoId;
                        smsScheduleADayPriorRecord01.Reference_Id__c = l.Name;
                        smsScheduleADayPriorRecord01.EventId__c=(String)eventRecord.Id;
                        smsScheduleADayPriorRecord01.Status__c = 'Pending';
                        smsScheduleADayPriorRecord01.Priority__c = 2;
                        smsScheduleADayPriorRecord01.Lead__c = eventRecord.WhoId;

                        System.debug(smsScheduleADayPriorRecord01.Schedule_Date__c);

                        smsScheduleRecordsToInsert.add(smsScheduleADayPriorRecord01);
                        continue;
                    }
                }


                //Creating Date Time Suffix
                String eventDateTime=eventRecord.StartDateTime.format('MMddyyyy_HHmm');
                if(eventRecord.Subject.containsIgnoreCase('Discovery call')
                        || eventRecord.Subject.containsIgnoreCase('Advisory #1')
                        ||eventRecord.Subject.containsIgnoreCase('Advisory #2')){

                    //Create a record 1 for notification before 1 Day
                    SMS_Schedule__c  smsScheduleADayPriorRecord01 = new SMS_Schedule__c ();
                    smsScheduleADayPriorRecord01.Schedule_Date__c= eventRecord.StartDateTime.addDays(-1);
                    smsScheduleADayPriorRecord01.Message__c='1-800Accountant alert: A friendly reminder - your meeting with your advisor is tomorrow at '+ eventRecord.StartDateTime.format('MM/dd/yyyy @ h:mm a') + ' EDT. Reply STOP to end account alerts';
                    smsScheduleADayPriorRecord01.Object_Id__c = (String) eventRecord.WhoId;
                    smsScheduleADayPriorRecord01.Reference_Id__c = l.Name + '-' + eventDateTime;
                    smsScheduleADayPriorRecord01.To_Phone_Number__c = l.Phone;
                    smsScheduleADayPriorRecord01.Name =  l.Name+'_'+eventDateTime;
                    smsScheduleADayPriorRecord01.Lead__c = eventRecord.WhoId;
                    smsScheduleADayPriorRecord01.EventID__c = eventRecord.Id;
                    smsScheduleADayPriorRecord01.Status__c = 'Pending';
                    smsScheduleADayPriorRecord01.Priority__c = 3;
                    smsScheduleADayPriorRecord01.Type__c = 'Advisory Reminder';

                    System.debug(LoggingLevel.FINE, 'event record cp :: ' + (eventRecord.StartDateTime.getTime()-Datetime.now().getTime())/3600000);

                    if(eventRecord.StartDateTime.addDays(-1) > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleADayPriorRecord01);
                    }

                    //Create a record 2 for notification before 1 Day (After 1 min)
                    SMS_Schedule__c  smsScheduleADayPriorRecord02 = new SMS_Schedule__c ();
                    smsScheduleADayPriorRecord02.Schedule_Date__c = eventRecord.StartDateTime.addDays(-1).addMinutes(5);
                    smsScheduleADayPriorRecord02.Message__c = 'If possible, please be in front of a computer during our call and collect any relevant documents for review.';
                    smsScheduleADayPriorRecord02.Object_Id__c = (String) eventRecord.WhoId;
                    smsScheduleADayPriorRecord02.Reference_Id__c = l.Name+'-'+eventDateTime;
                    smsScheduleADayPriorRecord02.To_Phone_Number__c = l.Phone;
                    smsScheduleADayPriorRecord02.Name =  l.Name+'_'+eventDateTime;
                    smsScheduleADayPriorRecord02.Lead__c = eventRecord.WhoId;
                    smsScheduleADayPriorRecord02.EventID__c = eventRecord.Id;
                    smsScheduleADayPriorRecord02.Status__c = 'Pending';
                    smsScheduleADayPriorRecord02.Priority__c = 3;
                    smsScheduleADayPriorRecord02.Type__c = 'Advisory Reminder';


                    if(eventRecord.StartDateTime.addDays(-1) > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleADayPriorRecord02);
                    }

                    //Create a record for notification before 1 Hour
                    SMS_Schedule__c  smsScheduleAnHourPriorRecord = new SMS_Schedule__c ();
                    smsScheduleAnHourPriorRecord.Schedule_Date__c = eventRecord.StartDateTime.addHours(-1);
                    smsScheduleAnHourPriorRecord.Object_Id__c = (String)eventRecord.WhoId;
                    smsScheduleAnHourPriorRecord.Reference_Id__c = l.Name+'-'+eventDateTime;
                    smsScheduleAnHourPriorRecord.To_Phone_Number__c = l.Phone;
                    smsScheduleAnHourPriorRecord.Name =  l.Name+'_'+eventDateTime;
                    smsScheduleAnHourPriorRecord.Lead__c = eventRecord.WhoId;
                    smsScheduleAnHourPriorRecord.Message__c = '1-800Accountant alert: A friendly reminder - your meeting with your advisor is in one hour - '+ eventRecord.StartDateTime.format('MM/dd/yyyy @ h:mm a') + ' EDT. Reply STOP to end account alerts';
                    smsScheduleAnHourPriorRecord.EventID__c = eventRecord.Id;
                    smsScheduleAnHourPriorRecord.Status__c = 'Pending';
                    smsScheduleAnHourPriorRecord.Priority__c = 3;
                    smsScheduleAnHourPriorRecord.Type__c = 'Advisory Reminder';

                    if(eventRecord.StartDateTime.addHours(-1) > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleAnHourPriorRecord);
                    }

                }

                //for 1on1 Sales Appointment
                if(eventRecord.Subject.containsIgnoreCase('1on1 Sales Appointment')){


                    //Create a record 1 for notification before 1 Day
                    SMS_Schedule__c  smsScheduleADayPriorRecord01 = new SMS_Schedule__c ();
                    smsScheduleADayPriorRecord01.Schedule_Date__c = System.now().addMinutes(2);
                    smsScheduleADayPriorRecord01.Message__c = '1-800Accountant confirmation: You have a Tax Savings Analysis appointment with a tax expert on ' + eventRecord.Local_Start_Time__c + '. Reply STOP to stop tax savings msgs';
                    smsScheduleADayPriorRecord01.Object_Id__c = (String) eventRecord.WhoId;
                    smsScheduleADayPriorRecord01.Reference_Id__c = l.Name+'-'+eventDateTime;
                    smsScheduleADayPriorRecord01.To_Phone_Number__c = l.Phone;
                    smsScheduleADayPriorRecord01.Name =  l.Name+'_TSA_'+eventDateTime;
                    smsScheduleADayPriorRecord01.Lead__c = eventRecord.WhoId;
                    smsScheduleADayPriorRecord01.EventID__c = eventRecord.Id;
                    smsScheduleADayPriorRecord01.Status__c = 'Pending';
                    smsScheduleADayPriorRecord01.Priority__c = 3;
                    smsScheduleADayPriorRecord01.Type__c = 'TSA Reminder';

                    System.debug(LoggingLevel.FINE, 'event record info :: ' + (eventRecord.StartDateTime.getTime()-Datetime.now().getTime())/3600000);

                    if(eventRecord.StartDateTime > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleADayPriorRecord01);
                    }

                    //Create a record for notification before 1 Hour
                    SMS_Schedule__c  smsScheduleAnHourPriorRecord = new SMS_Schedule__c ();
                    smsScheduleAnHourPriorRecord.Schedule_Date__c = eventRecord.StartDateTime.addHours(-1);
                    smsScheduleAnHourPriorRecord.Object_Id__c = (String)eventRecord.WhoId;
                    smsScheduleAnHourPriorRecord.Reference_Id__c = l.Name+'-'+eventDateTime;
                    smsScheduleAnHourPriorRecord.To_Phone_Number__c = l.Phone;
                    smsScheduleAnHourPriorRecord.Name =  l.Name+'_TSA_'+eventDateTime;
                    smsScheduleAnHourPriorRecord.Lead__c = eventRecord.WhoId;
                    smsScheduleAnHourPriorRecord.Message__c = '1-800Accountant reminder: Your Tax Savings Analysis begins in 1 hour. We look forward to discussing your business taxes and important upcoming tax deadlines. If needed, reschedule here: http://1800accountant.com/sfapi/t/?w=' + eventRecord.WhoId + '&c=SMS-TSA Reply STOP to stop all tax msgs. Msg & Data Rates May Apply';
                    smsScheduleAnHourPriorRecord.EventID__c = eventRecord.Id;
                    smsScheduleAnHourPriorRecord.Status__c = 'Pending';
                    smsScheduleAnHourPriorRecord.Priority__c = 3;
                    smsScheduleAnHourPriorRecord.Type__c = 'TSA Reminder';

                    if(eventRecord.StartDateTime.addHours(-1) > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleAnHourPriorRecord);
                    }

                }

                //for Entity Formation Consultation
                if(eventRecord.Subject.containsIgnoreCase('Formation Consultation')){


                    //Create a record 1 for notification before 1 Day
                    SMS_Schedule__c  smsScheduleADayPriorRecord01 = new SMS_Schedule__c ();
                    smsScheduleADayPriorRecord01.Schedule_Date__c = System.now().addMinutes(2);
                    smsScheduleADayPriorRecord01.Message__c = '1-800Accountant confirmation: You have an Entity Formation Consultation on ' + eventRecord.StartDateTime.format('MM/dd/yyyy @ h:mm a') + ' EDT. Reply STOP to stop entity msgs';
                    smsScheduleADayPriorRecord01.Object_Id__c = (String) eventRecord.WhoId;
                    smsScheduleADayPriorRecord01.Reference_Id__c = l.Name+'-'+eventDateTime;
                    smsScheduleADayPriorRecord01.To_Phone_Number__c = l.Phone;
                    smsScheduleADayPriorRecord01.Name =  l.Name+'_EF_'+eventDateTime;
                    smsScheduleADayPriorRecord01.Lead__c = eventRecord.WhoId;
                    smsScheduleADayPriorRecord01.EventID__c = eventRecord.Id;
                    smsScheduleADayPriorRecord01.Status__c = 'Pending';
                    smsScheduleADayPriorRecord01.Priority__c = 3;
                    smsScheduleADayPriorRecord01.Type__c = 'EF Reminder';

                    System.debug(LoggingLevel.FINE, 'event record info :: ' + (eventRecord.StartDateTime.getTime()-Datetime.now().getTime())/3600000);

                    if(eventRecord.StartDateTime > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleADayPriorRecord01);
                    }

                    //Create a record for notification before 1 Hour
                    SMS_Schedule__c  smsScheduleAnHourPriorRecord = new SMS_Schedule__c ();
                    smsScheduleAnHourPriorRecord.Schedule_Date__c = eventRecord.StartDateTime.addHours(-1);
                    smsScheduleAnHourPriorRecord.Object_Id__c = (String)eventRecord.WhoId;
                    smsScheduleAnHourPriorRecord.Reference_Id__c = l.Name+'-'+eventDateTime;
                    smsScheduleAnHourPriorRecord.To_Phone_Number__c = l.Phone;
                    smsScheduleAnHourPriorRecord.Name =  l.Name+'_EF_'+eventDateTime;
                    smsScheduleAnHourPriorRecord.Lead__c = eventRecord.WhoId;
                    smsScheduleAnHourPriorRecord.Message__c = '1-800Accountant reminder: Your Entity Formation Consultation begins in 1 hour. We look forward to discussing your new business. If needed, reschedule here: http://1800accountant.com/sfapi/f/?w=' + eventRecord.WhoId + '&c=SMS-EF Reply STOP to stop all entity msgs. Msg & Data Rates May Apply';
                    smsScheduleAnHourPriorRecord.EventID__c = eventRecord.Id;
                    smsScheduleAnHourPriorRecord.Status__c = 'Pending';
                    smsScheduleAnHourPriorRecord.Priority__c = 3;
                    smsScheduleAnHourPriorRecord.Type__c = 'EF Reminder';

                    if(eventRecord.StartDateTime.addHours(-1) > System.now()){
                        smsScheduleRecordsToInsert.add(smsScheduleAnHourPriorRecord);
                    }
                }
            }
        }

        if(!smsScheduleRecordsToInsert.isEmpty()){
            System.debug(LoggingLevel.DEBUG,'insertion block :: ' + smsScheduleRecordsToInsert);
            List<Database.SaveResult> sResults = Database.insert(smsScheduleRecordsToInsert, false);
            for (Database.SaveResult sResult : sResults){
                if (!sResult.isSuccess()){
                    System.debug(sResult.getErrors().get(0).getMessage());
                }
            }
        }
    }

    public static void updateEmailCampaignId (List<Event> newEvents) {
        System.debug('EventTriggerHandler.updateEmailCampaignId()');
        // Filter for correct Events and map to Accounts, Leads, or Contacts
        Map<Id, List<Event>> eventsByWhatId = new Map<Id, List<Event>>();
        Map<Id, List<Event>> eventsByWhoId = new Map<Id, List<Event>>();
        for (Event event : newEvents) {
            if (event.Type_of_Appointment__c == 'Tax Savings Analysis'
                    && event.Email_Campaign_ID__c == null
                    ) {
                if (event.WhatId != null) {
                    if (!eventsByWhatId.containsKey(event.WhatId)) {
                        eventsByWhatId.put(event.WhatId, new List<Event>());
                    }
                    eventsByWhatId.get(event.WhatId).add(event);
                } else if (event.WhoId != null) {
                    if (!eventsByWhoId.containsKey(event.WhoId)) {
                        eventsByWhoId.put(event.WhoId, new List<Event>());
                    }
                    eventsByWhoId.get(event.WhoId).add(event);
                }
            }
        }

        // Query all Events related to Accounts
        for (Event event : [
                SELECT Id, Email_Campaign_ID__c, WhatId
                FROM Event WHERE WhatId IN :eventsByWhatId.keySet()
                AND Type_of_Appointment__c = 'Tax Savings Analysis'
                AND Email_Campaign_ID__c != NULL
                AND (NOT(Email_Campaign_ID__c LIKE '%Dialer%'))
                AND CreatedDate = LAST_N_DAYS:60
                ORDER BY CreatedDate DESC
        ]) {
            // Update all new events with the most recent Email_Campaign_ID__c found
            if (eventsByWhatId.containsKey(event.WhatId)) {
                for (Event newEvent : eventsByWhatId.get(event.WhatId)) {
                    if (newEvent.Email_Campaign_ID__c == null) {
                        newEvent.Email_Campaign_ID__c = event.Email_Campaign_ID__c;
                    }
                }
            }
        }

        // Query all Events related to Leads and Contacts
        for (Event event : [
                SELECT Id, Email_Campaign_ID__c, WhoId
                FROM Event WHERE WhoId IN :eventsByWhoId.keySet()
                AND Type_of_Appointment__c = 'Tax Savings Analysis'
                AND Email_Campaign_ID__c != NULL
                AND (NOT(Email_Campaign_ID__c LIKE '%Dialer%'))
                AND CreatedDate = LAST_N_DAYS:60
                ORDER BY CreatedDate DESC
        ]) {
            // Update all new events with the most recent Email_Campaign_ID__c found
            if (eventsByWhoId.containsKey(event.WhoId)) {
                for (Event newEvent : eventsByWhoId.get(event.WhoId)) {
                    if (newEvent.Email_Campaign_ID__c == null) {
                        newEvent.Email_Campaign_ID__c = event.Email_Campaign_ID__c;
                    }
                }
            }
        }
    }

    public static void updateInvoicePaymentAmount (List<Event> newEvents) {
        System.debug('EventTriggerHandler.updateInvoicePaymentAmount()');
        // Get all Account IDs
        List<Id> accountsToQuery = new List<Id>();
        for (Event event : newEvents) {
            if (event.AccountId != null) {
                accountsToQuery.add(event.AccountId);
            }
        }

        // Run function to update all relevant events on all accounts
        ChargeOverInvoiceTriggerHandler.triggerFromEventRecord(accountsToQuery);
        updateInvoiceRunOnce = true;
        return;
    }
}