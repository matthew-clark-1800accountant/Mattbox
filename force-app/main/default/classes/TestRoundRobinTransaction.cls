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
@isTest
private class TestRoundRobinTransaction {

    static testMethod void myUnitTest() {
        Bill62__C62Billing_Config__c billingConfig = Bill62__C62Billing_Config__c.getOrgDefaults();
        billingConfig.Bill62__Allow_Multiple_Member_Subscriptions__c = true;
        billingConfig.Bill62__Create_Payments_From_Subscription_Lines__c = true;
        upsert billingConfig;
        
        Bill62__Payment_Gateway__c pg = new Bill62__Payment_Gateway__c();
        pg.Name = 'PayFlow NVP 1800accountant25';
        pg.Bill62__Production_URL__c = 'http://test.com';
        pg.Bill62__Vendor_Encrypted__c = 'test';
        pg.Bill62__Partner_Encrypted__c = 'test';
        pg.Bill62__Login_Encrypted__c = 'test';
        pg.Bill62__Password_Encrypted__c = 'test';
        insert pg;
        
        List<Round_Robin_Transaction_Setting__c> csInsert = new List<Round_Robin_Transaction_Setting__c>();
        Round_Robin_Transaction_Setting__c s1 = new Round_Robin_Transaction_Setting__c();
        s1.Name = 'PayFlow NVP 1800accountant25';
        s1.Company_Brand__c =  '1800Accountant';
        s1.Percentage__c =  0.25;
        csInsert.add(s1);
        
        Round_Robin_Transaction_Setting__c s2 = new Round_Robin_Transaction_Setting__c();
        s2.Name = 'PayFlow NVP 1800accountant2';
        s2.Company_Brand__c =  'Corporate Tax Network';
        s2.Percentage__c =  0.25;
        csInsert.add(s2);
        
        insert csInsert;
        
        Account a = new Account();
        a.Name = 'test';
        a.Company_Brand__c = '1800Accountant';
        insert a;
        
        Contact c = new Contact();
        c.FirstName = 'teest';
        c.LastName = 'test';
        c.Email = 'te@st.testtest';
        c.AccountId = a.Id;
        insert c;
        
        List<Product2> prodList = new List<Product2>();
        Product2 p2 = new Product2();
        p2.Name = 'test';
        p2.Product_Class__c = 'VTO Business';
        p2.Billing_Frequency__c = 'Annual';
        prodList.add(p2);
        
        Product2 p3 = new Product2();
        p3.Name = 'test2';
        p3.Product_Class__c = 'VTO Personal';
        prodList.add(p3);
        
        Product2 p4 = new Product2();
        p4.Name = 'test3';
        p4.Product_Class__c = 'VTO All';
        prodList.add(p4);
        
        insert prodList;
        
        Bill62__Billing_Schedule__c bs = new Bill62__Billing_Schedule__c();
        bs.Bill62__Active__c = true;
        bs.Bill62__Approved__c = true;
        bs.Bill62__Description__c = 'test';
        bs.Bill62__Product__c = p2.Id;
        insert bs;
        
        Bill62__Billing_Schedule_Line__c bsl = new Bill62__Billing_Schedule_Line__c();
        bsl.Bill62__Billing_Schedule__c = bs.Id;
        bsl.Bill62__Monthly_Amount__c = 10;
        bsl.Bill62__Charge_Amount__c = 10;
        bsl.Bill62__Charge_Month__c = 1;
        bsl.Bill62__Annual_Multiplier__c = 2;
        bsl.Bill62__Quarterly_Multiplier__c = 2;
        bsl.Bill62__SemiAnnual_Multiplier__c = 2;
        bsl.Bill62__Type__c = 'Dues';
        insert bsl;
        
        Bill62__Address__c ad = new Bill62__Address__c();
        ad.Bill62__City__c = 'Buffalo';
        ad.Bill62__Street_1__c = '123 fake st.';
        ad.Bill62__Country__c = 'United States';
        ad.Name = 'test';
        ad.Bill62__Zip_Postal_Code__c = '12345';
        ad.Bill62__Customer__c = c.Id;
        insert ad;
        
        Bill62__Payment_Method__c pm = new Bill62__Payment_Method__c();
        pm.Bill62__Customer__c = c.Id;
        pm.Bill62__Account__c = a.Id;
        pm.Bill62__Card_Type__c = 'MasterCard';
        pm.Bill62__Card_Number__c = '55555555554444';
        pm.Bill62__CVV_Code__c = '123';
        pm.Bill62__Expiration_Date__c = Date.today().addYears(2);
        pm.Bill62__Payment_Type__c = 'Credit Card';
        pm.Bill62__Billing_Address__c = ad.Id;
        insert pm;
        
        Bill62__Order__c o = new Bill62__Order__c();
        o.RecordTypeid = [SELECT ID FROM RECORDTYPE WHERE SOBJECTTYPE = 'Bill62__Order__c' AND NAME = 'Potential Order' LIMIT 1][0].Id;
        o.Bill62__Customer__c = c.Id;
        o.Name = 'test';
        insert o;
        
        Bill62__Subscription__c s = new Bill62__Subscription__c();
        s.Bill62__Address__c = ad.Id;
        s.Bill62__Customer__c = c.Id;
        s.Bill62__End_Date__c = Date.today().addYears(1).addDays(-1);
        s.Bill62__Start_Date__c = Date.today();
        s.Bill62__Product__c = p2.Id;
        s.Bill62__Billing_Frequency__c = 'Annual';
        s.Bill62__Payment_Method__c = pm.Id;
        insert s;
        
        Bill62__Subscription_Line__c sl = new Bill62__Subscription_Line__c();
        sl.Bill62__Billing_Frequency__c = 'Annual';
        sl.Bill62__Cycle_Start_Date__c = Date.today();
        sl.Bill62__Cycle_End_Date__c = Date.today().addYears(1).addDays(-1);
        sl.Bill62__Full_Cycle_Amount__c = 100;
        sl.Bill62__Full_Cycle_Start_Date__c = Date.today();
        sl.Bill62__Full_Cycle_End_Date__c = Date.today().addYears(1).addDays(-1);
        sl.Bill62__Schedule_Payment_Date__c = Date.today();
        sl.Bill62__Subscription__c = s.Id;
        insert sl;
        
        Bill62__Payment__c newPay = new Bill62__Payment__c();
        newPay.Bill62__Amount__c = sl.Bill62__Amount__c;
        newPay.Bill62__Next_Payment_Attempt_Date__c = sl.Bill62__Subscription__r.Bill62__Start_Date__c;
        newPay.Bill62__Payment_Date__c = sl.Bill62__Cycle_Start_Date__c;// don't know why this was here: Bill62__Subscription__r.Bill62__Start_Date__c;
        newPay.Bill62__Subscription_Line__c = sl.Id;
        newPay.Bill62__Customer__c = sl.Bill62__Subscription__r.Bill62__Customer__c;
        newPay.Bill62__Status__c = 'Queued';
        newPay.Bill62__Payment_Method__c = sl.Bill62__Subscription__r.Bill62__Payment_Method__c;
        newPay.Bill62__Subscription__c = sl.Bill62__Subscription__c;
        insert newPay;
        
        delete sl;
    }
    
    //test removing of first month
    static testMethod void myUnitTest2() {
        Bill62__C62Billing_Config__c billingConfig = Bill62__C62Billing_Config__c.getOrgDefaults();
        billingConfig.Bill62__Allow_Multiple_Member_Subscriptions__c = true;
        billingConfig.Bill62__Create_Payments_From_Subscription_Lines__c = true;
        upsert billingConfig;
        
        Bill62__Payment_Gateway__c pg = new Bill62__Payment_Gateway__c();
        pg.Name = 'PayFlow NVP 1800accountant25';
        pg.Bill62__Production_URL__c = 'http://test.com';
        pg.Bill62__Vendor_Encrypted__c = 'test';
        pg.Bill62__Partner_Encrypted__c = 'test';
        pg.Bill62__Login_Encrypted__c = 'test';
        pg.Bill62__Password_Encrypted__c = 'test';
        insert pg;
        
        List<Round_Robin_Transaction_Setting__c> csInsert = new List<Round_Robin_Transaction_Setting__c>();
        Round_Robin_Transaction_Setting__c s1 = new Round_Robin_Transaction_Setting__c();
        s1.Name = 'PayFlow NVP 1800accountant25';
        s1.Company_Brand__c =  '1800Accountant';
        s1.Percentage__c =  0.25;
        csInsert.add(s1);
        
        Round_Robin_Transaction_Setting__c s2 = new Round_Robin_Transaction_Setting__c();
        s2.Name = 'PayFlow NVP 1800accountant2';
        s2.Company_Brand__c =  'Corporate Tax Network';
        s2.Percentage__c =  0.25;
        csInsert.add(s2);
        
        insert csInsert;
        
        Account a = new Account();
        a.Name = 'test';
        a.Company_Brand__c = '1800Accountant';
        insert a;
        
        Contact c = new Contact();
        c.FirstName = 'teest';
        c.LastName = 'test';
        c.Email = 'te@st.testtest';
        c.AccountId = a.Id;
        insert c;
        
        List<Product2> prodList = new List<Product2>();
        Product2 p2 = new Product2();
        p2.Name = 'test';
        p2.Product_Class__c = 'VTO Business';
        p2.Billing_Frequency__c = 'Monthly';
        p2.Remove_First_Month_Charge_Amount__c = 20;
        p2.Remove_First_Month_Charge__c = true;
        p2.Is_Split_Payment__c = true;
        p2.Split_Payment_Amount__c = 55;
        prodList.add(p2);
        
        Product2 p3 = new Product2();
        p3.Name = 'test2';
        p3.Product_Class__c = 'VTO Personal';
        prodList.add(p3);
        
        Product2 p4 = new Product2();
        p4.Name = 'test3';
        p4.Product_Class__c = 'VTO All';
        prodList.add(p4);
        
        insert prodList;
        
        Bill62__Billing_Schedule__c bs = new Bill62__Billing_Schedule__c();
        bs.Bill62__Active__c = true;
        bs.Bill62__Approved__c = true;
        bs.Bill62__Description__c = 'test';
        bs.Bill62__Product__c = p2.Id;
        insert bs;
        
        Bill62__Billing_Schedule_Line__c bsl = new Bill62__Billing_Schedule_Line__c();
        bsl.Bill62__Billing_Schedule__c = bs.Id;
        bsl.Bill62__Monthly_Amount__c = 20;
        bsl.Bill62__Charge_Amount__c = 20;
        bsl.Bill62__Charge_Month__c = 1;
        bsl.Bill62__Annual_Multiplier__c = 1;
        bsl.Bill62__Quarterly_Multiplier__c = 1;
        bsl.Bill62__SemiAnnual_Multiplier__c = 1;
        bsl.Bill62__Type__c = 'Dues';
        insert bsl;
        
        Bill62__Billing_Schedule_Line__c bs2 = new Bill62__Billing_Schedule_Line__c();
        bs2.Bill62__Billing_Schedule__c = bs.Id;
        bs2.Bill62__Monthly_Amount__c = 55;
        bs2.Bill62__Charge_Amount__c = 55;
        bs2.Bill62__Charge_Month__c = 1;
        bs2.Bill62__Annual_Multiplier__c = 1;
        bs2.Bill62__Quarterly_Multiplier__c = 1;
        bs2.Bill62__SemiAnnual_Multiplier__c = 1;
        bs2.Bill62__Type__c = 'Voluntary Dues';
        bs2.Bill62__One_Time_Fee__c = true;
        insert bs2;
        
        Bill62__Address__c ad = new Bill62__Address__c();
        ad.Bill62__City__c = 'Buffalo';
        ad.Bill62__Street_1__c = '123 fake st.';
        ad.Bill62__Country__c = 'United States';
        ad.Name = 'test';
        ad.Bill62__Zip_Postal_Code__c = '12345';
        ad.Bill62__Customer__c = c.Id;
        insert ad;
        
        Bill62__Payment_Method__c pm = new Bill62__Payment_Method__c();
        pm.Bill62__Customer__c = c.Id;
        pm.Bill62__Account__c = a.Id;
        pm.Bill62__Card_Type__c = 'MasterCard';
        pm.Bill62__Card_Number__c = '55555555554444';
        pm.Bill62__CVV_Code__c = '123';
        pm.Bill62__Expiration_Date__c = Date.today().addYears(2);
        pm.Bill62__Payment_Type__c = 'Credit Card';
        pm.Bill62__Billing_Address__c = ad.Id;
        insert pm;
        
        Bill62__Order__c o = new Bill62__Order__c();
        o.RecordTypeid = [SELECT ID FROM RECORDTYPE WHERE SOBJECTTYPE = 'Bill62__Order__c' AND NAME = 'Potential Order' LIMIT 1][0].Id;
        o.Bill62__Customer__c = c.Id;
        o.Name = 'test';
        insert o;
        
        Bill62__Subscription__c s = new Bill62__Subscription__c();
        s.Bill62__Address__c = ad.Id;
        s.Bill62__Customer__c = c.Id;
        s.Bill62__End_Date__c = Date.today().addYears(1).addDays(-1);
        s.Bill62__Start_Date__c = Date.today();
        String todayNum;
        if (Date.today().day() > 28){
            todayNum = '28';
        } else {
            todayNum = String.valueOf(Date.today().day());
        }
        s.Bill62__Monthly_Billing_Start_Day__c = todayNum;
        s.Bill62__Product__c = p2.Id;
        s.Bill62__Billing_Frequency__c = 'Annual';
        s.Bill62__Payment_Method__c = pm.Id;
        insert s;
        
        Bill62__Subscription_Line__c sl = new Bill62__Subscription_Line__c();
        sl.Bill62__Billing_Frequency__c = 'Annual';
        sl.Bill62__Cycle_Start_Date__c = Date.today();
        sl.Bill62__Cycle_End_Date__c = Date.today().addYears(1).addDays(-1);
        sl.Bill62__Full_Cycle_Amount__c = 100;
        sl.Bill62__Full_Cycle_Start_Date__c = Date.today();
        sl.Bill62__Full_Cycle_End_Date__c = Date.today().addYears(1).addDays(-1);
        sl.Bill62__Schedule_Payment_Date__c = Date.today();
        sl.Bill62__Subscription__c = s.Id;
        insert sl;
        
        Bill62__Payment__c newPay = new Bill62__Payment__c();
        newPay.Bill62__Amount__c = sl.Bill62__Amount__c;
        newPay.Bill62__Next_Payment_Attempt_Date__c = sl.Bill62__Subscription__r.Bill62__Start_Date__c;
        newPay.Bill62__Payment_Date__c = sl.Bill62__Cycle_Start_Date__c;// don't know why this was here: Bill62__Subscription__r.Bill62__Start_Date__c;
        newPay.Bill62__Subscription_Line__c = sl.Id;
        newPay.Bill62__Customer__c = sl.Bill62__Subscription__r.Bill62__Customer__c;
        newPay.Bill62__Status__c = 'Queued';
        newPay.Bill62__Payment_Method__c = sl.Bill62__Subscription__r.Bill62__Payment_Method__c;
        newPay.Bill62__Subscription__c = sl.Bill62__Subscription__c;
        insert newPay;
        Test.startTest();
        delete sl;
        Test.stopTest();
    }
}