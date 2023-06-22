/**
 * Created by SReyes on 8/6/2020.
 */

 public with sharing class ChargeOverInvoiceTriggerHandler
 {
     private static Boolean runOne = false;
     public static void doBeforeTrigger(ChargeOver_Invoice__c[] triggerNew, Map<Id, ChargeOver_Invoice__c> oldMap, Boolean isInsert, Boolean isUpdate)
     {
 //        if(isInsert) {}
 //        if(isUpdate) {}
     }
 
     public static void doAfterTrigger(ChargeOver_Invoice__c[] triggerNew, Map<Id, ChargeOver_Invoice__c> newMap, Boolean isInsert, Boolean isUpdate, Boolean isDelete)
     {
 //        if(isInsert) {}
 //        if(isUpdate) {}
 //        if(isDelete) {}
         if(isInsert || isUpdate)
         {
             populateEventWithAggregatedAmount(triggerNew, null);
         }
     }
 
     public static void triggerFromEventRecord(Id[] ids)
     {
         populateEventWithAggregatedAmount(null, ids);
     }
 
     private static void populateEventWithAggregatedAmount(ChargeOver_Invoice__c[] triggerNew, Id[] ids)
     {
         System.debug('trigger size: '+triggerNew?.size());
         System.debug('id[] size: '+ids?.size());
         Set<Id> accountIds = new Set<Id>();
         if(null != triggerNew)
         {
             for(ChargeOver_Invoice__c invoice : triggerNew){ accountIds.add(invoice.Account__c); }
         } else { accountIds.addAll(ids); }
         System.debug(accountIds);
         Map<Id, Event[]> accountIdEventMap = new Map<Id, Event[]>();
         Set<Id> eventIds = new Set<Id>();
         for (Event evt : [
             SELECT Id, ActivityDate, AccountId
             FROM Event
             WHERE Account__c IN :accountIds
             AND (Secondary_Disposition_Details__c = 'Sale'
             OR Secondary_Disposition_Details__c = 'Follow-Up')
             AND AccountId IN :accountIds
             ORDER BY ActivityDate DESC
         ]){
             eventIds.add(evt.Id);
         }
 
         //Set<Id> eventIds = new Map<Id, Event>(eventList).keySet();
         Map<Id, UserRecordAccess> eventIdToRecordAccess = new Map<Id, UserRecordAccess>();
         for(UserRecordAccess acc : [SELECT RecordId, HasReadAccess, HasEditAccess, MaxAccessLevel
         FROM UserRecordAccess
         WHERE UserId = :UserInfo.getUserId()
         AND RecordId IN :eventIds]){
             eventIdToRecordAccess.put(acc.RecordId, acc);
         }
         System.debug(eventIdToRecordAccess);
         for (Event evt : [
             SELECT Id, ActivityDate, AccountId
             FROM Event
             WHERE Account__c IN :accountIds
             AND (Secondary_Disposition_Details__c = 'Sale'
             OR Secondary_Disposition_Details__c = 'Follow-Up')
             AND AccountId IN :accountIds
             ORDER BY ActivityDate DESC
         ])
         {
             if(eventIdToRecordAccess.containsKey(evt.Id) && eventIdToRecordAccess.get(evt.Id).HasEditAccess){
                 if(accountIdEventMap.containsKey(evt.AccountId)){ accountIdEventMap.get(evt.AccountId).add(evt);}
                 else { accountIdEventMap.put(evt.AccountId, new Event[]{evt}); }
             }            
         }
         System.debug(LoggingLevel.DEBUG, 'accountIdEventMap returned with a map size of :: ' + accountIdEventMap.size());
         for(Id actId : accountIdEventMap.keySet()){
             System.debug(accountIdEventMap.get(actId));
         }
         Event[] eventsToUpdate = new Event[0];
         for (Account[] actList : [
                 SELECT Id, (SELECT CreatedDate, Total__c
                 FROM ChargeOver_Invoices__r WHERE Total__c != NULL)
                 FROM Account WHERE Id IN :accountIds ORDER BY CreatedDate DESC
         ])
         {
             for(Account act : actList){
                 System.debug('act :: ' + act);
                 if(accountIdEventMap.containsKey(act.Id) && !act.ChargeOver_Invoices__r.isEmpty() && act.ChargeOver_Invoices__r.size() > 0)
                 {
                     Decimal chargeOverInvoiceTotal = 0;
                     for(Event evt : accountIdEventMap.get(act.Id))
                     {
                         Boolean eventChanged = false;
                         for(ChargeOver_Invoice__c coi : act.ChargeOver_Invoices__r)
                         {
                             if(evt.ActivityDate <= coi.CreatedDate && evt.ActivityDate.addDays(365) > coi.CreatedDate)
                             {
                                 System.debug(LoggingLevel.DEBUG, 'updating value... ' + coi.Total__c);
                                 eventChanged = true;
                                 chargeOverInvoiceTotal = chargeOverInvoiceTotal + coi.Total__c;
                             }
                         }
                         if(eventChanged)
                         {
                             System.debug(LoggingLevel.FINER, 'eventChanged :: ' + eventChanged);
                             evt.Invoice_Payment_Amount__c = chargeOverInvoiceTotal;
                             eventsToUpdate.add(evt);
                         }
                     }
                 }
             }
             
         }
 
         System.debug(LoggingLevel.FINE, 'eventsToUpdate :: ' + eventsToUpdate);
         if(eventsToUpdate.size() > 0 || !runOne)
         {
             runOne = true;
             update eventsToUpdate;
         }
 
 
     }
 }