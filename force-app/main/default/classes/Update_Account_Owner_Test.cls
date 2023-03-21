@isTest
private class Update_Account_Owner_Test{  
    @IsTest
    private static void testUpdateAccountOwnerToQueue() {
        Lead_Reassignment_Queue__mdt queueMetadata = [
            SELECT Id, MasterLabel, Queue_Object_Type__c, Reassignment_Queue_Name__c 
            FROM Lead_Reassignment_Queue__mdt 
            WHERE Queue_Type__c = 'General Lead Queue' 
            LIMIT 1
        ];
        String m_query = 'SELECT Id FROM '+ queueMetadata.Queue_Object_Type__c +' WHERE Name = \''+queueMetadata.Reassignment_Queue_Name__c+'\' LIMIT 1';
        Id queueId = Database.query(m_query).Id;

        //first time through with default Unpitched Accounts query
        Update_Account_Owner_to_Lead_Queue batchJob = new Update_Account_Owner_to_Lead_Queue();
        batchJob.setAccounts();
        batchJob.manualExecution();

        //second time through with Partner Accounts query
        batchJob.establishQuery('Tier 1 - Pitched (Account)');
        batchJob.setAccounts();
        batchJob.manualExecution();

        //third time through with Pitched Accounts query
        batchJob.establishQuery('Tier 1 - Unpitched (Account)');
        batchJob.setAccounts();
        batchJob.manualExecution();

        List<Account> testPartnerAccounts = [SELECT Id, OwnerId FROM Account WHERE OwnerId = :queueId AND Lead_Source__c != 'Bark'];
        System.assertEquals(false, testPartnerAccounts.isEmpty(), 'No Partner Accounts had the Owner Reassigned');
        System.assertEquals(5, testPartnerAccounts.size(), 'All Partner Accounts should be converted');

        List<Account> testPitchedBarkLeads = [SELECT Id, OwnerId FROM Account WHERE OwnerId = :queueId AND Lead_Source__c = 'Bark' AND X1_1_Scheduled__c != null];
        System.assertEquals(false, testPitchedBarkLeads.isEmpty(), 'No Pitched Bark Accounts had the Owner Reassigned');
        System.assertEquals(5, testPitchedBarkLeads.size(), 'All Pitched Bark Accounts should be converted');

        List<Account> testUnpitchedBarkLeads = [SELECT Id, OwnerId FROM Account WHERE OwnerId = :queueId AND Lead_Source__c = 'Bark' AND X1_1_Scheduled__c = null];                                           
        System.assertEquals(false, testUnpitchedBarkLeads.isEmpty(), 'No Unpitched Bark Accounts had the Owner Reassigned');
        System.assertEquals(5, testUnpitchedBarkLeads.size(), 'All Unpitched Bark Accounts should be converted');

        Test.startTest();
        Update_Account_Owner_to_Lead_Queue batchJob2 = new Update_Account_Owner_to_Lead_Queue();
        Database.executeBatch(batchJob2, 1);
        Test.stopTest();
    }

    @TestSetup
    private static void testSetup() {
        Id profileId = [SELECT Id, Name FROM Profile WHERE Name = 'Sales Manager' LIMIT 1].Id;

        User testUser = TestDataGenerator.createTestUser(profileId);
        insert testUser;

        List<Account> toInsertAccounts = new List<Account>();
        //Make 5 Partner Accounts
        for (Integer i = 0; i < 5; i++) {
            Account account = TestDataGenerator.createTestAccount(testUser.Id);
            account.Account_Status__c = 'No Sale';
            toInsertAccounts.add(account);
        }

        //Make 5 Unpitched Bark Accounts
        for (Integer i = 0; i < 5; i++) {
            Account account = TestDataGenerator.createTestAccount(testUser.Id);
            account.Lead_Source__c = 'Bark';
            account.Pitched_Date__c = null;
            account.Account_Status__c = 'No Sale';
            toInsertAccounts.add(account);
        }

        //Make 5 Pitched Bark Accounts
        for (Integer i = 0; i < 5; i++) {
            Account account = TestDataGenerator.createTestAccount(testUser.Id);
            account.Lead_Source__c = 'Bark';
            account.Account_Status__c = 'No Sale';
            account.X1_1_Scheduled__c = Date.today().addDays(-1);
            toInsertAccounts.add(account);
        }
        insert toInsertAccounts;
    }
     
}