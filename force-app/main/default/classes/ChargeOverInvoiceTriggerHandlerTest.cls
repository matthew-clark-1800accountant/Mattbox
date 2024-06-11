@IsTest
private class ChargeOverInvoiceTriggerHandlerTest
{

    @TestSetup
    private static void testSetup()
    {
        Account act = new Account(Name='TestAccountCOI');
        insert act;

        Event evt = new Event(Subject='TestEventCOI',DurationInMinutes=2,ActivityDate=Date.today(),ActivityDateTime=System.now(),WhatId=act.Id,Secondary_Disposition_Details__c='Sale');
        insert evt;

        Event evt2 = new Event(Subject='TestEventCOI2',DurationInMinutes=2,ActivityDate=Date.today().addDays(5),ActivityDateTime=System.now().addDays(5),WhatId=act.Id,Secondary_Disposition_Details__c='Sale');
        insert evt2;

        Event fullData = [SELECT AccountId FROM Event WHERE Id = :evt.Id];
        System.debug('fullData :: ' + fullData + ' act.Id :: ' + act.Id);
    }

    @IsTest
    static void testBehavior()
    {
        Account act = [SELECT Id FROM Account LIMIT 1];
        List<ChargeOver_Invoice__c> invoices = new List<ChargeOver_Invoice__c>();
        Double expectedTotal = 0;
        for(Integer i=0; i<250; i++){
            invoices.add(new ChargeOver_Invoice__c(Total__c=2.0,Account__c=act.Id));
            expectedTotal += 2.0;
        }
        //ChargeOver_Invoice__c coi = new ChargeOver_Invoice__c(Total__c=2.0,Account__c=act.Id);

        Test.startTest();
        insert invoices;
        Test.stopTest();

        Event evt = [SELECT Id, Invoice_Payment_Amount__c FROM Event WHERE AccountId = :act.Id AND Subject='TestEventCOI' LIMIT 1];
        System.debug('Invoice Payment Amount Aggregation Result :: ' + evt);
        System.assertEquals(expectedTotal,evt.Invoice_Payment_Amount__c,'should have returned a value where the evt has an aggregated account from the above COI...');
        
        evt = [SELECT Id, Invoice_Payment_Amount__c FROM Event WHERE AccountId = :act.Id AND Subject='TestEventCOI2' LIMIT 1];
        System.debug(evt);
        System.assertEquals(null,evt.Invoice_Payment_Amount__c,'should have returned a value where the evt has an aggregated account from the above COI...');
    }
}