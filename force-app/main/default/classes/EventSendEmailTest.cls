@isTest
public class EventSendEmailTest {
@isTest
    public static void LeadTest() {
        Test.startTest(); 
        Event leadEvent = [
            SELECT Id, WhatId, Appointment_Disposition__c, Who.Type, WhoId
            FROM Event
            WHERE Who.Type = 'Lead'
            LIMIT 1
        ];

        leadEvent.Appointment_Disposition__c = 'No Show';
        update leadEvent;
        Test.stopTest();
        Lead lead = [
            SELECT Id, Pre_TSA_Link__c
            FROM Lead
            WHERE Id = :leadEvent.WhoId
            LIMIT 1
        ];
        System.assertEquals('https://1800accountant.secure.force.com/PreTSA1?id='+leadEvent.Id, lead.Pre_TSA_Link__c);
    }

    @isTest
    public static void AccountTest() {
        Test.startTest(); 
        Event accountEvent = [
            SELECT Id, WhatId, Appointment_Disposition__c, Who.Type, WhoId
            FROM Event
            WHERE What.Type = 'Account'
            LIMIT 1
        ];
        
        accountEvent.Appointment_Disposition__c = 'No Show';
        update accountEvent;
        Test.stopTest();
        Account account = [
            SELECT Id, Pre_TSA_Link__c, Owner.Name
            FROM Account
            WHERE Id = :accountEvent.WhatId
            LIMIT 1
        ];
        System.assertEquals('https://1800accountant.secure.force.com/PreTSA1?id='+accountEvent.Id, account.Pre_TSA_Link__c);
    }

@TestSetup
    private static void testSetup() {
        Id profileId = [SELECT Id, Name FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id;

        User testUser = TestDataGenerator.createTestUser(profileId);
        insert testUser;
        //Match all criteria for email to go out and link to be generated
        Account testAccount = TestDataGenerator.createTestAccountWithoutOwner();
        insert testAccount;

        Lead testLead = TestDataGenerator.createTestLead(testUser.Id);
        insert testLead;

        Contact contact = TestDataGenerator.createTestContact(testAccount);
        contact.email = 'test@test.com';
        insert contact;

        testAccount.Primary_Contact__c = contact.Id;
        update testAccount;

        Event event = TestDataGenerator.createTestEvent();
        event.WhatId = testAccount.Id;
        event.Subject = '1on1 Sales Appointment';
        event.Type_of_Appointment__c = 'Tax Savings Analysis';
        insert event;

        Event leadEvent = TestDataGenerator.createTestEvent();
        leadEvent.WhoId = testLead.Id;
        leadEvent.Subject = '1on1 Sales Appointment';
        leadEvent.Type_of_Appointment__c = 'Tax Savings Analysis';
        insert leadEvent;
    }
}