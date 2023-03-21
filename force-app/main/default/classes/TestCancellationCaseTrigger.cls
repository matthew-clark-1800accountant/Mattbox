/*
@ Name          : TestCaseManagement
@ Author        : customersuccess@cloud62.com
@ Date          : 02 May, 2015
@ Description   : Test class for CaseManagement and SubscriptionExtras trigger.
*/

@isTest

public class TestCancellationCaseTrigger{    
    
    @testSetup static void createTestData(){        
        account testAccount = new account(name='Test Account');
        insert testAccount;
        contact testContact = new contact(firstName='Test',lastName='Contact',accountId=testAccount.Id);
        insert testContact;
        Bill62__Payment_Method__c testPaymentMethod = new Bill62__Payment_Method__c(Bill62__Payment_Type__c=       'Credit Card',
                                                                                    Bill62__Card_Number__c=        '4111111111111111',
                                                                                    Bill62__Card_Type__c=          'Visa',
                                                                                    Bill62__Customer__c=           testContact.Id,                                                                                          
                                                                                    Bill62__Customer_Email__c=     'test@test.com',
                                                                                    Bill62__CVV_Code__c=           '999',
                                                                                    Bill62__Card_Holder_Name__c=   testContact.Name,
                                                                                    Bill62__Expiration_Date__c=    date.today().addYears(1));
        insert testPaymentMethod;
        product2 testProduct = new product2(IsActive=          TRUE,
                                            Name=              'Test Product',
                                            Task_List__c=      'Additional Personal Return',
                                            Standard_Price__c= 500);
        insert testProduct;
        Bill62__Billing_Schedule__c testBillingSchedule = new Bill62__Billing_Schedule__c(Bill62__Product__c=    testProduct.Id);
        insert testBillingSchedule;
        PriceBookEntry testPriceBookEntry = new PriceBookEntry(IsActive=          TRUE,
                                                               PriceBook2Id=      Test.getStandardPricebookId(),
                                                               Product2Id=        testProduct.Id,
                                                               UnitPrice=         500);
        insert testPriceBookEntry;
        opportunity testOppty = new opportunity(Name=      'Test Oppty',
                                                Account=   testAccount,
                                                StageName= 'Sold',
                                                CloseDate= date.Today());
        insert testOppty;
        Bill62__Order__c testOrder = new Bill62__Order__c(Bill62__Account__c=        testAccount.Id,
                                                          Bill62__Customer__c=       testContact.Id,
                                                          Bill62__Opportunity__c=    testOppty.Id,
                                                          Bill62__Payment_Method__c= testPaymentMethod.Id);
        insert testOrder;
               
    }
    
    @isTest 
    public static void runTest(){
       account a = [SELECT Id FROM account WHERE name = 'Test Account' LIMIT 1];
       contact c = [SELECT Id FROM contact WHERE name = 'Test Contact' LIMIT 1];
       product2 p = [SELECT Id, Task_List__c FROM product2 WHERE name = 'Test Product'];
       recordtype rt = [SELECT Id,Name FROM recordType WHERE name = 'Cancellation' LIMIT 1];
       system.debug('Record type: '+rt.name);
       Bill62__Payment_Method__c pm = [SELECT Id FROM Bill62__Payment_Method__c WHERE Bill62__Card_Type__c= 'Visa' LIMIT 1];
       Bill62__Subscription__c sp = new Bill62__Subscription__c(Bill62__Account__c=           a.Id,
                                                                Bill62__Customer__c=          c.Id,
                                                                Bill62__Start_Date__c=        date.today(),
                                                                Bill62__Payment_Method__c=    pm.Id,
                                                                Bill62__Product__c=           p.Id);
       insert sp;  
       sp.Bill62__Suspended__c=TRUE;
       update sp;
       sp.Bill62__Termination_Date__c=date.today().adddays(3);        
       update sp;  
       system.debug('Service package status: '+sp.Bill62__Status__c);
       system.debug('Service package product: '+sp.Bill62__Product__c);
       
       //Modified to Contactid = c.id from Contact = c to satisfy field filter on case field: service package -- BJ ben.j.jones@gmail.com 
       Case cs = new case(Contactid=             c.id,
                          Service_Package__c=  sp.Id,
                          Status=              'Cancellation Requested');
       
       Test.startTest();
       insert cs;
       cs.status='Save Attempt';
       update cs;
       delete cs;
       Case cs2 = new case(Contactid=             c.id,
                          Service_Package__c=  sp.Id,
                          RecordTypeId=        rt.Id,
                          Status=              'Save Attempt');
       
       //insert cs2;       
       cs2.status='Closed-Cancelled';        
       //update cs2;
       //delete cs2;
       Case cs3 = new case(Contactid=             c.id,
                          Service_Package__c=  sp.Id,
                          RecordTypeId=        rt.Id,
                          Status=              'Closed-Refund');
       
       //insert cs3;                
       cs3.status='Closed-Refund';
       //update cs3;
       //delete cs3;
       Case cs4 = new case(Contactid=             c.id,
                          Service_Package__c=  sp.Id,
                          RecordTypeId=        rt.Id,
                          Status=              'Closed-Saved');
       
       //insert cs4;                
       cs4.status='Closed-Saved';
       //update cs4;
       //delete cs4;
       Test.stopTest();       
        
    }
    
    @isTest 
    public static void testIntegers(){
        Test.startTest();
        X1800Utilities.testIntegers();
        Test.stopTest();
    }
}