trigger CreateNoteEventTrigger on Create_Note__e (after insert) {
        
    CreateNoteEventTriggerHandler.afterInsert(Trigger.new);
}