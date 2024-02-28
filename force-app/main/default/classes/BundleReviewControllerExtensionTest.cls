@IsTest
public with sharing class BundleReviewControllerExtensionTest {
    
    @TestSetup
    static void makeData(){
        Lead l = new Lead(FirstName='first',LastName='last',status='new', company='company', email='test1@gtest.com');
        insert l;
        Account acc = new Account(Name='new account');
        insert acc;
        Opportunity opp = new Opportunity(AccountId = acc.Id, Name='name', StageName='New');
        insert opp;
        Product2 p = new Product2(Name = 'Loan Agreement', IsActive=true, Guided_Selling_Identifier__c='Personal Return',
        ChargeOver__c = true, Environment__c='Standard');
        insert p;
        PricebookEntry pbe = new PricebookEntry(Product2Id = p.id, IsActive=true, Pricebook2Id=Test.getStandardPricebookId(), UnitPrice=1.0);
        insert pbe;

        Product2 p2 = new Product2(Name = '1-800AccountantAccess', IsActive=true, Guided_Selling_Identifier__c='Business Return',
        ChargeOver__c = true, Environment__c='Standard', Billing_Frequency__c = 'Annual');
        insert p2;
        system.debug(p);
        system.debug(p2);
        PricebookEntry pbe2 = new PricebookEntry(Product2Id = p2.id, IsActive=true, Pricebook2Id=Test.getStandardPricebookId(), UnitPrice=12.0);
        insert pbe2;
    }

    @isTest 
    public static void fakeTest(){
        Lead l = [SELECT Id, FirstName, LastName, Status, Company, Email FROM Lead LIMIT 1];
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];

        Test.StartTest(); 
        ApexPages.currentPage().getParameters().put('recordId',String.valueOf(l.Id));
			//ApexPages.currentPage().getParameters().put('id', String.valueOf(contr.Id));
            Event e = new Event();
            ApexPages.StandardController sc = new ApexPages.StandardController(e);
			BundleReviewControllerExtension con = new BundleReviewControllerExtension(sc);
            con.getBaseUrl();
            con.hideSectionOnChange();
            con.getEntityType();
            con.getCurrency();
            con.getCurrencyProfit();
            con.getMileage();
            con.getOffice();
            con.getFilingStatus();
            BundleReviewControllerExtension.getLead(l.Email);
            BundleReviewControllerExtension.calculateSavings('','75000','5000','15000','150','Single','50000','',acc.Id);
            BundleReviewControllerExtension.calculateSavings('','75000','5000','15000','150','Single','50000','',l.Id);
            //BundleReviewControllerExtension.calculateSavings('','75000','5000','15000','150','Single','50000','',opp.Id);
            BundleReviewControllerExtension.upsertAndConvertLead(JSON.serialize(l));
            BundleReviewControllerExtension.upsertAndConvertLead(JSON.serialize(new Lead(FirstName='first2',LastName='last2',status='new', company='company2', email='test2@gtest.com')));
            BundleReviewControllerExtension.getConvertedIds(l.Id);
            BundleReviewControllerExtension.generateQuotes('Standard',opp.Id, acc.Id, JSON.serialize(l), 'Annual');

		Test.StopTest();
    }
}