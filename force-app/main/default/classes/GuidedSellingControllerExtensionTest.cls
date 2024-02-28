@isTest
private class GuidedSellingControllerExtensionTest {
    
    /* 
    * Tests for methods on class GuidedSellingControllerExtension 
    */

    @TestSetup
    static void makeData(){
        Pricebook2 pb = new Pricebook2 (
            Id = Test.getStandardPricebookId(),
            IsActive = true,
            Environment__c = 'Standard'
        );
        try{
            update pb;
        } catch(Exception ex){
            System.debug(ex.getMessage());
        }        
        Lead l = new Lead(FirstName='first',LastName='last',status='new', company='company', email='test1@gtest.com');
        insert l;
        Account acc = new Account(Name='new account');
        insert acc;
        Opportunity opp = new Opportunity(CloseDate=Date.today(), AccountId = acc.Id, Name='name', StageName='New');
        insert opp;
        Product2 p = new Product2(Name = 'Loan Agreement', IsActive=true, Guided_Selling_Identifier__c='Personal Return',
        ChargeOver__c = true, Environment__c='Standard',Billing_Frequency__c = 'Annual',HTML_Description__c = 'test', Description = 'test', No_Split_Allowed__c = true, sort_Order__c = 2);
        //insert p;
        //insert pbe;
        Contact c = new Contact(
            FirstName = 'test',
            LastName = 'Contact', 
            Email = 'test@1800accountant.com', 
            AccountId = acc.Id
        );
        insert c;
        Business__c b = new Business__c(
            Name = 'Test Business',
            Account__c = acc.Id
        );   
        insert b;
        Business_Owner__c bo = new Business_Owner__c(
            Name = 'Test Business Owner',
            Business__c = b.Id, 
            Primary_Contact__c = true
        );   
        insert bo;


        Event e = new Event(
            Subject = 'Test Event',
            WhoId = c.Id,
            WhatId = acc.Id,
            Type_of_Appointment__c = 'Tax Savings Analysis', 
            StartDateTime = system.today(), 
            DurationInMinutes = 20
        ); 
        insert e;

        Product2 p2 = new Product2(Name = '1-800AccountantAccess', IsActive=true, Guided_Selling_Identifier__c='Business Return',
        ChargeOver__c = true, Environment__c='Standard', Billing_Frequency__c = 'Annual',HTML_Description__c = 'test', Description = 'test', No_Split_Allowed__c = true, sort_Order__c = 2);
        //insert p2;
        system.debug(p);
        system.debug(p2);
        //insert pbe2;
        Product2 p3 = new Product2 (
            Name = 'Test prod 3',
            Calculator_Location__c = 'A La Carte', 
            AnnualMonthlyOption__c = true, 
            Billing_Frequency__c = 'One-Time', 
            HTML_Description__c = 'test', 
            Description = 'test', 
            No_Split_Allowed__c = true, 
            Guided_Selling_Identifier__c = 'Test prod 3', 
            sort_Order__c = 3
            );
        //insert p3;

        Product2 p4 = new Product2 (
            Name = 'Test prod 4',
            Calculator_Location__c = 'A La Carte', 
            AnnualMonthlyOption__c = true, 
            Billing_Frequency__c = 'Annual', 
            HTML_Description__c = 'test', 
            Description = 'test', 
            No_Split_Allowed__c = true, 
            Guided_Selling_Identifier__c = 'Test prod 4', 
            sort_Order__c = 4
            );
        //insert p4;

        Product2 p5 = new Product2 (
            Name = 'Test prod 5',
            Calculator_Location__c = 'Advisory', 
            AnnualMonthlyOption__c = true, 
            Billing_Frequency__c = 'Annual', 
            HTML_Description__c = 'test', 
            Description = 'test', 
            No_Split_Allowed__c = true, 
            Guided_Selling_Identifier__c = 'Test prod 5', 
            sort_Order__c = 5
            );
        //insert p5;
        insert new List<Product2>{p,p2,p3,p4,p5};
        PricebookEntry pbe = new PricebookEntry(Product2Id = p.id, IsActive=true, Pricebook2Id=Test.getStandardPricebookId(), UnitPrice=1.0);
        PricebookEntry pbe2 = new PricebookEntry(Product2Id = p2.id, IsActive=true, Pricebook2Id=Test.getStandardPricebookId(), UnitPrice=12.0);

        PricebookEntry pbe3 = new PricebookEntry(
            UnitPrice = 0, 
            IsActive = true, 
            Pricebook2Id = pb.Id, 
            Product2Id = p3.Id
        );

        PricebookEntry pbe4 = new PricebookEntry(
            UnitPrice = 365, 
            IsActive = true, 
            Pricebook2Id = pb.Id, 
            Product2Id = p4.Id
        );

        PricebookEntry pbe5 = new PricebookEntry(
            UnitPrice = 1125, 
            IsActive = true, 
            Pricebook2Id = pb.Id, 
            Product2Id = p5.Id
        );

        insert new List<PricebookEntry>{pbe,pbe2,pbe3,pbe4,pbe5};

        OpportunityLineItem oli1 = new OpportunityLineItem(
            OpportunityId = opp.Id,
            Payment_Cycle__c = 'yrl',
            Installment_Payment_Schedule__c = 'Yearly',
            Quantity = 1.0,
            UnitPrice = 1.0,
            Description = 'Test prod 3',
            Product2Id = p3.Id,            
            PricebookEntryId = pbe4.Id
        );

        OpportunityLineItem oli2 = new OpportunityLineItem(
            OpportunityId = opp.Id,
            Payment_Cycle__c = 'yrl',
            Installment_Payment_Schedule__c = '2-Pay',
            Quantity = 1.0,
            UnitPrice = 1.0,
            Description = 'Test prod 4',
            Product2Id = p4.Id,
            PricebookEntryId = pbe4.Id
        );

        insert new List<OpportunityLineItem>{oli1, oli2};

        Quote testQuote = new Quote(
            Name = 'test quote',
            OpportunityId = opp.Id,
            billingSchedule__c = 'yrl',
            Calc_Bookkeeping_Start_Date__c = '2023-10-09',
            Calc_Bookkeeping_End_Date__c = '2023-11-09'
        );
        insert testQuote;
    }


    @isTest
    static void GuidedSellingControllerExtensionMainTest() {
        
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];
        Business__c b = [SELECT Id FROM Business__c LIMIT 1];
        Business_Owner__c bo = [SELECT Id FROM Business_Owner__c LIMIT 1];

        List<Business_Owner__c> boList = new List<Business_Owner__c>();
        boList.add(bo);

        Pricebook2 pb = [SELECT Id, IsActive, Environment__c FROM Pricebook2 WHERE Id = :Test.getStandardPricebookId()];
        Product2 p = [SELECT Id FROM Product2 WHERE Guided_Selling_Identifier__c != null LIMIT 1];
        // List<Product2> pList = new List<Product2>();
        // pList.add(p);

        PricebookEntry pbe1 = new PricebookEntry(
            UnitPrice = 29.99, 
            IsActive = true, 
            Pricebook2Id = pb.Id, 
            Product2Id = p.Id
        );

        PageReference pageRef2 = Page.GuidedSellingPage;
        Test.setCurrentPage(pageRef2);
        ApexPages.currentPage().getParameters().put('rid', opp.Id);
        GuidedSellingControllerExtension gs = new GuidedSellingControllerExtension(new ApexPages.StandardController(opp));

        //gs.defaultNumForeignOwners = '0';
        gs.defaultYearsInBusiness = '0';
        gs.defaultEntity = 'LLC';
        gs.defaultIndustry = 'Other';
        gs.defaultDomesticState = 'California';
        gs.defaultForeignState = 'California';
        //gs.defaultPersonalState = 'California';
        gs.defaultStartupCosts = '5000';
        gs.defaultRevenue = '5000';
        gs.defaultFirstYearProfit = '0';
        //gs.defaultInvestorFunding = '0';
        gs.defaultNumTransactions = '0-75';
        gs.defaultNumOwners = '1';
        gs.defaultNumEmployees = '1';
        //gs.defaultNumContractors = '1';
        gs.defaultFilingStatus = 'Single';
        gs.defaultPersonalIncome = '50000';
        gs.defaultNumberOfRentalProperties = '1';
        //gs.defaultOtherInvestments = 'No';
        gs.defaultOffice = '200';
        gs.defaultMileage = '7500';
        gs.defaultState = 'California';
        gs.defaultNumberOfEmployeeContractors = 'Yes';
        gs.requiredfields = 'First Business';
        gs.disabledProducts = '';
        gs.stringDefaultProducts = '';
        gs.theAccountId = ac.Id;
        gs.defaultCountry = 'United States';
        gs.hasRecordId = true;
        gs.useBTPLegalZoomScript = false;
        gs.useBAPLegalZoomScript = false;
        gs.firstBusiness = true;
        gs.runPayrollBefore = true;
        gs.hasEmployeesContractors = true;
        //gs.foreignIncome = true;
        gs.hasRentalProperties = true;
        gs.isWorkingFromHome = true;
        gs.commutesWithOwnVehicle = true;
        //gs.eCommerce = true;
        gs.numRequiredFields = 1;
        gs.opportunity = opp;
        gs.account = ac;
        gs.business = b;
        gs.businessOwner = bo;
        gs.partners = boList;
        // gs.finalProducts = pList;
        gs.businessId = b.Id;
        gs.nonProfitTaxPrepId = p.Id;
        gs.businessReturnId = p.Id;    

        gs.getStateOfIncorporation();
        gs.getEntityType();
        gs.getIndustryType();
        gs.getMoneyAmount();
        gs.getMileage();
        gs.getOffice();
        gs.getFilingStatus();
        gs.getNumberOf();
        gs.getYearsInBusiness();
        gs.getNumberOfTransactions();
        gs.getNumberOfEmployeeContractors();
        gs.getNumberOfRentalProperties();
        gs.getContries();
    }

    @isTest
    static void getProductDataTest(){
        Test.startTest();
        Opportunity opp = new Opportunity();
        Opportunity l = [SELECT Id FROM Opportunity LIMIT 1];
        ApexPages.StandardController a = new ApexPages.StandardController(l);
        ApexPages.currentPage().getParameters().put('rId',String.valueOf(l.Id));
        GuidedSellingControllerExtension gs = new GuidedSellingControllerExtension(a);
        gs.getProductData();
        Test.stopTest();

    }
    @isTest
    static void calculateSavingsGuidedSellingTest() {
        
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];
        Business__c b = [SELECT Id FROM Business__c LIMIT 1];
        String res = GuidedSellingControllerExtension.calculateSavingsGuidedSelling('LLC', '50000', '75000', '15000', '200', 'Married Filing Separate', '100000', 'Banking', ac.Id);
    }

    @isTest
    static void createUpdatePartnerTest() {
        
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];
        Business__c b = [SELECT Id FROM Business__c LIMIT 1];
        Business_Owner__c bo = [SELECT Id FROM Business_Owner__c LIMIT 1];

        String partnerData = '{"firstName":"John","lastName":"Smith","role":"Manager","email":"jsmith22023@gmail.com","phone":"5555555555"}';

        String res1 = GuidedSellingControllerExtension.createUpdatePartner(b.Id, bo.Id, 'test company', partnerData);
        String res2 = GuidedSellingControllerExtension.createUpdatePartner(b.Id, null, 'test company', partnerData);
    }

    @isTest
    static void dispositionEventTest() {
        
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];
        Business__c b = [SELECT Id FROM Business__c LIMIT 1];

        GuidedSellingControllerExtension.dispositionEvent(e.Id, 'Canceled', 'Consulted', ac.Id);
        GuidedSellingControllerExtension.dispositionEvent(e.Id, 'Not Interested', 'Consulted', ac.Id);
    }


    @isTest
    static void saveNoteTest() {
        
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];
        Contact c = [SELECT Id FROM Contact LIMIT 1];

        GuidedSellingControllerExtension.saveNote(c.Id, 'this is a note', 'Testing Note Saving');
    }

    @isTest
    static void saveAnswersTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];
        Business__c b = [SELECT Id FROM Business__c LIMIT 1];

        String answers = 'What entity type is your business?LLC///What industry is your business in?Banking///What is your state of incorporation?Delaware///How much have you invested so far in start-up costs?75000///What do you anticipate your revenue to be over the next 12 months?75000///What do you project your 1st year profit to be over the next 12 months?50000///How many owners are outside the USA?6///How many employees do you have?16///How many contractors do you have?12///What is your tax filing status?Married Filing Separate///What was your household W-2 income last year?100000///How many rental properties do you have?4///What is the approximate square footage of your home office?200///How many business-related miles do you estimate you’ll drive per year?7500///Is this your first business?Yes///Do you currently have any employees?Yes///Do you currently have any rental properties?Yes///Will you be working from home?Yes///Will you use your personal vehicle for business purposes?Yes';

        GuidedSellingControllerExtension.saveAnswers(answers, b.Id, ac.Id, 'Standard');
    }

    @isTest
    static void saveBusinessDataTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];
        Business__c b = [SELECT Id FROM Business__c LIMIT 1];

        GuidedSellingControllerExtension.saveBusinessData('New name business', b.Id, 'LLC', ac.Id);
    }

    @isTest
    static void saveClientInfoTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];
        Business__c b = [SELECT Id FROM Business__c LIMIT 1];
        Business_Owner__c bo = [SELECT Id FROM Business_Owner__c LIMIT 1];

        GuidedSellingControllerExtension.saveClientInfo('personal', b.Id, bo.Id, ac.Id, 'tbo@1800accountant.com', '5555001122', '', '', '', '', '');
        GuidedSellingControllerExtension.saveClientInfo('billing', b.Id, bo.Id, ac.Id, '', '', '105 KROME AVE', 'Miami', 'Florida', '33185', 'United States');
    }

    @isTest
    static void getBusinessInfoTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];


        GuidedSellingControllerExtension.getBusinessInfo(ac.Id);
    }

   

    @isTest
    static void doSubmitTest() {
        List<Product2> prods = [SELECT Id, Name, Calculator_Location__c, AnnualMonthlyOption__c,Billing_Frequency__c,HTML_Description__c,
        Description,No_Split_Allowed__c,Guided_Selling_Identifier__c,sort_Order__c FROM Product2 WHERE Guided_Selling_Identifier__c != null];
        List<GuidedSellingProduct> gsprods = new List<GuidedSellingProduct>();
        for(Product2 prod : prods){
            gsprods.add(new GuidedSellingProduct(prod));
        }
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];

        String res = GuidedSellingControllerExtension.doSubmit('Standard', JSON.serialize(gsprods), (String)opp.Id, (String)ac.Id, 'yrl', '2023-05-03', '2023-07-03', 'true', null);
    }

    /* 
    * Tests for methods on class GuidedSellingClientControllerExtension 
    */

    @isTest
    static void GuidedSellingClientControllerExtensionMainTest() {
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];

        PageReference pageRef2 = Page.CV_TSA_Intro;
        Test.setCurrentPage(pageRef2);
        ApexPages.currentPage().getParameters().put('rId', e.Id);
        GuidedSellingClientControllerExtension gs = new GuidedSellingClientControllerExtension(new ApexPages.StandardController(opp));
    }

    @isTest
    static void GuidedSellingEditTest() {
        Quote testQuote = [SELECT Id FROM Quote LIMIT 1];
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];
        Business__c b = [SELECT Id FROM Business__c LIMIT 1];
        Business_Owner__c bo = [SELECT Id FROM Business_Owner__c LIMIT 1];

        List<Business_Owner__c> boList = new List<Business_Owner__c>();
        boList.add(bo);

        Pricebook2 pb = [SELECT Id, IsActive, Environment__c FROM Pricebook2 WHERE Id = :Test.getStandardPricebookId()];
        Product2 p = [SELECT Id FROM Product2 WHERE Guided_Selling_Identifier__c != null LIMIT 1];

        PageReference pageRef2 = Page.GuidedSellingPage;
        Test.setCurrentPage(pageRef2);
        ApexPages.currentPage().getParameters().put('Q', testQuote.Id);        
        ApexPages.currentPage().getParameters().put('rid', opp.Id);
        GuidedSellingEditControllerExtension gs = new GuidedSellingEditControllerExtension(new ApexPages.StandardController(opp));

        gs.defaultYearsInBusiness = '0';
        gs.defaultEntity = 'LLC';
        gs.defaultIndustry = 'Other';
        gs.defaultDomesticState = 'California';
        gs.defaultForeignState = 'California';
        //gs.defaultPersonalState = 'California';
        gs.defaultStartupCosts = '5000';
        gs.defaultRevenue = '5000';
        gs.defaultFirstYearProfit = '0';
        //gs.defaultInvestorFunding = '0';
        gs.defaultNumTransactions = '0-75';
        gs.defaultNumOwners = '1';
        gs.defaultNumEmployees = '1';
        //gs.defaultNumContractors = '1';
        gs.defaultFilingStatus = 'Single';
        gs.defaultPersonalIncome = '50000';
        gs.defaultNumberOfRentalProperties = '1';
        //gs.defaultOtherInvestments = 'No';
        gs.defaultOffice = '200';
        gs.defaultMileage = '7500';
        gs.defaultState = 'California';
        gs.defaultNumberOfEmployeeContractors = 'Yes';
        gs.requiredfields = 'First Business';
        gs.disabledProducts = '';
        gs.stringDefaultProducts = '';
        gs.theAccountId = ac.Id;
        gs.defaultCountry = 'United States';
        gs.hasRecordId = true;
        gs.useBTPLegalZoomScript = false;
        gs.useBAPLegalZoomScript = false;
        gs.firstBusiness = true;
        gs.runPayrollBefore = true;
        gs.hasEmployeesContractors = true;
        //gs.foreignIncome = true;
        gs.hasRentalProperties = true;
        gs.isWorkingFromHome = true;
        gs.commutesWithOwnVehicle = true;
        //gs.eCommerce = true;
        gs.numRequiredFields = 1;
        gs.opportunity = opp;
        gs.account = ac;
        gs.business = b;
        gs.businessOwner = bo;
        gs.partners = boList;
        // gs.finalProducts = pList;
        gs.businessId = b.Id;
        gs.nonProfitTaxPrepId = p.Id;
        gs.businessReturnId = p.Id;   

        // gs.getStateOfIncorporation();
        // gs.getEntityType();
        // gs.getIndustryType();
        // gs.getMoneyAmount();
        // gs.getMileage();
        // gs.getOffice();
        // gs.getFilingStatus();
        // gs.getNumberOf();
        // gs.getYearsInBusiness();
        // gs.getNumberOfTransactions();
        // gs.getNumberOfEmployeeContractors();
        // gs.getNumberOfRentalProperties();
        // gs.getContries();
        List<Product2> prods = [SELECT Id, Name, Calculator_Location__c, AnnualMonthlyOption__c,Billing_Frequency__c,HTML_Description__c,
        Description,No_Split_Allowed__c,Guided_Selling_Identifier__c,sort_Order__c FROM Product2 WHERE Guided_Selling_Identifier__c != null];
        List<GuidedSellingProduct> gsprods = new List<GuidedSellingProduct>();
        for(Product2 prod : prods){
            gsprods.add(new GuidedSellingProduct(prod));
        }

        String res = GuidedSellingControllerExtension.doSubmit('Standard', JSON.serialize(gsprods), (String)opp.Id, (String)ac.Id, 'yrl', '2023-05-03', '2023-07-03', 'true', null);
    }

    /* 
    * Tests for methods on class LaunchGuidedSellingInvocable 
    */


    @isTest
    static void launchGuidedSellingEventTest() {

        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];


        Test.startTest();

        LaunchGuidedSellingInvocable.Requests req = new LaunchGuidedSellingInvocable.Requests();
        req.recordId = e.Id;
        req.sessionId = '1234';
        List<LaunchGuidedSellingInvocable.Requests> requestList = new List<LaunchGuidedSellingInvocable.Requests>();
        requestList.add(req);
        LaunchGuidedSellingInvocable.launchGuidedSelling(requestList);

        Test.stopTest();
    }

    @isTest
    static void launchGuidedSellingOpportunityTest() {

        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];

        Test.startTest();

        LaunchGuidedSellingInvocable.Requests req = new LaunchGuidedSellingInvocable.Requests();
        req.recordId = opp.Id;
        req.sessionId = '1234';
        req.action = 'Send Email';
        req.controllerToken = '1234';
        req.emailAddresses = 'test@mail.com';
        req.presentationToken = '1234';
        List<LaunchGuidedSellingInvocable.Requests> requestList = new List<LaunchGuidedSellingInvocable.Requests>();
        requestList.add(req);
        LaunchGuidedSellingInvocable.launchGuidedSelling(requestList);

        Test.stopTest();
    }

    @isTest
    static void launchGuidedSellingLeadTest() {

        // Lead l = new Lead(
        //     FirstName = 'Test',
        //     LastName = 'Lead', 
        //     Company = 'test'
        // );   
        // insert l;

        // Event e = new Event(
        //     Subject = 'Test Event',
        //     WhoId = l.Id,
        //     Type_of_Appointment__c = 'Tax Savings Analysis', 
        //     StartDateTime = system.today(), 
        //     DurationInMinutes = 20
        // ); 
        // insert e;
        Lead l = [SELECT Id FROM Lead LIMIT 1];

        Test.startTest();

        LaunchGuidedSellingInvocable.Requests req = new LaunchGuidedSellingInvocable.Requests();
        req.recordId = l.Id;
        req.sessionId = '1234';
        req.action = 'Send Email';
        req.controllerToken = '1234';
        req.emailAddresses = 'test@mail.com';
        req.presentationToken = '1234';
        List<LaunchGuidedSellingInvocable.Requests> requestList = new List<LaunchGuidedSellingInvocable.Requests>();
        requestList.add(req);
        LaunchGuidedSellingInvocable.launchGuidedSelling(requestList);

        Test.stopTest();
    }

    @isTest
    static void launchGuidedSellingAccountTest() {

        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];


        Test.startTest();

        LaunchGuidedSellingInvocable.Requests req = new LaunchGuidedSellingInvocable.Requests();
        req.recordId = ac.Id;
        req.sessionId = '1234';
        req.action = 'Send Email';
        req.controllerToken = '1234';
        req.emailAddresses = 'test@mail.com';
        req.presentationToken = '1234';
        List<LaunchGuidedSellingInvocable.Requests> requestList = new List<LaunchGuidedSellingInvocable.Requests>();
        requestList.add(req);
        LaunchGuidedSellingInvocable.launchGuidedSelling(requestList);

        Test.stopTest();
    }

    @isTest
    static void launchGuidedSellingSendEmailTest() {

        Event e = [SELECT Id FROM Event LIMIT 1];


        Test.startTest();

        LaunchGuidedSellingInvocable.Requests req = new LaunchGuidedSellingInvocable.Requests();
        req.recordId = e.Id;
        req.sessionId = '1234';
        req.action = 'Send Email';
        req.controllerToken = '1234';
        req.emailAddresses = 'test@mail.com';
        req.presentationToken = '1234';
        List<LaunchGuidedSellingInvocable.Requests> requestList = new List<LaunchGuidedSellingInvocable.Requests>();
        requestList.add(req);
        LaunchGuidedSellingInvocable.launchGuidedSelling(requestList);

        Test.stopTest();
    }

    @isTest
    static void launchGuidedSellingBusinessCreationTest() {

        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];
        delete [SELECT Id FROM Business_Owner__c];
        delete [SELECT Id FROM Business__c];

        Test.startTest();

        LaunchGuidedSellingInvocable.Requests req = new LaunchGuidedSellingInvocable.Requests();
        req.recordId = e.Id;
        req.sessionId = '1234';
        req.action = 'Create business and business owner';
        List<LaunchGuidedSellingInvocable.Requests> requestList = new List<LaunchGuidedSellingInvocable.Requests>();
        requestList.add(req);
        LaunchGuidedSellingInvocable.launchGuidedSelling(requestList);

        Test.stopTest();
    }

    @isTest
    static void launchGuidedSellingTokenTest() {
        Test.setMock(HttpCalloutMock.class, new GuidedSellingMockEndpoints());
        Test.startTest();
        LaunchGuidedSellingInvocable linc = new LaunchGuidedSellingInvocable();
        linc.getSessionTokens();
        Test.stopTest();
    }

    @isTest 
    static void testUrlMethods(){
        System.assertNotEquals(null, GuidedSellingClientControllerExtension.getsfBaseUrl());
        System.assertNotEquals(null, GuidedSellingClientControllerExtension.getsiteBaseUrl());
        System.assertNotEquals(null, GuidedSellingClientControllerExtension.getschedulerBaseUrl());
        System.assertNotEquals(null, GuidedSellingClientControllerExtension.getsocketBaseUrl());
        System.assertNotEquals(null, LaunchGuidedSellingInvocable.environmentName);
        System.assertNotEquals(null, GetSiteUrlInvocable.getSiteBaseUrl());
    }

    


}