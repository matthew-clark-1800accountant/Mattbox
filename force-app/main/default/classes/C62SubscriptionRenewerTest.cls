@isTest
private class C62SubscriptionRenewerTest{

    @testSetup
    private static void getData(){
        Bill62__C62Billing_Config__c billSettings = new Bill62__C62Billing_Config__c();
        billSettings.Bill62__Create_Payments_From_Subscription_Lines__c = true;
        billSettings.Bill62__Generate_Payments_n_Days_Before__c = 7;
        billSettings.Bill62__Payment_Terms__c = 12;
        billSettings.Bill62__Initiation_Fee_Required__c = false;
        insert billSettings;
    
        Account a = new Account();
        a.Name = 'Starbuck';
        insert a;
        Contact c = new Contact();
        c.FirstName = 'Katee';
        c.LastName = 'Sackhoff';
        insert c;
        
        Product2 p = new Product2();
        p.isActive = true;
        p.Bill62__Auto_Renew__c = true;
        p.Name = 'Test Product';
        insert p;
        
        Bill62__Billing_Schedule__c b1 = new Bill62__Billing_Schedule__c();
        b1.Bill62__Active__c = true;
        b1.Bill62__Approved__c = true;
        b1.Bill62__Default__c = true;
        b1.Bill62__Product__c = p.Id;
        insert b1;
        
        Bill62__Billing_Schedule_Line__c theAce = new Bill62__Billing_Schedule_Line__c();
        theAce.Bill62__Billing_Schedule__c = b1.Id;
        theAce.Bill62__One_Time_Fee__c = true;
        theAce.Bill62__Type__c = 'One-Time';
        theAce.Bill62__Charge_Month__c = 0;
        theAce.Bill62__Days_Adjustment__c = 0;
        theAce.Bill62__Charge_Amount__c = 200;
        insert theAce;
        Bill62__Billing_Schedule_Line__c ofSpades = new Bill62__Billing_Schedule_Line__c();
        ofSpades.Bill62__Billing_Schedule__c = b1.Id;
        ofSpades.Bill62__One_Time_Fee__c = false;
        ofSpades.Bill62__Type__c = 'Recurring';
        ofSpades.Bill62__Charge_Month__c = 1;
        ofSpades.Bill62__Days_Adjustment__c = 0;
        ofSpades.Bill62__Charge_Amount__c = 100;
        insert ofSpades;
        
        Bill62__Subscription__c sub = new Bill62__Subscription__c(); 
        sub.Bill62__Customer__c = c.Id;
        sub.Bill62__Product__c = p.Id;
        sub.Bill62__Start_Date__c = System.Date.TODAY().addMonths(-13);
        sub.Bill62__Billing_Schedule__c = b1.Id;
        insert sub;
    }
    
    private static testmethod void testRenewer(){
        Test.startTest();
            List<Bill62__Subscription__c> subList = [SELECT ID FROM Bill62__Subscription__c];
            Set<String> subIDs = new Set<String>{subList[0].ID};
            C62SubscriptionRenewer.renewSubscriptions(subIDs,false);
        Test.stopTest();
    }

}