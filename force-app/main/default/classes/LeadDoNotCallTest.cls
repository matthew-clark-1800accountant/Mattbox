/**
*   Overview: Test class for LeadDoNotCall trigger
*   Author: Koby Campbell
*   Date: June 2021
*/


//deprecated on 2-9-23 by Matt Clark
@IsTest
private class LeadDoNotCallTest{
    // @IsTest
    // private static void testLeadSourceUpdate() {
    //     List<Lead> testLeads = new List<Lead>([
    //         SELECT Id, Status
    //         FROM Lead 
    //         WHERE Status = 'Do Not Call'
    //     ]);

    //     System.assertEquals(1, testLeads.size(), 'Lead Status was updated on insert');

    //     testLeads[0].Status = 'New';
    //     testLeads[0].of_Connected_Calls__c = 4;

    //     update testLeads[0];

    //     List<Lead> testUpdateLeads = new List<Lead>([
    //         SELECT Id, Status
    //         FROM Lead 
    //         WHERE Status = 'Do Not Call'
    //     ]);

    //     System.assertEquals(1, testUpdateLeads.size(), 'Lead Status was updated on update');
    // }

    // @TestSetup
    // private static void testSetup() {
    //     Id profileId = [SELECT Id, Name FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id;

    //     User testUser = TestDataGenerator.createTestUser(profileId);
    //     insert testUser;
    //     Lead lead = TestDataGenerator.createTestLead(testUser.Id);
    //     lead.LeadSource = 'ZenBusiness';
    //     lead.of_Connected_Calls__c = 3;
    //     insert lead;
    // }
}