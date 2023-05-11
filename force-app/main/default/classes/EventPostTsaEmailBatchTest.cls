/**
*   Overview: Test class for EventPostTsaEmailBatch
*   Author: Koby Campbell
*   Date: June 2021
*/

@IsTest
private class EventPostTsaEmailBatchTest{
    @IsTest
    private static void testEmailSent() {
        Test.startTest();
        EventPostTsaEmailBatch batchJob = new EventPostTsaEmailBatch();
        Database.executeBatch(batchJob, 1);
        Test.stopTest();

        Opportunity testOpportunity = [
            SELECT Id, Name, Post_TSA_Link__c
            FROM Opportunity
            WHERE Name = 'Post TSA Test'
            LIMIT 1
        ];

        //System.assertNotEquals(null, testOpportunity.Post_TSA_Link__c);
    }

    @TestSetup
    private static void testSetup() {

        //Match all criteria for email to go out and link to be generated
        Account account = TestDataGenerator.createTestAccountWithoutOwner();
        account.Current_Year_Profit_Projection__c = '50000';
        account.Potential_Total_Savings__c = '$12,321';
        insert account;

        Contact contact = TestDataGenerator.createTestContact(account);
        contact.email = 'test@test.com';
        insert contact;

        account.Primary_Contact__c = contact.Id;
        update account;

        Opportunity opportunity = TestDataGenerator.createTestOpportunity(account);
        opportunity.ChargeOver_Quote_URL__c = 'www.test.com';
        opportunity.Name = 'Post TSA Test';
        insert opportunity;

        Event event = TestDataGenerator.createTestEvent();
        event.WhatId = opportunity.Id;
        event.ActivityDateTime  = Datetime.now().addDays(-2);
        event.StartDateTime = event.ActivityDateTime;
        event.EndDateTime = Datetime.now().addDays(-2).addMinutes(30);
        event.Subject = '1on1 Sales Appointment';
        event.Type_of_Appointment__c = 'Tax Savings Analysis';
        event.Appointment_Disposition__c = 'Consulted';
        event.Secondary_Disposition_Details__c = 'Not Interested';
        System.debug(event.ActivityDateTime);
        System.debug(event.StartDateTime);

        
        insert event;
    }
}