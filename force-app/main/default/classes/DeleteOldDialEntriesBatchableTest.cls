@IsTest
public with sharing class DeleteOldDialEntriesBatchableTest {
    @TestSetup
    static void makeData(){
        NVMConnect__ProcessedDialEntry__c entry =  new NVMConnect__ProcessedDialEntry__c();
        
        insert entry;
        Test.setCreatedDate(entry.Id, Datetime.now().addDays(-61));
    }

    @IsTest 
    static void testDeleteBatch(){
        Test.startTest();
        Database.executeBatch(new DeleteOldDialEntriesBatchable(60), 200);
        Test.stopTest();
        System.assertEquals(0, [SELECT COUNT() FROM NVMConnect__ProcessedDialEntry__c]);
    }

    @IsTest 
    static void testSchedule(){
        Test.startTest();
        String jobId = System.schedule('testBasicScheduledApex', '20 30 8 10 2 ?', new DeleteOldDialEntriesBatchable(60));
        Test.stopTest();
        System.assertNotEquals(null, jobId);
    }
}