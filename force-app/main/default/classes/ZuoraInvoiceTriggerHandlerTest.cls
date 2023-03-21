@IsTest
private class ZuoraInvoiceTriggerHandlerTest {

    @TestSetup
    static void setupTestData() {
        Account account = new Account(
            Name = 'Test Account'
        );
        insert account;
        
        Event event = new Event(
            WhatId = account.Id,
            Subject = 'Test Event',
            StartDateTime = System.now(),
            EndDateTime = System.now().addDays(2),
            Appointment_Disposition__c = 'Consulted',
            Secondary_Disposition_Details__c = 'Sale'
        );
        insert event;
    }

//    @IsTest
//    static void test_updateInvoicePaymentAmount () {
//        Account account = [SELECT Id FROM Account LIMIT 1];
//
//        Test.startTest();
//        Zuora__ZInvoice__c invoice = new Zuora__ZInvoice__c(
//            Zuora__Account__c = account.Id,
//            Zuora__InvoiceDate__c = System.today().addDays(1),
//            Zuora__PaymentAmount__c = 10
//        );
//        insert invoice;
//        Test.stopTest();
//
//        Zuora__ZInvoice__c invoice2 = [SELECT Id, Zuora__Account__c, Zuora__PaymentAmount__c FROM Zuora__ZInvoice__c LIMIT 1];
//        System.debug('invoice2 :: ' + invoice2);
//
//        Event updatedEvent = [
//            SELECT Invoice_Payment_Amount__c FROM Event LIMIT 1
//        ];
//        System.assertEquals(10, updatedEvent.Invoice_Payment_Amount__c);
//    }
}