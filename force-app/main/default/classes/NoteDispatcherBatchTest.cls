@IsTest
public with sharing class NoteDispatcherBatchTest
{
    @TestSetup
    private static void testData()
    {
        ContentVersion ver = new ContentVersion(Title='TestCV',ContentUrl='https://test.com/drop');
        insert ver;

    }

    @IsTest
    private static void testSchedulableBatch()
    {
        Test.startTest();
            NoteDispatcherBatch job = new NoteDispatcherBatch();
            job.execute(null);
        Test.stopTest();
    }

    @IsTest
    private static void testBatchJob()
    {
        System.debug(System.now().addMinutes(-30));
        ContentVersion[] versions = [SELECT Id, IsLatest,SystemModstamp,ContentDocumentId FROM ContentVersion LIMIT 1];

        Test.startTest();
            NoteDispatcherBatch job = new NoteDispatcherBatch();
            job.start(null);
            job.execute(null, versions);
            job.finish(null);
        Test.stopTest();

        NoteDispatcher__c ndc = [SELECT Id, ContentVersionId__c, SObject__c FROM NoteDispatcher__c LIMIT 1];
        System.assertEquals(versions[0].Id,ndc.ContentVersionId__c, 'NoteDispatcher__c.ContentVersionId__c record should match trigger record Id.');
    }
}