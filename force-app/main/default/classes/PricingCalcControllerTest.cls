@isTest(seeAllData=true)
private class PricingCalcControllerTest {
    
    static testMethod void testPriceCalc(){
    
        String testID = '';
        String ownerID = '';
    
        Test.startTest();
        
        // get account
        List<Account> accounts = [SELECT Id, OwnerId FROM Account WHERE Name='test' AND Owner.Name != 'Do Not Reply' LIMIT 1];
            
        for(Account aItem : accounts){
            System.debug('found');
            testID = aItem.Id;
            ownerID = aItem.OwnerId;
        
        }
        
        //Account[] accounts = [SELECT Id, OwnerId FROM Account WHERE Name='test' AND Owner.Name != 'Do Not Reply' LIMIT 1];
        //System.debug(accounts.size());
        //if (accounts.size() > 0) {
        //    testID = accounts[0].Id;
        //    ownerID = accounts[0].OwnerId;
        //}
        System.debug(testID);
        // create test opportunity
        Opportunity op = new Opportunity();
        op.AccountId = testID;
        op.Name = 'Test Opportunity';
        op.StageName = 'New';
        op.OwnerId = ownerID;
        op.CloseDate = Date.today();
        insert op; 
        String offersJSON = '[{"Name":"Economy","Active__c":true,"Environment__c":"Standard","Default__c":false} ,' 
             + '{"Name":"Standard","Active__c":true,"Environment__c":"Standard","Default__c":false} ,' 
             + '{"Name":"Complete","Active__c":true,"Environment__c":"Standard","Default__c":false} ,' 
             + '{"Name":"EIN Discount","Active__c":true,"Environment__c":"EIN Tax Filing","Default__c":false} ,' 
             + '{"Name":"Opportunity","Active__c":true,"Environment__c":"Sprout","Default__c":true} ,' 
             + '{"Name":"Growth","Active__c":true,"Environment__c":"Sprout","Default__c":false} ,' 
             + '{"Name":"Advantage","Active__c":true,"Environment__c":"Sprout","Default__c":false} ,' 
             + '{"Name":"Custom Accounting Package","Active__c":false,"Environment__c":"Standard","Default__c":true}]';
        List<Calculator_Offer__c> offers = (List<Calculator_Offer__c>) JSON.deserialize(offersJson, List<Calculator_Offer__c>.class);
        insert offers;
        System.debug(op.Id);
        String offerProductsJSON = '[{"Amount__c":97.00,"Active__c":true, "Name":"EIN - Standard Processing","Delay_Days__c":0,"Master_Product__c":false,"Product__c":"01t3Z0000057HZGQA2","Upsell_Product__c":false,"Use_Pricebook__c":false},' 
            + '{"Amount__c":0.00,"Active__c":true, "Name":"Entity Formation","Delay_Days__c":0,"Master_Product__c":false,"Product__c":"01tf1000004hsUWAAY","Upsell_Product__c":false,"Use_Pricebook__c":false},'
            + '{"Amount__c":0.00,"Active__c":true, "Name":"Advantage","Delay_Days__c":0,"Master_Product__c":true,"Product__c":"01t3Z000004bmO2QAI","Upsell_Product__c":false,"Use_Pricebook__c":false}]';
        List<Calculator_Offer_Product__c> offerProducts = (List<Calculator_Offer_Product__c>)JSON.deserialize(offerProductsJSON, List<Calculator_Offer_Product__c>.class);
        for(Integer i = 0; i<offerProducts.size(); i++){
            offerProducts[i].Calculator_Offer__c = offers[i].Id;
        }
        insert offerProducts;
        
        ApexPages.currentPage().getParameters().put('A', testID);
        ApexPages.currentPage().getParameters().put('O', op.Id);
        ApexPages.currentPage().getParameters().put('Q', '');
        
        
        //PageReference pageRef = Page.Pricing_Calc_Form;
        
        //Test.setCurrentPage(pageRef);
        
        PricingCalcController controller = new PricingCalcController();

        // todo set form parameters for submission
        controller.accountID = testID;
        controller.accountNameInput = 'test';
        controller.opportunityID = op.Id;
        controller.quoteID = '';
        controller.stateOfIncorporationInput = 'California';
        controller.entityTypeInput = 'Single Member LLC';
        controller.industryTypeInput = 'Other';
        controller.totalStartupCostInput = '5000';
        controller.projectedFirstYearRevenueInput = '5000';
        controller.projectedFirstYearProfitInput = '0';
        controller.numberOfTransactionsInput = '0-75';
        controller.numberOfEmployeesInput = '1';
        controller.numberOfOwnersInput = '1';
        controller.personalIncomeInput = '50000';
        controller.numberOfRentalPropertiesInput = '1';
        //ApexPages.currentPage().getParameters().put('bundle', '');
        controller.billingTime = 'yrl';
        controller.billingStreetInput = '123 test';
        controller.billingCityInput = 'st george';
        controller.billingZipInput = '84790';
        controller.billingStateInput = 'UT';
        controller.billingCountryInput = 'United States';
        
        controller.doBusinessReturn = true;
        controller.businessQuantity = 1;
        
        controller.doPersonalReturn = true;
        controller.personalQuantity = 1;
        
        controller.doPayroll = true;
        controller.payrollQuantity = 1;
        
        controller.doAdvisory = true;
        controller.taxAdvisoryQuantity = 1;
        
        controller.doBookkeeping = true;
        controller.bookkeepingQuantity = 1;
        
        controller.doStateFiling = false;
        controller.stateFilingQuantity = 1;
        
        controller.doStateFilingCorp = false;
        controller.stateFilingCorpQuantity = 1;
        
        controller.doBackBookkeeping = false;
        controller.backBookkeepingQuantity = 1;
        
        controller.doForeignState = false;
        controller.foreignStateQuantity = 1;
        
        controller.doBackPayroll = false;
        controller.backPayrollQuantity = 1;
        
        controller.doBackBusiness = false;
        controller.backBusinessQuantity = 1;
        
        controller.doBackPersonal = false;
        controller.backPersonalQuantity = 1;
        
        controller.doNonProfitBookkeeping = false;
        controller.nonProfitBookkeepingQuantity = 1;
        
        controller.doNonProfitBackBookkeeping = false;
        controller.nonProfitBackBookkeepingQuantity = 1;
        
        System.debug(controller.advisoryAddonsJSON);
        PricingCalcController.priceOverrideWrapper wrap = new PricingCalcController.priceOverrideWrapper();
        wrap.ProductId = ''; wrap.amount = 1; wrap.productPostion = '';
        PricingCalcController.priceAdjustmentWrapper adjPrice = new PricingCalcController.priceAdjustmentWrapper();
        adjPrice.amount=1; adjPrice.percent=1; adjPrice.productId=''; adjPrice.productPostion='';
        PricingCalcController.productWrapper proWrap = new PricingCalcController.productWrapper();
        proWrap.AnnualMonthlyOption='';proWrap.Billing_Frequency='';proWrap.Bundles='';proWrap.Calculator_Location='';proWrap.Description='';proWrap.Disable_QTY_on_Calc=false;proWrap.EnvironmentList='';proWrap.HTML_Description='';proWrap.Id='';proWrap.MasterOffer=false;proWrap.Name='';proWrap.RevenueInstallmentPeriod='';proWrap.Setup_Fee='';proWrap.Sort_Order='';
        
        Integer ind = 0;
        for(PricingCalcController.myWrapperClass acItem : controller.acList){

            acItem.doIt = true;
            acItem.quantity = 1;
            
            if(++ind > 10){
                break;
            }
            
            
        }
        
        controller.doSubmit();
        
        controller.sleep(1);
        
        // todo set form parameters and dopay submission
        controller.doPay();
        //controller.doPayEmail();
        controller.doRedirect();
        
        Test.stopTest();
        
    }
    
    static testMethod void testPriceCalc2(){
    
        String testID = '';
        String ownerID = '';
    
        Test.startTest();
        
        // get account
        List<Account> accounts = [SELECT Id, OwnerId FROM Account WHERE Name='test' AND Owner.Name != 'Do Not Reply' LIMIT 1];
            
        for(Account aItem : accounts){
            System.debug('found');
            testID = aItem.Id;
            ownerID = aItem.OwnerId;
        
        }
        
        //Account[] accounts = [SELECT Id, OwnerId FROM Account WHERE Name='test' AND Owner.Name != 'Do Not Reply' LIMIT 1];
        //System.debug(accounts.size());
        //if (accounts.size() > 0) {
        //    testID = accounts[0].Id;
        //    ownerID = accounts[0].OwnerId;
        //}
        System.debug(testID);
        
        // create opportunity
        Opportunity op = new Opportunity();
        op.AccountId = testID;
        op.Name = 'Test Opportunity';
        op.StageName = 'New';
        op.OwnerId = ownerID;
        op.CloseDate = Date.today();
        insert op; 
        
        System.debug(op.Id);
        
        ApexPages.currentPage().getParameters().put('A', testID);
        ApexPages.currentPage().getParameters().put('O', op.Id);
        ApexPages.currentPage().getParameters().put('Q', '');
        
        
        //PageReference pageRef = Page.Pricing_Calc_Form;
        
        //Test.setCurrentPage(pageRef);
        
        PricingCalcController controller = new PricingCalcController();

        // todo set form parameters for submission
        controller.accountID = testID;
        controller.accountNameInput = 'test';
        controller.opportunityID = op.Id;
        controller.quoteID = '';
        controller.stateOfIncorporationInput = 'California';
        controller.entityTypeInput = 'Single Member LLC';
        controller.industryTypeInput = 'Other';
        controller.totalStartupCostInput = '5000';
        controller.projectedFirstYearRevenueInput = '5000';
        controller.projectedFirstYearProfitInput = '0';
        controller.numberOfTransactionsInput = '0-75';
        controller.numberOfEmployeesInput = '1';
        controller.numberOfOwnersInput = '1';
        controller.personalIncomeInput = '50000';
        controller.numberOfRentalPropertiesInput = '1';
        //ApexPages.currentPage().getParameters().put('bundle', '');
        controller.billingTime = 'mon';
        controller.billingStreetInput = '123 test';
        controller.billingCityInput = 'st george';
        controller.billingZipInput = '84790';
        controller.billingStateInput = 'UT';
        controller.billingCountryInput = 'United States';
        
        controller.doBusinessReturn = false;
        controller.businessQuantity = 1;
        
        controller.doPersonalReturn = false;
        controller.personalQuantity = 1;
        
        controller.doPayroll = false;
        controller.payrollQuantity = 1;
        
        controller.doAdvisory = false;
        controller.taxAdvisoryQuantity = 1;
        
        controller.doBookkeeping = false;
        controller.bookkeepingQuantity = 1;
        
        controller.doStateFiling = false;
        controller.stateFilingQuantity = 1;
        
        controller.doStateFilingCorp = false;
        controller.stateFilingCorpQuantity = 1;
        
        controller.doBackBookkeeping = false;
        controller.backBookkeepingQuantity = 1;
        
        controller.doForeignState = false;
        controller.foreignStateQuantity = 1;
        
        controller.doBackPayroll = false;
        controller.backPayrollQuantity = 1;
        
        controller.doBackBusiness = false;
        controller.backBusinessQuantity = 1;
        
        controller.doBackPersonal = false;
        controller.backPersonalQuantity = 1;
        
        controller.doNonProfitBookkeeping = false;
        controller.nonProfitBookkeepingQuantity = 1;
        
        controller.doNonProfitBackBookkeeping = false;
        controller.nonProfitBackBookkeepingQuantity = 1;
        
        for(PricingCalcController.myWrapperClass acItem : controller.acList){

            acItem.doIt = false;
            acItem.quantity = 1;
            
            break;
            
        }
        
        controller.doSubmit();
        
        controller.sleep(1);
        
        // todo set form parameters and dopay submission
        //controller.doPay();
        //controller.doPayEmail();
        
        //controller.doRedirect();
        
        Test.stopTest();
        //Adding some testing for the savings calculator
        Decimal calculateSavings = PricingCalcController.calculateSavings('Startup Cost', 'Single', 150000, 150000, 200, 300, 25000);
        Decimal calculateSavings2 = PricingCalcController.calculateSavings('QBI', 'Head of Household', 150000, 150000, 200, 300, 25000);
        Decimal calculateSCorporationSavings = PricingCalcController.calculateSCorporationSavings(0);
        Boolean displaySCorporationSavings = PricingCalcController.displaySCorporationSavings(0, 'S Corporation', 'S Corporation');
        String getDiscountData = PricingCalcController.getDiscountData('S Corporation', 'Transportation', '0', '0', '0', '2', '350000', '350000', '350000', 'CA', '350000', 'formRunPayrollBefore', 'formFilingStatus', '200', '1000');
        
    }
    static testMethod void testPriceCalcWithOppItems(){
    
        String testID = '';
        String ownerID = '';
    
        Test.startTest();
        
        // get account
        List<Account> accounts = [SELECT Id, OwnerId FROM Account WHERE Name='test' AND Owner.Name != 'Do Not Reply' LIMIT 1];
            
        for(Account aItem : accounts){
            System.debug('found');
            testID = aItem.Id;
            ownerID = aItem.OwnerId;
        
        }
        
        //Account[] accounts = [SELECT Id, OwnerId FROM Account WHERE Name='test' AND Owner.Name != 'Do Not Reply' LIMIT 1];
        //System.debug(accounts.size());
        //if (accounts.size() > 0) {
        //    testID = accounts[0].Id;
        //    ownerID = accounts[0].OwnerId;
        //}
        System.debug(testID);
        Id standardPricebookId = Test.getStandardPricebookId();
        // create opportunity
        Opportunity op = new Opportunity();
        op.AccountId = testID;
        op.Name = 'Test Opportunity';
        op.StageName = 'New';
        op.OwnerId = ownerID;
        op.CloseDate = Date.today();
        op.Pricebook2Id = standardPricebookId;
        insert op; 
        
        Quote q = new Quote(Pricebook2Id = standardPriceBookID, OpportunityId=op.Id, Name='Test Quote');
        insert q;
        
        List<OpportunityLineItem> oppItems = new List<OpportunityLineItem>{
            new OpportunityLineItem(Product2Id = '01tf1000003JjrqAAC', Quantity = 1, OpportunityId = op.Id, TotalPrice = 149),
            new OpportunityLineItem(Product2Id = '01tf1000003JjrbAAC', Quantity = 1, OpportunityId = op.Id, TotalPrice = 149),
            new OpportunityLineItem(Product2Id = '01tf1000003JjrcAAC', Quantity = 1, OpportunityId = op.Id, TotalPrice = 149),
            new OpportunityLineItem(Product2Id = '01tf1000003JjrtAAC', Quantity = 1, OpportunityId = op.Id, TotalPrice = 149),
            new OpportunityLineItem(Product2Id = '01tf1000003JjrdAAC', Quantity = 1, OpportunityId = op.Id, TotalPrice = 149),
            new OpportunityLineItem(Product2Id = '01tf1000004hhoGAAQ', Quantity = 1, OpportunityId = op.Id, TotalPrice = 149)
        };
        insert oppItems;
        System.debug(op.Id);
        
        ApexPages.currentPage().getParameters().put('A', testID);
        ApexPages.currentPage().getParameters().put('O', op.Id);
        ApexPages.currentPage().getParameters().put('Q', q.Id);
        
        
        //PageReference pageRef = Page.Pricing_Calc_Form;
        
        //Test.setCurrentPage(pageRef);
        
        PricingCalcController controller = new PricingCalcController();

        // todo set form parameters for submission
        controller.accountID = testID;
        controller.accountNameInput = 'test';
        controller.opportunityID = op.Id;
        controller.quoteID = '';
        controller.stateOfIncorporationInput = 'California';
        controller.entityTypeInput = 'Single Member LLC';
        controller.industryTypeInput = 'Other';
        controller.totalStartupCostInput = '5000';
        controller.projectedFirstYearRevenueInput = '5000';
        controller.projectedFirstYearProfitInput = '0';
        controller.numberOfTransactionsInput = '0-75';
        controller.numberOfEmployeesInput = '1';
        controller.numberOfOwnersInput = '1';
        controller.personalIncomeInput = '50000';
        controller.numberOfRentalPropertiesInput = '1';
        //ApexPages.currentPage().getParameters().put('bundle', '');
        controller.billingTime = 'mon';
        controller.billingStreetInput = '123 test';
        controller.billingCityInput = 'st george';
        controller.billingZipInput = '84790';
        controller.billingStateInput = 'UT';
        controller.billingCountryInput = 'United States';
        
        controller.doBusinessReturn = false;
        controller.businessQuantity = 1;
        
        controller.doPersonalReturn = false;
        controller.personalQuantity = 1;
        
        controller.doPayroll = false;
        controller.payrollQuantity = 1;
        
        controller.doAdvisory = false;
        controller.taxAdvisoryQuantity = 1;
        
        controller.doBookkeeping = false;
        controller.bookkeepingQuantity = 1;
        
        controller.doStateFiling = false;
        controller.stateFilingQuantity = 1;
        
        controller.doStateFilingCorp = false;
        controller.stateFilingCorpQuantity = 1;
        
        controller.doBackBookkeeping = false;
        controller.backBookkeepingQuantity = 1;
        
        controller.doForeignState = false;
        controller.foreignStateQuantity = 1;
        
        controller.doBackPayroll = false;
        controller.backPayrollQuantity = 1;
        
        controller.doBackBusiness = false;
        controller.backBusinessQuantity = 1;
        
        controller.doBackPersonal = false;
        controller.backPersonalQuantity = 1;
        
        controller.doNonProfitBookkeeping = false;
        controller.nonProfitBookkeepingQuantity = 1;
        
        controller.doNonProfitBackBookkeeping = false;
        controller.nonProfitBackBookkeepingQuantity = 1;
        
        for(PricingCalcController.myWrapperClass acItem : controller.acList){

            acItem.doIt = false;
            acItem.quantity = 1;
            
            break;
            
        }
        
        controller.doSubmit();
        
        controller.sleep(1);
        
        // todo set form parameters and dopay submission
        //controller.doPay();
        //controller.doPayEmail();
        
        //controller.doRedirect();
        
        Test.stopTest();
        
    }
    static testMethod void testPriceCalc3(){
    
        String testID = '';
        String ownerID = '';
    
        Test.startTest();
        
        // get account
        List<Account> accounts = [SELECT Id, OwnerId FROM Account WHERE Name='test' AND Owner.Name != 'Do Not Reply' LIMIT 1];
            
        for(Account aItem : accounts){
            System.debug('found');
            testID = aItem.Id;
            ownerID = aItem.OwnerId;
        
        }
        
        //Account[] accounts = [SELECT Id, OwnerId FROM Account WHERE Name='test' AND Owner.Name != 'Do Not Reply' LIMIT 1];
        //System.debug(accounts.size());
        //if (accounts.size() > 0) {
        //    testID = accounts[0].Id;
        //    ownerID = accounts[0].OwnerId;
        //}
        System.debug(testID);
        
        // create opportunity
        Opportunity op = new Opportunity();
        op.AccountId = testID;
        op.Name = 'Test Opportunity';
        op.StageName = 'New';
        op.OwnerId = ownerID;
        op.CloseDate = Date.today();
        insert op; 
        
        System.debug(op.Id);
        
        ApexPages.currentPage().getParameters().put('A', testID);
        ApexPages.currentPage().getParameters().put('O', op.Id);
        ApexPages.currentPage().getParameters().put('Q', '');
        
        
        //PageReference pageRef = Page.Pricing_Calc_Form;
        
        //Test.setCurrentPage(pageRef);
        
        PricingCalcController controller = new PricingCalcController();

        // todo set form parameters for submission
        controller.accountID = testID;
        controller.accountNameInput = 'test';
        controller.opportunityID = op.Id;
        controller.quoteID = '';
        controller.stateOfIncorporationInput = 'California';
        controller.entityTypeInput = 'Single Member LLC';
        controller.industryTypeInput = 'Other';
        controller.totalStartupCostInput = '5000';
        controller.projectedFirstYearRevenueInput = '5000';
        controller.projectedFirstYearProfitInput = '0';
        controller.numberOfTransactionsInput = '0-75';
        controller.numberOfEmployeesInput = '1';
        controller.numberOfOwnersInput = '1';
        controller.personalIncomeInput = '50000';
        controller.numberOfRentalPropertiesInput = '1';
        //ApexPages.currentPage().getParameters().put('bundle', '');
        controller.billingTime = '2pay';
        controller.billingStreetInput = '123 test';
        controller.billingCityInput = 'st george';
        controller.billingZipInput = '84790';
        controller.billingStateInput = 'UT';
        controller.billingCountryInput = 'United States';
        
        controller.doBusinessReturn = false;
        controller.businessQuantity = 1;
        
        controller.doPersonalReturn = false;
        controller.personalQuantity = 1;
        
        controller.doPayroll = false;
        controller.payrollQuantity = 1;
        
        controller.doAdvisory = false;
        controller.taxAdvisoryQuantity = 1;
        
        controller.doBookkeeping = false;
        controller.bookkeepingQuantity = 1;
        
        controller.doStateFiling = false;
        controller.stateFilingQuantity = 1;
        
        controller.doStateFilingCorp = false;
        controller.stateFilingCorpQuantity = 1;
        
        controller.doBackBookkeeping = false;
        controller.backBookkeepingQuantity = 1;
        
        controller.doForeignState = false;
        controller.foreignStateQuantity = 1;
        
        controller.doBackPayroll = false;
        controller.backPayrollQuantity = 1;
        
        controller.doBackBusiness = false;
        controller.backBusinessQuantity = 1;
        
        controller.doBackPersonal = false;
        controller.backPersonalQuantity = 1;
        
        controller.doNonProfitBookkeeping = false;
        controller.nonProfitBookkeepingQuantity = 1;
        
        controller.doNonProfitBackBookkeeping = false;
        controller.nonProfitBackBookkeepingQuantity = 1;
        
        //for(PricingCalcController.myWrapperClass acItem : controller.acList){

        //    acItem.doIt = true;
        //    acItem.quantity = 1;
            
        //    break;
            
        //}
        
        //controller.doSubmit();
        
        // todo set form parameters and dopay submission
        //controller.doPayEmail();
        
        Test.stopTest();
        
    }
    
    static testMethod void testPriceCalc4(){
    
        String testID = '';
        String ownerID = '';
    
        Test.startTest();
        
        // get account
        List<Account> accounts = [SELECT Id, OwnerId FROM Account WHERE Name='test' AND Owner.Name != 'Do Not Reply' LIMIT 1];
            
        for(Account aItem : accounts){
            System.debug('found');
            testID = aItem.Id;
            ownerID = aItem.OwnerId;
        
        }
        
        //Account[] accounts = [SELECT Id, OwnerId FROM Account WHERE Name='test' AND Owner.Name != 'Do Not Reply' LIMIT 1];
        //System.debug(accounts.size());
        //if (accounts.size() > 0) {
        //    testID = accounts[0].Id;
        //    ownerID = accounts[0].OwnerId;
        //}
        System.debug(testID);
        
        // create opportunity
        Opportunity op = new Opportunity();
        op.AccountId = testID;
        op.Name = 'Test Opportunity';
        op.StageName = 'New';
        op.OwnerId = ownerID;
        op.CloseDate = Date.today();
        insert op; 
        
        System.debug(op.Id);
        
        ApexPages.currentPage().getParameters().put('A', testID);
        ApexPages.currentPage().getParameters().put('O', op.Id);
        ApexPages.currentPage().getParameters().put('Q', '');
        
        
        //PageReference pageRef = Page.Pricing_Calc_Form;
        
        //Test.setCurrentPage(pageRef);
        
        PricingCalcController controller = new PricingCalcController();

        // todo set form parameters for submission
        controller.accountID = testID;
        controller.accountNameInput = 'test';
        controller.opportunityID = op.Id;
        controller.quoteID = '';
        controller.stateOfIncorporationInput = 'California';
        controller.entityTypeInput = 'Single Member LLC';
        controller.industryTypeInput = 'Other';
        controller.totalStartupCostInput = '5000';
        controller.projectedFirstYearRevenueInput = '5000';
        controller.projectedFirstYearProfitInput = '0';
        controller.numberOfTransactionsInput = '0-75';
        controller.numberOfEmployeesInput = '1';
        controller.numberOfOwnersInput = '1';
        controller.personalIncomeInput = '50000';
        controller.numberOfRentalPropertiesInput = '1';
        //ApexPages.currentPage().getParameters().put('bundle', '');
        controller.billingTime = '3pay';
        controller.billingStreetInput = '123 test';
        controller.billingCityInput = 'st george';
        controller.billingZipInput = '84790';
        controller.billingStateInput = 'UT';
        controller.billingCountryInput = 'United States';
        
        controller.doBusinessReturn = false;
        controller.businessQuantity = 1;
        
        controller.doPersonalReturn = false;
        controller.personalQuantity = 1;
        
        controller.doPayroll = false;
        controller.payrollQuantity = 1;
        
        controller.doAdvisory = false;
        controller.taxAdvisoryQuantity = 1;
        
        controller.doBookkeeping = false;
        controller.bookkeepingQuantity = 1;
        
        controller.doStateFiling = false;
        controller.stateFilingQuantity = 1;
        
        controller.doStateFilingCorp = false;
        controller.stateFilingCorpQuantity = 1;
        
        controller.doBackBookkeeping = false;
        controller.backBookkeepingQuantity = 1;
        
        controller.doForeignState = false;
        controller.foreignStateQuantity = 1;
        
        controller.doBackPayroll = false;
        controller.backPayrollQuantity = 1;
        
        controller.doBackBusiness = false;
        controller.backBusinessQuantity = 1;
        
        controller.doBackPersonal = false;
        controller.backPersonalQuantity = 1;
        
        controller.doNonProfitBookkeeping = false;
        controller.nonProfitBookkeepingQuantity = 1;
        
        controller.doNonProfitBackBookkeeping = false;
        controller.nonProfitBackBookkeepingQuantity = 1;
        
        for(PricingCalcController.myWrapperClass acItem : controller.acList){

            acItem.doIt = true;
            acItem.quantity = 1;
            
            break;
            
        }
        
        //controller.doSubmit();
        
        Test.stopTest();
        
    }
    
    static testMethod void testPriceCalc5(){
    
        String testID = '';
        String ownerID = '';
    
        Test.startTest();
        
        // get account
        List<Account> accounts = [SELECT Id, OwnerId FROM Account WHERE Name='test' AND Owner.Name != 'Do Not Reply' LIMIT 1];
            
        for(Account aItem : accounts){
            System.debug('found');
            testID = aItem.Id;
            ownerID = aItem.OwnerId;
        
        }
        
        //Account[] accounts = [SELECT Id, OwnerId FROM Account WHERE Name='test' AND Owner.Name != 'Do Not Reply' LIMIT 1];
        //System.debug(accounts.size());
        //if (accounts.size() > 0) {
        //    testID = accounts[0].Id;
        //    ownerID = accounts[0].OwnerId;
        //}
        System.debug(testID);
        
        // create opportunity
        Opportunity op = new Opportunity();
        op.AccountId = testID;
        op.Name = 'Test Opportunity';
        op.StageName = 'New';
        op.OwnerId = ownerID;
        op.CloseDate = Date.today();
        insert op; 
        
        System.debug(op.Id);
        
        ApexPages.currentPage().getParameters().put('A', testID);
        ApexPages.currentPage().getParameters().put('O', op.Id);
        ApexPages.currentPage().getParameters().put('Q', '');
        
        
        //PageReference pageRef = Page.Pricing_Calc_Form;
        
        //Test.setCurrentPage(pageRef);
        
        PricingCalcController controller = new PricingCalcController();

        // todo set form parameters for submission
        controller.accountID = testID;
        controller.accountNameInput = 'test';
        controller.opportunityID = op.Id;
        controller.quoteID = '';
        controller.stateOfIncorporationInput = 'California';
        controller.entityTypeInput = 'Single Member LLC';
        controller.industryTypeInput = 'Other';
        controller.totalStartupCostInput = '5000';
        controller.projectedFirstYearRevenueInput = '5000';
        controller.projectedFirstYearProfitInput = '0';
        controller.numberOfTransactionsInput = '0-75';
        controller.numberOfEmployeesInput = '1';
        controller.numberOfOwnersInput = '1';
        controller.personalIncomeInput = '50000';
        controller.numberOfRentalPropertiesInput = '1';
        //ApexPages.currentPage().getParameters().put('bundle', '');
        controller.billingTime = '4pay';
        controller.billingStreetInput = '123 test';
        controller.billingCityInput = 'st george';
        controller.billingZipInput = '84790';
        controller.billingStateInput = 'UT';
        controller.billingCountryInput = 'United States';
        
        controller.doBusinessReturn = false;
        controller.businessQuantity = 1;
        
        controller.doPersonalReturn = false;
        controller.personalQuantity = 1;
        
        controller.doPayroll = false;
        controller.payrollQuantity = 1;
        
        controller.doAdvisory = false;
        controller.taxAdvisoryQuantity = 1;
        
        controller.doBookkeeping = false;
        controller.bookkeepingQuantity = 1;
        
        controller.doStateFiling = false;
        controller.stateFilingQuantity = 1;
        
        controller.doStateFilingCorp = false;
        controller.stateFilingCorpQuantity = 1;
        
        controller.doBackBookkeeping = false;
        controller.backBookkeepingQuantity = 1;
        
        controller.doForeignState = false;
        controller.foreignStateQuantity = 1;
        
        controller.doBackPayroll = false;
        controller.backPayrollQuantity = 1;
        
        controller.doBackBusiness = false;
        controller.backBusinessQuantity = 1;
        
        controller.doBackPersonal = false;
        controller.backPersonalQuantity = 1;
        
        controller.doNonProfitBookkeeping = false;
        controller.nonProfitBookkeepingQuantity = 1;
        
        controller.doNonProfitBackBookkeeping = false;
        controller.nonProfitBackBookkeepingQuantity = 1;
        
        for(PricingCalcController.myWrapperClass acItem : controller.acList){

            acItem.doIt = true;
            acItem.quantity = 1;
            
            break;
            
        }
        
        //controller.doSubmit();
        
        Test.stopTest();
        
    }
    
    static testMethod void testPriceCalc6(){
    
        String testID = '';
        String ownerID = '';
    
        Test.startTest();
        
        // get account
        List<Account> accounts = [SELECT Id, OwnerId FROM Account WHERE Name='test' AND Owner.Name != 'Do Not Reply' LIMIT 1];
            
        for(Account aItem : accounts){
            System.debug('found');
            testID = aItem.Id;
            ownerID = aItem.OwnerId;
        
        }
        
        System.debug(testID);
        
        // create opportunity
        Opportunity op = new Opportunity();
        op.AccountId = testID;
        op.Name = 'Test Opportunity';
        op.StageName = 'New';
        op.OwnerId = ownerID;
        op.CloseDate = Date.today();
        insert op; 
        
        // create quote
        String standardPriceBookID = '01sj0000000J4tSAAS';
        
        List<Pricebook2> pbList = [SELECT Id, Name, IsActive, IsStandard FROM Pricebook2 WHERE IsActive = true AND IsStandard = true];
        
        for(Pricebook2 pbItem : pbList){
            standardPriceBookID = pbItem.Id;
        }
        
        // create new quote, todo, check for existing quote first
        Quote theQuote;
        
        //ChargeOver_Quote__c theCOQuote;

        theQuote = new Quote(
            Name = 'Calculated Quote',
            OpportunityId = op.Id,
            Pricebook2Id = standardPriceBookID
        );
    
        insert theQuote;
        

        System.debug(op.Id);
        
        ApexPages.currentPage().getParameters().put('A', testID);
        ApexPages.currentPage().getParameters().put('O', op.Id);
        ApexPages.currentPage().getParameters().put('Q', theQuote.Id);
        
        
        //PageReference pageRef = Page.Pricing_Calc_Form;
        
        //Test.setCurrentPage(pageRef);
        
        PricingCalcController controller = new PricingCalcController();

        // todo set form parameters for submission
        controller.accountID = testID;
        controller.accountNameInput = 'test';
        controller.opportunityID = op.Id;
        controller.quoteID = theQuote.Id;
        controller.stateOfIncorporationInput = 'California';
        controller.entityTypeInput = 'Single Member LLC';
        controller.industryTypeInput = 'Other';
        controller.totalStartupCostInput = '5000';
        controller.projectedFirstYearRevenueInput = '5000';
        controller.projectedFirstYearProfitInput = '0';
        controller.numberOfTransactionsInput = '0-75';
        controller.numberOfEmployeesInput = '1';
        controller.numberOfOwnersInput = '1';
        controller.personalIncomeInput = '50000';
        controller.numberOfRentalPropertiesInput = '1';
        //ApexPages.currentPage().getParameters().put('bundle', '');
        controller.billingTime = '6pay';
        controller.billingStreetInput = '123 test';
        controller.billingCityInput = 'st george';
        controller.billingZipInput = '84790';
        controller.billingStateInput = 'UT';
        controller.billingCountryInput = 'United States';
        
        controller.doBusinessReturn = false;
        controller.businessQuantity = 1;
        
        controller.doPersonalReturn = false;
        controller.personalQuantity = 1;
        
        controller.doPayroll = false;
        controller.payrollQuantity = 1;
        
        controller.doAdvisory = false;
        controller.taxAdvisoryQuantity = 1;
        
        controller.doBookkeeping = false;
        controller.bookkeepingQuantity = 1;
        
        controller.doStateFiling = false;
        controller.stateFilingQuantity = 1;
        
        controller.doStateFilingCorp = false;
        controller.stateFilingCorpQuantity = 1;
        
        controller.doBackBookkeeping = false;
        controller.backBookkeepingQuantity = 1;
        
        controller.doForeignState = false;
        controller.foreignStateQuantity = 1;
        
        controller.doBackPayroll = false;
        controller.backPayrollQuantity = 1;
        
        controller.doBackBusiness = false;
        controller.backBusinessQuantity = 1;
        
        controller.doBackPersonal = false;
        controller.backPersonalQuantity = 1;
        
        controller.doNonProfitBookkeeping = false;
        controller.nonProfitBookkeepingQuantity = 1;
        
        controller.doNonProfitBackBookkeeping = false;
        controller.nonProfitBackBookkeepingQuantity = 1;
        
        //controller.doSubmit();
        
        controller.doForm();
        
        //controller.showLocked();
        
        //controller.showApproved();
        
        Test.stopTest();
        
    }
    
}