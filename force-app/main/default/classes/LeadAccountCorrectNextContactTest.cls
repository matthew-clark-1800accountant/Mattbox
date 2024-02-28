/**
*   Overview: Test class for AccountCorrectNextContact & LeadCorrectNextContact
*   Author: Koby Campbell
*   Date: April 2021
*/
@isTest
private class LeadAccountCorrectNextContactTest{  
    @IsTest
    private static void testUpdateNextContact() {
        //Asserting that no leads or accounts exist in the test database with the incorrect year for Next Contact Time
        Datetime badDate = datetime.newInstance(4000, 12, 1);
        List<Lead> testUpdateLead = [SELECT Id, Name, NVMConnect__NextContactTime__c FROM Lead WHERE NVMConnect__NextContactTime__c = :badDate];
        System.assertEquals(true, testUpdateLead.isEmpty());

        List<Account> testAccount = [SELECT Id, Name, NextContactTime__c FROM Account WHERE NextContactTime__c = :badDate];
        System.assertEquals(true, testAccount.isEmpty());
    }

    @TestSetup
    private static void testSetup() {
        User sdrQueue = [SELECT Id FROM User WHERE Name = 'SDR Queue' LIMIT 1];

        Id profileId = [SELECT Id, Name FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id;
        User testUser = TestDataGenerator.createTestUser(profileId);
        insert testUser;
        //Creating Lead & Account with an invalid date year 4000
        Datetime badDate = datetime.newInstance(4000, 12, 1);
        Lead lead = TestDataGenerator.createTestLead(testUser.Id);
        lead.NVMConnect__NextContactTime__c = badDate;
        insert lead;

        Account account = TestDataGenerator.createTestAccountWithoutOwner();
        account.NextContactTime__c = badDate;
        insert account;

        //Datetime badDate = datetime.newInstance(4000, 12, 1);
        lead = TestDataGenerator.createTestLead(sdrQueue.Id);
        lead.NVMConnect__NextContactTime__c = badDate;
        lead.Distribute_Date__c = Date.today();
        lead.Status = 'Attempted';
        //lead.Dialer_Tier__c = 'Tier 1';
        lead.LeadSource = 'Inc. Authority';
        insert lead;

        account = TestDataGenerator.createTestAccountWithoutOwner();
        account.NextContactTime__c = badDate;
        account.OwnerId = sdrQueue.Id;
        account.Distribute_Date__c = Date.today();
        account.Lead_Status__c = 'Attempted';
        //account.Dialer_Tier__c = 'Tier 1';
        account.Lead_Source__c = 'Inc. Authority';
        insert account;
    }
     
}