/**
*   Overview: Test class for EventLeadSourceTrackingHelper
*   Author: Koby Campbell
*   Date: June 2021
*/

@IsTest
private class EventLeadSourceTrackingHelperTest{
    @IsTest
    private static void testEventLeadSourceTracking() {
        EventLeadSourceTrackingHelper batchJob = new EventLeadSourceTrackingHelper(30);
        batchJob.manualExecution();

        List<Event> testEvents = new List<Event>([
            SELECT Id, WhoId, Lead_Source__c, Distribute_Date__c
            FROM Event 
            WHERE Distribute_Date__c = N_DAYS_AGO:15
            AND Lead_Source__c = 'ZenBusiness'
        ]);

        System.assertEquals(10, testEvents.size(), 'Lead Source and Distribute Date Tracking Was Not Added to all Events');

    }

    @TestSetup
    private static void testSetup() {
        Test.startTest();
        Id profileId = [SELECT Id, Name FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id;

        User testUser = TestDataGenerator.createTestUser(profileId);
        insert testUser;

        List<Account> toInsertAccounts = new List<Account>();
        //Make 5 Accounts
        for(Integer i = 0; i < 5; i++) {
            Account account = TestDataGenerator.createTestAccountWithoutOwner();
            account.Lead_Source__c = 'ZenBusiness';
            toInsertAccounts.add(account);
        }
        insert toInsertAccounts;

        List<Lead> toInsertLeads = new List<Lead>();
        //Make 5 Leads
        for(Integer i = 0; i < 5; i++) {
            Lead lead = TestDataGenerator.createTestLead(testUser.Id);
            lead.LeadSource = 'ZenBusiness';
            toInsertLeads.add(lead);
        }
        insert toInsertLeads;

        List<Contact> toInsertContacts = new List<Contact>();
        //Make 5 Contacts
        for(Integer i = 0; i < 5; i++) {
            Contact contact = TestDataGenerator.createTestContact(toInsertAccounts[i]);
            contact.LeadSource = 'ZenBusiness';
            toInsertContacts.add(contact);
        }
        insert toInsertContacts;

        //Make 5 Events with Lead WhoIds
        List<Event> toInsertLEvents = new List<Event>();
        for(Integer i = 0; i < 5; i++) {
            Event event = TestDataGenerator.createTestEvent();
            event.WhoId = toInsertLeads[i].Id;
            toInsertLEvents.add(event);
        }
        insert toInsertLEvents;

        //Make 5 Events with Contact WhoIds
        List<Event> toInsertCEvents = new List<Event>();
        for(Integer i = 0; i < 5; i++) {
            Event event = TestDataGenerator.createTestEvent();
            event.WhoId = toInsertContacts[i].Id;
            toInsertCEvents.add(event);
        }
        insert toInsertCEvents;
        Test.stopTest();

    }
}