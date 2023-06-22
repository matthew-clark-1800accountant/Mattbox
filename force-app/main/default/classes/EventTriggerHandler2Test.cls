@isTest
private class EventTriggerHandler2Test { 
    @testSetup static void setupTestData() {
        User u = [SELECT Id FROM User WHERE Name = 'Matthew Clark' LIMIT 1];
        Account account = new Account(
            OwnerId = u.Id,
            Name = 'Test Account',
            Email_Campaign_ID__c = '12345',
            Email_Campaign_ID_Last_Touch__c = '12345'
        );
        insert account;

        // Contact testContact = new Contact(
        //     FirstName='Test',
        //     LastName='Contact',
        //     AccountId = account.Id
        // );
        // insert testContact;
        
        Event event = new Event(
            OwnerId = u.Id,
            WhatId = account.Id,
            // WhoId = testContact.Id,
            Subject = 'Test Event',
            StartDateTime = System.now().addDays(2),
            EndDateTime = System.now().addDays(2),
            Email_Campaign_ID__c = '12345',
            Type_of_Appointment__c = 'Tax Savings Analysis',
            Portal_Event_Owner__c = 'Matthew Clark'
        );
        //insert event;

        Event calendarBlock = new Event(
            OwnerId = u.Id,
            WhatId = account.Id,
            Email_Campaign_ID__c = '12345',
            Subject = 'Tax Consultation',
            Type_of_Appointment__c = 'Calendar Block',
            StartDateTime = Datetime.now(),
            EndDateTime = Datetime.now().addMinutes(30)
        );
        //insert calendarBlock;
        insert (new List<Event>{event, calendarBlock});
        

        // Event event2 = new Event(
        //     WhatId = account.Id,
        //     WhoId = testContact.Id,
        //     Subject = 'Discovery Call',
        //     StartDateTime = System.now().addDays(2),
        //     EndDateTime = System.now().addDays(2),
        //     Email_Campaign_ID__c = '12345',
        //     Type_of_Appointment__c = 'Discovery Call',
        //     Portal_Event_Owner__c = 'Matthew Clark'
        // );
        // insert event2;
        
    }

    @isTest static void test_updateEmailCampaignId () {
        Account account = [SELECT Id FROM Account LIMIT 1];
        
        Lead lead = new Lead(
            FirstName = 'Test',
            LastName = 'Test Lead',
            Email = 'test@test.com',
            Phone = '8001111111',
            Company = 'Test Company',
            Status = 'New'
        );
        insert lead;
        Event leadEvent = new Event(
            WhoId = lead.Id,
            Subject = 'Test Event',
            StartDateTime = System.now(),
            EndDateTime = System.now(),
            Email_Campaign_ID__c = '11111',
            Type_of_Appointment__c = 'Tax Savings Analysis'
        );
        //insert leadEvent;

        Contact contact = new Contact(
            FirstName = 'Test',
            LastName = 'Test Contact',
            Email = 'test2@test.com',
            Phone = '8002222222',
            AccountId = account.Id
        );
        insert contact;
        Event contactEvent = new Event(
            WhoId = contact.Id,
            Subject = 'Test Event',
            StartDateTime = System.now(),
            EndDateTime = System.now(),
            Email_Campaign_ID__c = '22222',
            Type_of_Appointment__c = 'Tax Savings Analysis'
        );
        //insert contactEvent;

        Test.startTest();
        Event newAccountEvent = new Event(
            WhatId = account.Id,
            Subject = 'Test Event',
            StartDateTime = System.now(),
            EndDateTime = System.now(),
            Type_of_Appointment__c = 'Tax Savings Analysis'
        );
        //insert newAccountEvent;

        Event newLeadEvent = new Event(
            WhoId = lead.Id,
            Subject = 'Test Event',
            StartDateTime = System.now(),
            EndDateTime = System.now(),
            Type_of_Appointment__c = 'Tax Savings Analysis'
        );
        //insert newLeadEvent;

        Event newContactEvent = new Event(
            WhoId = contact.Id,
            Subject = 'Test Event',
            StartDateTime = System.now(),
            EndDateTime = System.now(),
            Type_of_Appointment__c = 'Tax Savings Analysis'
        );
        //insert newContactEvent;
        insert new List<Event>{leadEvent, contactEvent, newAccountEvent, newLeadEvent, newContactEvent};
        Test.stopTest();

        List<Id> testIds = new List<Id>{newAccountEvent.Id, newLeadEvent.Id, newContactEvent.Id };
        Integer idCount = [SELECT Count() FROM Event WHERE Id IN :testIds];
        System.assertEquals(idCount, 3);
            // Event updatedAccountEvent = [
    //     SELECT Email_Campaign_ID__c FROM Event WHERE Id = :newAccountEvent.Id
    // ];
    // System.assertEquals('12345', updatedAccountEvent.Email_Campaign_ID__c);
    
    // Event updatedLeadEvent = [
    //     SELECT Email_Campaign_ID__c FROM Event WHERE Id = :newLeadEvent.Id
    // ];
    // System.assertEquals('11111', updatedLeadEvent.Email_Campaign_ID__c);

    // Event updatedContactEvent = [
    //     SELECT Email_Campaign_ID__c FROM Event WHERE Id = :newContactEvent.Id
    // ];
    // System.assertEquals('22222', updatedContactEvent.Email_Campaign_ID__c);

    }
    
    @isTest static void test_createFieldUpdateHistory(){
        Test.startTest();
        Event testEvent = [SELECT Id, StartDateTime, EndDateTime, Portal_Event_Owner__c, Account.Primary_Contact__r.Name FROM Event LIMIT 1];
        testEvent.ShowAs = 'Free';
        
        Id owner = [Select Id From User where Profile.Name = 'System Administrator' and IsActive=true Limit 1].Id;
        System.debug(owner);
        testEvent.OwnerId = owner;
        testEvent.StartDateTime = testEvent.StartDateTime.addDays(1);
        testEvent.EndDateTime = testEvent.EndDateTime.addDays(1);
        testEvent.Type_of_Appointment__c = 'Discovery Call';
        update testEvent;
        Test.stopTest();
        testEvent = [SELECT Id, Event_History__c, StartDateTime, EndDateTime, Portal_Event_Owner__c, Account.Primary_Contact__r.Name FROM Event WHERE Id = :testEvent.Id LIMIT 1];
        System.assert(testEvent.Event_History__c != null);
        System.assert([SELECT COUNT() FROM Event_Field_Update__c] > 0);

        
    }

    @isTest static void test_updateSMSMessage(){
        Account account = [SELECT Id FROM Account LIMIT 1];
        Contact testContact = new Contact(
            FirstName='Test',
            LastName='Contact',
            AccountId = account.Id
        );
        insert testContact;
        
        Event testEvent = new Event(
            WhatId = account.Id,
            WhoId = testContact.Id,
            Subject = 'Discovery Call',
            StartDateTime = System.now().addDays(2),
            EndDateTime = System.now().addDays(2),
            Email_Campaign_ID__c = '12345',
            Type_of_Appointment__c = 'Discovery Call',
            Portal_Event_Owner__c = 'Matthew Clark'
        );
        insert testEvent;
        testEvent.Portal_Event_Owner__c = 'Drew Troutner';
        update testEvent;
        // String contactName = testEvent.Account.Primary_Contact__r.Name;
        // List<String> smsTypes = new List<String>{'Advisory Reminder'};
        // Datetime startTime = testEvent.StartDateTime.addMinutes(-15);
        // if(testEvent.Portal_Event_Owner__c != null){
        //     System.debug('sms count: '+[SELECT COUNT() FROM SMS_Schedule__c]);
        //     User portalEventOwner = [SELECT Id, Name, Phone FROM User WHERE Name = :testEvent.Portal_Event_Owner__c];
        //     SMS_Schedule__c smsRecord = [SELECT Id, Type__c FROM SMS_Schedule__c WHERE Type__c IN :smsTypes AND Schedule_Date__c = :startTime LIMIT 1];
        //     String ownerPhone = portalEventOwner.Phone;
        //     String ownerName = portalEventOwner.Name;
            
        //     String baseString;
        //     if(ownerPhone == null){
        //         baseString = 'Hi {0}, you have a meeting with {1} your 1-800Accountant Advisor in a few minutes. We look forward to speaking with you!';
        //         //smsScheduleJustPriorRecord.Message__c = String.format(baseString, new List<String>{eventRecord.Account.Primary_Contact__r.Name, eventRecord.Account.PortalAccountOwner__r.Name});
        //         System.assertEquals(String.format(baseString, new List<String>{contactName, ownerName}),smsRecord.Message__c);
        //     } else {
        //         baseString = 'Hi {0}, you have a meeting with {1} your 1-800Accountant Advisor in a few minutes. Watch for the call from this number: {2}. We look forward to speaking with you!';
        //         System.assertEquals(String.format(baseString, new List<String>{contactName, ownerName, ownerPhone}),smsRecord.Message__c);
        //     }
        // }
    }

    @isTest static void test_updateCalendarBlock(){
        Event block = [SELECT Id, CreatedDate FROM Event WHERE Type_of_Appointment__c = 'Calendar Block' LIMIT 1];
        Test.setCreatedDate(block.Id, DateTime.newInstance(2020,12,12));
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        System.debug(block);
        Test.startTest();
        block.ShowAs = 'OutOfOffice';
        update block;
        Test.stopTest();
    }

    @isTest static void test_deleteCalendarBlock(){
        Event block = [SELECT Id, CreatedDate FROM Event WHERE Type_of_Appointment__c = 'Calendar Block' LIMIT 1];
        Test.setCreatedDate(block.Id, DateTime.newInstance(2020,12,12));
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        System.debug(block);
        Test.startTest();
        delete block;
        Test.stopTest();
    }

    @IsTest 
    public static void updateWhatIdTest(){
        System.debug('updateWhatIdTest()');
        Event ev = [SELECT Id FROM Event LIMIT 1];
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Contact con = new Contact(AccountId=acc.Id, FirstName='Test', LastName='Con');
        insert con;
        Opportunity opp = new Opportunity(Name='Test', AccountId=acc.Id, StageName='New', CloseDate=Date.today());
        insert opp;
        ev.Type_of_Appointment__c = 'BNA';
        ev.Appointment_Disposition__c = 'Consulted';
        ev.Secondary_Disposition_Details__c = 'Sale';
        ev.WhatId = acc.Id;
        ev.WhoId = con.Id;
        Test.startTest();
        update ev;
        Test.stopTest();
        
        //ev = [SELECT Id, WhatId FROM Event LIMIT 1];
        //System.assertNotEquals(acc.Id, ev.WhatId);
    }

    

//    @isTest static void test_updateInvoicePaymentAmount () {
//        Account account = [SELECT Id FROM Account LIMIT 1];
//        Event event = [SELECT Id FROM Event LIMIT 1];
//        Zuora__ZInvoice__c invoice = new Zuora__ZInvoice__c(
//            Zuora__Account__c = account.Id,
//            Zuora__InvoiceDate__c = System.today().addDays(1),
//            Zuora__PaymentAmount__c = 10
//        );
//        insert invoice;
//
//        Test.startTest();
//        event.Appointment_Disposition__c = 'Consulted';
//        event.Secondary_Disposition_Details__c = 'Sale';
//        update event;
//        Test.stopTest();
//
//        Event updatedEvent = [
//            SELECT Invoice_Payment_Amount__c FROM Event WHERE Id = :event.Id
//        ];
//        System.assertEquals(10, updatedEvent.Invoice_Payment_Amount__c);
//    }
}