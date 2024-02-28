@isTest()
public class PreTSAControllerExtensionTest {
@isTest()
    public static void leadsPreTSAGeneration() {
        Lead testLead = [SELECT Id, FirstName FROM Lead WHERE FirstName = 'Pre TSA Test' LIMIT 1];
        Event testEvent = new Event(
            WhoId = testLead.Id,
            DurationInMinutes = 30,
            ActivityDateTime = Date.today(),
            Subject = 'Tax Consultation'
        );
        insert testEvent;

        ApexPages.currentPage().getParameters().put('Id', testEvent.Id);
        ApexPages.StandardController preTSA = new ApexPages.StandardController(testEvent);
        PreTSAControllerExtension controller = new PreTSAControllerExtension(preTSA);
        
        //Variable roll call
        //Check that the default came from the account
        String defaultEntity = controller.defaultEntity;
        System.assertEquals('S Corporation', defaultEntity);

        //Testing savings calculations
        Decimal totalSavings = PreTSAControllerExtension.calculateSavings('S Corporation', '50000', '5000', '15000', '150', 'Single', '50000', testEvent.Id, '');
        //Testing that the Lead was updated
        Lead testLead2 = [SELECT Id, Entity_Type__c FROM Lead WHERE FirstName = 'Pre TSA Test' LIMIT 1];
        System.assertEquals('S Corporation', testLead2.Entity_Type__c);

        //Picklist options for code coverage
        List<SelectOption> entityTypeOptions = new List<SelectOption>(controller.getEntityType());
        System.assertNotEquals(null, entityTypeOptions);
        List<SelectOption> currencyOptions = new List<SelectOption>(controller.getCurrency());
        System.assertNotEquals(null, currencyOptions);
        List<SelectOption> mileageOptions = new List<SelectOption>(controller.getMileage());
        System.assertNotEquals(null, mileageOptions);
        List<SelectOption> officeOptions = new List<SelectOption>(controller.getOffice());
        System.assertNotEquals(null, officeOptions);
        List<SelectOption> filingStatusOptions = new List<SelectOption>(controller.getFilingStatus());
        System.assertNotEquals(null, filingStatusOptions);
    }
    @isTest()
    public static void accountsPreTSAGeneration() {
        Account testAccount = [SELECT Id, Name FROM Account WHERE Name = 'Pre TSA Test' LIMIT 1];
        Event testEvent = new Event(
            WhatId = testAccount.Id,
            DurationInMinutes = 30,
            ActivityDateTime = Date.today(),
            Subject = 'Tax Consultation'
        );
        insert testEvent;

        ApexPages.currentPage().getParameters().put('Id', testEvent.Id);
        ApexPages.StandardController preTSA = new ApexPages.StandardController(testEvent);
        PreTSAControllerExtension controller = new PreTSAControllerExtension(preTSA);

        //Testing savings calculations
        Decimal totalSavings = PreTSAControllerExtension.calculateSavings('LLC', '50000', '5000', '15000', '150', 'Single', '50000', testEvent.Id, '');
        //Testing that the Account was updated
        Account testAccount2 = [SELECT Id, Name, Potential_Total_Savings__c FROM Account WHERE Name = 'Pre TSA Test' LIMIT 1];
        System.assertEquals(testAccount2.Potential_Total_Savings__c, totalSavings);
    }
    @TestSetup
    static void makeData(){
        Id profileId = [SELECT Id, Name FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id;

        User testUser = TestDataGenerator.createTestUser(profileId);
        insert testUser;

        Lead lead = TestDataGenerator.createTestLead(testUser.Id);
        lead.FirstName = 'Pre TSA Test';
        //Testing default
        lead.Entity_Type__c = 'S Corporation';
        insert lead;

        Account testAccount = TestDataGenerator.createTestAccountWithoutOwner();
        testAccount.Name = 'Pre TSA Test';
        //Testing default
        testAccount.Entity_Type__c = 'Non-Profit';
        insert testAccount;

        Contact testContact = TestDataGenerator.createTestContact(testAccount);
        insert testContact;
    }
}