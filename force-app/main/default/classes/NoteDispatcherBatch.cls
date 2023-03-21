public without sharing class NoteDispatcherBatch implements Schedulable, Database.Batchable<SObject>
{
    public void execute(SchedulableContext sc)
    {
        NoteDispatcherBatch ndb = new NoteDispatcherBatch();
        String cronStrHour = '0 00 * * * ?';
        String cronStrHalfHour = '0 30 * * * ?';
        String jobName = 'ProcessNoteDispatcherBatchHour';
        String jobName30 = 'ProcessNoteDispatcherBatchHalfHour';

        //Schedule the next job for next half hour.
        //Apex is funky so I need to attempt to set it for each hour manually. :30, and :00
        try
        {
            System.schedule(jobName, cronStrHour, ndb);
            System.debug('ProcessNoteDispatcherBatchHour scheduled....');
        } catch (Exception e)
        {
            System.debug('job already scheduled :: ' + e);
        }

        try
        {
            System.schedule(jobName30, cronStrHalfHour, ndb);
            System.debug('ProcessNoteDispatcherBatchHalfHour scheduled....');
        } catch (Exception e)
        {
            System.debug('job already scheduled :: ' + e);
        }

        //Run actual batch job for this run.
        Database.executeBatch(ndb);
    }

    private static Datetime afterTime = System.now().addMinutes(-30);
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        System.debug('NoteDispatcherBatch start method...');
        //Validate it is marked as latest AND was modified within the last 30 minutes.

        return Database.getQueryLocator([
                SELECT Id, ContentDocumentId, SystemModstamp
                FROM ContentVersion
                WHERE IsLatest = TRUE AND SystemModstamp > :afterTime AND IsLatest = TRUE]);
    }

    public void execute(Database.BatchableContext bc, ContentVersion[] records)
    {
        System.debug('NoteDispatcherBatch.execute () records :: ' + records);
        noteDispatcherForOutboundMessage(records);
    }

    public void finish(Database.BatchableContext bc)
    {
    }

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