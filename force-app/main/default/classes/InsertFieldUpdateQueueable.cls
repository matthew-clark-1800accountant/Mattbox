//Matt Clark - 12/2/22
//Simple queueable class to create records for Event field update tracking

public without sharing class InsertFieldUpdateQueueable implements Queueable{
    private Map<Event_Field_Update__c, Event> updates;
    
    public InsertFieldUpdateQueueable(Map<Event_Field_Update__c, Event> fieldUpdates){
        this.updates = fieldUpdates;
    }
    
    public void execute(System.QueueableContext qc){
        System.debug('Starting insertFieldUpdate()');        
        Map<Event_Field_Update__c, Event> fieldUpdates = this.updates;
        System.debug(fieldUpdates);
        List<Event> eventsToUpdate = new List<Event>();
        for(Event updatedEvent : new Set<Event>(fieldUpdates.values())){
            if(updatedEvent.Event_History__c == null){
                Event_History__c history = new Event_History__c();
                insert history;
                System.debug('history: '+history);
                //updatedEvent.Event_History__c = history.Id;
                eventsToUpdate.add(new Event(Id = updatedEvent.Id, Event_History__c = history.Id));
               }
        }
        if(!eventsToUpdate.isEmpty()){
            System.debug('eventsToUpdate: '+eventsToUpdate);
            update eventsToUpdate;
        }
        Map<Id, Event> eventsToUpdateMap = new Map<Id, Event>(eventsToUpdate);
        for(Event_Field_Update__c fieldUpdate : fieldUpdates.keySet()){
            Event updatedEvent = fieldUpdates.get(fieldUpdate);
            if(updatedEvent.Event_History__c == null){
                fieldUpdate.Event_History__c = 
                eventsToUpdateMap.get(updatedEvent.Id)
                .Event_History__c;
            } else {
                fieldUpdate.Event_History__c = updatedEvent.Event_History__c;
            }
            System.debug('fieldUpdate: '+fieldUpdate);
        }
        insert new List<Event_Field_Update__c>(fieldUpdates.keySet());
    }


}