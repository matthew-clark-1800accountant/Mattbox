@isTest
public class FeedCommentTriggerHandlerTest {
	static testMethod void testUpdate(){
        Profile salesManagerProfile = [SELECT Id FROM Profile WHERE Name = 'Sales Manager'];
        User testSalesManager = new User(
            FirstName = 'Test',
            LastName = 'SalesManager',
            email = 'testsalesmanager@test.com',
            Username = 'testusernamesm@test.com',
            Alias = 'tsm',
            ProfileId = salesManagerProfile.Id,
            Sales_Team__c = 'Test team',
			EmailEncodingKey ='ISO-8859-1',
			LanguageLocaleKey = 'en_US',
			LocaleSidKey = 'en_US',
			TimeZoneSidKey = 'America/Los_Angeles'
        );
        insert testSalesManager;
        
        Case testCase = new Case(Subject = 'Test Case',RecordTypeId = '012f1000001163mAAA');
        insert testCase;
        
        FeedItem testFeedItem = new FeedItem(ParentId = testCase.Id, Body = 'Test FeedItem Body');
        insert testFeedItem;
        
        FeedComment testComment = new FeedComment(FeedItemId = testFeedItem.Id , CommentBody = 'Test FeedComment Body');
        System.runAs(testSalesManager){
            // Invoke the trigger by inserting the FeedComment
            Test.startTest();
            insert testComment;
            Test.stopTest();
        }
        
        // Verify that the Case was updated
        Case updatedCase = [SELECT Id, Manager_Response_Date__c FROM Case WHERE Id =: testCase.Id];
        System.assertNotEquals(null, updatedCase.Manager_Response_Date__c, 'Manager Response Date field is populated');
    }
}