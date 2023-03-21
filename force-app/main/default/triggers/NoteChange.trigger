trigger NoteChange on Note (after insert, after update) {
    List<NoteDispatcher__c> notesEvents = new List<NoteDispatcher__c>();

    for(Note n : Trigger.new)
    {
        notesEvents.add(new NoteDispatcher__c(NoteID__c = n.Id, Pending__c = true,SObject__c='Note'));
    }

    insert notesEvents;
}