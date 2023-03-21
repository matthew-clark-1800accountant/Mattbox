/** Created by Samuel Reyes 7/30/20 **/
global with sharing class NoteDispatcherRemoverBatch implements Database.Batchable<SObject>, Schedulable
{

    //Scheduleable execute method to enable declarative scheduling of batch job.
    global static void execute(SchedulableContext sc)
    {
        NoteDispatcherRemoverBatch job = new NoteDispatcherRemoverBatch();
        Database.executeBatch(job);
    }

    /**
     * As of 7/30/20 23:55 this is untested per Drew asking me to hold off on him doing
     * some DataLoader tests first to mimic behavior of this class. -SReyes
     */

    private static Date DATE_LIMIT = Date.today().addDays(-7);

    public Database.QueryLocator start(Database.BatchableContext context)
    {
        return Database.getQueryLocator([SELECT Id, CreatedDate FROM NoteDispatcher__c]);
    }

    public void execute(Database.BatchableContext context, NoteDispatcher__c[] records)
    {
        Id[] toDelete = new Id[0];
        for(NoteDispatcher__c noteDispatcher : records)
        {
            if(noteDispatcher.CreatedDate < DATE_LIMIT){ toDelete.add(noteDispatcher.Id); }
        }
        new DMLUtility(toDelete,'NoteDispatcherRemoverBatch').execute(null);
    }

    public void finish(Database.BatchableContext context) {}

}