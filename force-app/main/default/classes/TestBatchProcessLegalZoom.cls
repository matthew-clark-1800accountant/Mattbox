/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest (seeAllData=true)
private class TestBatchProcessLegalZoom {
/*
    static testMethod void myUnitTest() {
        Legal_Zoom__c lz = new Legal_Zoom__c();
        lz.Business_Purpose__c = 'test text';
        lz.City__c = 'Toronto';
        lz.Current_Status__c = 'Pending';
        lz.Date_Orders__c = Date.today();
        lz.Date_Started__c = Date.today();
        lz.Email__c = 'abc@abc.abc1234';
        lz.First_Name__c = 'test';
        lz.Last_Name__c = 'tester1';
        lz.Mailing_Address__c = '133 fake st';
        lz.Number__c = '12345123451';
        lz.Order_Number__c = '12345123';
        lz.Package__c = 'test';
        lz.Phone__c = '12123415';
        lz.Postal_Code__c = '01521';
        lz.Process__c = 'Incorporation';
        lz.Product_Name__c = '1234';
        lz.Sent_To_Customer__c = Date.today();
        lz.State__c = 'AZ';
        lz.State_Of_Formation__c = '123';
        lz.Status__c = 'Pending';
        
        insert lz;
        
        Test.startTest();
        BatchProcessLegalZoom b = new BatchProcessLegalZoom();
        Database.executeBatch(b);
        Test.stopTest();
    }*/
}