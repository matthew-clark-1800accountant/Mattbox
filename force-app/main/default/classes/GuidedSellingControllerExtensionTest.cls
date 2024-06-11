@isTest
private class GuidedSellingControllerExtensionTest {
    
    /* 
    * Tests for methods on apex class GuidedSellingControllerExtension 
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
        Account acc = new Account(Name='new account', Lead_Type_New__c = 'Bark');
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
        System.debug(gs.guidedSellingProducts);
        Test.stopTest();

    }
    @isTest
    static void calculateSavingsGuidedSellingTest() {
        
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];
        Business__c b = [SELECT Id FROM Business__c LIMIT 1];
        String res = GuidedSellingControllerExtension.calculateSavingsGuidedSelling(ac.Id);
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

        String answers = '[{"Visible":true,"Value":"No","Required":true,"QuestionType":"Boolean","QuestionText":"Is this your first business?","PicklistValuesFromObject":[],"PicklistOptions":null,"Label":"First Business","IncludesEngageText":true,"FilterTags":["Formation"],"EngageText":"Let the client respond and engage with a congratulatory response.","DevName":"First_Business","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"First_Business__c","Answered":true,"AccountFieldMapping":"Worked_With_CPA_Accountant__c","isPicklist":false},{"Visible":true,"Value":null,"Required":false,"QuestionType":"Date","QuestionText":"When did you form your business?","PicklistValuesFromObject":[],"PicklistOptions":null,"Label":"Formation Date","IncludesEngageText":false,"FilterTags":["Formation"],"EngageText":null,"DevName":"Formation_Date","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"Date_of_incorporation__c","Answered":false,"AccountFieldMapping":null,"isPicklist":false},{"Visible":true,"Value":null,"Required":true,"QuestionType":"Text Only","QuestionText":"What motivated you to start the business?","PicklistValuesFromObject":[],"PicklistOptions":null,"Label":"Motivation","IncludesEngageText":true,"FilterTags":["Formation"],"EngageText":"Engage and take notes.","DevName":"Motivation","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":null,"Answered":true,"AccountFieldMapping":null,"isPicklist":false},{"Visible":true,"Value":"1","Required":true,"QuestionType":"Single Selection","QuestionText":"How many owners does your business have?","PicklistValuesFromObject":["0","1","2","3","4","5","6","7","8","9","10"],"PicklistOptions":null,"Label":"Number of Owners","IncludesEngageText":false,"FilterTags":null,"EngageText":null,"DevName":"Number_of_Owners","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"Number_of_Owners__c","Answered":true,"AccountFieldMapping":null,"isPicklist":true},{"Visible":true,"Value":"Alabama","Required":true,"QuestionType":"State","QuestionText":"What is your state of incorporation?","PicklistValuesFromObject":["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Dist. of Columbia","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"],"PicklistOptions":null,"Label":"State of Incorporation","IncludesEngageText":false,"FilterTags":["Formation","State"],"EngageText":null,"DevName":"State_of_Incorporation","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"State_of_incorporation__c","Answered":true,"AccountFieldMapping":"State_of_Formation__c","isPicklist":true},{"Visible":true,"Value":"Alaska","Required":true,"QuestionType":"State","QuestionText":"What state is your business operating out of?","PicklistValuesFromObject":["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","District of Columbia","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"],"PicklistOptions":null,"Label":"Operating State","IncludesEngageText":false,"FilterTags":["Formation"],"EngageText":null,"DevName":"Operating_State","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"State__c","Answered":true,"AccountFieldMapping":null,"isPicklist":true},{"Visible":true,"Value":"LLC","Required":true,"QuestionType":"Single Selection","QuestionText":"What entity type is your business?","PicklistValuesFromObject":["LLC","S Corporation","C Corporation","DBA","LLC taxed as S-Corp","Sole Proprietorship","Partnership","LLC taxed as Partnership","LLC taxed as Sole Proprietorship","LLC taxed as C Corp","Non-Profit","Personal Only"],"PicklistOptions":"LLC;S Corporation","Label":"Entity Type","IncludesEngageText":false,"FilterTags":["Entity"],"EngageText":null,"DevName":"Entity_Type","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"Business_Type__c","Answered":true,"AccountFieldMapping":"Entity_Tax_Classification__c","isPicklist":true},{"Visible":true,"Value":"No","Required":true,"QuestionType":"Boolean","QuestionText":"Did you file your Entity Classification Election?","PicklistValuesFromObject":["Yes","No"],"PicklistOptions":null,"Label":"Filed ECE","IncludesEngageText":false,"FilterTags":["Filing"],"EngageText":null,"DevName":"Filed_ECE","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"ECE_Completed__c","Answered":true,"AccountFieldMapping":null,"isPicklist":false},{"Visible":true,"Value":"No","Required":true,"QuestionType":"Boolean","QuestionText":"Did you file your BOI (Beneficial Ownership Information)?","PicklistValuesFromObject":["Yes","No"],"PicklistOptions":null,"Label":"Filed BOI","IncludesEngageText":false,"FilterTags":["Filing"],"EngageText":null,"DevName":"Filed_BOI","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"BOI_Completed__c","Answered":true,"AccountFieldMapping":null,"isPicklist":false},{"Visible":true,"Value":"Business","Required":true,"QuestionType":"Single Selection","QuestionText":"What is your business doing?","PicklistValuesFromObject":["Agriculture","Animal Services","Apparel","Architecture","Automotive","Banking","Business","Childcare","Coffee","Communications","Construction","Consulting","Cryptocurrency","Dentistry","E-Commerce","Education","Electronics","Engineering","Entertainment","Environmental","Finance","Floristry","Food & Beverage","Government","Health & Beauty","Healthcare","Hospitality","Insurance","Landscaping","Legal","Machinery","Manufacturing","Media","Not For Profit","Optometry","Other","Publishing","Real Estate","Recreation","Retail","Sales & Marketing","Sales and Marketing","Service","Shipping","Software and Internet","Technology","Telecommunications","Transportation","Travel Recreation and Leisure","Utilities","Wholesale and Distribution"],"PicklistOptions":null,"Label":"Industry","IncludesEngageText":false,"FilterTags":["Formation"],"EngageText":null,"DevName":"Industry","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"Industry__c","Answered":true,"AccountFieldMapping":"Industry","isPicklist":true},{"Visible":true,"Value":null,"Required":true,"QuestionType":"Text Only","QuestionText":"How are you leveraging your start-up: savings, W-2, 401k, credit cards?","PicklistValuesFromObject":[],"PicklistOptions":null,"Label":"Startup Investment","IncludesEngageText":true,"FilterTags":["Business Income"],"EngageText":"Engage, take notes, and find out how much was invested.","DevName":"Startup_Investment","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":null,"Answered":true,"AccountFieldMapping":null,"isPicklist":false},{"Visible":true,"Value":"5000","Required":true,"QuestionType":"Single Selection","QuestionText":"Approximately how much was invested?","PicklistValuesFromObject":["0","5000","10000","25000","50000","75000","100000","150000","250000","500000","1000000"],"PicklistOptions":null,"Label":"Investment Amount","IncludesEngageText":false,"FilterTags":["Business Income"],"EngageText":null,"DevName":"Investment_Amount","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"Startup_Costs__c","Answered":true,"AccountFieldMapping":"Total_Startup_Costs__c","isPicklist":true},{"Visible":true,"Value":"5000","Required":true,"QuestionType":"Single Selection","QuestionText":"How much money do you plan on making this year/next year?","PicklistValuesFromObject":["0","5000","10000","25000","50000","75000","100000","150000","250000","500000","1000000"],"PicklistOptions":null,"Label":"Anticipated Revenue","IncludesEngageText":false,"FilterTags":["Business Income"],"EngageText":null,"DevName":"Anticipated_Revenue","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"Anticipated_Revenue__c","Answered":true,"AccountFieldMapping":"Expected_1st_year_revenue__c","isPicklist":true},{"Visible":true,"Value":"5000","Required":true,"QuestionType":"Single Selection","QuestionText":"How much of that do you think is going to be profit?","PicklistValuesFromObject":["0","5000","10000","25000","50000","75000","100000","150000","250000","500000","1000000"],"PicklistOptions":null,"Label":"Projected Profit","IncludesEngageText":false,"FilterTags":["Business Income"],"EngageText":null,"DevName":"Projected_Profit","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"Profit_Projection__c","Answered":true,"AccountFieldMapping":"Current_Year_Profit_Projection__c","isPicklist":true},{"Visible":true,"Value":"No","Required":true,"QuestionType":"Boolean","QuestionText":"Excluding yourself, do you currently have any employees or contractors?","PicklistValuesFromObject":[],"PicklistOptions":null,"Label":"Employees or Contractors","IncludesEngageText":false,"FilterTags":["Payroll"],"EngageText":null,"DevName":"Employees_or_Contractors","ChildQuestionLabel":"Additional Employees;Contractors","CanBeVisible":true,"BusinessFieldMapping":"Has_Employees_Contractors__c","Answered":true,"AccountFieldMapping":null,"isPicklist":false},{"Visible":false,"Value":"0","Required":true,"QuestionType":"Single Selection","QuestionText":"How many additional employees do you have?","PicklistValuesFromObject":["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51+"],"PicklistOptions":null,"Label":"Additional Employees","IncludesEngageText":false,"FilterTags":["Payroll"],"EngageText":null,"DevName":"Additional_Employees","ChildQuestionLabel":null,"CanBeVisible":false,"BusinessFieldMapping":"Number_of_Employees__c","Answered":true,"AccountFieldMapping":"NumberOfEmployees","isPicklist":true},{"Visible":false,"Value":"0","Required":true,"QuestionType":"Single Selection","QuestionText":"How many contractors do you have?","PicklistValuesFromObject":["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51+"],"PicklistOptions":null,"Label":"Contractors","IncludesEngageText":false,"FilterTags":["Payroll"],"EngageText":null,"DevName":"Contractors","ChildQuestionLabel":null,"CanBeVisible":false,"BusinessFieldMapping":"Number_of_Contractors__c","Answered":true,"AccountFieldMapping":"Number_of_Contractors__c","isPicklist":true},{"Visible":true,"Value":"false","Required":false,"QuestionType":"Boolean","QuestionText":"Have you run payroll before?","PicklistValuesFromObject":[],"PicklistOptions":null,"Label":"Payroll","IncludesEngageText":false,"FilterTags":["Payroll"],"EngageText":null,"DevName":"Payroll","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"Run_Payroll_Before__c","Answered":false,"AccountFieldMapping":null,"isPicklist":false},{"Visible":true,"Value":"Single","Required":true,"QuestionType":"Single Selection","QuestionText":"Do you file single or jointly?","PicklistValuesFromObject":["Single","Married Filing Separate","Married Filing Jointly","Head of Household"],"PicklistOptions":null,"Label":"Filing Status","IncludesEngageText":false,"FilterTags":["Filing"],"EngageText":null,"DevName":"Filing_Status","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"Tax_Filing_Status__c","Answered":true,"AccountFieldMapping":"Personal_Return_Filing_Status__c","isPicklist":true},{"Visible":true,"Value":"Yes","Required":true,"QuestionType":"Boolean","QuestionText":"Is this business intended to be your sole source of income?","PicklistValuesFromObject":["Yes","No"],"PicklistOptions":null,"Label":"Sole Income","IncludesEngageText":false,"FilterTags":["Personal Income","Business Income"],"EngageText":null,"DevName":"Sole_Income","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"Is_Business_Sole_Source_of_Income__c","Answered":true,"AccountFieldMapping":null,"isPicklist":false},{"Visible":true,"Value":"W-2","Required":true,"QuestionType":"Multi Selection","QuestionText":"Do you have additional sources of income? For example, W-2, 1099, or Rental Income","PicklistValuesFromObject":["W-2","1099","Rental Income"],"PicklistOptions":null,"Label":"Additional Income","IncludesEngageText":false,"FilterTags":["Personal Income"],"EngageText":null,"DevName":"Additional_Income","ChildQuestionLabel":"1099:Number of 1099s;Rental Income:Rental Properties","CanBeVisible":true,"BusinessFieldMapping":"Additional_Income_Sources__c","Answered":true,"AccountFieldMapping":null,"isPicklist":true},{"Visible":false,"Value":null,"Required":true,"QuestionType":"Single Selection","QuestionText":"How many 1099s are you receiving?","PicklistValuesFromObject":[],"PicklistOptions":"0;1;2;3;4;5;6;7;8;9;10","Label":"Number of 1099s","IncludesEngageText":false,"FilterTags":["Payroll"],"EngageText":null,"DevName":"Number_of_1099s","ChildQuestionLabel":"1099 related to business","CanBeVisible":false,"BusinessFieldMapping":"Number_of_Issued_1099s__c","Answered":false,"AccountFieldMapping":null,"isPicklist":true},{"Visible":false,"Value":null,"Required":true,"QuestionType":"Single Selection","QuestionText":"How many are related to this business?","PicklistValuesFromObject":[],"PicklistOptions":"0;1;2;3;4;5;6;7;8;9;10","Label":"1099 related to business","IncludesEngageText":false,"FilterTags":["Payroll"],"EngageText":null,"DevName":"X1099_related_to_business","ChildQuestionLabel":null,"CanBeVisible":false,"BusinessFieldMapping":"Number_of_Received_1099s__c","Answered":false,"AccountFieldMapping":null,"isPicklist":true},{"Visible":false,"Value":null,"Required":true,"QuestionType":"Single Selection","QuestionText":"How many rental properties do you have?","PicklistValuesFromObject":["0","1","2","3","4","5","6","7","8","9","10","11","12","13"],"PicklistOptions":null,"Label":"Rental Properties","IncludesEngageText":false,"FilterTags":["Personal Income"],"EngageText":null,"DevName":"Rental_Properties","ChildQuestionLabel":null,"CanBeVisible":false,"BusinessFieldMapping":"Number_of_Rental_Properties__c","Answered":false,"AccountFieldMapping":"Rental_Properties__c","isPicklist":true},{"Visible":true,"Value":"Owed","Required":true,"QuestionType":"Single Selection","QuestionText":"What about last year’s taxes–did you owe or get a refund?","PicklistValuesFromObject":["Owed","Refund Received"],"PicklistOptions":"Owed;Refund Received","Label":"Last Tax Return","IncludesEngageText":false,"FilterTags":["Personal Income"],"EngageText":null,"DevName":"Last_Tax_Return","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"Prior_Year_s_Tax_Return_Status__c","Answered":true,"AccountFieldMapping":null,"isPicklist":true},{"Visible":true,"Value":"0","Required":true,"QuestionType":"Single Selection","QuestionText":"How much income did you report to the IRS?","PicklistValuesFromObject":["0","5000","10000","25000","50000","75000","100000","150000","250000","500000","1000000"],"PicklistOptions":null,"Label":"Income Reported","IncludesEngageText":false,"FilterTags":["Personal Income"],"EngageText":null,"DevName":"Income_Reported","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"W2_Income__c","Answered":true,"AccountFieldMapping":null,"isPicklist":true},{"Visible":true,"Value":null,"Required":false,"QuestionType":"Single Selection","QuestionText":"How many monthly bookkeeping transactions do you have?","PicklistValuesFromObject":["0-75","76-150","151-250","251-500","501-750","751-1000","1001-1250","1251-1500"],"PicklistOptions":null,"Label":"Bookkeeping Transactions","IncludesEngageText":false,"FilterTags":["Bookkeeping"],"EngageText":null,"DevName":"Bookkeeping_Transactions","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"Monthly_Bookkeeping_Transactions__c","Answered":false,"AccountFieldMapping":"Trans_Per_Month__c","isPicklist":true},{"Visible":true,"Value":null,"Required":false,"QuestionType":"Date","QuestionText":"What transaction date should your bookkeeper start on?","PicklistValuesFromObject":[],"PicklistOptions":null,"Label":"Bookkeeping Start Date","IncludesEngageText":false,"FilterTags":["Bookkeeping"],"EngageText":null,"DevName":"Bookkeeping_Start_Date","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":null,"Answered":false,"AccountFieldMapping":null,"isPicklist":false},{"Visible":true,"Value":null,"Required":false,"QuestionType":"Date","QuestionText":"What transaction date should your bookkeeper end on?","PicklistValuesFromObject":[],"PicklistOptions":null,"Label":"Bookkeeping End Date","IncludesEngageText":false,"FilterTags":["Bookkeeping"],"EngageText":null,"DevName":"Bookkeeping_End_Date","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":null,"Answered":false,"AccountFieldMapping":null,"isPicklist":false},{"Visible":true,"Value":"No","Required":true,"QuestionType":"Boolean","QuestionText":"Will you be working from home?","PicklistValuesFromObject":[],"PicklistOptions":null,"Label":"Work From Home","IncludesEngageText":false,"FilterTags":["Deductions"],"EngageText":null,"DevName":"Work_From_Home","ChildQuestionLabel":"Home Office Footage","CanBeVisible":true,"BusinessFieldMapping":"Is_Working_From_Home__c","Answered":true,"AccountFieldMapping":null,"isPicklist":false},{"Visible":false,"Value":"0","Required":true,"QuestionType":"Single Selection","QuestionText":"What is the approximate square footage of your home office?","PicklistValuesFromObject":[],"PicklistOptions":"0;100;200;250;275;300","Label":"Home Office Footage","IncludesEngageText":false,"FilterTags":["Deductions"],"EngageText":null,"DevName":"Home_Office_Footage","ChildQuestionLabel":null,"CanBeVisible":false,"BusinessFieldMapping":"Home_Office_Square_Feet__c","Answered":true,"AccountFieldMapping":"Home_Office_Square_Feet__c","isPicklist":true},{"Visible":true,"Value":"Yes","Required":true,"QuestionType":"Boolean","QuestionText":"Will you use your personal vehicle for business purposes?","PicklistValuesFromObject":[],"PicklistOptions":null,"Label":"Personal Vehicle","IncludesEngageText":false,"FilterTags":["Deductions"],"EngageText":null,"DevName":"Personal_Vehicle","ChildQuestionLabel":"Business Miles","CanBeVisible":true,"BusinessFieldMapping":"Commutes_With_Own_Vehicle__c","Answered":true,"AccountFieldMapping":null,"isPicklist":false},{"Visible":true,"Value":"5000","Required":true,"QuestionType":"Single Selection","QuestionText":"How many business-related miles do you estimate you’ll drive per year?","PicklistValuesFromObject":["0","5000","7500","10000","15000","20000","25000"],"PicklistOptions":null,"Label":"Business Miles","IncludesEngageText":false,"FilterTags":["Deductions"],"EngageText":null,"DevName":"Business_Miles","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":"Yearly_Business_Miles__c","Answered":true,"AccountFieldMapping":"Estimated_Business_Mileage__c","isPicklist":true},{"Visible":true,"Value":null,"Required":true,"QuestionType":"Text Only","QuestionText":"Just so I make sure you get the most out of this conversation, what concerns you the most when it comes to taxes?","PicklistValuesFromObject":[],"PicklistOptions":null,"Label":"Concerns","IncludesEngageText":true,"FilterTags":null,"EngageText":"Engage and take notes.","DevName":"Concerns","ChildQuestionLabel":null,"CanBeVisible":true,"BusinessFieldMapping":null,"Answered":true,"AccountFieldMapping":null,"isPicklist":false}]';

        GuidedSellingControllerExtension.saveAnswers(answers, b.Id, ac.Id);
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
        Description,No_Split_Allowed__c,Guided_Selling_Identifier__c,sort_Order__c, Bundles__c FROM Product2 WHERE Guided_Selling_Identifier__c != null];
        List<GuidedSellingProduct> gsprods = new List<GuidedSellingProduct>();
        for(Product2 prod : prods){
            gsprods.add(new GuidedSellingProduct(prod));
        }
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        Account ac = [SELECT Id FROM Account LIMIT 1];
        Event e = [SELECT Id FROM Event LIMIT 1];

        String res = GuidedSellingControllerExtension.doSubmit('Standard', JSON.serialize(gsprods), (String)opp.Id, (String)ac.Id, 'yrl', '2023-05-03', '2023-07-03', 0);
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
        Description,No_Split_Allowed__c,Guided_Selling_Identifier__c,sort_Order__c, Bundles__c FROM Product2 WHERE Guided_Selling_Identifier__c != null];
        List<GuidedSellingProduct> gsprods = new List<GuidedSellingProduct>();
        for(Product2 prod : prods){
            gsprods.add(new GuidedSellingProduct(prod));
        }

        String res = GuidedSellingControllerExtension.doSubmit('Standard', JSON.serialize(gsprods), (String)opp.Id, (String)ac.Id, 'yrl', '2023-05-03', '2023-07-03', 0);
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
    
    @isTest
    static void testQuestionWrapperClass()
    {
        new GuidedSellingQuestionWrapper(new Guided_Selling_Discovery_Question__mdt());
    }
    


}