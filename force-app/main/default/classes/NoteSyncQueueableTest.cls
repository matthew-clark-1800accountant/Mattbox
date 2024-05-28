@IsTest
public with sharing class NoteSyncQueueableTest {
    @TestSetup
    static void makeData(){
        Account acc = new Account(Name='test account');
        insert acc;
        
        User u = [SELECT Id FROM User WHERE Profile.Name = 'System Admin' AND IsActive = true LIMIT 1];
        
        ContentVersion cv = new ContentVersion();
        String title = 'title';  
        cv.VersionData =Blob.valueOf('body');
        cv.PathOnClient= 'Test Sales Notes'+'.snote'; //<your file title>.snote 
        cv.OwnerId = u.Id;
        cv.FirstPublishLocationId = acc.Id;
        insert cv;

    }

    @isTest 
    static void testQueueable(){
        Test.startTest();
        System.enqueueJob(new NoteSyncQueueable(Date.today().addDays(-1), 2, 0, 2));
        Test.stopTest();
    }
}