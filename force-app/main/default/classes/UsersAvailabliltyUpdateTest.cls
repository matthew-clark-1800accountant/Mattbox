/**
*   Overview: Test class for UsersAvailabilityUpdate
*   Author: Koby Campbell
*   Date: June 2021
*/

@IsTest
private class UsersAvailabliltyUpdateTest{
    @IsTest
    private static void testUserUpdate() {
        UsersAvailabilityUpdate batchJob = new UsersAvailabilityUpdate();
        batchJob.manualExecution();

        List<User> testUser = new List<User>([
            SELECT Id, Scheduler_Availability__c, AboutMe
            FROM User
            WHERE Scheduler_Availability__c = 'Unavailable'
            //Make sure I'm getting the one I inserted
            AND AboutMe = 'Test'

        ]);
        
        System.assertEquals(1, testUser.size(), 'InsideSalesUser - Zuora Users scheduler availablilty was not changed');
    }

    @TestSetup
    private static void testSetup() {
        Id profileId = [SELECT Id, Name FROM Profile WHERE Name = 'InsideSalesUser - Zuora' LIMIT 1].Id;

        User testUser = TestDataGenerator.createTestUser(profileId);
        testUser.Scheduler_Availability__c = 'Available';
        //Add an attribute for tracking
        testUser.AboutMe = 'Test';

        insert testUser;
    }
}