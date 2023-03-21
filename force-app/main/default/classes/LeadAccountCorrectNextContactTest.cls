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
    }
     
}