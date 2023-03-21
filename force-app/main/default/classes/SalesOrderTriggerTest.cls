//test code
@isTest
private class SalesOrderTriggerTest{

    /*
        Negative test: new Opp, update it with conditions to not set fields
    */
    static testmethod void test01(){
        //get test data
        User u = getUser();
        
        Account a = getAccount();
        Opportunity o = getOpp(a.Id);
        o.OwnerId = u.Id;
        
        //start test
        Test.startTest();
        
        o.Billing_Status__c = 'Not Billed';
        update o;
        Account b = [SELECT ID,Sales_Rep__c,Corp_Sales_Owner__c,Merchant_Sales_Owner__c,OwnerId FROM Account];
        system.assertEquals(b.OwnerId, b.Sales_Rep__c, 'Sales Rep was set when it shouldnt');
        system.assertEquals(null, b.Corp_Sales_Owner__c, 'Corp Sales Owner was set when it shouldnt');
        system.assertEquals(null, b.Merchant_Sales_Owner__c, 'Merchant Sales Owner was set when it shouldnt');

        //stop test
        Test.stopTest();
    }
    
    /*
        Positive test: new Opp, update it with conditions to set fields
    */
    //static testmethod void test02(){
        //get test data
        //User u = getUser();
        
        //Account a = getAccount();
        //Opportunity o = getOpp(a.Id);
        //o.OwnerId = u.Id;
        
        //getOppLineItems(o);
        
        //start test
    //    Test.startTest();
        
        //o.Billing_Status__c = 'CC Paid';
        //update o;
        //Account b = [SELECT ID,Sales_Rep__c,Corp_Sales_Owner__c,Merchant_Sales_Owner__c FROM Account];
        //system.assertEquals(u.Id, b.Sales_Rep__c, 'Sales Rep was not set when it should');
        //system.assertEquals(u.Id, b.Corp_Sales_Owner__c, 'Corp Sales Owner was not set when it should');
        //system.assertEquals(u.Id, b.Merchant_Sales_Owner__c, 'Merchant Sales Owner was not set when it should');

        //stop test
    //    Test.stopTest();
    //}
    
    private static void getOppLineItems(Opportunity o){
        Product2 p1 = new Product2();
        p1.Name = 'First Product';
        p1.Family = 'Merchant Processing';
        insert p1;
        Product2 p2 = new Product2();
        p2.Name = 'Second Product';
        p2.Family = 'Corp';
        insert p2;
        Product2 p3 = new Product2();
        p3.Name = 'Third Product';
        p3.Family = 'Accounting Package';
        insert p3;
        
        String priceBookID = Test.getStandardPricebookId();
        
        PriceBookEntry pbe1 = new PriceBookEntry();
        pbe1.Pricebook2Id = priceBookID;//pb.Id;
        pbe1.UnitPrice = 1.0;
        pbe1.Product2Id = p1.Id;
        pbe1.isActive = true;
        insert pbe1;
        
        PriceBookEntry pbe2 = new PriceBookEntry();
        pbe2.Pricebook2Id = priceBookID;//pb.Id;
        pbe2.UnitPrice = 1.0;
        pbe2.Product2Id = p2.Id;
        pbe2.isActive = true;
        insert pbe2;
        
        PriceBookEntry pbe3 = new PriceBookEntry();
        pbe3.Pricebook2Id = priceBookID;//pb.Id;
        pbe3.UnitPrice = 1.0;
        pbe3.Product2Id = p3.Id;
        pbe3.isActive = true;
        insert pbe3;
        
        OpportunityLineItem oli1 = new OpportunityLineItem();
        oli1.PriceBookEntryId = pbe1.Id;
        oli1.OpportunityId = o.Id;
        oli1.Quantity = 1;
        oli1.TotalPrice = 1.0;
        insert oli1;
        
        OpportunityLineItem oli2 = new OpportunityLineItem();
        oli2.PriceBookEntryId = pbe2.Id;
        oli2.OpportunityId = o.Id;
        oli2.Quantity = 1;
        oli2.TotalPrice = 1.0;
        insert oli2;
        
        OpportunityLineItem oli3 = new OpportunityLineItem();
        oli3.PriceBookEntryId = pbe3.Id;
        oli3.OpportunityId = o.Id;
        oli3.Quantity = 1;
        oli3.TotalPrice = 1.0;
        insert oli3;
    }
    
    private static Opportunity getOpp(String accountId){
        Opportunity o = new Opportunity();
        o.StageName = 'Not Sold';
        o.Name = 'The Opp';
        o.CloseDate = system.Date.TODAY().addMonths(1);
        o.AccountId = accountId;
        insert o;
        return o;
    }

    private static Account getAccount(){
        Account a = new Account();
        a.Name = 'The Account';
        insert a;
        return a;
    }
    
    public static User getUser(){
        Profile p = [select id from profile where name='Standard User' LIMIT 1];
        User standardUser = new User(
          Username = getUserNamePrefix() + 'standarduser@testorg.com',
          Alias = 'standt',
          email = 'standarduser@testorg.com',
          emailencodingkey = 'UTF-8',
          LastName = 'Testing',
          LocaleSidKey = 'en_US',
          ProfileID = p.Id,
          TimeZoneSidKey = 'America/Los_Angeles',
          LanguageLocaleKey = 'en_US'
        );
        insert standardUser;
        return standardUser;
    }
    
    public static String getUserNamePrefix(){
        return UserInfo.getOrganizationId() + System.now().millisecond();
    }


}