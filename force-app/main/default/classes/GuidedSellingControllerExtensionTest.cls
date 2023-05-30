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
    }


    @isTest
    static void GuidedSellingControllerExtensionMainTest() {
        Account ac = new Account(
            Name = 'Test Account',
            Lead_Source__c = 'LegalZoom', 
            Lead_Type_New__c = 'BTP'
        );   
        insert ac;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'New', 
            CloseDate = system.today(),
            AccountId = ac.Id
        );   
        insert opp;

        Business__c b = new Business__c(
            Name = 'Test Business',
            Account__c = ac.Id
        );   
        insert b;

        Business_Owner__c bo = new Business_Owner__c(
            Name = 'Test Business Owner',
            Business__c = b.Id, 
            Primary_Contact__c = true
        );   
        insert bo;

        List<Business_Owner__c> boList = new List<Business_Owner__c>();
        boList.add(bo);

        Pricebook2 pb = [SELECT Id, IsActive, Environment__c FROM Pricebook2 WHERE Id = :Test.getStandardPricebookId()];
        // try{
        //     pb = new Pricebook2 (
        //         Id = Test.getStandardPricebookId(),
        //         IsActive = true,
        //         Environment__c = 'Standard'
        //     );
        //     update pb;
        // } catch (Exception ex){
        //     System.debug(ex.getMessage());
        //     pb = [SELECT Id, IsActive, Environment__c FROM Pricebook2 WHERE Id = :Test.getStandardPricebookId()];
        // }    

        Product2 p = new Product2(
            Name = 'Business Return',
            Calculator_Location__c = 'Business Return',
            AnnualMonthlyOption__c = true, 
            Billing_Frequency__c = 'Annual',
            HTML_Description__c = 'test', 
            Description = 'test', 
            No_Split_Allowed__c = true, 
            Guided_Selling_Identifier__c = 'Business Return',
            Disable_QTY_on_Calc__c = true, 
            Environment__c = 'Standard',
            ChargeOver__c = true
        );   
        insert p;

        List<Product2> pList = new List<Product2>();
        pList.add(p);

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
        gs.finalProducts = pList;
        gs.defaultProducts = pList;
        gs.frequentProducts = pList;
        gs.businessProducts = pList;
        gs.personalProducts = pList;
        gs.payrollProducts = pList;
        gs.bookkeepingProducts = pList;
        gs.entityFormationProducts = pList;
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
    static void calculateSavingsGuidedSellingTest() {
        Account ac = new Account(Name = 'Test Account');   
        insert ac;
        String res = GuidedSellingControllerExtension.calculateSavingsGuidedSelling('LLC', '50000', '75000', '15000', '200', 'Married Filing Separate', '100000', 'Banking', ac.Id);
    }

    @isTest
    static void createUpdatePartnerTest() {
        Account ac = new Account(Name = 'Test Account');   
        insert ac;

        Business__c b = new Business__c(
            Name = 'Test Business',
            Account__c = ac.Id
        );   
        insert b;

        Business_Owner__c bo = new Business_Owner__c(
            Name = 'Test Business Owner',
            Business__c = b.Id
        );   
        insert bo;

        String partnerData = '{"firstName":"John","lastName":"Smith","role":"Manager","email":"jsmith22023@gmail.com","phone":"5555555555"}';

        String res1 = GuidedSellingControllerExtension.createUpdatePartner(b.Id, bo.Id, 'test company', partnerData);
        String res2 = GuidedSellingControllerExtension.createUpdatePartner(b.Id, null, 'test company', partnerData);
    }

    @isTest
    static void dispositionEventTest() {
        Account ac = new Account(Name = 'Test Account');   
        insert ac;

        Business__c b = new Business__c(
            Name = 'Test Business',
            Account__c = ac.Id
        );   
        insert b;

        Event e = new Event(
            Subject = 'Test Event',
            WhatId = ac.Id,
            Type_of_Appointment__c = 'Tax Savings Analysis', 
            StartDateTime = system.today(), 
            DurationInMinutes = 20
        ); 
        insert e;

        GuidedSellingControllerExtension.dispositionEvent(ac.Id, 'Canceled', 'Consulted', ac.Id);
        GuidedSellingControllerExtension.dispositionEvent(ac.Id, 'Not Interested', 'Consulted', ac.Id);
    }

    /* @isTest
    static void sentEmailTest() {
        Account ac = new Account(Name = 'Test Account');   
        insert ac;

        Contact c = new Contact(
            FirstName = 'test',
            LastName = 'Contact', 
            Email = 'test@1800accountant.com', 
            AccountId = ac.Id
        );

        ac.Primary_Contact__c = c.Id; 
        update ac;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'New', 
            CloseDate = system.today(),
            AccountId = ac.Id, 
            ContactId = c.Id, 
            OwnerId = userinfo.getUserId()
        );   
        insert opp;

        GuidedSellingControllerExtension.sentEmail(opp.Id);
    } */

    @isTest
    static void saveNoteTest() {
        Account ac = new Account(Name = 'Test Account');   
        insert ac;

        Contact c = new Contact(
            FirstName = 'test',
            LastName = 'Contact', 
            Email = 'test@1800accountant.com', 
            AccountId = ac.Id
        );
        insert c;

        GuidedSellingControllerExtension.saveNote(c.Id, 'this is a note', 'Testing Note Saving');
    }

    @isTest
    static void saveAnswersTest() {
        Account ac = new Account(Name = 'Test Account');   
        insert ac;

        Business__c b = new Business__c(
            Name = 'Test Business',
            Account__c = ac.Id
        );   
        insert b;

        String answers = 'What entity type is your business?LLC///What industry is your business in?Banking///What is your state of incorporation?Delaware///How much have you invested so far in start-up costs?75000///What do you anticipate your revenue to be over the next 12 months?75000///What do you project your 1st year profit to be over the next 12 months?50000///How many owners are outside the USA?6///How many employees do you have?16///How many contractors do you have?12///What is your tax filing status?Married Filing Separate///What was your household W-2 income last year?100000///How many rental properties do you have?4///What is the approximate square footage of your home office?200///How many business-related miles do you estimate you’ll drive per year?7500///Is this your first business?Yes///Do you currently have any employees?Yes///Do you currently have any rental properties?Yes///Will you be working from home?Yes///Will you use your personal vehicle for business purposes?Yes';

        GuidedSellingControllerExtension.saveAnswers(answers, b.Id, ac.Id, 'Standard');
    }

    @isTest
    static void saveBusinessDataTest() {
        Account ac = new Account(Name = 'Test Account');   
        insert ac;

        Business__c b = new Business__c(
            Account__c = ac.Id,
            Name = 'Test Business'
        );   
        insert b;

        GuidedSellingControllerExtension.saveBusinessData('New name business', b.Id, 'LLC', ac.Id);
    }

    @isTest
    static void saveClientInfoTest() {
        Account ac = new Account(Name = 'Test Account');   
        insert ac;

        Contact c = new Contact(
            FirstName = 'test',
            LastName = 'Contact', 
            Email = 'test@1800accountant.com', 
            AccountId = ac.Id
        );
        insert c;

        ac.Primary_Contact__c = c.id;
        update ac;

        Business__c b = new Business__c(
            Name = 'Test Business',
            Account__c = ac.Id
        );   
        insert b;

        Business_Owner__c bo = new Business_Owner__c(
            Name = 'Test Business Owner',
            Business__c = b.Id
        );   
        insert bo;

        GuidedSellingControllerExtension.saveClientInfo('personal', b.Id, bo.Id, ac.Id, 'tbo@1800accountant.com', '5555001122', '', '', '', '', '');
        GuidedSellingControllerExtension.saveClientInfo('billing', b.Id, bo.Id, ac.Id, '', '', '105 KROME AVE', 'Miami', 'Florida', '33185', 'United States');
    }

    @isTest
    static void getBusinessInfoTest() {
        Account ac = new Account(Name = 'Test Account');   
        insert ac;

        Business__c b = new Business__c(
            Name = 'Test Business',
            Account__c = ac.Id
        );   
        insert b;

        GuidedSellingControllerExtension.getBusinessInfo(ac.Id);
    }

    @isTest
    static void getChargeOverURLTest() {
        Account ac = new Account(Name = 'Test Account');   
        insert ac;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'New', 
            CloseDate = system.today()
        );   
        insert opp;

        Quote q = new Quote(
            Name = 'Test Quote',
            OpportunityId = opp.Id
        );   
        insert q;

        ChargeOver_Quote__c co1 = new ChargeOver_Quote__c(
            Name = 'Test ChargeOver Quote',
            Payment_Cycle__c = 'yrl',
            Opportunity__c = opp.Id
        ); 
        ChargeOver_Quote__c co2 = new ChargeOver_Quote__c(
            Name = 'Test ChargeOver Quote',
            Payment_Cycle__c = 'one',
            Opportunity__c = opp.Id
        ); 
        ChargeOver_Quote__c co3 = new ChargeOver_Quote__c(
            Name = 'Test ChargeOver Quote',
            Payment_Cycle__c = 'mon',
            Opportunity__c = opp.Id
        ); 
        
        List<ChargeOver_Quote__c> coList = new List<ChargeOver_Quote__c>();
        coList.add(co1);
        coList.add(co2);
        coList.add(co3);
        insert coList;

        String res = GuidedSellingControllerExtension.getChargeOverURL(opp.Id);
    }

    @isTest
    static void doSubmitTest() {
        Account ac = new Account(
            Name = 'Test Account',
            Lead_Type_New__c = 'ClientBooks Opt-In;Data append;TSA', 
            Lead_Source__c = '1800Accountant-Legacy'
        );   
        insert ac;

        Contact c = new Contact(
            FirstName = 'test',
            LastName = 'Contact', 
            Email = 'test@1800accountant.com', 
            AccountId = ac.Id
        );
        insert c;

        ac.Primary_Contact__c = c.Id;
        update ac;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'New', 
            CloseDate = system.today()
        );   
        insert opp;

        Business__c b = new Business__c(
            Name = 'Test Business',
            Account__c = ac.Id
        );   
        insert b;

        Pricebook2 pb = [SELECT Id, IsActive, Environment__c FROM Pricebook2 WHERE Id = :Test.getStandardPricebookId()];

        Product2 p1 = new Product2 (
            Name = 'Test prod 1',
            Calculator_Location__c = 'A La Carte', 
            AnnualMonthlyOption__c = true, 
            Billing_Frequency__c = 'Monthly', 
            HTML_Description__c = 'test', 
            Description = 'test', 
            No_Split_Allowed__c = true, 
            Guided_Selling_Identifier__c = 'Test prod 1', 
            sort_Order__c = 1
            );
        insert p1;

        Product2 p2 = new Product2 (
            Name = 'Test prod 2',
            Calculator_Location__c = 'Business Return', 
            AnnualMonthlyOption__c = true, 
            Billing_Frequency__c = 'Annual', 
            HTML_Description__c = 'test', 
            Description = 'test', 
            No_Split_Allowed__c = true, 
            Guided_Selling_Identifier__c = 'Test prod 2', 
            sort_Order__c = 2
            );
        insert p2;

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
        insert p3;

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
        insert p4;

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
        insert p5;

        PricebookEntry pbe1 = new PricebookEntry(
            UnitPrice = 29.99, 
            IsActive = true, 
            Pricebook2Id = pb.Id, 
            Product2Id = p1.Id
        );

        PricebookEntry pbe2 = new PricebookEntry(
            UnitPrice = 815, 
            IsActive = true, 
            Pricebook2Id = pb.Id, 
            Product2Id = p2.Id
        );

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

        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        pbeList.add(pbe1);
        pbeList.add(pbe2);
        pbeList.add(pbe3);
        pbeList.add(pbe4);
        pbeList.add(pbe5);
        insert pbeList;

        String prods = p1.Id + '//Monthly//1//29.99//29.99//29.99,' + p2.Id + '//Annual//1//815//815//815.00,' + p3.Id + '//One-Time//1//0//0//0.00,' + p4.Id + '//Annual//1//365//365//365.00,' + p5.Id + '//Annual//1//1125//1125//1125.00';
        system.debug('++++ ' + prods);
        String res = GuidedSellingControllerExtension.doSubmit('Standard', prods, opp.Id, ac.Id, 'yrl', '');
        GuidedSellingEditControllerExtension.doSubmit('Standard', prods, opp.Id, ac.Id, 'yrl', '');
    }

    /* 
    * Tests for methods on class GuidedSellingClientControllerExtension 
    */

    @isTest
    static void GuidedSellingClientControllerExtensionMainTest() {
        Account ac = new Account(Name = 'Test Account');   
        insert ac;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'New', 
            CloseDate = system.today(),
            AccountId = ac.Id
        );   
        insert opp;

        Event e = new Event(
            Subject = 'Test Event',
            WhatId = ac.Id,
            Type_of_Appointment__c = 'Tax Savings Analysis', 
            StartDateTime = system.today(), 
            DurationInMinutes = 20
        ); 
        insert e;

        PageReference pageRef2 = Page.CV_TSA_Intro;
        Test.setCurrentPage(pageRef2);
        ApexPages.currentPage().getParameters().put('rId', e.Id);
        GuidedSellingClientControllerExtension gs = new GuidedSellingClientControllerExtension(new ApexPages.StandardController(opp));
    }

    @isTest
    static void GuidedSellingEditControllerExtensionMainTest() {
        Account ac = new Account(
            Name = 'Test Account',
            Lead_Source__c = 'LegalZoom', 
            Lead_Type_New__c = 'BTP'
        );   
        insert ac;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'New', 
            CloseDate = system.today(),
            AccountId = ac.Id
        );   
        insert opp;

        Business__c b = new Business__c(
            Name = 'Test Business',
            Account__c = ac.Id
        );   
        insert b;

        Business_Owner__c bo = new Business_Owner__c(
            Name = 'Test Business Owner',
            Business__c = b.Id, 
            Primary_Contact__c = true
        );   
        insert bo;

        List<Business_Owner__c> boList = new List<Business_Owner__c>();
        boList.add(bo);

        Pricebook2 pb = [SELECT Id, IsActive, Environment__c FROM Pricebook2 WHERE Id = :Test.getStandardPricebookId()];

        Product2 p = new Product2(
            Name = 'Business Return',
            Calculator_Location__c = 'Business Return',
            AnnualMonthlyOption__c = true, 
            Billing_Frequency__c = 'Annual',
            HTML_Description__c = 'test', 
            Description = 'test', 
            No_Split_Allowed__c = true, 
            Guided_Selling_Identifier__c = 'Business Return',
            Disable_QTY_on_Calc__c = true, 
            Environment__c = 'Standard',
            ChargeOver__c = true
        );   
        insert p;

        List<Product2> pList = new List<Product2>();
        pList.add(p);

        PricebookEntry pbe1 = new PricebookEntry(
            UnitPrice = 29.99, 
            IsActive = true, 
            Pricebook2Id = pb.Id, 
            Product2Id = p.Id
        );

        PageReference pageRef2 = Page.GuidedSellingPage;
        Test.setCurrentPage(pageRef2);
        ApexPages.currentPage().getParameters().put('rid', opp.Id);
        GuidedSellingEditControllerExtension gs = new GuidedSellingEditControllerExtension(new ApexPages.StandardController(opp));

        gs.defaultNumForeignOwners = '0';
        gs.defaultYearsInBusiness = '0';
        gs.defaultEntity = 'LLC';
        gs.defaultIndustry = 'Other';
        gs.defaultDomesticState = 'California';
        gs.defaultForeignState = 'California';
        gs.defaultPersonalState = 'California';
        gs.defaultStartupCosts = '5000';
        gs.defaultRevenue = '5000';
        gs.defaultFirstYearProfit = '0';
        gs.defaultInvestorFunding = '0';
        gs.defaultNumTransactions = '0-75';
        gs.defaultNumOwners = '1';
        gs.defaultNumEmployees = '1';
        gs.defaultNumContractors = '1';
        gs.defaultFilingStatus = 'Single';
        gs.defaultPersonalIncome = '50000';
        gs.defaultNumberOfRentalProperties = '1';
        gs.defaultOtherInvestments = 'No';
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
        gs.foreignIncome = true;
        gs.hasRentalProperties = true;
        gs.isWorkingFromHome = true;
        gs.commutesWithOwnVehicle = true;
        gs.eCommerce = true;
        gs.numRequiredFields = 1;
        gs.opportunity = opp;
        gs.account = ac;
        gs.business = b;
        gs.businessOwner = bo;
        gs.partners = boList;
        gs.finalProducts = pList;
        gs.defaultProducts = pList;
        gs.frequentProducts = pList;
        gs.businessProducts = pList;
        gs.personalProducts = pList;
        gs.payrollProducts = pList;
        gs.bookkeepingProducts = pList;
        gs.entityFormationProducts = pList;
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

    /* 
    * Tests for methods on class LaunchGuidedSellingInvocable 
    */


    @isTest
    static void launchGuidedSellingEventTest() {

        Lead l = new Lead(
            FirstName = 'Test',
            LastName = 'Lead', 
            Company = 'test'
        );   
        insert l;

        Event e = new Event(
            Subject = 'Test Event',
            WhoId = l.Id,
            Type_of_Appointment__c = 'Tax Savings Analysis', 
            StartDateTime = system.today(), 
            DurationInMinutes = 20
        ); 
        insert e;

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

        Account ac = new Account(
            Name = 'Test Account'
        );   
        insert ac;

        Contact c = new Contact(
            FirstName = 'test',
            LastName = 'Contact', 
            Email = 'test@1800accountant.com', 
            AccountId = ac.Id
        );
        insert c;

        ac.Primary_Contact__c = c.Id;
        update ac;

        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'New', 
            CloseDate = system.today(),
            AccountId = ac.Id
        );   
        insert opp;

        Event e = new Event(
            Subject = 'Test Event',
            WhatId = opp.Id,
            Type_of_Appointment__c = 'Tax Savings Analysis', 
            StartDateTime = system.today(), 
            DurationInMinutes = 20
        ); 
        insert e;

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

        Lead l = new Lead(
            FirstName = 'Test',
            LastName = 'Lead', 
            Company = 'test'
        );   
        insert l;

        Event e = new Event(
            Subject = 'Test Event',
            WhoId = l.Id,
            Type_of_Appointment__c = 'Tax Savings Analysis', 
            StartDateTime = system.today(), 
            DurationInMinutes = 20
        ); 
        insert e;

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

        Account ac = new Account(
            Name = 'Test Account'
        );   
        insert ac;

        Contact c = new Contact(
            FirstName = 'test',
            LastName = 'Contact', 
            Email = 'test@1800accountant.com', 
            AccountId = ac.Id
        );
        insert c;

        ac.Primary_Contact__c = c.Id;
        update ac;

        Event e = new Event(
            Subject = 'Test Event',
            WhatId = ac.Id,
            Type_of_Appointment__c = 'Tax Savings Analysis', 
            StartDateTime = system.today(), 
            DurationInMinutes = 20
        ); 
        insert e;

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

        Lead l = new Lead(
            FirstName = 'Test',
            LastName = 'Lead', 
            Company = 'test'
        );   
        insert l;

        Event e = new Event(
            Subject = 'Test Event',
            WhoId = l.Id,
            Type_of_Appointment__c = 'Tax Savings Analysis', 
            StartDateTime = system.today(), 
            DurationInMinutes = 20
        ); 
        insert e;

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

        Account ac = new Account(
            Name = 'Test Account'
        );   
        insert ac;

        Contact c = new Contact(
            FirstName = 'test',
            LastName = 'Contact', 
            Email = 'test@1800accountant.com', 
            AccountId = ac.Id
        );
        insert c;

        ac.Primary_Contact__c = c.Id;
        update ac;

        Event e = new Event(
            Subject = 'Test Event',
            WhatId = ac.Id,
            Type_of_Appointment__c = 'Tax Savings Analysis', 
            StartDateTime = system.today(), 
            DurationInMinutes = 20
        ); 
        insert e;

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
    static void testUrlMethods(){
        System.assertNotEquals(null, GuidedSellingClientControllerExtension.getsfBaseUrl());
        System.assertNotEquals(null, GuidedSellingClientControllerExtension.getsiteBaseUrl());
        System.assertNotEquals(null, GuidedSellingClientControllerExtension.getschedulerBaseUrl());
        System.assertNotEquals(null, GuidedSellingClientControllerExtension.getsocketBaseUrl());
        System.assertNotEquals(null, LaunchGuidedSellingInvocable.environmentName);
        System.assertNotEquals(null, GetSiteUrlInvocable.getSiteBaseUrl());
    }


}