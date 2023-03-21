@isTest
public with sharing class ChargeoverInvoiceLineTriggerTest {
    // public static Account acc;
    // public static Product2 prod;
    // public static Active_Subscriptions__c acSub;
    // public static Chargeover_Subscription__c chSub;
    // public static ChargeOver_Subscription_Line_Item__c subLine;
    // public static ChargeOver_Invoice_Line_Item__c inLine;
    @TestSetup
    static void makeData(){
        Account acc = new Account(Name='test');
        Product2 prod = new Product2(Name='test', Billing_Frequency__c = 'Annual', Fulfillable_Product_for_Renewal__c=true, zqu__EffectiveStartDate__c=Date.today(), zqu__EffectiveEndDate__c=Date.today().addDays(1), Family='Tax Prep and Advisory');
        Active_Subscriptions__c acSub = new Active_Subscriptions__c(Name='1-800Accountant Access', Customer_Number__c='123456');
        Chargeover_Subscription__c chSub = new Chargeover_Subscription__c(Name='567890');
        insert new List<sObject>{acc, prod, acSub, chSub};
        ChargeOver_Subscription_Line_Item__c subLine = new ChargeOver_Subscription_Line_Item__c(Name='1-800Accountant Access', Status__c='Active', Active_Subscription__c=acSub.Id, Chargeover_Subscription__c=chSub.Id, Subscription_Start_Date__c=Date.today());
        insert subLine;
        ChargeOver_Invoice_Line_Item__c inLine = new ChargeOver_Invoice_Line_Item__c(Name='1800', Quantity__c=2, Rate__c=123, Account__c=acc.Id, Product__c=prod.Id, ChargeOver_Subscription_Line_Item__c=subLine.Id, Payment_Type__c='Initial');
        insert inLine;
    }

    @isTest
    public static void testRenewal(){
        Integer subLines = [SELECT COUNT() FROM Active_Subscription_Line__c];
        Integer inLines = [SELECT COUNT() FROM ChargeOver_Invoice_Line_Item__c];
        Test.startTest();
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Product2 prod = [SELECT Id FROM Product2 LIMIT 1];
        ChargeOver_Subscription_Line_Item__c subLine = [SELECT Id FROM ChargeOver_Subscription_Line_Item__c LIMIT 1];
        ChargeOver_Invoice_Line_Item__c inLine = new ChargeOver_Invoice_Line_Item__c(Name='1800', Quantity__c=2, Rate__c=123, Account__c=acc.Id, Product__c=prod.Id, ChargeOver_Subscription_Line_Item__c=subLine.Id, Is_Obligation__c=true, First_Obligation_ID__c=1234, Payment_Type__c='Renewal');
        insert inLine;
        Test.stopTest();
        System.assertEquals(subLines+2, [SELECT COUNT() FROM Active_Subscription_Line__c]);
        System.assertEquals(inLines+1, [SELECT COUNT() FROM ChargeOver_Invoice_Line_Item__c]);
        //System.assertEquals(246, [SELECT Subscription_Amount__c FROM Active_Subscriptions__c][0].Subscription_Amount__c);
    }

    @isTest
    public static void testUpdate(){
        Integer subLines = [SELECT COUNT() FROM Active_Subscription_Line__c];
        Integer inLines = [SELECT COUNT() FROM ChargeOver_Invoice_Line_Item__c];
        Test.startTest();
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Product2 prod = [SELECT Id FROM Product2 LIMIT 1];
        ChargeOver_Subscription_Line_Item__c subLine = [SELECT Id FROM ChargeOver_Subscription_Line_Item__c LIMIT 1];
        ChargeOver_Invoice_Line_Item__c inLine = new ChargeOver_Invoice_Line_Item__c(Name='1800', Quantity__c=2, Rate__c=123, Account__c=acc.Id, Product__c=prod.Id, ChargeOver_Subscription_Line_Item__c=subLine.Id, Is_Obligation__c=true, First_Obligation_ID__c=1234, Payment_Type__c='Renewal');
        insert inLine;
        
        List<Active_Subscription_Line__c> asls = [SELECT Id FROM Active_Subscription_Line__c];
        System.debug('**asls: '+asls.size());
        System.debug([SELECT COUNT() FROM Active_Subscription_Line__c]);
        inline.ASL_Renewal_Trigger__c = true;
        update inLine;
        Test.stopTest();
        System.assertEquals(subLines+4, [SELECT COUNT() FROM Active_Subscription_Line__c]);
        System.assertEquals(inLines+1, [SELECT COUNT() FROM ChargeOver_Invoice_Line_Item__c]);
        //System.assertEquals(246, [SELECT Subscription_Amount__c FROM Active_Subscriptions__c][0].Subscription_Amount__c);
    }
}