public without sharing class NoteSyncQueueable implements Queueable {
    private Date startDate = Date.today();
    private Integer batchSize = 50;
    private Integer offset = 0;
    private Integer minuteDelay = 2;

    public NoteSyncQueueable(Date startDate, Integer batchSize, Integer offset, Integer minuteDelay) {
        this.startDate = startDate;
        this.batchSize = batchSize;
        this.offset = offset;
        this.minuteDelay = minuteDelay;
    }

    public void execute(System.QueueableContext qc){
        Datetime now = Datetime.now();
        
        List<ContentVersion> notes = [SELECT Id, ContentDocumentId, SystemModstamp FROM ContentVersion 
            WHERE IsLatest = TRUE AND SystemModstamp > :this.startDate AND IsLatest = TRUE LIMIT :this.batchSize OFFSET :this.offset];
        Set<Id> noteIds = new Map<Id, ContentVersion>(notes).keySet();

        //check for duplicates
        List<NoteDispatcher__c> dispatchers = [SELECT Id FROM NoteDispatcher__c WHERE ContentVersionId__c IN :noteIds];
        for(NoteDispatcher__c disp : dispatchers){
            noteIds.remove(disp.ContentVersionId__c);
        }
        notes = [SELECT Id, ContentDocumentId, SystemModstamp FROM ContentVersion WHERE Id IN :noteIds];

        if(notes.isEmpty()){
            return;
        }
        //run existing logic
        noteDispatcherForOutboundMessage(notes);

        //chain next job
        // if(now.minute() == 0 || now.minute() == 30){
        //     //change offset?
        // }
        if(!Test.isRunningTest()){
            System.enqueueJob(new NoteSyncQueueable(this.startDate, this.batchSize, this.offset+this.batchSize, this.minuteDelay), this.minuteDelay);
        }
        
    }

    //copied from NoteDispatcherBatch
    private static void noteDispatcherForOutboundMessage(ContentVersion[] records)
    {
        System.debug(LoggingLevel.FINEST, 'NoteDispatcherBatch.noteDispatcherForOutboundMessage.records :: ' + records);

        Set<Id> contentDocIds = new Set<Id>();
        for(ContentVersion ver : records)
        {
            contentDocIds.add(ver.ContentDocumentId);
        }
        System.debug(LoggingLevel.DEBUG, 'contentDocIds :: ' + contentDocIds);

        //We'll query against all ContentVersion's related to this ContentDocumentId, not just the ones
        //that are included with our trigger. If a related ContentVersion has a DateValidation__c greater than
        //the last 20 seconds, we do not create a new outbound message. -SReyes

        //This one should be a good use case for DMLUtility, because these are outbound messages which can
        //be triggered asynchronously. -SReyes
        NoteDispatcher__c[] toInsert = new NoteDispatcher__c[0];
        for(ContentVersion ver : records)
        {
            toInsert.add(new NoteDispatcher__c(Pending__c=true,SObject__c='ContentVersion',ContentVersionId__c=ver.Id));
        }
        System.debug(LoggingLevel.FINER, 'toInsert :: ' + toInsert);

        //Insert new records, DMLUtility has built in error handling. Process using execute method directly.
        new DMLUtility(toInsert, DMLUtility.DMLType.INSERTS, 'NoteDispatcherBatch.noteDispatcherForOutboundMessage insert job...').execute(null);
        System.debug(LoggingLevel.FINE, 'dmlJob executed... moving on...');

    }
}