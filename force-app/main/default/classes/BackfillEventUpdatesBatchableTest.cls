@isTest
public without sharing class BackfillEventUpdatesBatchableTest {

    @isTest
    public static void testBatch(){
        User u = [SELECT Id FROM User WHERE Name = 'Matthew Clark' LIMIT 1];
        Account account = new Account(
            OwnerId = u.Id,
            Name = 'Test Account',
            Email_Campaign_ID__c = '12345',
            Email_Campaign_ID_Last_Touch__c = '12345'
        );
        insert account;
        
        Event_History__c history = new Event_History__c();
        insert history; 

        Event testEvent = new Event(
            OwnerId = u.Id,
            WhatId = account.Id,
            // WhoId = testContact.Id,
            Subject = 'Test Event',
            StartDateTime = System.now(),
            EndDateTime = System.now().addMinutes(30),
            Email_Campaign_ID__c = '12345',
            Type_of_Appointment__c = 'Tax Savings Analysis',
            Portal_Event_Owner__c = 'Matthew Clark',
            Event_History__c = history.Id
        );
        insert testEvent;

        Event_Field_Update__c up = new Event_Field_Update__c(
            Updated_Field__c = 'Show As',
            Old_Value__c = 'Busy',
            New_Value__c = 'Free',
            Event_History__c = history.Id
        );
        insert up;
        System.debug(testEvent);
        System.debug(up);
        Test.startTest();
        System.debug(Database.executeBatch(new BackfillEventUpdatesBatchable(null)));
        Test.stopTest();
        System.assert([SELECT COUNT() FROM Event_Field_Update__c WHERE Update_made_in_change_window__c = true] > 0);
    }
}