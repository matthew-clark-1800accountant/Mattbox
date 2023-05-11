@IsTest
public with sharing class InteractionEventTriggerHandlerTest {
    @TestSetup
    static void makeData(){
        System.debug('**InteractionEventTriggerHandlerTest.makeData()');
        Account testAccount = new Account(
            Name = 'Test Account'
        );
        insert testAccount;

        Contact testContact = new Contact(
            FirstName='Test',
            LastName='Contact',
            AccountId = testAccount.Id
        );
        insert testContact;
        
        Event event = new Event(
            WhatId = testAccount.Id,
            WhoId = testContact.Id,
            Subject = 'Test Event',
            StartDateTime = Datetime.now().addMinutes(-2),
            EndDateTime = Datetime.now(),
            Email_Campaign_ID__c = '12345',
            Type_of_Appointment__c = 'Tax Savings Analysis',
            Portal_Event_Owner__c = 'Matthew Clark',
            of_Calls_for_Event__c = 0
        );
        insert event;

        NVMContactWorld__InteractionEvent__c testCall = new NVMContactWorld__InteractionEvent__c(
            Name='test call',
            //NVMContactWorld__Who__c = whoContact.Id,
            NVMContactWorld__Type__c = 'Deliver',
            NVMContactWorld__TimeStamp__c = Datetime.now(),
            NVMContactWorld__IndexedCallObjectIdentifier__c = 'abc123'
        );
        insert testCall;
    }

    @IsTest
    static void testLogCall(){
        System.debug('InteractionEventTriggerHandlerTest.testLogCall()');
        
        Test.startTest();
        Contact whoContact = [SELECT Id FROM Contact LIMIT 1];
        // NVMContactWorld__InteractionEvent__c testCall = new NVMContactWorld__InteractionEvent__c(
        //     Name='test call',
        //     NVMContactWorld__Who__c = whoContact.Id,
        //     NVMContactWorld__Type__c = 'Deliver',
        //     NVMContactWorld__TimeStamp__c = Datetime.now(),
        //     NVMContactWorld__IndexedCallObjectIdentifier__c = 'abc123'
        // );
        // insert testCall;
        NVMContactWorld__InteractionEvent__c testCall = [SELECT Id FROM NVMContactWorld__InteractionEvent__c LIMIT 1];
        testCall.NVMContactWorld__Who__c = whoContact.Id;
        update testCall;
        Test.stopTest();

        Event testEvent = [SELECT Id, Minute_Difference_for_Appt_Call__c, of_Calls_for_Event__c, Most_Recent_Call_for_Event__c FROM Event LIMIT 1];
        System.debug(testEvent);
        System.assertEquals(2, testEvent.Minute_Difference_for_Appt_Call__c);
        System.assertEquals(1, testEvent.of_Calls_for_Event__c);
        System.assertNotEquals(null, testEvent.Most_Recent_Call_for_Event__c);
    }
}