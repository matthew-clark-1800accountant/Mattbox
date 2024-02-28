public without sharing class BackfillEventUpdatesBatchable implements Database.batchable<sObject>{

    public Integer limitSizeInt = null;
    public BackfillEventUpdatesBatchable(Integer limitSize) {
        System.debug('BackfillEventUpdatesBatchable()');
        limitSizeInt = limitSize;
    }

    public Database.QueryLocator start(Database.BatchableContext BC){
        System.debug('start()');
        String query = 'SELECT Id, CreatedDate, Event_History__r.Id FROM Event_Field_Update__c WHERE CreatedDate = LAST_90_DAYS';
        if(limitSizeInt != null){
            query += ' LIMIT '+limitSizeInt;
        }
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<Event_Field_Update__c> scope){        
        System.debug('execute');
        System.debug(scope);
        Map<Id, List<Event_Field_Update__c>> historyIdToUpdates = new Map<Id, List<Event_Field_Update__c>>();
        //Map<Event, List<Event_Field_Update__c>> eventToUpdates = new Map<Event,  List<Event_Field_Update__c>>();
        List<Event_Field_Update__c> updatesToUpdate = new List<Event_Field_Update__c>();
        for(Event_Field_Update__c up : scope){
            if(!historyIdToUpdates.containsKey(up.Event_History__r.Id)){
                historyIdToUpdates.put(up.Event_History__r.Id, new List<Event_Field_Update__c>{up});
            } else {
                historyIdToUpdates.get(up.Event_History__r.Id).add(up);
            }
        }
        List<Event> eventList = [SELECT Id, StartDateTime, EndDateTime, Event_History__r.Id FROM Event WHERE Event_History__r.Id IN :historyIdToUpdates.keySet()];
        
        System.debug(eventList);
        for(Event ev : eventList){
            for(Event_Field_Update__c up : historyIdToUpdates.get(ev.Event_History__r.Id)){
                if(up.CreatedDate > ev.startDateTime.addMinutes(-15) && up.CreatedDate < ev.EndDateTime){
                    up.Update_made_in_change_window__c = true;
                } else {
                    up.Update_made_in_change_window__c = false;
                }
                updatesToUpdate.add(up);
            }           
        }
        update updatesToUpdate;
    }

    public void finish(Database.BatchableContext BC){
        System.debug('finish');
    }
}