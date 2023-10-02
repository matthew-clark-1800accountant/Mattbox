@IsTest
public with sharing class DeleteCalendarBlocksBatchableTest {
    @TestSetup
    static void makeData(){
        Id currentUserId = UserInfo.getUserId();

        Event tsa = new Event(
            Subject='Tax Consultation', 
            Type_of_Appointment__c='Tax Savings Analysis',
            StartDateTime=Datetime.now().addHours(1),
            EndDateTime=Datetime.now().addHours(2),        
            OwnerId = currentUserId
        );

        Event block = new Event(
            Subject='Tax Consultation', 
            Type_of_Appointment__c='Calendar Block',
            StartDateTime=Datetime.now().addHours(1),
            EndDateTime=Datetime.now().addHours(2),        
            OwnerId = currentUserId
        );

        insert new List<Event>{tsa, block};

        }

    @isTest static void deleteBlocks(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Test.startTest();
        // DeleteCalendarBlocksBatchable bat = new DeleteCalendarBlocksBatchable(new List<Id>{UserInfo.getUserId()});
        // Database.executeBatch(bat);
        DeleteCalendarBlocksBatchable.startBatch(new List<List<Id>>{new List<Id>{UserInfo.getUserId()}});
        Test.stopTest();
        Integer count = [SELECT COUNT() FROM Event];
        System.assertEquals(1, count);
    }
}