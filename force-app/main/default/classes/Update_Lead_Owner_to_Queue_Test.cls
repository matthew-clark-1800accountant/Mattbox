/**
*   Overview: Test class for Update_Lead_Owner_to_Queue
*   Author: Koby Campbell
*   Date: April 2021
*/

@IsTest
private class Update_Lead_Owner_to_Queue_Test{
    @IsTest
    private static void testUpdateLeadOwnerToQueue() {
        Lead_Reassignment_Queue__mdt queueMetadata = [
            SELECT Id, MasterLabel, Queue_Object_Type__c, Reassignment_Queue_Name__c 
            FROM Lead_Reassignment_Queue__mdt 
            WHERE Queue_Type__c = 'General Lead Queue' 
            LIMIT 1
        ];
        String m_query = 'SELECT Id FROM '+ queueMetadata.Queue_Object_Type__c +' WHERE Name = \''+queueMetadata.Reassignment_Queue_Name__c+'\' LIMIT 1';
        Id queueId = Database.query(m_query).Id;

        //first time through with default query
        Update_Lead_Owner_to_Queue batchJob = new Update_Lead_Owner_to_Queue();
        batchJob.setLeads();
        batchJob.manualExecution();

        //second time through with Partner Leads query
        batchJob.establishQuery('Tier 1 (Lead)');
        batchJob.setLeads();
        batchJob.manualExecution();

        List<Lead> testPartnerLeads = [SELECT Id, OwnerId FROM Lead WHERE LeadSource != 'Bark'];

        System.assertEquals(queueId, testPartnerLeads[0].OwnerId, 'OwnerId should match queueId.');
        System.assertEquals(5, testPartnerLeads.size(), 'All Partner Leads should be converted');

        List<Lead> testBarkLeads = [SELECT Id, OwnerId FROM Lead WHERE OwnerId = :queueId AND LeadSource = 'Bark'];
        System.assertEquals(queueId, testBarkLeads[0].OwnerId, 'OwnerId should match queueId.');
        System.assertEquals(5, testBarkLeads.size(), 'All Bark Leads should be converted');

        Test.startTest();
        Update_Lead_Owner_to_Queue batchJob2 = new Update_Lead_Owner_to_Queue();
        Database.executeBatch(batchJob2, 1);
        Test.stopTest();
    }

    @TestSetup
    private static void testSetup() {
        Id profileId = [SELECT Id, Name FROM Profile WHERE Name = 'Sales Manager' LIMIT 1].Id;

        User testUser = TestDataGenerator.createTestUser(profileId);
        insert testUser;

        List<Lead> toInsertLeads = new List<Lead>();
        //Make 5 Partner Leads
        for (Integer i = 0; i < 5; i++) {
            Lead lead = TestDataGenerator.createTestLead(testUser.Id);
            toInsertLeads.add(lead);
        }
        //Make 5 Bark Leads
        for (Integer i = 0; i < 5; i++) {
            Lead lead = TestDataGenerator.createTestLead(testUser.Id);
            lead.LeadSource = 'Bark';
            toInsertLeads.add(lead);
        }
        insert toInsertLeads;
    }
}