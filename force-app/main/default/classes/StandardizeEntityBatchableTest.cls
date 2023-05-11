@isTest
public with sharing class StandardizeEntityBatchableTest {
    @TestSetup
    static void makeData(){
        User u = [SELECT Id FROM User WHERE Name = 'Matthew Clark' LIMIT 1];
        List<Lead> testLeads = new List<Lead>();
        testLeads.add(new Lead(
            FirstName='Test', OwnerId = u.Id, Status='New', Lead_Type_New__c='1-800Accountant', LastName='Test', Email='test@test.com', Phone='5555555555', Company='Test',
            Entity_Tax_Classification__c='C'
        ));
        testLeads.add(new Lead(
            FirstName='Test', OwnerId = u.Id, Status='New', Lead_Type_New__c='1-800Accountant', LastName='Test', Email='test@test.com', Phone='5555555555', Company='Test',
            Entity_Tax_Classification__c='DBA'
        ));
        testLeads.add(new Lead(
            FirstName='Test', OwnerId = u.Id, Status='New', Lead_Type_New__c='1-800Accountant', LastName='Test', Email='test@test.com', Phone='5555555555', Company='Test',
            Entity_Tax_Classification__c='PLLC'
        ));
        testLeads.add(new Lead(
            FirstName='Test', OwnerId = u.Id, Status='New', Lead_Type_New__c='1-800Accountant', LastName='Test', Email='test@test.com', Phone='5555555555', Company='Test',
            Entity_Tax_Classification__c='NON'
        ));
        testLeads.add(new Lead(
            FirstName='Test', OwnerId = u.Id, Status='New', Lead_Type_New__c='1-800Accountant', LastName='Test', Email='test@test.com', Phone='5555555555', Company='Test',
            Entity_Tax_Classification__c='LP'
        ));
        testLeads.add(new Lead(
            FirstName='Test', OwnerId = u.Id, Status='New', Lead_Type_New__c='1-800Accountant', LastName='Test', Email='test@test.com', Phone='5555555555', Company='Test',
            Entity_Tax_Classification__c='S'
        ));
        testLeads.add(new Lead(
            FirstName='Test', OwnerId = u.Id, Status='New', Lead_Type_New__c='1-800Accountant', LastName='Test', Email='test@test.com', Phone='5555555555', Company='Test',
            Entity_Tax_Classification__c='NA'
        ));
        insert testLeads;


        List<Account> testAccounts = new List<Account>();
        testAccounts.add(new Account(
            Name='Test',
            Entity_Tax_Classification__c='C'
        ));
        testAccounts.add(new Account(
            Name='Test',
            Entity_Tax_Classification__c='DBA'
        ));
        testAccounts.add(new Account(
            Name='Test',
            Entity_Tax_Classification__c='PLLC'
        ));
        testAccounts.add(new Account(
            Name='Test',
            Entity_Tax_Classification__c='NON'
        ));
        testAccounts.add(new Account(
            Name='Test',
            Entity_Tax_Classification__c='LP'
        ));
        testAccounts.add(new Account(
            Name='Test',
            Entity_Tax_Classification__c='S'
        ));
        testAccounts.add(new Account(
            Name='Test',
            Entity_Tax_Classification__c='NA'
        ));
        insert testAccounts;
    }

    @isTest 
    public static void testBatch(){
        Test.startTest();
        StandardizeEntityBatchable leadBatch = new StandardizeEntityBatchable(Date.today(), 'Lead');
        Database.executeBatch(leadBatch);
        StandardizeEntityBatchable accountBatch = new StandardizeEntityBatchable(Date.today(), 'Account');
        Database.executeBatch(accountBatch);
        Test.stopTest();

        System.assertEquals(1, [SELECT COUNT() FROM Lead WHERE Entity_Tax_Classification__c = 'C Corporation']);
        System.assertEquals(1, [SELECT COUNT() FROM Lead WHERE Entity_Tax_Classification__c = 'DBA/Sole Proprietorship']);
        System.assertEquals(1, [SELECT COUNT() FROM Lead WHERE Entity_Tax_Classification__c = 'LLC']);
        System.assertEquals(1, [SELECT COUNT() FROM Lead WHERE Entity_Tax_Classification__c = 'Partnership']);
        System.assertEquals(1, [SELECT COUNT() FROM Lead WHERE Entity_Tax_Classification__c = 'Non-Profit']);
        System.assertEquals(1, [SELECT COUNT() FROM Lead WHERE Entity_Tax_Classification__c = 'S Corporation']);
        System.assertEquals(1, [SELECT COUNT() FROM Lead WHERE Entity_Tax_Classification__c = 'Undetermined']);

        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Entity_Tax_Classification__c = 'C Corporation']);
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Entity_Tax_Classification__c = 'DBA']);
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Entity_Tax_Classification__c = 'LLC']);
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Entity_Tax_Classification__c = 'Partnership']);
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Entity_Tax_Classification__c = 'Non-Profit']);
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Entity_Tax_Classification__c = 'S Corporation']);
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Entity_Tax_Classification__c = 'Undetermined']);
    }
}