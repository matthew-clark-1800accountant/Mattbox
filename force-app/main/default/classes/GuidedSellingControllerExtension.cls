public without sharing class GuidedSellingControllerExtension {

    // Classes extends
    public class NoOpportunityIdFoundException extends Exception {}
    public class FoundMoreThanOneScriptException extends Exception {}

    // Variables String 
    public String FoundMoreThanOneScript = 'More than one script was found in the TSA Introduction Script Metadata for the Lead Source.';
    public String noOpportunityFound = 'No Opportunity Id Found.';

    public Double bundleDiscount {get; set;}
    public Double financingIncrease {get; set;}

    public String dynamicScript { get; set; }
    public String environment { get; set; }
    //public String defaultNumForeignOwners { get; set; }
    public String defaultYearsInBusiness { get; set; }
    public String defaultEntity { get; set; }
    public String defaultIndustry { get; set; }
    public String defaultDomesticState { get; set; }
    public String defaultForeignState { get; set; }
    //public String defaultPersonalState { get; set; }
    public String defaultStartupCosts { get; set; }
    public String defaultRevenue { get; set; }
    public String defaultFirstYearProfit { get; set; }
    //public String defaultInvestorFunding { get; set; }
    public String defaultNumTransactions { get; set; }
    public String defaultNumOwners { get; set; }
    public String defaultNumEmployees { get; set; }
    //public String defaultNumContractors { get; set; }
    public String defaultFilingStatus { get; set; }
    public String defaultPersonalIncome { get; set; }
    public String defaultNumberOfRentalProperties { get; set; }
    //public String defaultOtherInvestments { get; set; }
    public String defaultOffice { get; set; }
    public String defaultMileage { get; set; }
    public String defaultState { get; set; }
    public String defaultNumberOfEmployeeContractors { get; set; }
    public String requiredfields { get; set; }
    public String disabledProducts { get; set; }
    public String disabledQuantityProducts { get; set; }
    public String stringDefaultProducts { get; set; }
    public String theAccountId { get; set; }
    public String defaultCountry { get; set; }
    //public static String quoteButtonText { get; set; }
    public String quoteId { get; set; }

    public Date defaultBookkeepingStart { get; set; }
    public static Date bookkeepingStartDate { get; set; }
    public static Date bookkeepingEndDate { get; set; }
    public Date formationDate { get; set; }
    public String existingBookkeepingStart { get; set; }
    public String existingBookkeepingEnd { get; set; }
    public String billingFreq {get; set;}

    // Variables Boolean 
    public Boolean hasRecordId { get; set; }
    public Boolean useBTPLegalZoomScript { get; set; }
    public Boolean useBAPLegalZoomScript { get; set; }
    public Boolean firstBusiness { get; set; }
    public Boolean runPayrollBefore { get; set; }
    public Boolean hasEmployeesContractors { get; set; }
    //public Boolean foreignIncome { get; set; }
    public Boolean hasRentalProperties { get; set; }
    public Boolean isWorkingFromHome { get; set; }
    public Boolean commutesWithOwnVehicle { get; set; }
    //public Boolean eCommerce { get; set; }
    public Boolean btp { get; set; }
    public Boolean isNonProfit { get; set; }

    // Variables Integer 
    public Integer numRequiredFields {get; set;}

    //Record Variables
    public Opportunity opportunity { get; set; }
    public User user { get; set; }
    public Account account { get; set; }
    public String accountJSON { get;set; }
    public Business__c business { get; set; }
    public Business_Owner__c businessOwner { get; set; }
    public Event eventRec { get; set; }
    public List<GuidedSellingQuestionWrapper> discoveryQuestions {get;set;}
    public String discoveryQuestionsJson {get {return JSON.serialize(discoveryQuestions);} set;}
    public GuidedSellingQuestionWrapper testQuestion {get;set;}


    public List<String> existingQuoteProductNames = new List<String>();

    public String eligibleBundle {get; set;}
    
    public Map<String, List<String>> bundleToDefaultProductNames = new Map<String, List<String>>{
        'Core Accounting Package' => new List<String>{'Business Tax Preparation', 'Personal Tax Preparation', 'Tax Advisory', '1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement', 'Beneficial Owner Information Report'},
        'Core Accounting Package (Partner BTP)' => new List<String>{'Personal Tax Preparation', 'Tax Advisory', '1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement', 'Audit Defense - Business','Audit Defense - Personal','Two-Year Review', 'Beneficial Owner Information Report'},
        'Core Accounting Package (Partner BTP/BOI)' => new List<String>{'Personal Tax Preparation', 'Tax Advisory', '1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement', 'Audit Defense - Business','Audit Defense - Personal','Two-Year Review'},
        'Core Accounting Package (Partner BTP/PTP/BOI)' => new List<String>{'Tax Advisory', '1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement', 'Audit Defense - Business','Audit Defense - Personal','Two-Year Review'},
        'Core Accounting Package (Partner BTPNS/BOI)' => new List<String>{'Personal Tax Preparation', 'Tax Advisory', '1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement', 'Audit Defense - Business','Audit Defense - Personal','Two-Year Review', 'Business Tax Preparation - State Only'}
    };
    
    public List<String> disabledProductNames = new List<String>{'Dedicated Bookkeeping', 'Personal Financial Planning', 'Core Accounting Package', '1-800Accountant Access', 'Loan Agreement', 'Core Accounting Package (Partner BTP)', 
    'Core Accounting Package (Partner BTP/BOI)', 'Tailor Brands Business and Personal Tax Preparation Package', 'Core Accounting Package (Partner BTPNS/BOI)', 'Beneficial Owner Information Report'};
    public List<String> disabledQuantityProductNames = new List<String>{'Dedicated Bookkeeping', 'Personal Financial Planning', 'Core Accounting Package', '1-800Accountant Access', 'Loan Agreement', 'Core Accounting Package (Partner BTP)', 
    'Core Accounting Package (Partner BTP/BOI)', 'Tailor Brands Business and Personal Tax Preparation Package', 'Core Accounting Package (Partner BTPNS/BOI)', 'Beneficial Owner Information Report'};
    
    public List<String> entityFormationProductNames = new List<String>{'LLC State Filing Fee', 'Corp State Filing Fee', 'Complete Compliance', 'EIN - Priority Processing', 'EIN - Standard Processing', 'Entity Formation', 'Operating Agreement', 'Registered Agent', 'Rush Processing'};

    public List<String> advisoryAddonProductNames {get{
        return new List<String>{'1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement', 'Beneficial Owner Information Report'};
    } set;}
    public String advisoryAddonsJSON {get{
        return JSON.serialize(advisoryAddonProductNames);
    }set;}
    //List Variables
    public List<Business_Owner__c> partners { get; set; }
    //public List<Product2> finalProducts { get; set; }
    public List<GuidedSellingProduct> finalProducts { get{
        if(guidedSellingProducts == null){
            return new List<GuidedSellingProduct>();
        } else {
            return guidedSellingProducts;
        }       
    } set; }
    public String finalProductsJson {get {return JSON.serialize(finalProducts);} set;}
    //public List<Product2> defaultProducts { get; set; }
    public List<GuidedSellingProduct> defaultProducts { get {
        if(guidedSellingProducts == null || guidedSellingProducts.size() == 0 || btp == null){
            return new List<GuidedSellingProduct> ();
        } else {
            List<GuidedSellingProduct> tempList = new List<GuidedSellingProduct>();
            List<String> defaultProductNames = bundleToDefaultProductNames.get(getEligibleBundle());
            for(GuidedSellingProduct p : guidedSellingProducts){
                if(defaultProductNames.contains(p.Product.Name)){
                    tempList.add(p);
                }
            }
            return tempList;
        }
    } set; }
    //public List<Product2> frequentProducts { get; set; }
    public List<GuidedSellingProduct> frequentProducts { get {
        if(guidedSellingProducts == null || guidedSellingProducts.size() == 0){
            return new List<GuidedSellingProduct> ();
        } else {
            List<GuidedSellingProduct> tempList = new List<GuidedSellingProduct>();
            for(GuidedSellingProduct p : guidedSellingProducts){
                if('A La Carte' != p.Product.Calculator_Location__c){
                    tempList.add(p);
                }
            }
            return tempList;
        }
    } set; }
    public String frequentProductsJson {get {return JSON.serialize(frequentProducts);} set;}
    //public List<Product2> businessProducts { get; set; } 
    public List<GuidedSellingProduct> businessProducts { get {
        if(guidedSellingProducts == null || guidedSellingProducts.size() == 0){
            return new List<GuidedSellingProduct> ();
        } else {
            List<GuidedSellingProduct> tempList = new List<GuidedSellingProduct>();
            for(GuidedSellingProduct p : guidedSellingProducts){
                if(p.Product.Name != null && (p.Product.Name.containsIgnoreCase('business')
                || p.Product.Name == 'Quarterly Estimated Taxes')){
                    tempList.add(p);
                }
            }
            return tempList;
        }
    } set; }
    public String businessProductsJson {get {return JSON.serialize(businessProducts);} set;}
    //public List<Product2> personalProducts { get; set; }
    public List<GuidedSellingProduct> personalProducts { get {
        if(guidedSellingProducts == null || guidedSellingProducts.size() == 0){
            return new List<GuidedSellingProduct> ();
        } else {
            List<GuidedSellingProduct> tempList = new List<GuidedSellingProduct>();
            for(GuidedSellingProduct p : guidedSellingProducts){
                if(p.Product.Name != null && (p.Product.Name.containsIgnoreCase('personal')
                || p.Product.Name == 'Quarterly Estimated Taxes')){
                    tempList.add(p);
                }
            }
            return tempList;
        }
    } set; }
    public String personalProductsJson {get {return JSON.serialize(personalProducts);} set;}
    //public List<Product2> payrollProducts { get; set; }
    public List<GuidedSellingProduct> payrollProducts { get {
        if(guidedSellingProducts == null || guidedSellingProducts.size() == 0){
            return new List<GuidedSellingProduct> ();
        } else {
            List<GuidedSellingProduct> tempList = new List<GuidedSellingProduct>();
            for(GuidedSellingProduct p : guidedSellingProducts){
                if(p.Product.Name != null && p.Product.Name.containsIgnoreCase('payroll')){
                    tempList.add(p);
                }
            }
            return tempList;
        }
    } set; }
    public String payrollProductsJson {get {return JSON.serialize(payrollProducts);} set;}

    //public List<Product2> bookkeepingProducts { get; set; }
    public List<GuidedSellingProduct> bookkeepingProducts { get {
        if(guidedSellingProducts == null || guidedSellingProducts.size() == 0){
            return new List<GuidedSellingProduct> ();
        } else {
            List<GuidedSellingProduct> tempList = new List<GuidedSellingProduct>();
            for(GuidedSellingProduct p : guidedSellingProducts){
                if(p.Product.Name != null && (p.Product.Name.containsIgnoreCase('bookkeeping') || p.Product.Name.containsIgnoreCase('books'))){
                    tempList.add(p);
                }
            }
            return tempList;
        }
    } set; }
    public String bookkeepingProductsJson {get {return JSON.serialize(bookkeepingProducts);} set;}
    //public List<Product2> entityFormationProducts { get; set; }
    public List<GuidedSellingProduct> entityFormationProducts { get {
        if(guidedSellingProducts == null || guidedSellingProducts.size() == 0){
            return new List<GuidedSellingProduct> ();
        } else {
            List<GuidedSellingProduct> tempList = new List<GuidedSellingProduct>();
            for(GuidedSellingProduct p : guidedSellingProducts){
                if(p.Product.Name != null && (p.Product.Name.containsIgnoreCase('entity') || entityFormationProductNames.contains(p.Product.Name))){
                    tempList.add(p);
                }
            }
            return tempList;
        }
    } set; }
    public String entityFormationProductsJson {get {return JSON.serialize(entityFormationProducts);} set;}
    public List<GuidedSellingProduct> tempSelectedProducts { get {
        if(guidedSellingProducts == null || guidedSellingProducts.size() == 0){
            return new List<GuidedSellingProduct> ();
        } else {
            List<GuidedSellingProduct> tempList = new List<GuidedSellingProduct>();
            List<String> defaultProductNames;
            if(isValidQuoteId()){
                defaultProductNames = existingQuoteProductNames;
            } else {
                defaultProductNames = bundleToDefaultProductNames.get(getEligibleBundle());
            } 
            if(hasActiveBTP != null && hasActiveBTP && defaultProductNames.indexOf('Business Tax Preparation') != -1){
                defaultProductNames.remove(defaultProductNames.indexOf('Business Tax Preparation'));
            }
            if(hasActivePTP != null && hasActivePTP && defaultProductNames.indexOf('Personal Tax Preparation') != -1){
                defaultProductNames.remove(defaultProductNames.indexOf('Personal Tax Preparation'));
            }
            for(GuidedSellingProduct p : guidedSellingProducts){
                if(defaultProductNames.contains(p.Product.Name)){
                    tempList.add(p);
                }
            }
            return tempList;
        }
    } set; }
    public String selectedProductsJson {get {return JSON.serialize(tempSelectedProducts);} set;}
    public List<Product_Offer__mdt> offersOfProducts { get; set; }
    public List<GuidedSellingProduct> guidedSellingProducts { get; set; }
    public Map<String, GuidedSellingProduct> guidedSellingProductsIdMap { get; set; }
    public static Decimal quoteTotalAnnual {get;set;}
    public static Decimal quoteTotalMonthly {get;set;}
    public static Decimal quoteTotal {get { 
        if(quoteTotalAnnual == null || quoteTotalMonthly == null){
            return 0;
        }
        return quoteTotalAnnual + quoteTotalMonthly; }}

    //Map Variables
    public Map<String, String> disabledMessage { get; set; }
    public Map<Id, Decimal> defaultPrices { get; set; }
    public Map<Id, Decimal> productToPrice;
    public Map<Id, String> productToIdentifier;
    // public Map<String, Id> productNameToId { get;set; }

    //Id Variables
    public Id businessId { get; set; }
    public Id nonProfitTaxPrepId { get; set; }
    public Id businessReturnId { get; set; }
     
    // Funtions 
    // @RemoteAction
    public static String environmentName{
        get {
            String name = System.DomainParser.parse(URL.getOrgDomainUrl()).getSandboxName();
            if(name == null){
                return 'production';
            } else {
                return name;
            }
        }
    }
    public static String getsfBaseUrl(){
        System.debug('getsfBaseUrl');
        if(System.DomainParser.parse(URL.getOrgDomainUrl()).getSandboxName() == null){
            return 'https://1800accountant.lightning.force.com';
        } else {
            return 'https://1800accountant--'+environmentName+'.sandbox.lightning.force.com';
        }
        
    }

    public static String getsiteBaseUrl(){
        Site mySite = [select Id from Site where Name = 'Guided_Selling_Client_View' LIMIT 1];
        SiteDetail mySiteDetail = [select SecureURL from SiteDetail where DurableId = :mySite.Id LIMIT 1];
        String url = mySiteDetail.SecureURL.substring(0, mySiteDetail.SecureURL.indexOf('.com/')+4);
        System.debug('getsiteBaseUrl');
        return url;
    }

    public static String getschedulerBaseUrl(){
        List<Guided_Selling_URL__mdt> urls = [SELECT Endpoint__c FROM Guided_Selling_URL__mdt WHERE URL_Type__c = 'Scheduler'
        AND Environment__c = :environmentName];
        if(urls.isEmpty()){
            urls = [SELECT Endpoint__c FROM Guided_Selling_URL__mdt WHERE URL_Type__c = 'Scheduler'
            AND Environment__c = 'default'];
        } 
        System.debug('getschedulerBaseUrl');
        return urls[0].Endpoint__c;
        
    }

    public static String getsocketBaseUrl(){
        List<Guided_Selling_URL__mdt> urls = [SELECT Endpoint__c FROM Guided_Selling_URL__mdt WHERE URL_Type__c = 'Socket'
        AND Environment__c = :environmentName];
        if(urls.isEmpty()){
            urls = [SELECT Endpoint__c FROM Guided_Selling_URL__mdt WHERE URL_Type__c = 'Socket'
            AND Environment__c = 'default'];
        } 
        System.debug('getsocketBaseUrl');
        return urls[0].Endpoint__c;
    }

    public void setproductToPrice(Map<Id, Decimal> dumperVar) {
        this.productToPrice = dumperVar;
        System.debug('setproductToPrice');

    }

    public String getproductToPrice() {         
        System.debug('getproductToPrice');
        return JSON.serialize(this.productToPrice); 
    }

    public void setproductToIdentifier(Map<Id, String> dumperVar) {
        this.productToIdentifier = dumperVar;
        System.debug('setproductToIdentifier');
    }

    public String getproductToIdentifier() { 
        System.debug('getproductToIdentifier');
        return JSON.serialize(this.productToIdentifier); 
    }

    public Boolean isValidQuoteId(){
        return (quoteId != null && quoteId != 'null' && Id.valueOf(quoteId).getSObjectType().getDescribe().getName() == 'Quote');
    }

    public Boolean hasActiveBTP {get; set;}
    public Boolean hasActiveBTPNS {get; set;}
    public Boolean hasActivePTP {get; set;}
    public Boolean hasActiveAdvisory {get; set;}
    public Boolean hasActiveHotline {get; set;}
    public Boolean hasActiveBundleProduct {get; set;}

    public List<String> questionFilters {get;set;}
    public String questionFiltersJson {get{return JSON.serialize(questionFilters);}set;}
    public List<SelectOption> filterOptionList {get{
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Show All Questions', 'Show All Questions'));
        options.add(new SelectOption('Required Questions', 'Required Questions'));
        options.add(new SelectOption('Unanswered Required Questions', 'Unanswered Required Questions'));
        if(questionFilters == null || questionFilters.isEmpty()){
            return options;
        } else {
            for(String s : questionFilters){
                options.add(new SelectOption(s, s));
            }
            return options;
        }
    } set;}
    public String defaultFilterValue {get{
        if(filterOptionList == null || filterOptionList.isEmpty()){
            return '';
        } else {
            return filterOptionList[0].getValue();
        }
    } set;}

    // public Map<String, List<GuidedSellingQuestionWrapper>> parentNameToChildQuestions {get;set;}
    // public String parentNameMapJson {get {return JSON.serialize(parentNameToChildQuestions);} set;}

    // public Map<String, GuidedSellingQuestionWrapper> questionLabelToQuestion {get;set;}
    // public String questionLabelMapJson {get {return JSON.serialize(questionLabelToQuestion);} set;}

    public Id recordOwnerId;
    public Boolean useStaticPackage { get; set; }

    // public void setproductIdToPrice(Map<Id, Decimal> setproductIdToPrice) {
    //    this.productIdToPrice = setproductIdToPrice;
    //}
    // public String getproductIdToPrice() { 
    //    return JSON.serialize(this.productIdToPrice); 
    //}

    public static String removeSubstrings(String startingString, List<String> substrings){
        for(String sub : substrings){
            startingString = startingString.replace(sub, '');
        }
        return startingString;
    }

    public static String normalizePhoneNumber(String phone){
        if(phone == '' || phone == null){
            return phone;
        }
        phone = phone.replace(' ', '').replace('(','').replace(')','').replace('-','');
        if(phone.length() < 11){phone = '+1'+phone;}
        Integer len = phone.length();
        phone = phone.substring(0, len-10) + ' (' + phone.substring(len-10, len-7) + ') ' + phone.substring(len-7,len-4) + '-' + phone.substring(len-4, len);
        return phone;
    }

    public GuidedSellingControllerExtension(ApexPages.StandardController stdController) {
        discoveryQuestions = new List<GuidedSellingQuestionWrapper>();
        
        
        financingIncrease = Dynamic_Pricing_Values__c.getValues('Financing increase')?.Percent_value__c;
        bundleDiscount = Dynamic_Pricing_Values__c.getValues('Bundle discount')?.Percent_value__c;
        useStaticPackage = true;
        System.debug('*checkpoint 1');
        //Integer i = 5/0;
        //First identify the record Id passed in the parameters through the flow
        Id recordId = ApexPages.currentPage().getParameters().get('rId');
        hasRecordId = (null == recordId) ? false : true;
        if(recordId == null){ recordId = '00UDM000005BArh2AG';}
        //quoteButtonText = 'Generate Quote';
        //defaultNumForeignOwners = '---';
        defaultState = 'Select a State';
        defaultYearsInBusiness = '---';
        defaultEntity = 'Select an Entity Type';
        defaultIndustry = 'Select an Industry';
        defaultDomesticState = 'Select a State';
        defaultForeignState = 'Select a State';
        //defaultPersonalState = 'Select a State';
        defaultStartupCosts = '---';
        defaultRevenue = '---';
        defaultFirstYearProfit = '---';
        ///defaultInvestorFunding = '---';
        defaultNumTransactions = '---';
        defaultNumOwners = '---';
        defaultNumEmployees = '---';
        //defaultNumContractors = '---';
        defaultFilingStatus = 'Select a Filing Status';
        defaultPersonalIncome = '---';
        defaultNumberOfRentalProperties = '---';
        //defaultOtherInvestments = '---';
        defaultOffice = '---';
        defaultMileage = '---';
        existingBookkeepingStart = '';
        existingBookkeepingEnd = '';
        firstBusiness = false;
        runPayrollBefore = false;
        hasEmployeesContractors = false;
        //foreignIncome = false; 
        hasRentalProperties = false; 
        isWorkingFromHome = false;
        commutesWithOwnVehicle = false; 
        //eCommerce = false; 
        defaultCountry = 'United States';
        defaultBookkeepingStart = Date.today();
        //formationDate = Date.today();
        quoteTotalAnnual = 0;
        quoteTotalMonthly = 0;
        quoteId = ApexPages.currentPage().getParameters().get('Q');
        hasActiveAdvisory = false;
        hasActiveBTP = false;
        //hasActiveBTPNS = false;
        hasActivePTP = false;
        hasActiveHotline = false;
        hasActiveBundleProduct = false;

        if(isValidQuoteId()){
            Quote curQuote = [SELECT billingSchedule__c, Calc_Bookkeeping_Start_Date__c, Calc_Bookkeeping_End_Date__c FROM Quote WHERE Id = :quoteId LIMIT 1];
            billingFreq = curQuote.billingSchedule__c;
            existingBookkeepingStart = curQuote.Calc_Bookkeeping_Start_Date__c;
            existingBookkeepingEnd = curQuote.Calc_Bookkeeping_End_Date__c;
        } else {
            System.debug('no quote id found: '+quoteId);
        }

        String recordIdType = recordId?.getSObjectType().getDescribe().getName(); 
        
        Id eventId = ('Event' == recordIdType) ? recordId : null;
        Id leadId = ('Lead' == recordIdType) ? recordId : null;
        Id accountId = ('Account' == recordIdType) ? recordId : null;
        Id opportunityId = ('Opportunity' == recordIdType) ? recordId : null;
        System.debug('*checkpoint 2');

        //If there is an Event Id, get either an Opportunity or Account
        if(null != eventId) {
            eventRec = [SELECT Id, WhatId, WhoId, Subject, OwnerId FROM Event WHERE Id = :recordId LIMIT 1];
            recordOwnerId = eventRec.OwnerId;

            //Getting either an Account or Opportunity from the Event
            if(null != eventRec.WhatId && 'Account' == eventRec.WhatId.getSObjectType().getDescribe().getName()) {
                accountId = eventRec.WhatId;
            }
            
            if(null != eventRec.WhatId && 'Opportunity' == eventRec.WhatId.getSObjectType().getDescribe().getName()) {
                opportunityId = eventRec.WhatId;
            }
        }

        //If there is a Lead Id, it was converted and we can get the Opportunity Id
        if(null != leadId) {
            Lead lead = [
                SELECT Id, Name, Entity_Type__c, Company, LeadSource, Email, Owner.Name, Owner.Email, ConvertedOpportunityId, OwnerId
                FROM Lead
                WHERE Id = :leadId
            ];
            opportunityId = lead.ConvertedOpportunityId;
            recordOwnerId = lead.OwnerId;
        }

        //In the case an Event has an Account and Opportunity, we only want the Opportunity
        if(null != opportunityId && null != accountId) {
            Opportunity findLatestOpportunity = [
                SELECT Id, Name, AccountId, OwnerId FROM Opportunity WHERE AccountId = :accountId ORDER BY CreatedDate DESC LIMIT 1
            ];
            opportunityId = findLatestOpportunity.Id;
            recordOwnerId = findLatestOpportunity.OwnerId;
        }
        if(null != opportunityId && null == recordOwnerId){
            Opportunity findLatestOpportunity = [
                SELECT Id, Name, AccountId, OwnerId FROM Opportunity WHERE Id = :opportunityId
            ];
            recordOwnerId = findLatestOpportunity.OwnerId;
        }
        User recordOwner = [SELECT Id, Skills_Sales__c FROM User WHERE Id = :recordOwnerId];
        //useStaticPackage = recordOwner.Skills_Sales__c.contains('Bundle Packages');
        //Now we need to have an Opportunity Id at this point as the source of data for the page
        if(null == opportunityId && null != recordId) {
            throw new NoOpportunityIdFoundException(noOpportunityFound);
        }
        
        if(null != opportunityId) {
            opportunity = [
                SELECT Id, Name, Account.Primary_Contact_Email__c, Account.Primary_Contact__c, Account.Owner.Name, Account.Owner.Email, AccountId, Account.Owner.Skills_Sales__c,
                Account.Name, Account.Lead_Source__c, Account.Primary_Contact__r.FirstName, Account.Primary_Contact__r.LastName, Account.Primary_Contact__r.Phone, 
                Account.Primary_Contact__r.Email, Account.Owner.FirstName, Account.Lead_Type_New__c, Account.Campaign__c, Account.Owner.Id, Account.Entity_Tax_Classification__c,
                Account.Website_Selling_Goods__c, Account.Years_in_Business__c, Account.Industry, Account.State_of_Formation__c, Account.Personal_Return_Filing_Status__c, 
                Account.Total_Startup_Costs__c, Account.Expected_1st_year_revenue__c, Account.Trans_Per_Month__c, 
                Account.How_much_funding__c, Account.Current_Year_Profit_Projection__c, Account.Number_of_owners__c, Account.NumberOfEmployees, 
                Account.Personal_Income__c, Account.Rental_Properties__c, Account.Home_Office_Square_Feet__c, Account.Estimated_Business_Mileage__c, 
                Account.Lead_Source_Date__c
                FROM Opportunity 
                WHERE Id = :opportunityId
                LIMIT 1
            ];
        }

        theAccountId = opportunity.AccountId;

        if(opportunity.AccountId != null) {
            List<Business__c> businesses = [
                SELECT Id, Name, Account__c, Anticipated_Revenue__c, Industry__c, Business_Type__c, Number_of_Owners__c, Startup_Costs__c, Years_In_Business__c, 
                Profit_Projection__c, Home_Office_Square_Feet__c,Number_of_Contractors__c,
                State_of_incorporation__c, Monthly_Bookkeeping_Transactions__c, Number_of_Employees__c, Tax_Filing_Status__c,
                W2_Income__c, Number_of_Rental_Properties__c, Yearly_Business_Miles__c, 
                Run_Payroll_Before__c, Has_Employees_Contractors__c, File_Return_Yourself__c, Has_Rental_Properties__c, Is_Working_From_Home__c, Commutes_With_Own_Vehicle__c, 
                First_Business__c, Foreign_State_of_Incorporation__c, State__c, Date_of_incorporation__c, ECE_Completed__c, BOI_Completed__c, Is_Business_Sole_Source_of_Income__c,
                Additional_Income_Sources__c, Number_of_Issued_1099s__c, Number_of_Received_1099s__c, Prior_Year_s_Tax_Return_Status__c, Prior_Year_s_Report_Income__c
                FROM Business__c 
                WHERE Account__r.Id = :opportunity.AccountId
                LIMIT 1
            ];
            if(businesses.size()>0){
                business = businesses[0];
            } else {
                business = new Business__c();
            }
        }

        Integer numEmpl = 0;
        if(business.Number_of_Employees__c != null) {
            numEmpl = Integer.valueOf(business.Number_of_Employees__c) - 1;
        }

        String businessEntity = '';
        if(business.Business_Type__c != 'LLC' && business.Business_Type__c != 'C Corporation' && business.Business_Type__c != 'S Corporation' &&
           business.Business_Type__c != 'Partnership' && business.Business_Type__c != 'DBA' && business.Business_Type__c != 'Non-Profit' &&
           business.Business_Type__c != 'Personal Only') {
            businessEntity = null;
        } else {
            businessEntity = business.Business_Type__c;
        }
        System.debug('*checkpoint 3');
        System.debug('business '+business);
        questionFilters = new List<String>();
        //parentNameToChildQuestions = new Map<String, List<GuidedSellingQuestionWrapper>>();
        // questionLabelToQuestion = new Map<String, GuidedSellingQuestionWrapper>();
        Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Business__c.fields.getMap();
        
        for(Guided_Selling_Discovery_Question__mdt q : [SELECT Id,Display_By_Default__c,Engage_Text__c,Includes_Engage_Text__c,
        Picklist_Options__c, Filter_Tags__c, Child_Question_Label__c, Question_Text__c,Question_Type__c,Required__c,DeveloperName, MasterLabel,
        Account_Field_Mapping__c,Business_Field_Mapping__c,Sort_Order__c FROM Guided_Selling_Discovery_Question__mdt WHERE IsActive__c = true ORDER BY Sort_Order__c ASC]){
            GuidedSellingQuestionWrapper question = new GuidedSellingQuestionWrapper(q);
            try{
                if(question.BusinessFieldMapping != null && business.isSet(question.BusinessFieldMapping) && business.get(question.BusinessFieldMapping) != null ){
                    question.Value = String.valueOf(business.get(question.BusinessFieldMapping));
                    if(question.Value == 'true'){ question.Value = 'Yes'; }

                    if(question.Value == 'false'){ 
                        if(isValidQuoteId()){
                            question.Value = 'No';
                            question.Answered = true;
                        } 
                    } else {
                        question.Answered = true;
                    }                    
                }            
            
                if(question.QuestionType == 'Text Only'){
                    question.Answered = true;
                }
                Schema.DescribeFieldResult businessField = fieldMap.get(question.BusinessFieldMapping)?.getDescribe();
                if(question.BusinessFieldMapping != null && businessField != null && (businessField.getType().name() == 'PICKLIST' || businessField.getType().name() == 'MULTIPICKLIST')){
                    
                    for(Schema.PicklistEntry entry : fieldMap.get(question.BusinessFieldMapping).getDescribe().getPicklistValues()){
                        if(entry.isActive()){ question.PicklistMap.put(entry.getLabel(), entry.getValue()); }
                    }
                }
                if(question.FilterTags != null){
                    for(String tag : question.FilterTags){
                        if(!questionFilters.contains(tag)){
                            questionFilters.add(tag);
                        }
                    }
                }

                //questionLabelToQuestion.put(question.Label, question);

                // if(question.ParentQuestionName != null){
                //     if(!parentNameToChildQuestions.containsKey(question.ParentQuestionName)){
                //         parentNameToChildQuestions.put(question.ParentQuestionName, new List<GuidedSellingQuestionWrapper>{question});
                //     } else {
                //         parentNameToChildQuestions.get(question.ParentQuestionName).add(question);
                //     }
                // }
            } catch(Exception ex) {
                System.debug(ex.getMessage());
            }
            discoveryQuestions.add(question);
            System.debug('question '+question);
        }
        
        
        //Map question to default
        defaultRevenue = (business.Anticipated_Revenue__c != null) ? business.Anticipated_Revenue__c : '---';
        defaultIndustry = (business.Industry__c != null) ? business.Industry__c : 'Select an Industry';
        defaultEntity = (businessEntity != null) ? businessEntity : 'Select an Entity Type';
        defaultNumOwners = (business.Number_of_Owners__c != null) ? business.Number_of_Owners__c : '---';
        defaultStartupCosts = (business.Startup_Costs__c != null) ? business.Startup_Costs__c : '---';
        defaultYearsInBusiness = (business.Years_In_Business__c != null) ? business.Years_In_Business__c : '---';
        //defaultPersonalState = (business.State_of_Residence__c != null) ? business.State_of_Residence__c : 'Select a State';
        defaultFirstYearProfit = (business.Profit_Projection__c != null) ? business.Profit_Projection__c : '---';
        //defaultNumContractors = (business.Number_of_Contractors__c != null) ? business.Number_of_Contractors__c : '---';
        defaultOffice = (business.Home_Office_Square_Feet__c != null) ? String.valueOf(business.Home_Office_Square_Feet__c) : '---';
        defaultDomesticState = (business.State_of_incorporation__c != null) ? business.State_of_incorporation__c : 'Select a State';
        defaultForeignState = (business.Foreign_State_of_Incorporation__c != null) ? business.Foreign_State_of_Incorporation__c : 'Select a State';
        //defaultInvestorFunding = (business.Investor_Funding__c != null) ? business.Investor_Funding__c : '---';
        defaultNumTransactions = (business.Monthly_Bookkeeping_Transactions__c != null) ? String.valueOf(business.Monthly_Bookkeeping_Transactions__c) : '---';
        //defaultNumForeignOwners = (business.Number_of_Foreign_Owners__c != null) ? business.Number_of_Foreign_Owners__c : '---';
        defaultNumEmployees = (business.Number_of_Employees__c != null) ? String.valueOf(numEmpl+1) : '---';
        defaultFilingStatus = (business.Tax_Filing_Status__c != null) ? business.Tax_Filing_Status__c : 'Select a Filing Status';
        defaultPersonalIncome = (business.W2_Income__c != null) ? business.W2_Income__c : '---';
        defaultNumberOfRentalProperties = (business.Number_of_Rental_Properties__c != null) ? business.Number_of_Rental_Properties__c : '---';
        //defaultOtherInvestments = (business.Number_of_K1_Investments__c != null) ? business.Number_of_K1_Investments__c : '---';
        defaultMileage = (business.Yearly_Business_Miles__c != null) ? business.Yearly_Business_Miles__c : '---';
        firstBusiness = business.First_Business__c;
        runPayrollBefore = business.Run_Payroll_Before__c;
        hasEmployeesContractors = business.Has_Employees_Contractors__c;
        //foreignIncome = business.Foreign_Income__c;
        hasRentalProperties = business.Has_Rental_Properties__c;
        isWorkingFromHome = business.Is_Working_From_Home__c;
        commutesWithOwnVehicle = business.Commutes_With_Own_Vehicle__c;
        //eCommerce = business.E_Commerce__c;
        

        user = [SELECT Id, Name, Skills_Sales__c, Sell_Client_Books__c FROM User WHERE Id = :opportunity.Account.Owner.Id LIMIT 1];

        account = [SELECT Id, Lead_Type_New__c, Lead_Source__c, State_of_Formation__c, Entity_Tax_Classification__c, (SELECT Id, Name, Subscription_Status__c FROM Active_Subscriptions__r) FROM Account WHERE Id = :opportunity.AccountId LIMIT 1];
        if(account.Lead_Type_New__c == null){account.Lead_Type_New__c = '';}
        if(account.Lead_Type_New__c.contains('BTP')){
            hasActiveBTP = true;
        }
        if(account.Lead_Type_New__c.contains('PTP')){
            hasActivePTP = true;
        }
        if(account.Lead_Type_New__c.contains('Advisory')){
            hasActiveAdvisory = true;
        }
        
        for(Active_Subscriptions__c sub : account.Active_Subscriptions__r){
            if(sub.Name == 'Tax Advisory'){
                hasActiveAdvisory = (sub.Subscription_Status__c == 'Active');
            } else if (sub.Name == 'Personal Tax Preparation'){
                hasActivePTP = (sub.Subscription_Status__c == 'Active');
            } else if (sub.Name == 'Business Tax Preparation'){
                hasActiveBTP = (sub.Subscription_Status__c == 'Active');
            } else if (sub.Name == 'Tax Hotline'){
                hasActiveHotline = (sub.Subscription_Status__c == 'Active');
            } else if (sub.Name.contains('Core Accounting Package') || sub.Name.contains('Custom Accounting Package')){
                hasActiveBundleProduct = (sub.Subscription_Status__c == 'Active');
            }     
            // else if (sub.Name == 'Business Tax Preparation - Federal Only'){
            //     hasActiveBTPNS = true;
            // }
        }
        accountJSON = JSON.serialize(account);
        isNonProfit = account.Entity_Tax_Classification__c  == 'Non-Profit';
        if(!String.isBlank(business.Id)) {
            businessId = business.Id;
            partners = [
                SELECT Id, First_Name__c, Last_Name__c, Email__c, Phone__c, Partner_Role__c, Primary_Contact__c 
                FROM Business_Owner__c 
                WHERE Business__c = :business.Id
                AND Primary_Contact__c = false
            ];

            businessOwner = [
                SELECT Id, First_Name__c, Last_Name__c, Email__c, Phone__c, Partner_Role__c, Primary_Contact__c, Address__c, City__c, State__c, Zip__c, Country__c
                FROM Business_Owner__c
                WHERE Business__c = :business.Id
                AND Primary_Contact__c = true
                LIMIT 1
            ];
            businessOwner.Phone__c = normalizePhoneNumber(businessOwner.Phone__c);
        } else {
            businessOwner = new Business_Owner__c();
        }
        System.debug('*checkpoint 4');

        defaultCountry = (businessOwner.Country__c != null) ? businessOwner.Country__c : 'United States';
        defaultState = (businessOwner.State__c != null) ? businessOwner.State__c : 'Select a State';

        //Logic based on Lead Source here
        btp = false;

        //Calculator Environment logic
        environment = 'Standard';
        System.debug('checking lead source');
        if(null != opportunity.Account.Lead_Source__c) {
                
            //Setting the LegalZoom script here: Priority for LegalZoom script: 1.BTP 2.BAP
            if('LegalZoom' == opportunity.Account.Lead_Source__c && null != opportunity.Account.Lead_Type_New__c) {
                if(opportunity.Account.Lead_Type_New__c?.contains('BTP')) {
                    btp = true;
                    useBTPLegalZoomScript = true;   
                } else if(opportunity.Account.Lead_Type_New__c?.contains('BAP') && !opportunity.Account.Lead_Type_New__c?.contains('BTP')) {
                    useBAPLegalZoomScript = true;
                }
            }
            
            
            if(null != opportunity.Account.Lead_Type_New__c) {
                if('Sprout' == opportunity.Account.Lead_Type_New__c) {
                    environment = 'Sprout';
                }

                if('EIN' == opportunity.Account.Lead_Type_New__c || 'EIN Tax Filing' == opportunity.Account.Lead_Source__c) {
                    environment = 'EIN Tax Filing';
                }
            }
        }

        /* ----- Comment this out since this rul was deativated on the Calculator Rules records -----
        if((null != opportunity.Account.Owner.Skills_Sales__c && opportunity.Account.Owner.Skills_Sales__c.contains('Paid Digital–Entity')) || 
           (null != opportunity.Account.Campaign__c && opportunity.Account.Campaign__c.contains('Entity Formation'))){
            environment = 'Entity Formation';
        } 
        */
        System.debug('*checkpoint ');
        System.debug('environment: '+environment);

        String queryEnvironment = '%'+environment+'%';
        List<Required_Fields_Guided_Selling__mdt> getRequired = [
            SELECT Guided_Selling_Field_Name__c, Required__c, Label FROM Required_Fields_Guided_Selling__mdt WHERE Required__c LIKE :queryEnvironment
        ];

        System.debug('getRequired '+getRequired);

        for(Required_Fields_Guided_Selling__mdt rf : getRequired) {
            if(null == requiredfields) {
                requiredfields = rf.Label;
                numRequiredFields = 1;
            } else {
                requiredfields += ', ' + rf.Label;
                numRequiredFields++;
            }
        }

        System.debug('*checkpoint 5');

        defaultProducts = new List<GuidedSellingProduct>(); //filter all products based on GSID and account fields
        frequentProducts = new List<GuidedSellingProduct>(); //filter all products based on p.Calculator_Location__c
        businessProducts = new List<GuidedSellingProduct>();  //filter all products based on p.Name
        personalProducts = new List<GuidedSellingProduct>(); //filter all products based on p.Name
        payrollProducts = new List<GuidedSellingProduct>(); //filter all products based on p.Name
        bookkeepingProducts = new List<GuidedSellingProduct>(); //filter all products based on p.Name
        finalProducts = new List<GuidedSellingProduct>(); //the same list as allProducts
        entityFormationProducts = new List<GuidedSellingProduct>(); //filter all products based on p.Name
        disabledMessage = new Map<String, String>();
        guidedSellingProductsIdMap = new Map<String, GuidedSellingProduct>();
        productToIdentifier = new Map<Id, String>();
        productToPrice = new Map<Id, Decimal>();
        defaultPrices = new Map<Id, Decimal>();
        
        eligibleBundle = getEligibleBundle();
    }

    public string getEligibleBundle(){
        if(account?.Lead_Source__c == 'Tailor Brands'){
            if(account?.Lead_Type_New__c?.contains('BTPNS')){
                return 'Core Accounting Package (Partner BTPNS/BOI)';
            }
            if(hasActiveBTP){
                if(hasActivePTP){
                    return 'Core Accounting Package (Partner BTP/PTP/BOI)';
                } else {
                    return 'Core Accounting Package (Partner BTP/BOI)';
                }
            }
        } else if(account?.Lead_Source__c == 'ZenBusiness' && hasActiveBTP){
            return 'Core Accounting Package (Partner BTP)';
        }
        return 'Core Accounting Package';        
    }

    public void updateEventSubject(){
        if(eventRec != null && eventRec.Subject != null && !eventRec.Subject.toLowerCase().contains('guided selling')){
            eventRec.Subject += ' - Guided Selling';
            update eventRec;
        }
    }

    @RemoteAction
    public static void updateRegistrationDate(Id accountId, Date formationDate){
        Account acc = new Account(Id=accountId, Registration_Date__c=formationDate);
        update acc;
    }

    public void getProductData() {
        //System.debug('bookkeepingStartString: '+bookkeepingStartString);
        
        Map<Id, Product2> products = new Map<Id, Product2>([
            SELECT Id, Name, Guided_Selling_Identifier__c, Calculator_Location__c, AnnualMonthlyOption__c, Bundles__c,
            Billing_Frequency__c, Disable_QTY_on_Calc__c, sort_Order__c, No_Split_Allowed__c, HTML_Description__c, Setup_Fee__c
            FROM Product2 
            WHERE Guided_Selling_Identifier__c != null 
            AND Environment__c INCLUDES (:environment) 
            AND Product2.ChargeOver__c = true
            ORDER BY Name
        ]);

        // for(Product2 p : products.values()){
        //     productIdToDescription.put(p.Id, p.Description);
        //     productIdToHTML.put(p.Id, p.HTML_Description__c);
        //     p.Description = '';
        //     p.HTML_Description__c = '';
        // }

        user = [SELECT Id, Name, Skills_Sales__c, Sell_Client_Books__c FROM User WHERE Id = :opportunity.Account.Owner.Id LIMIT 1];
        account = [SELECT Id, Lead_Type_New__c, Lead_Source__c, State_of_Formation__c, Entity_Tax_Classification__c, (SELECT Id, Name FROM Active_Subscriptions__r WHERE Subscription_Status__c = 'Active') FROM Account WHERE Id = :opportunity.AccountId LIMIT 1];
            

        defaultProducts = new List<GuidedSellingProduct>(); //filter all products based on GSID and account fields
        frequentProducts = new List<GuidedSellingProduct>(); //filter all products based on p.Calculator_Location__c
        businessProducts = new List<GuidedSellingProduct>();  //filter all products based on p.Name
        personalProducts = new List<GuidedSellingProduct>(); //filter all products based on p.Name
        payrollProducts = new List<GuidedSellingProduct>(); //filter all products based on p.Name
        bookkeepingProducts = new List<GuidedSellingProduct>(); //filter all products based on p.Name
        finalProducts = new List<GuidedSellingProduct>(); //the same list as allProducts
        entityFormationProducts = new List<GuidedSellingProduct>(); //filter all products based on p.Name
        Set<String> allProducts = new Set<String>(); //add each product, then remove some based on Product_Configuration__mdt 
        disabledMessage = new Map<String, String>();
        List<Id> allProductIds = new List<Id>();
        guidedSellingProductsIdMap = new Map<String, GuidedSellingProduct>();

        for(Product2 p : products.values()) {
            p.HTML_Description__c = p.HTML_Description__c?.substring(0,Math.min(1000,p.HTML_Description__c.length())).escapeHtml4().escapeJava();
            allProducts.add(p.Guided_Selling_Identifier__c);
            allProductIds.add(p.Id);
        }

        List<Product_Configuration__mdt> removeOrDisable = [
            SELECT Id, Label, Account_Field__c, Action__c, Active__c, Message__c, Operator__c, Product_Name__c, User_Field__c, Value__c
            FROM Product_Configuration__mdt
            WHERE Product_Name__c IN :allProducts
            AND Active__c = true
        ];

        for(Product_Configuration__mdt rule : removeOrDisable) {
            String accountFieldValue = rule.Account_Field__c;
            String userFieldValue = rule.User_Field__c;
                
            if(null != userFieldValue) {
                Map<String, Object> serializedUser = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(user));
                String userValue = String.valueOf(serializedUser.get(userFieldValue));
                if(compareValueWithList(rule.Operator__c, userValue, rule.Value__c.split(','))){
                    if('Remove Product' == rule.Action__c) {
                        allProducts.remove(rule.Product_Name__c);
                    } else {
                        if(null == disabledProducts) {
                            disabledProducts = rule.Product_Name__c;
                        } else {
                            disabledProducts += ', ' + rule.Product_Name__c;
                        }
                        disabledMessage.put(rule.Product_Name__c, rule.Message__c);
                    }
                }                
            }

            if(null != accountFieldValue) {
                System.debug('rule '+rule);
                Map<String, Object> serializedAccount = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(account));
                System.debug('serializedAccount '+serializedAccount);
                System.debug('accountFieldValue: '+accountFieldValue);
                String accountValue = String.valueOf(serializedAccount.get(accountFieldValue));
                if(compareValueWithList(rule.Operator__c, accountValue, rule.Value__c.split(','))){
                    if('Remove Product' == rule.Action__c) {
                        allProducts.remove(rule.Product_Name__c);
                    } else {
                        if(null == disabledProducts) {
                            disabledProducts = rule.Product_Name__c;
                        } else {
                            disabledProducts += ', ' + rule.Product_Name__c;
                        }
                        disabledMessage.put(rule.Product_Name__c, rule.Message__c);
                    }
                }    
            }
        }

        productToIdentifier = new Map<Id, String>();

        Map<String, Id> productIdToIdentifier = new Map<String, Id>();
        for(Product2 p : products.values()) {
            if(allProducts.contains(p.Guided_Selling_Identifier__c)) {
                guidedSellingProductsIdMap.put(p.Guided_Selling_Identifier__c, new GuidedSellingProduct(p));
                //finalProducts.add(p);
                productIdToIdentifier.put(p.Guided_Selling_Identifier__c, p.Id);
                productToIdentifier.put(p.Id, p.Guided_Selling_Identifier__c);
                
                if('Non-Profit Tax Preparation' == p.Guided_Selling_Identifier__c) {
                    nonProfitTaxPrepId = p.Id;
                }

                if('Business Return' == p.Guided_Selling_Identifier__c) {
                    businessReturnId = p.Id;
                }
            }  else {
                System.debug('allProducts does not contain '+p.Guided_Selling_Identifier__c);
            }
        }
        System.debug('productToIdentifier: '+productToIdentifier);

        List<Product_Pricing_Rule__mdt> overrideRules = [
            SELECT Id, MasterLabel, Quote_Field2__c, Product_Name__c, Field_Value__c, Price_Adjustment__c, User_Field__c, Account_Field__c, Flat_Price_Override__c
            FROM Product_Pricing_Rule__mdt
            WHERE Product_Name__c IN :allProducts
            AND Flat_Price_Override__c = true
            AND Active__c = true
        ];

        Business__c b;
        List<Business__c> bList = [
                SELECT Id, Name, Account__c, Anticipated_Revenue__c, Industry__c, Business_Type__c, Number_of_Owners__c, Startup_Costs__c, Years_In_Business__c, 
                Profit_Projection__c, Home_Office_Square_Feet__c,
                State_of_incorporation__c, Monthly_Bookkeeping_Transactions__c, Number_of_Employees__c, Tax_Filing_Status__c,
                W2_Income__c, Number_of_Rental_Properties__c, Yearly_Business_Miles__c, 
                Run_Payroll_Before__c, Has_Employees_Contractors__c, File_Return_Yourself__c, Has_Rental_Properties__c, Is_Working_From_Home__c, Commutes_With_Own_Vehicle__c, 
                First_Business__c, Foreign_State_of_Incorporation__c
                FROM Business__c 
                WHERE Account__r.Id = :opportunity.AccountId
                LIMIT 1
            ];
            if(bList.isEmpty()){
                b = new Business__c();
            } else {
                b = bList[0];
            }

        User u = [SELECT Id, Name, Skills_Sales__c, Sell_Client_Books__c FROM User WHERE Id = :opportunity.Account.Owner.Id LIMIT 1];
        Account a = [SELECT Id, Lead_Type_New__c, Lead_Source__c FROM Account WHERE Id = :opportunity.AccountId LIMIT 1];

        productToPrice = new Map<Id, Decimal>();
        defaultPrices = new Map<Id, Decimal>();
            
        for(Product_Pricing_Rule__mdt rule : overrideRules) {
            String quoteFieldValue = rule.Quote_Field2__c;
            String accountFieldValue = rule.Account_Field__c;
            String userFieldValue = rule.User_Field__c;
            
            // Calling it "quote" but we are using the business data and fields
            if(null != quoteFieldValue) {
                Map<String, Object> serializedQuote = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(b));
                String quoteValue = String.valueOf(serializedQuote.get(quoteFieldValue));
                if(quoteValue == rule.Field_Value__c) {
                    productToPrice.put(productIdToIdentifier.get(rule.Product_Name__c), rule.Price_Adjustment__c);
                    defaultPrices.put(productIdToIdentifier.get(rule.Product_Name__c), rule.Price_Adjustment__c);
                }
            } 

            if(null != userFieldValue) {
                Map<String, Object> serializedUser = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(u));
                String userValue = String.valueOf(serializedUser.get(userFieldValue));
                if(userValue == rule.Field_Value__c) {
                    productToPrice.put(productIdToIdentifier.get(rule.Product_Name__c), rule.Price_Adjustment__c);
                    defaultPrices.put(productIdToIdentifier.get(rule.Product_Name__c), rule.Price_Adjustment__c);
                }
            }

            if(null != accountFieldValue) {
                Map<String, Object> serializedAccount = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(a));
                String accountValue = String.valueOf(serializedAccount.get(accountFieldValue));
                if(accountValue == rule.Field_Value__c) {
                    productToPrice.put(productIdToIdentifier.get(rule.Product_Name__c), rule.Price_Adjustment__c);
                    defaultPrices.put(productIdToIdentifier.get(rule.Product_Name__c), rule.Price_Adjustment__c);
                }
            }
        }

        List<Product_Pricing_Rule__mdt> rules = [
            SELECT Id, MasterLabel, Quote_Field2__c, Product_Name__c, Field_Value__c, Price_Adjustment__c, User_Field__c, Account_Field__c, Flat_Price_Override__c
            FROM Product_Pricing_Rule__mdt
            WHERE Product_Name__c IN :allProducts
            AND Flat_Price_Override__c = false
            AND Active__c = true
        ];
        
        for(Product_Pricing_Rule__mdt rule : rules) {
            String quoteFieldValue = rule.Quote_Field2__c;
            Map<String, Object> serializedObject = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(b));
            String quoteValue = String.valueOf(serializedObject.get(quoteFieldValue));

            if(quoteValue == rule.Field_Value__c) {
                System.debug('applying rule: '+rule);
                if(null == productToPrice.get(productIdToIdentifier.get(rule.Product_Name__c))) {
                    productToPrice.put(productIdToIdentifier.get(rule.Product_Name__c), rule.Price_Adjustment__c);
                    defaultPrices.put(productIdToIdentifier.get(rule.Product_Name__c), rule.Price_Adjustment__c);
                } else {
                    Decimal totalPrice = productToPrice.get(productIdToIdentifier.get(rule.Product_Name__c)) + rule.Price_Adjustment__c;
                    productToPrice.put(productIdToIdentifier.get(rule.Product_Name__c), totalPrice);
                    defaultPrices.put(productIdToIdentifier.get(rule.Product_Name__c), totalPrice);
                }
                System.debug(productToPrice);
            }
            
        }

        // Bundles logic 

        List<Product_Offer__mdt> offerList = [
            SELECT Id, DeveloperName, MasterLabel, Active__c, Amount__c, Environment__c, Product__c, calcId__c
            FROM Product_Offer__mdt 
            WHERE Active__c = true 
            AND Environment__c = :environment
        ];
    
        for(Product_Offer__mdt offerProductItem : offerList) {
            for(Product2 p : products.values()) {
                if(productIdToIdentifier.get(offerProductItem.Product__c) != null) {
                    if(offerProductItem.Product__c == p.Guided_Selling_Identifier__c) {
                        System.debug('applying offer: '+offerProductItem);
                        productToPrice.put(productIdToIdentifier.get(offerProductItem.Product__c), offerProductItem.Amount__c);
                        defaultPrices.put(productIdToIdentifier.get(offerProductItem.Product__c), offerProductItem.Amount__c);
                        System.debug(productToPrice);
                    }
                }
            }
        } 

        Id pricebookId = [SELECT Id, Name, IsActive from PriceBook2 where IsStandard = true LIMIT 1].Id;
        List<Pricebook2> pbList = [SELECT Id, Name, IsActive, IsStandard FROM Pricebook2 WHERE IsActive = true AND Environment__c INCLUDES (:environment)];
        
        for(Pricebook2 pbItem : pbList) {
            pricebookId = pbItem.Id;
        } 
            
        List<PricebookEntry> prices = [
            SELECT Id, Name, Pricebook2Id, UnitPrice, IsActive, Product2Id, Product2.Name, Product2.ChargeOver__c, Product2.Calculator_Location__c, Product2.Guided_Selling_Identifier__c
            FROM PricebookEntry
            WHERE Pricebook2Id = :pricebookId
            AND isActive = true
            AND Product2.ChargeOver__c = true
            AND Product2Id IN :allProductIds
            AND Product2.Id NOT IN :productToPrice.keySet()
        ];
             
        for(PricebookEntry pb : prices) {
            if(null != productIdToIdentifier.get(pb.Product2.Guided_Selling_Identifier__c)) {
                Decimal price = pb.UnitPrice;
                // if(pb.Product2.Guided_Selling_Identifier__c == '1-800Accountant Access'){
                //     price = price * (11.0/12.0);
                // }
                System.debug('applying pbe: '+pb);
                productToPrice.put(productIdToIdentifier.get(pb.Product2.Guided_Selling_Identifier__c), price);
                defaultPrices.put(productIdToIdentifier.get(pb.Product2.Guided_Selling_Identifier__c), price);
                System.debug(productToPrice);
            }
        }
        for(String gsid : productIdToIdentifier.keySet()){
            Double adjustedPrice = productToPrice.get(productIdToIdentifier.get(gsid));//+0.03;
            guidedSellingProductsIdMap.get(gsid).adjustedPrice = adjustedPrice;
            guidedSellingProductsIdMap.get(gsid).subtotal = adjustedPrice;//qty=1 and freq=default
        }

        if(isValidQuoteId()){
            System.debug('quoteId: '+quoteId);
            List<OpportunityLineItem> oppItems = [SELECT Payment_Cycle__c, Installment_Payment_Schedule__c, Quantity, UnitPrice, Description FROM OpportunityLineItem WHERE OpportunityId = :opportunity.Id];
            Map<String,String> prodNameToGsid = new Map<String, String>();
            for(Product2 prod : [SELECT Name, Guided_Selling_Identifier__c FROM Product2 WHERE Guided_Selling_Identifier__c != null]){
                prodNameToGsid.put(prod.Name, prod.Guided_Selling_Identifier__c);
            }
            for(OpportunityLineItem oli : oppItems){
                System.debug('oli '+oli);
                String curGsid = prodNameToGsid.get(oli.Description);
                GuidedSellingProduct curProd = guidedSellingProductsIdMap.get(curGsid);
                curProd.currentQuantity =  oli.Quantity.intValue();
                //curProd.adjustedPrice = oli.UnitPrice;
                curProd.subtotal = oli.UnitPrice*oli.Quantity;
                if(new List<String>{'Monthly', 'Annual', 'One-Time'}.contains(oli.Installment_Payment_Schedule__c)){
                    curProd.currentBillingFrequency = oli.Installment_Payment_Schedule__c;
                } else {
                    curProd.currentBillingFrequency = new Map<String,String>{'mon'=>'Monthly', 'one'=>'One-Time', 'yrl'=>'Annual'}.get(oli.Payment_Cycle__c);
                }
                curProd.selected = true;
                existingQuoteProductNames.add(curProd.Product.Name);
            }
            // Quote curQuote = [SELECT billingSchedule__c, Calc_Bookkeeping_Start_Date__c FROM Quote WHERE Id = :quoteId LIMIT 1];
            // billingFreq = curQuote.billingSchedule__c;
            // existingBookkeepingStart = curQuote.Calc_Bookkeeping_Start_Date__c;
        } else {
            System.debug('no quoteId found');
        }
        guidedSellingProducts = guidedSellingProductsIdMap.values();
        Double monthlyTotal = 0;
        Double annualTotal = 0;
        for(GuidedSellingProduct p : tempSelectedProducts){//defaultProducts){
            p.selected = true;
            if(p.currentBillingFrequency == 'Monthly'){
                monthlyTotal += p.subtotal;
            } else {
                annualTotal += p.subtotal;
            }
            System.debug('GuidedSellingProduct '+p);
        }
        quoteTotalAnnual = annualTotal;
        quoteTotalMonthly = monthlyTotal;

        System.debug('guidedSellingProducts: ');
        for(GuidedSellingProduct p : guidedSellingProducts){
            if(disabledProductNames.contains(p.Product.Name)){
                p.enabled = false;
            }
            if(disabledQuantityProductNames.contains(p.Product.Name)){
                p.quantityEnabled = false;
            }
            if(advisoryAddonProductNames.contains(p.Product.Name) || bundleToDefaultProductNames.keySet().contains(p.Product.Name)){
                p.visible = false;
            }
            System.debug('GuidedSellingProduct '+p);
        }
        //System.debug(finalProductsJson);
        //System.debug(JSON.deserialize(selectedProductsJson, List<GuidedSellingProduct>.class));

        ApexPages.currentPage().getParameters().put('rerender', 'dProds, fProds, frProds, bProds, pProds, payProds, bkkProds, eProds');
        //return billingFreq;
    }

    @RemoteAction
    //public static String calculateSavingsGuidedSelling(String entityType, String profits, String startup, String mileage, String office, String filingStatus, String income, String industryType, String accountId) {
    public static String calculateSavingsGuidedSelling(String accountId) {
        Business__c bus = [SELECT Id,Business_Type__c,Profit_Projection__c,Startup_Costs__c,Yearly_Business_Miles__c,Industry__c,
            Home_Office_Square_Feet__c,Tax_Filing_Status__c,W2_Income__c FROM Business__c WHERE Account__r.Id = :accountId LIMIT 1];

        String entityType = bus.Business_Type__c == null ? 'LLC' : bus.Business_Type__c;
        String profits = bus.Profit_Projection__c == null ? '0' : bus.Profit_Projection__c;
        String startup = bus.Startup_Costs__c == null ? '0' : bus.Startup_Costs__c;
        String mileage = bus.Yearly_Business_Miles__c == null ? '0' : bus.Yearly_Business_Miles__c;
        String office = String.valueOf(bus.Home_Office_Square_Feet__c == null ? 0 : bus.Home_Office_Square_Feet__c);
        String filingStatus = bus.Tax_Filing_Status__c == null ? 'Single' : bus.Tax_Filing_Status__c;
        String income = bus.W2_Income__c == null ? '0' : bus.W2_Income__c;
        String industryType = bus.Industry__c == null ? 'Other' : bus.Industry__c;

        
        //Check for disqualifiers to be thorough, but none should get to this point
        Boolean displaySavings = PricingCalcController.displaySavings(entityType, industryType);
        
        //Calculating each saving type individually if not disqualified
        Decimal sCorpSavings = (!PricingCalcController.displaySCorporationSavings(Integer.valueOf(profits), entityType, industryType)) ? 0.00 : PricingCalcController.calculateSCorporationSavings(Integer.valueOf(PostTSALandingPageController.currencyStringToDecimal(profits)));
        Decimal officeSavings = ('---' == office || '0' == office || !displaySavings) ? 0.00 : PricingCalcController.calculateSavings('Home Office', filingStatus, Decimal.valueOf(income), Decimal.valueOf(profits), Decimal.valueOf(office), 0, 0);
        Decimal mileageSavings = ('---' == mileage || '0' == mileage || !PricingCalcController.displayBusinessMileageSavings(entityType, industryType)) ? 0.00 : PricingCalcController.calculateSavings('Business Mileage', filingStatus, Decimal.valueOf(income), Decimal.valueOf(profits), 0, Decimal.valueOf(mileage), 0);
        Decimal QBISavings = (!displaySavings) ? 0.00 : PricingCalcController.calculateSavings('QBI', filingStatus, Decimal.valueOf(income), Decimal.valueOf(profits), 0, 0, 0);
        Decimal startupSavings = ('---' == startup || '0' == startup || !displaySavings) ? 0.00 : PricingCalcController.calculateSavings('Startup Cost', filingStatus, Decimal.valueOf(income), Decimal.valueOf(profits), 0, 0, Decimal.valueOf(startup));
        
        //Add each savings together for the grand total
        Decimal finalSavings = sCorpSavings + officeSavings + mileageSavings + QBISavings + startupSavings;  

        if('' != accountId) {
            Account account = [
                SELECT Id
                // Name, Entity_Type_After_Discovery_Call__c, Current_Year_Profit_Projection__c, Total_Startup_Costs__c,
                // Personal_Return_Filing_Status__c, Personal_Income__c, Estimated_Business_Mileage__c, Home_Office_Square_Feet__c,
                // Potential_Business_Mile_Savings__c, Potential_Home_Office_Savings__c, Potential_QBI_Savings__c, Potential_SCorp_Savings__c,
                // Potential_Startup_Savings__c, Potential_Total_Savings__c, Foreign_State__c
                FROM Account
                WHERE Id =:accountId
                LIMIT 1
            ]; 

            //Updating the Account business details
            // account.Entity_Type_After_Discovery_Call__c = entityType;
            // account.Current_Year_Profit_Projection__c = profits;
            // account.Total_Startup_Costs__c = startup;
            // account.Personal_Return_Filing_Status__c = filingStatus;
            // account.Personal_Income__c = income;
            // account.Estimated_Business_Mileage__c = mileage;
            // account.Home_Office_Square_Feet__c = office;

            //Updating the Accounts's savings details
            account.Potential_Business_Mile_Savings__c = mileageSavings;//'$' + String.valueOf(mileageSavings);
            account.Potential_Home_Office_Savings__c = officeSavings;//'$' + String.valueOf(officeSavings);
            account.Potential_QBI_Savings__c = qbiSavings;//'$' + String.valueOf(qbiSavings);
            account.Potential_SCorp_Savings__c = sCorpSavings;//'$' + String.valueOf(sCorpSavings);
            account.Potential_Startup_Savings__c = startupSavings;//'$' + String.valueOf(startupSavings);
            account.Potential_Total_Savings__c = finalSavings;//'$' + String.valueOf(finalSavings);
            update account;
        }

        String result = String.valueOf(sCorpSavings) +','+ String.valueOf(officeSavings) +','+ String.valueOf(mileageSavings) +','+ String.valueOf(qbiSavings) +','+ String.valueOf(startupSavings) +','+ String.valueOf(finalSavings);
        
        return result;
    }

    public static Boolean compareValueWithList(String comparator, String value, List<String> valueList){
        System.debug(value+', '+comparator+', '+valueList);
        if('Not Equal' == comparator){
            return !compareValueWithList('Equals', value, valueList);
        }
        if('Does Not Contain String' == comparator){
            return !compareValueWithList('Contains String', value, valueList);
        }
        
        for(String valueFromList : valueList){
            if('Equals' == comparator && value == valueFromList){
                return true;
            }
            if('Contains String' == comparator && value != null && value.containsIgnoreCase(valueFromList)){
                return true;
            }
        }
        return false;
    }


    @RemoteAction
    public static void updateQuoteTotals(Double monthlyTotal, Double annualTotal){
        quoteTotalMonthly = monthlyTotal;
        quoteTotalAnnual = annualTotal;
    }

    public class businessWrapper {
        public String businessId { get;set; }
        public String businessOwnerId { get;set; }
    }

    @RemoteAction
    public static String createUpdatePartner(String businessId, String contactId, String companyName, String partnerData) {
        Partner partner;

        //For deletions, no partner data is passed
        if(null != partnerData) {
            partner = (Partner)JSON.deserialize(partnerData, Partner.class);
        }

        // Account account;
        Business_Owner__c businessOwner;
        Id existingContactId;
        Id existingLeadId;
        Lead toInsertLead;
        Business_Owner__c toInsertBusinessContact;

        //When updating
        if(null != contactId) {
            businessOwner = [
                SELECT Id, Name, First_Name__c, Last_Name__c, Email__c, Phone__c, Partner_Role__c, Business__c, Contact__c, Lead__c FROM Business_Owner__c WHERE Id = :contactId LIMIT 1
            ];

            if(null == partner) {
                delete businessOwner;
            } else {
                businessOwner.Name = partner.firstName + ' ' + partner.lastName;
                businessOwner.First_Name__c = partner.firstName;
                businessOwner.Last_Name__c = partner.lastName;
                businessOwner.Partner_Role__c = partner.role;
                businessOwner.Email__c = partner.email;
                businessOwner.Phone__c = partner.phone;
                update businessOwner;
            }

        //When inserting
        } else {
            //Checking if a contact exists that matches name or email already in the system to use
            List<Contact> checkForContacts = new List<Contact>([
                SELECT Id, Name, FirstName, LastName, Email, Phone, AccountId FROM Contact WHERE Email = :partner.email OR Phone = :partner.phone
            ]);

            Date lastYear = date.today().addDays(-366);

            if(!checkForContacts.isEmpty()) {
                existingContactId = checkForContacts[0].Id;
                
                Account acc = [SELECT Id, Name, Account_Status__c, CreatedDate FROM Account WHERE Id = :checkForContacts[0].AccountId LIMIT 1];
                
                if(acc.Account_Status__c == 'Prospect' || acc.Account_Status__c == 'Paused Client' || acc.Account_Status__c == 'Refunded Client') {
                    if(acc.CreatedDate > lastYear) {
                        acc.AccountSource = '1-800Accountant';
                    } else {
                        system.debug('else');
                        acc.AccountSource = '1-800Accountant';
                        acc.Lead_Source__c = '1-800Accountant';
                        acc.Lead_Source_New__c = '1-800Accountant';
                        acc.Lead_Type_New__c = 'Referral';
                    }
    
                    update acc;
                }
            }

            //Checking if a lead exists that matches name or email already in the system to use
            List<Lead> checkForLeads = new List<Lead>([
                SELECT Id, Name, FirstName, LastName, Email, Phone, CreatedDate, Lead_Type_New__c, LeadSource, Lead_Source_New__c FROM Lead WHERE Email = :partner.email OR Phone = :partner.phone
            ]);

            if(!checkForLeads.isEmpty()) {
                existingLeadId = checkForLeads[0].Id;
            }

            if(null == existingContactId && null == existingLeadId) {
                toInsertLead = new Lead(
                    FirstName = partner.firstName,
                    LastName = partner.lastName,
                    Email = partner.email,
                    Phone = partner.phone,
                    Company = partner.firstName + ' ' + partner.lastName,
                    LeadSource = '1-800Accountant',
                    Lead_Source_New__c = '1-800Accountant',
                    Lead_Type_New__c = 'Referral'
                );
                insert toInsertLead;
            }

            Id leadToSave;
            if(null != toInsertLead) {
                leadToSave = toInsertLead.Id;
            } else if(null == existingContactId) {
                leadToSave = existingLeadId;

                Lead l = checkForLeads[0];

                if(checkForLeads[0].CreatedDate > lastYear) {
                    l.Lead_Type_New__c = 'Referral';
                } else {
                    l.LeadSource = '1-800Accountant';
                    l.Lead_Source_New__c = '1-800Accountant';
                    l.Lead_Type_New__c = 'Referral';
                }

                update l;
            }

            businessOwner = new Business_Owner__c(
                Name = partner.firstName + ' ' + partner.lastName,
                First_Name__c = partner.firstName,
                Last_Name__c = partner.lastName,
                Email__c = partner.Email,
                Phone__c = partner.phone,
                Partner_Role__c = partner.role,
                Business__c = businessId,
                Contact__c = existingContactId,
                Lead__c = leadToSave                
            );
            insert businessOwner;
        }
        return businessOwner.Id;
    }


    @RemoteAction
    public static void dispositionEvent(String rId, String secdis, String primDis, String accId) {

        Event event = new Event();

        if(Test.isRunningTest()) {
            event = [
                SELECT Id, StartDateTime, Appointment_Disposition__c, Secondary_Disposition_Details__c 
                FROM Event 
                WHERE (Type_of_Appointment__c = 'Tax Savings Analysis' OR Type_of_Appointment__c = 'Formation Consultation')
                AND (WhoId =:rId OR WhatId =:rId OR Id =:rId) 
                LIMIT 1
            ];
        } else {
            System.debug('rid: '+rid+', accId: '+accId);
            List<Lead> convertedLead = [SELECT Id, ConvertedOpportunityId FROM Lead 
            WHERE Id = :rId AND IsConverted = true];
            
            if(!convertedLead.isEmpty()){
                rid = convertedLead[0].ConvertedOpportunityId;
            }
            event = [
                SELECT Id, StartDateTime, Appointment_Disposition__c, Secondary_Disposition_Details__c 
                FROM Event 
                WHERE (Type_of_Appointment__c = 'Tax Savings Analysis' OR Type_of_Appointment__c = 'Formation Consultation')
                AND (WhoId =:rId OR WhatId =:rId OR Id =:rId) 
                AND (Account__c =:accId) 
                //AND StartDateTime = TODAY
                LIMIT 1
            ];
        }

        event.Appointment_Disposition__c = primDis;
        event.Secondary_Disposition_Details__c = secdis;

        update event;
    }
    
    @RemoteAction
    public static void sentEmail(String oppId) {
        Opportunity opp = [SELECT Send_Quote_Toggle__c FROM Opportunity WHERE Id = :oppId LIMIT 1];
        String oppString = JSON.serialize(new Opportunity(
            Id = oppId,
            Send_Quote_Toggle__c = !opp.Send_Quote_Toggle__c,
            StageName = 'Quote Sent'
        ));

        EventBus.publish(new Update_Opportunity__e(Opportunity_JSON__c = oppString));
    }

    @RemoteAction
    public static String isOpportunityPaid(String oppId) {
               
        Opportunity opp = [SELECT Id, StageName FROM Opportunity WHERE Id =:oppId LIMIT 1];
        return opp.StageName;
    }

    @RemoteAction
    public static void saveNote(String accId, String title, String note) {
        
        Contact con = [SELECT Id, Description FROM Contact WHERE Id =:accId LIMIT 1];
        String d = con.Description;
        if(d == null || d == '') {
            con.Description = title + ': ' + note;
        } else {
            //con.Description = d + '\n' + title + ': ' + note;
            con.Description = title + ': ' + note;
        }
        update con;
    }

    @RemoteAction
    //public static Map<String,String> saveAnswers(String answers, String businessId, String accId, String environment) {
    public static void saveAnswers(String questionListJSON, String businessId, String accId) {

        System.debug('saveAnswers');
        Map<String, Schema.SObjectField> businessFieldMap = Schema.SObjectType.Business__c.fields.getMap();
        Map<String, Schema.SObjectField> accountFieldMap = Schema.SObjectType.Account.fields.getMap();
        List<GuidedSellingQuestionWrapper> questionList = (List<GuidedSellingQuestionWrapper>) JSON.deserialize(questionListJSON, List<GuidedSellingQuestionWrapper>.class);
        Map<String,String> answersMap = new Map<String,String>();
        List<String> answersList = new List<String>();
        List<String> answersSplitList = new List<String>();

        
        Business__c bus = new Business__c(Id = businessId);
        Account acc = new Account(Id = accId);
        for(GuidedSellingQuestionWrapper question : questionList){
            if(question.Value != null && question.PicklistMap?.get(question.Value) != null){
                question.Value = question.PicklistMap?.get(question.Value); //convert label to picklist value
            }
            Object valueToSave;
            if(question.Value != null && question.AccountFieldMapping != null){
                String fieldType = accountFieldMap.get(question.AccountFieldMapping).getDescribe().getType().name();
                if(fieldType == 'Boolean'){
                    valueToSave = Boolean.valueOf(question.Value == 'Yes');
                } else if(fieldType == 'Date'){
                    valueToSave = Date.valueOf(question.Value);
                } else if(fieldType == 'Datetime'){
                    valueToSave = Datetime.valueOf(question.Value);
                } else if(fieldType == 'Integer'){
                    valueToSave = Integer.valueOf(removeSubstrings(question.Value, new List<String>{'$', ','}));
                } else if(fieldType == 'Double'){
                    valueToSave = Double.valueOf(removeSubstrings(question.Value, new List<String>{'$', ','}));
                } else {
                    valueToSave = question.Value;
                }
                acc.put(question.AccountFieldMapping, valueToSave);
            }
            if(question.Value != null && question.BusinessFieldMapping != null){
                String fieldType = businessFieldMap.get(question.BusinessFieldMapping).getDescribe().getType().name();
                if(fieldType == 'Boolean'){
                    valueToSave = Boolean.valueOf(question.Value == 'Yes');
                } else if(fieldType == 'Date'){
                    valueToSave = Date.valueOf(question.Value);
                } else if(fieldType == 'Datetime'){
                    valueToSave = Datetime.valueOf(question.Value);
                } else if(fieldType == 'Integer'){
                    valueToSave = Integer.valueOf(removeSubstrings(question.Value, new List<String>{'$', ','}));
                } else if(fieldType == 'Double' || fieldType == 'Currency'){
                    valueToSave = Double.valueOf(removeSubstrings(question.Value, new List<String>{'$', ','}));
                } else {
                    valueToSave = question.Value;
                }
                System.debug(question.BusinessFieldMapping+' ('+fieldType+') = '+valueToSave);
                bus.put(question.BusinessFieldMapping, valueToSave);
            }
        }
        update acc;
        update bus;
        

        // if(!String.isBlank(answers)) {
        //     answersList = answers.split('///');
        // }

        // if(!answersList.isEmpty()) {
        //     System.debug(answersList);
        //     for(String s : answersList) {
        //         answersSplitList = s.split('\\?');
        //         System.debug(answersSplitList);
        //         if(!answersSplitList.isEmpty()) {
        //             if(answersSplitList.size() == 1){
        //                 answersMap.put(answersSplitList[0], null);
        //             } else {
        //                 answersMap.put(answersSplitList[0], answersSplitList[1]);
        //             }                    
        //         }
        //     }
        // }

        // if(!answersMap.isEmpty()) {
        //     Business__c bus = new Business__c(Id = businessId);
        //     bus.First_Business__c = (answersMap.get('Is this your first business') == 'Yes') ? true : false;
        //     bus.Years_In_Business__c = answersMap.get('How many years have you been in business');
        //     bus.Business_Type__c = answersMap.get('What entity type is your business');
        //     bus.Industry__c = answersMap.get('What industry is your business in');
        //     bus.State_of_incorporation__c = answersMap.get('What is your state of incorporation');
        //     bus.Foreign_State_of_Incorporation__c = answersMap.get('What is your foreign state of incorporation');
        //     //bus.State_of_Residence__c = answersMap.get('What is your state of residence');
        //     bus.Startup_Costs__c = answersMap.get('How much have you invested so far in start-up costs');
        //     bus.Anticipated_Revenue__c = answersMap.get('What do you anticipate your revenue to be over the next 12 months');
        //     bus.Profit_Projection__c = answersMap.get('What do you project your 1st year profit to be over the next 12 months');
        //     //bus.Investor_Funding__c = answersMap.get('What is your total investor funding');
        //     bus.Monthly_Bookkeeping_Transactions__c = answersMap.get('How many monthly bookkeeping transactions do you have');
        //     bus.Number_of_Owners__c = answersMap.get('How many owners does your business have');
        //     //bus.Number_of_Foreign_Owners__c = answersMap.get('How many owners are outside the USA');
        //     bus.Run_Payroll_Before__c = (answersMap.get('Have you run payroll before') == 'Yes') ? true : false;
        //     bus.Has_Employees_Contractors__c = (answersMap.get('Do you currently have any employees') == 'Yes') ? true : false;
        //     bus.Number_of_Employees__c = String.valueOf(answersMap.get('How many employees do you have'));
        //     //bus.Number_of_Contractors__c = answersMap.get('How many contractors do you have');
        //     bus.Tax_Filing_Status__c = answersMap.get('What is your tax filing status');
        //     bus.W2_Income__c = answersMap.get('What was your household W-2 income last year');
        //     //bus.Foreign_Income__c = (answersMap.get('Do you have any foreign sourced income') == 'Yes') ? true : false;
        //     bus.Has_Rental_Properties__c = (answersMap.get('Do you currently have any rental properties') == 'Yes') ? true : false;
        //     bus.Number_of_Rental_Properties__c = answersMap.get('How many rental properties do you have');
        //     // bus.Number_of_K1_Investments__c = answersMap.get('How many K-1s are from other investments');
        //     bus.Is_Working_From_Home__c = (answersMap.get('Will you be working from home') == 'Yes') ? true : false;
        //     bus.Home_Office_Square_Feet__c = Decimal.valueOf(answersMap.get('What is the approximate square footage of your home office'));
        //     bus.Commutes_With_Own_Vehicle__c = (answersMap.get('Will you use your personal vehicle for business purposes') == 'Yes') ? true : false;
        //     bus.Yearly_Business_Miles__c = answersMap.get('How many business-related miles do you estimate you’ll drive per year');
        //     //bus.E_Commerce__c = (answersMap.get('Will your business have a web or e-commerce presence') == 'Yes') ? true : false;

        //     update bus;

        //     Account acc = new Account(Id = accId);
        //     acc.State_of_Formation__c = answersMap.get('What is your state of incorporation');
        //     acc.Entity_Tax_Classification__c = answersMap.get('What entity type is your business');
        //     acc.Industry = answersMap.get('What industry is your business in');
        //     //acc.Total_Startup_Costs__c = answersMap.get('How much have you invested so far in start-up costs');
        //     acc.Expected_1st_year_revenue__c = answersMap.get('What do you anticipate your revenue to be over the next 12 months');
        //     acc.Current_Year_Profit_Projection__c = answersMap.get('What do you project your 1st year profit to be over the next 12 months');
        //     //acc.NumberOfEmployees = Integer.valueOf(answersMap.get('How many employees do you have'));
        //     //acc.Number_of_Contractors__c = Integer.valueOf(answersMap.get('How many contractors do you have'));
        //     acc.Number_of_owners__c = answersMap.get('How many owners does your business have');
        //     acc.Personal_Income__c = answersMap.get('What was your household W-2 income last year');
        //     //acc.Rental_Properties__c = Integer.valueOf(answersMap.get('How many rental properties do you have'));
        //     acc.Personal_Return_Filing_Status__c = answersMap.get('What is your tax filing status');
        //     acc.Home_Office_Square_Feet__c = answersMap.get('What is the approximate square footage of your home office');
        //     acc.Estimated_Business_Mileage__c = answersMap.get('How many business-related miles do you estimate you’ll drive per year');
        //     acc.Foreign_State__c = answersMap.get('What is your foreign state of incorporation');
        //     acc.Years_in_Business__c = answersMap.get('How many years have you been in business');
        //     //acc.State_of_Residence__c = answersMap.get('What is your state of residence');
        //     acc.Trans_Per_Month__c = answersMap.get('How many monthly bookkeeping transactions do you have');
        //     //acc.How_much_funding__c = answersMap.get('What is your total investor funding');
        //     acc.Worked_With_CPA_Accountant__c = (answersMap.get('Is this your first business') == 'Yes') ? true : false;
        //     //acc.Website_Selling_Goods__c = (answersMap.get('Will your business have a web or e-commerce presence') == 'Yes') ? true : false;
        //     //acc.Foreign_Income__c = (answersMap.get('Do you have any foreign sourced income') == 'Yes') ? true : false;

        //     if(environment != 'Entity Formation') {
        //         String value = answersMap.get('How many employees do you have');
        //         String numEmpl = value.replace('+', '');
        //         acc.Total_Startup_Costs__c = answersMap.get('How much have you invested so far in start-up costs');
        //         //acc.Number_of_Contractors__c = Integer.valueOf(answersMap.get('How many contractors do you have'));
        //         acc.NumberOfEmployees = Integer.valueOf(numEmpl);
        //         acc.Rental_Properties__c = Integer.valueOf(answersMap.get('How many rental properties do you have'));
        //     }

        //     update acc;

            
        //     //bookkeepingStartDate = Date.valueOf(answersMap.get('What transaction date should your bookkeeper start on'));
        //     //System.debug(answersMap.get('What transaction date should your bookkeeper start on'));
        //     //System.debug('*bookkeepingStartDate: '+bookkeepingStartDate);
            
        // }
        // return answersMap;
    }

    @RemoteAction
    public static void saveBusinessData(String newName, String businessId, String busType, String accId) {
        if(!String.isBlank(newName)) {
            Business__c bus = new Business__c(Id = businessId);
            bus.Name = newName;
            bus.Business_Type__c = busType;
            update bus;

            Account acc = new Account(Id = accId);
            acc.Entity_Tax_Classification__c = busType;
            update acc;
        }
    }

    @RemoteAction
    public static void saveClientInfo(String infoType, String businessId, String businessOwnerId, String accId, String email, String phone, String address, String city, String state, String zip, String country) {
        Boolean needBusUpdate = false;
        Boolean needAccUpdate = false;
        Boolean needConUpdate = false;
        Business_Owner__c busOwner = new Business_Owner__c(Id = businessOwnerId);
        Business__c bus = new Business__c(Id = businessId);
        Account acc = [SELECT Id, Primary_Contact__c, BillingState, BillingCountry, BillingStreet, BillingPostalCode, BillingCity FROM Account WHERE Id = :accId LIMIT 1];
        Contact con = new Contact(Id = acc.Primary_Contact__c);
        if(infoType == 'personal') {
            busOwner.Phone__c = phone;
            busOwner.Email__c = email;

            con.Phone = phone;
            con.Email = email;

            needBusUpdate = true;
            needConUpdate = true;
        } else if(infoType == 'billing') {
            busOwner.Address__c = address;
            busOwner.City__c = city;
            busOwner.State__c = state;
            busOwner.Zip__c = zip;
            busOwner.Country__c = country;

            acc.BillingState = state;
            acc.BillingCountry = country;
            acc.BillingStreet = address;
            acc.BillingPostalCode = zip;
            acc.BillingCity = city;

            bus.Business_Address__CountryCode__s = getCountryCode(country);
            bus.Business_Address__StateCode__s = getStateCode(state);
            bus.Business_Address__Street__s = address;
            bus.Business_Address__PostalCode__s = zip;
            bus.Business_Address__City__s = city;

            needBusUpdate = true;
            needAccUpdate = true;
        }
        if(needBusUpdate == true) {
            update busOwner;
        }
        if(needAccUpdate == true) {
            update acc;
            update bus;
        }
        if(needConUpdate == true) {
            update con;
        }
    } 

    @RemoteAction
    public static String getBusinessInfo(String accId) {
        Business__c business = [
                SELECT Id, Name, Account__c, Anticipated_Revenue__c, Industry__c, Business_Type__c, Number_of_Owners__c, Startup_Costs__c, Years_In_Business__c, 
                Profit_Projection__c, Home_Office_Square_Feet__c,
                State_of_incorporation__c, Monthly_Bookkeeping_Transactions__c, Number_of_Employees__c, Tax_Filing_Status__c,
                W2_Income__c, Number_of_Rental_Properties__c, Yearly_Business_Miles__c, 
                Run_Payroll_Before__c, Has_Employees_Contractors__c, File_Return_Yourself__c, Has_Rental_Properties__c, Is_Working_From_Home__c, Commutes_With_Own_Vehicle__c, 
                First_Business__c, Foreign_State_of_Incorporation__c
                FROM Business__c 
                WHERE Account__r.Id = :accId
                LIMIT 1
            ];

            String response = String.valueOf(business.Run_Payroll_Before__c);
            return response;
    }

    public class Partner {
        public String firstName;
        public String lastName; 
        public String role;  
        public String email;  
        public String phone;  
    }

    public class SelectedProduct {
        public String id;
        public String name;
        public String billing; 
        public String quantity;  
        public String price;  
        public String freqPrice;  
        public String subtotal;
        public String description;
        public String HTMLdescription;
        public Boolean noSplitAllowed;
        public String pbeId;
        public Boolean isInOffer;
        public String sellingIdentifier;
        public Decimal delayDays;
        public Decimal sortOrder;
        public String location;
    }

    public static ChargeOver_Quote__c getChargeOverQuote(List<String> data) {
        
        Integer instPay = 0;
        if(data[16] != '' && data[16] != null) {
            instPay = integer.valueof(data[16]);
        } else {
            instPay = null;
        }
        ChargeOver_Quote__c chargeOverQuote = new ChargeOver_Quote__c(
                Name = data[0] + ' Quote',
                Payment_Cycle__c = data[1],
                Account__c = data[2],
                Quote_ID__c = data[3],
                Quote__c = data[3],
                Quote_Number__c = data[4] + data[5],
                Opportunity__c = data[6],
                Brand_Name__c = data[7],
                Contact__c = data[8],
                Sales_Source__c = 'Sales',
                Billing_Street_Line_1__c = data[9],
                Billing_City__c = data[10],
                Billing_State__c = data[11],
                Billing_Postal_Code__c = data[12],
                Billing_Country__c = data[13],
                //Scheduler_URL__c = data[14],
                Guided_Selling_Scheduler_URL__c = data[14],
                Name_of_Offer_Package__c = data[15],
                Installment_Payment_Schedule__c = instPay,
                Scheduler_URL_VIP_hide__c = data[17],
                isFromGuidedSelling__c = true
            );
        return chargeOverQuote;
    }
    
    @RemoteAction
    public static String getChargeOverURL(String oppId) {

        Boolean prevTokenFound = false;
        Chargeover_URL__c uset = Chargeover_URL__c.getOrgDefaults();
        String theURL = uset.Chargeover_URL__c;
        String redirURL = theURL + '/r/salesforce/wait/quote.custom_1/';
        String cOQuoteId = '';
        String cOQuoteIdOneTime = '';
        String cOQuoteIdMonth = '';
        
        list<ChargeOver_Quote__c> coQuoteList = [
                SELECT Id, Quote_Created__c, ChargeOver_View_URL__c, Payment_Cycle__c, ChargeOver_URL_Token__c
                FROM ChargeOver_Quote__c 
                WHERE Opportunity__r.Id = :oppId];

        for(ChargeOver_Quote__c coQ : coQuoteList) {
            if(coQ.Payment_Cycle__c == 'yrl') {
                cOQuoteId = coQ.Id;
            } else if(coQ.Payment_Cycle__c == 'one') {
                cOQuoteIdOneTime = coQ.Id;
            } else if(coQ.Payment_Cycle__c == 'mon') {
                cOQuoteIdMonth = coQ.Id;
            }
        }

        if (cOQuoteId != '') {
            if (prevTokenFound == true) {
                redirURL = redirURL + ',';
            }
            
            for(ChargeOver_Quote__c coQ : coQuoteList) {
                if(coQ.Id == cOQuoteId) {
                    redirURL = redirURL + coQ.ChargeOver_URL_Token__c;
                    prevTokenFound = true;
                }
            }
        }
        
        if (cOQuoteIdOneTime != '') {
            if (prevTokenFound == true) {
                redirURL = redirURL + ',';
            }
            
            for(ChargeOver_Quote__c coQ : coQuoteList) {
                if(coQ.Id == cOQuoteIdOneTime) {
                    redirURL = redirURL + coQ.ChargeOver_URL_Token__c;
                    prevTokenFound = true;
                }
            }
        }
        
        if (cOQuoteIdMonth != '') {
            if (prevTokenFound == true) {
                redirURL = redirURL + ',';
            }
            
            for(ChargeOver_Quote__c coQ : coQuoteList) {
                if(coQ.Id == cOQuoteIdMonth) {
                    redirURL = redirURL + coQ.ChargeOver_URL_Token__c;
                    prevTokenFound = true;
                }
            }
        }

        String updURL = redirURL;
        redirURL = redirURL + '?utm_source=Sales&utm_term=Sales&utm_medium=Guided+Selling';
        
        sleep(4000);
        
        List<Quote> quoteList = [SELECT Id, Payment_URL__c FROM Quote WHERE OpportunityId = :oppId];
        if(quoteList.size() > 0) {
            for(Quote q : quoteList) {
                q.Payment_URL__c = redirURL;
            }
        }

        update quoteList;
        
        update new Opportunity(
            Id = oppId,
            StageName = 'Quote Generated'
        );

        return updURL;
    }

    //input review:
    //environment: only used to determine pricing mdt to use
    //listProdSelected: primary product data
    //oppId/accOd: used to update the opportunity and create the quotes and line items
    //billingTime: used to determine branding (?) as well as opp/quote data
    //delProds: used to filter out input products
    @RemoteAction
    public static String doSubmit(String environment, String listProdSelected, String oppId, String accId, String billingTime, String bookStartDate, String bookEndDate, Double quoteTotal) {
        //quoteButtonText = 'Next Section';
        // Initialize class variables
        System.debug('doSubmit');
        System.debug('listProdSelected '+listProdSelected);
        System.debug('environment '+environment);
        List<GuidedSellingProduct> selectedProds = (List<GuidedSellingProduct>) JSON.deserialize(listProdSelected, List<GuidedSellingProduct>.class);

        String packageName = '';
        String quoteID = '';
        String quoteNum = '';
        String brand = '1-800Accountant';
        String leadTypeNew = '';
        String leadSource = '';
        Boolean entityFormation = false;
        Boolean clientBooks = false;
        Boolean advisory = false;
        Boolean bookkAdv = false;
        Boolean bookk = false;
        Boolean payroll = false;
        Boolean backBookk = false;
        Boolean persTaxAdv = false;
        Boolean persTaxPrep = false;
        Boolean busiRet = false;
        Boolean persRet = false;
        Boolean doSomeSchedule = false;
        String apptType = '';
        String contactId = '';
        String emailCampId = '';
        String coQuoteMonthId = '';
        String coQuoteOneTimeId = '';
        String coQuoteAnnualId = '';

        // Initialize package name

        List<Product_Offer__mdt> offerList = [
            SELECT Id, DeveloperName, MasterLabel, Active__c, Amount__c, Environment__c, Product__c, calcId__c, Default_Parent__c, Default_Child_isMaster__c, Delay_Days__c
            FROM Product_Offer__mdt 
            WHERE Active__c = true 
            AND Environment__c = :environment];
            
        Set<String> prodsIds = new Set<String>();
        

        // // Get products ids from the selected ones
        Decimal vipAmount = quoteTotal;
        if(vipAmount == null){
            System.debug('quoteTotal not found');
            vipAmount = 0.00;
            for(GuidedSellingProduct prod : selectedProds) {
                vipAmount += prod.subtotal;
            }
        }
        for(GuidedSellingProduct prod : selectedProds) {
            prodsIds.add(prod.Product.Id);
        }

        // // Get standard Pricebook id

        String standardPriceBookID = '';
        List<Pricebook2> pbList = [
            SELECT Id, Name, IsActive, IsStandard 
            FROM Pricebook2 
            WHERE IsActive = true 
            AND Environment__c includes (:environment)];
        for(Pricebook2 pbItem : pbList) {
            standardPriceBookID = pbItem.Id;
        }

        // // Get Pricebook Entries ids from the selected products
        
        List<PricebookEntry> pbAllList = [
            SELECT Id, UnitPrice, Name, IsActive, Pricebook2Id, Product2Id 
            FROM PricebookEntry 
            WHERE (Product2Id IN :prodsIds) 
            AND Pricebook2Id = :standardPriceBookID];

        // Get Product information from the selected ones

        Map<Id,Product2> productList = new Map<Id, Product2>([
            SELECT Id, Calculator_Location__c, Name, AnnualMonthlyOption__c, Billing_Frequency__c, HTML_Description__c, Description, No_Split_Allowed__c, Guided_Selling_Identifier__c, sort_Order__c
            FROM Product2 
            WHERE Id IN :prodsIds]);
        
        Decimal businessTax = 0.00;
        Decimal personalTax = 0.00;
        
        //Map<String, GuidedSellingProduct> nameToProductMap = new Map<String, GuidedSellingProduct>();
        GuidedSellingProduct advisoryProduct;
        Double advisoryAddonTotal = 0;
        List<String> advisoryAddonProductNames = new List<String>{'1-800Accountant Access', 'Personal Financial Planning', 'Loan Agreement', 'Beneficial Owner Information Report'};
        for(GuidedSellingProduct prodData : selectedProds) {
            // prodSelec.description = prodData.Description;
            // prodSelec.HTMLdescription = prodData.HTML_Description__c;
            // prodSelec.noSplitAllowed = prodData.No_Split_Allowed__c;
            // prodSelec.sellingIdentifier = prodData.Guided_Selling_Identifier__c;
            // prodSelec.name = prodData.Name;
            // prodSelec.location = prodData.Calculator_Location__c;
            // prodSelec.sortOrder = prodData.sort_Order__c;
            System.debug('setting flags for '+prodData.Product.Name);

            System.debug('prodData '+prodData);
            System.debug('productList '+productList.get(prodData.Id));
            prodData.Product.Description = productList.get(prodData.Product.Id).Description;
            prodData.Product.HTML_Description__c = productList.get(prodData.Product.Id).HTML_Description__c;

            if(advisoryAddonProductNames.contains(prodData.Product.Name)){
                advisoryAddonTotal += prodData.adjustedPrice;
            }

            if(prodData.Product.Name == 'Entity Formation') {
                entityFormation = true;
            }
            if(prodData.Product.Name == 'ClientBooks') {
                clientBooks = true;
            }
            if(prodData.Product.Calculator_Location__c == 'Advisory') {
                advisory = true;
                advisoryProduct = prodData;
                System.debug('advisoryProduct: '+advisoryProduct);
            }
            if(prodData.Product.Name == 'Bookkeeping Advisory') {
                bookkAdv = true;
            }
            if(prodData.Product.Calculator_Location__c == 'Bookkeeping') {
                bookk = true;
            }
            if(prodData.Product.Calculator_Location__c == 'Payroll') {
                payroll = true;
            }
            if(prodData.Product.Name == 'Back Bookkeeping') {
                backBookk = true;
            }
            if(prodData.Product.Name == 'Personal Tax Advisory') {
                persTaxAdv = true;
            }
            if(prodData.Product.Name == 'Personal Tax Preparation') {
                persTaxPrep = true;
            }
            if (prodData.Product.Calculator_Location__c == 'Business Return') {
                busiRet = true;
                businessTax = Decimal.valueOf(prodData.subtotal);
            }
            if (prodData.Product.Calculator_Location__c == 'Personal Return') {
                persRet = true;
                personalTax = Decimal.valueOf(prodData.subtotal);
            }
            

            for(PricebookEntry pbe : pbAllList) {
                if(prodData.Product.Id == String.valueOf(pbe.Product2Id)) {
                    prodData.pbeId = pbe.Id;
                }
            }

            for(Product_Offer__mdt offerProductItem : offerList) {
                if(offerProductItem.Product__c == prodData.Product.Guided_Selling_Identifier__c) {
                    prodData.isInOffer = true;
                    prodData.delayDays = offerProductItem.Delay_Days__c.intValue();
                } else {
                    prodData.isInOffer = false;
                }
            } 
        }

        System.debug('advisoryAddonTotal: '+advisoryAddonTotal);
        //separate the revenue again
        if(advisoryProduct != null){
            advisoryProduct.adjustedPrice -= advisoryAddonTotal;
            advisoryProduct.subtotal = advisoryProduct.adjustedPrice * advisoryProduct.currentQuantity;
            if(billingTime == 'mon'){
                advisoryProduct.subtotal = advisoryProduct.subtotal / 10;
            }
        }
        System.debug('separated advisoryProduct: '+advisoryProduct);


        // Extra for: some special calculations on prods

        // Decimal vipAmount = 0.00;

        // for(SelectedProduct prodSelec : prodSelecDataList) {
        //     if(prodSelec.location == 'Advisory') {
        //         prodSelec.price = String.valueOf(((businessTax + personalTax) / (869 + 390)) * 1199);
        //     }

        //     if(advisory == true && persTaxPrep == true) {
        //         if(prodSelec.name == 'Loan Agreement') {
        //             prodSelec.price = '0.00';
        //             prodSelec.freqPrice = '0.00';
        //             prodSelec.subtotal = '0.00';
        //         }
        //     }

        //     vipAmount = vipAmount + Decimal.valueOf(prodSelec.subtotal);
        // }

        // Get data for the quote creation

        Account acc = [
            SELECT Id, Name, Potential_Total_Savings__c, Lead_Type_New__c, Lead_Source__c, Primary_Contact_ID__c, BillingState, BillingCountry, BillingStreet, BillingCity, BillingPostalCode 
            FROM Account 
            WHERE Id = :accId
            LIMIT 1];
        leadTypeNew = acc.Lead_Type_New__c;
        leadSource = acc.Lead_Source__c;
        contactId = acc.Primary_Contact_ID__c;
        if(leadTypeNew == null){leadTypeNew='';}

        Opportunity opp = [SELECT Id, StageName, OwnerId, Email_Campaign_ID__c FROM Opportunity WHERE Id = :oppId LIMIT 1];
        emailCampId = opp.Email_Campaign_ID__c;

        // Missing fields from original query: Name, Account__c, Has_Employees_Contractors__c, File_Return_Yourself__c, Has_Rental_Properties__c, Is_Working_From_Home__c, 
        // Commutes_With_Own_Vehicle__c, First_Business__c, 
        Business__c business = [
                SELECT Id, Business_Type__c, Industry__c, Number_of_Employees__c, 
                Number_of_Owners__c, Monthly_Bookkeeping_Transactions__c, Number_of_Rental_Properties__c, W2_Income__c, Profit_Projection__c, 
                Anticipated_Revenue__c, State_of_incorporation__c, Startup_Costs__c, Run_Payroll_Before__c, Tax_Filing_Status__c, 
                Yearly_Business_Miles__c, Home_Office_Square_Feet__c, Years_In_Business__c, Foreign_State_of_Incorporation__c,
                Date_of_incorporation__c 
                FROM Business__c 
                WHERE Account__r.Id = :accId
                LIMIT 1];

        String livingAbroad = 'No';
        // if (business.Foreign_Income__c == true) {
        //     livingAbroad = 'Yes';
        // }

        String E_Commerce = 'No';
        // if (business.E_Commerce__c == true) {
        //     E_Commerce = 'Yes';
        // }

        String runPayrollBefore = 'No';
        if (business.Run_Payroll_Before__c == true) {
            runPayrollBefore = 'Yes';
        }
        
        // Set pricebook id, brand and scheduler links for the opportunity

        if (billingTime == 'mon') {
            brand = 'Subscription Management Services';
        }
        
        if (leadTypeNew.contains('Sprout') && entityFormation == true) {
            brand = 'EzBizFile';    
        }
        
        if (leadTypeNew.contains('EIN') && leadSource == 'EIN Tax Filing') {
            brand = 'EIN-Tax-Filing';
        }
        
        if (clientBooks == true) {
            brand = 'ClientBooks';
        }
        
        Chargeover_URL__c uset = Chargeover_URL__c.getOrgDefaults();
        String sURL = uset.Scheduler_URL__c;
        apptType = 'Discovery';
        
        if (advisory == true) {
            apptType = 'Discovery';
        } else {
            apptType = 'ALaCart';
            if (bookkAdv == true) {
                apptType = 'BKAdvOnboard';
            }
            if (bookk == true) {
                apptType = 'BKOnboard';
            } else if (payroll == true) {
                apptType = 'PayOnboard';
            }
            if (backBookk == true) {
                apptType = 'BKOnboard';
            }
            if (persTaxAdv == true) {
                apptType = 'Discovery';
            }
        }
        
        if (brand == 'EzBizFile') {
            apptType = 'EForm';
        }
        
        String schedulerURL = sURL + '?TID=' + apptType + '	&WID=' + contactId + '&EmailCampaignID=' + emailCampId+'&OtherTrackingID=Guided%20Selling';
        String schedulerVIPURL = '';
        String schedulerCSAURL = '';

        String schedulerURLReturn = sURL + ',' + apptType + ',' + contactId + ',' + emailCampId;
        String schedulerVIPURLReturn = ''; 
        String schedulerCSAURLReturn = '';
        
        if (apptType == 'Discovery') {
            schedulerVIPURL = sURL + '?TID=DiscoveryVIP' + '&WID=' + contactId + '&EmailCampaignID=' + emailCampId+'&OtherTrackingID=Guided%20Selling';
            schedulerVIPURLReturn = sURL + ',VIP,' + contactId + ',' + emailCampId;
            schedulerCSAURL = sURL + '?TID=CSAO&WID='+contactID+ '&EmailCampaignID=' + emailCampId+'&OtherTrackingID=Guided%20Selling';
            schedulerCSAURLReturn = sURL + ',CSAO,' + contactId + ',' + emailCampId;
        }
        
        if (advisory == true || busiRet == true || persRet == true || payroll == true || bookk == true || brand == 'EzBizFile') {
            doSomeSchedule = true;
        }
 
        if (doSomeSchedule == false) {
            schedulerURL = '';
            schedulerVIPURL = '';
        }

        Boolean isCSA = ((leadSource == '1-800Accountant' || leadSource =='Bark' || leadSource == 'Inc. Authority' || leadSource == 'ZenBusiness') && advisory) || ((leadSource != '1-800Accountant' || leadSource != 'Bark' || leadSource != 'Inc. Authority' || leadSource != 'ZenBusiness') && vipAmount >= 7500 && advisory);
        Boolean isVIP = (!isCSA && vipAmount >= 5000);
        // update opportunity
        System.debug('updating Opportunity');
        update new Opportunity(
            Id = oppId,
            Pricebook2Id = standardPriceBookID,
            Customized_Bundle__c = false,
            Name_of_Offer_Package__c = packageName,
            Brand__c = brand,
            Email_Campaign_ID__c = emailCampId,
            Sales_Platform__c = 'Guided Selling'
        );

        // Creation of the quote
        Quote theQuote = new Quote(
            Name = acc.Name + ' Quote',
            OpportunityId = oppId,
            Pricebook2Id = standardPriceBookID,
            Calc_Entity_Type__c = business.Business_Type__c,
            //Calc_Foreign_Owners__c = business.Number_of_Foreign_Owners__c,
            Calc_Industry_Type__c = business.Industry__c,
            Calc_Living_Abroad__c = livingAbroad,
            //Calc_Number_of_Contractors__c = business.Number_of_Contractors__c,
            Calc_Number_of_Employees__c = business.Number_of_Employees__c,
            //Calc_Number_of_K1s__c = business.Number_of_K1_Investments__c,
            Calc_Number_of_Owners__c = business.Number_of_Owners__c,
            Calc_Number_of_Transactions__c = business.Monthly_Bookkeeping_Transactions__c,
            Calc_Number_of_Rental_Properties__c = business.Number_of_Rental_Properties__c,
            Calc_Personal_Income__c = business.W2_Income__c,
            Calc_Projected_1st_Year_Profit__c = business.Profit_Projection__c,
            Calc_Projected_1st_Year_Revenue__c = business.Anticipated_Revenue__c,
            Calc_State_of_Incorporation__c = business.State_of_incorporation__c,
            //Calc_Total_Investor_Funding__c = business.Investor_Funding__c,
            Calc_Total_Startup_Cost__c = business.Startup_Costs__c,
            //Calc_Website_Selling_Goods__c = E_Commerce,
            //Calc_Worked_with_Accountant__c = business.workedWithAccountantInPastInput,
            Calc_Run_Payroll_Before__c = runPayrollBefore,
            Calc_Filing_Status__c = business.Tax_Filing_Status__c,
            Calc_Business_Miles__c = business.Yearly_Business_Miles__c,
            Calc_Office_Square_Footage__c = String.valueOf(business.Home_Office_Square_Feet__c),
            Calc_Foreign_State__c = business.Foreign_State_of_Incorporation__c,
            Calc_Years_in_Business__c = (business.Date_of_incorporation__c == null ? '' : String.valueOf((Date.today().year() - business.Date_of_incorporation__c?.year()))),
            //Calc_State_of_Residence__c = business.State_of_Residence__c,
            billingSchedule__c = billingTime,
            Bundle__c = 'None',
            Calc_Savings_Amount__c = String.valueOf(acc.Potential_Total_Savings__c)
        );
        if(bookStartDate != null){
            System.debug('bookkepingStartDate: '+bookStartDate);
            //theQuote.Calc_Bookkeeping_Start_Date__c  = Datetime.newInstance(bookkeepingStartDate, Time.newInstance(0,0,0,0)).format('yyyy-MM-dd');//mc
            theQuote.Calc_Bookkeeping_Start_Date__c = bookStartDate;
            theQuote.Calc_Bookkeeping_End_Date__c = bookEndDate;
        } else {
            System.debug('bookkepingStartDate null');
        }
        System.debug('theQuote '+theQuote);
        List<Quote> quoteList = [SELECT Id FROM Quote WHERE OpportunityId = :oppId LIMIT 1];
        if(!quoteList.isEmpty()) {
            quoteId = quoteList[0].Id;
            theQuote.Id = quoteId;
            update theQuote;
            // delete quote line items

            List<QuoteLineItem> oldQLI = [SELECT Id FROM QuoteLineItem WHERE QuoteId = :quoteID];
            delete oldQLI;
            
            // delete opportunity line items
            List<OpportunityLineItem> oldOLI = [SELECT Id FROM OpportunityLineItem WHERE OpportunityId = :oppId];
            delete oldOLI;
            
            // delete chargeover quotes
            List<ChargeOver_Quote__c> oldCOQ = [SELECT Id FROM ChargeOver_Quote__c WHERE Quote__c = :quoteID];
            for(ChargeOver_Quote__c cOQItem : oldCOQ){
                
                // delete chargeover quote line items
                List<ChargeOver_Quote_Line_Item__c> oldCOQLI = [SELECT Id FROM ChargeOver_Quote_Line_Item__c WHERE ChargeOver_Quote__c = :cOQItem.Id];
                delete oldCOQLI;
                
            }
            
            delete oldCOQ;
            
            //sleep(3000);
            
            // get quote number from quote
            List <Quote> currentQuote = [SELECT Id, QuoteNumber FROM Quote WHERE Id = :quoteID];
            for(Quote cqItem : currentQuote){
                quoteNum = cqItem.QuoteNumber;
            }
        } else {
            
            insert theQuote;
            quoteID = theQuote.Id;

            Quote currentQuote = [SELECT Id, QuoteNumber FROM Quote WHERE Id = :quoteID LIMIT 1];
            quoteNum = currentQuote.QuoteNumber;
        }

        

        // Check for existing event related to opportunity and assign email campaign id if it exists

        if (emailCampId != '' && emailCampId != null) {
            List<Event> eventList = [
                SELECT Id, WhoId, WhatId, Type_of_Appointment__c, ActivityDate 
                FROM Event 
                WHERE WhoId = :contactId 
                AND (Type_of_Appointment__c = 'Tax Savings Analysis' OR Type_of_Appointment__c = 'BNA' OR Type_of_Appointment__c = 'Formation Consultation') 
                AND ActivityDate = LAST_N_DAYS:365
                ORDER BY ActivityDate DESC];
            
            for (Event eve : eventList){
                eve.Email_Campaign_ID__c = emailCampId;
            }
            System.debug('eventList '+eventList);
            update eventList;
        }
        
        // shorten account name if necessary
        String shortAccName = acc.Name;
        Integer maxSize = 70;
        if(shortAccName.length() > maxSize) {
            shortAccName = shortAccName.substring(0, maxSize);
        }
        
        // Initialize data structure for Chargeover quotes and creation if necessary

        ChargeOver_Quote__c theCOQuote;
        ChargeOver_Quote__c theCOQuoteMonth;
        ChargeOver_Quote__c theCOQuoteOneTime;

        Boolean doMonthlyQuote = false;
        Boolean doOneTimeQuote = false;
        Boolean doAnnualQuote = false;

        for(GuidedSellingProduct prodSelec : selectedProds) {
            if((prodSelec.currentBillingFrequency == 'Monthly' || billingTime == 'mon') && coQuoteMonthId == '') {
                doMonthlyQuote = true;
            }
            if(prodSelec.currentBillingFrequency == 'One-Time') {
                doOneTimeQuote = true;
            }
            if(prodSelec.currentBillingFrequency == 'Annual' && billingTime != 'mon') {
                doAnnualQuote = true;
            }
        }

        System.debug('creating CO Quotes');
        List<String> dataForQuoteMon = new list<String>{shortAccName, 'mon', accId, quoteID, quoteNum, '-m', oppId, brand, contactId, acc.BillingStreet, acc.BillingCity, acc.BillingState, acc.BillingPostalCode, acc.BillingCountry, schedulerURL, packageName, '', schedulerVIPURL};
        theCOQuoteMonth = getChargeOverQuote(dataForQuoteMon);

        List<String> dataForQuoteOneTime = new list<String>{shortAccName, 'one', accId, quoteID, quoteNum, '-o', oppId, brand, contactId, acc.BillingStreet, acc.BillingCity, acc.BillingState, acc.BillingPostalCode, acc.BillingCountry, schedulerURL, packageName, '', schedulerVIPURL};
        theCOQuoteOneTime = getChargeOverQuote(dataForQuoteOneTime);

        if (doMonthlyQuote == true) {
            insert theCOQuoteMonth;
            coQuoteMonthId = theCOQuoteMonth.Id;
        } 
        
        if (doOneTimeQuote == true) {
            insert theCOQuoteOneTime;
            coQuoteOneTimeId = theCOQuoteOneTime.Id;
        }
        theCOQuote = new Chargeover_Quote__c();
        if (doAnnualQuote == true) {
            if (billingTime == '2pay') {
                List<String> dataForQuote = new list<String>{shortAccName, 'yrl', accId, quoteID, quoteNum, '-y', oppId, brand, contactId, acc.BillingStreet, acc.BillingCity, acc.BillingState, acc.BillingPostalCode, acc.BillingCountry, schedulerURL, packageName, '4', schedulerVIPURL};
                theCOQuote = getChargeOverQuote(dataForQuote);
            } else if (billingTime == '3pay') {
                List<String> dataForQuote = new list<String>{shortAccName, 'yrl', accId, quoteID, quoteNum, '-y', oppId, brand, contactId, acc.BillingStreet, acc.BillingCity, acc.BillingState, acc.BillingPostalCode, acc.BillingCountry, schedulerURL, packageName, '5', schedulerVIPURL};
                theCOQuote = getChargeOverQuote(dataForQuote);
            } else if (billingTime == '4pay') {
                List<String> dataForQuote = new list<String>{shortAccName, 'yrl', accId, quoteID, quoteNum, '-y', oppId, brand, contactId, acc.BillingStreet, acc.BillingCity, acc.BillingState, acc.BillingPostalCode, acc.BillingCountry, schedulerURL, packageName, '6', schedulerVIPURL};
                theCOQuote = getChargeOverQuote(dataForQuote);
            } else if (billingTime == '6pay') {
                List<String> dataForQuote = new list<String>{shortAccName, 'yrl', accId, quoteID, quoteNum, '-y', oppId, brand, contactId, acc.BillingStreet, acc.BillingCity, acc.BillingState, acc.BillingPostalCode, acc.BillingCountry, schedulerURL, packageName, '7', schedulerVIPURL};
                theCOQuote = getChargeOverQuote(dataForQuote);
            } else {
                List<String> dataForQuote = new list<String>{shortAccName, 'yrl', accId, quoteID, quoteNum, '-y', oppId, brand, contactId, acc.BillingStreet, acc.BillingCity, acc.BillingState, acc.BillingPostalCode, acc.BillingCountry, schedulerURL, packageName, '', schedulerVIPURL};
                theCOQuote = getChargeOverQuote(dataForQuote);
            }

            insert theCOQuote;
            coQuoteAnnualId = theCOQuote.Id;
        } 

        createLineItems(selectedProds, billingTime, oppId, quoteID, accId, coQuoteMonthId, coQuoteOneTimeId, coQuoteAnnualId, bookStartDate, bookEndDate, business.Monthly_Bookkeeping_Transactions__c);
        
        sleep(3000);
        
        if (isCSA && schedulerCSAURL != '') {
            theCOQuoteMonth.Scheduler_URL__c = schedulerCSAURL;
            theCOQuoteOneTime.Scheduler_URL__c = schedulerCSAURL;
            theCOQuote.Scheduler_URL__c = schedulerCSAURL;
        } else if(schedulerVIPURL != '' && isVIP) {
            theCOQuoteMonth.Scheduler_URL__c = schedulerVIPURL;
            theCOQuoteOneTime.Scheduler_URL__c = schedulerVIPURL;
            theCOQuote.Scheduler_URL__c = schedulerVIPURL;
        }

        if(coQuoteMonthId != '' && !Test.isRunningTest()) {
            theCOQuoteMonth.Quote_Created__c = true;     
            update theCOQuoteMonth;
        }

        if(coQuoteOneTimeId != '' && !Test.isRunningTest()) {
            theCOQuoteOneTime.Quote_Created__c = true;
            update theCOQuoteOneTime;       
        }

        if(coQuoteAnnualId != '' && !Test.isRunningTest()) {
            theCOQuote.Quote_Created__c = true;
            update theCOQuote;
        }

        
        if (isCSA && schedulerCSAURL != '') {
            System.debug('schedulerCSAURLReturn: '+schedulerCSAURLReturn);
            return schedulerCSAURLReturn;
        } else if(schedulerVIPURL != '' && isVip) {
            System.debug('schedulerVIPURLReturn: '+schedulerVIPURLReturn);
            return schedulerVIPURLReturn;
        } else {
            System.debug('schedulerURLReturn: '+schedulerURLReturn);
            return schedulerURLReturn;
        }
    }

    //Decimal productPassAdjustment, List<SelectedProduct> prodSelectedList, String calcIdPass, String bundlePass, String productDescription, String opportunityIdPass, String pricebookEntryIdPass, String productIdPass, Integer quantityPass, String timePass, String timeDefPass, String billingTimePass, String quoteIdPass, String coQuoteIdPass, String coQuoteIdMonthPass, String coQuoteIdOneTimePass, String sowDescPass, String sowDescPassHTML, String accountIdPass, Decimal sortOrderPass, Boolean doFeePass, Decimal feeAmountPass, String feeDesc, Boolean oneTimePass, Boolean noSplitPass)
    public static void createLineItems(List<GuidedSellingProduct> prodSelectedList, String billingFinance, String oppId, String qId, String accId, String coMonthQuoteId, String coOneTimeQuoteId, String coAnnualQuoteId, String bookStartDate, String bookEndDate, String monthlyTransactions) {
        System.debug('createLineItems');
        System.debug(oppId);
        System.debug(qId);
        System.debug(coMonthQuoteId);
        System.debug(coOneTimeQuoteId);
        System.debug(coAnnualQuoteId);
        Set<Id> bookkeepingIds = new Map<Id, Product2>([SELECT Id FROM Product2 WHERE Name LIKE '%Dedicated Bookkeeping%']).keySet();
        Set<Id> backBookkeepingIds = new Map<Id, Product2>([SELECT Id FROM Product2 WHERE Name LIKE '%Back Bookkeeping%']).keySet();

        Datetime holdDate;
        String holdDateString = '';

        Decimal subAmount = 0.00;
        Decimal monthlyPrice = 0.00;
        Decimal tmpACPrice = 0.00;
        Decimal subTotalAmount = 0.00;
        Decimal financeAmount = 0.00;
        String OLIPayInstall = '';
        Double quoteSalesPrice = 0;
        Double quoteSubtotal = 0;
        Double quoteFirstChargeTotal = 0;
        Double quoteFirstChargePrice = 0;

        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        List<QuoteLineItem> qliList = new List<QuoteLineItem>();
        List<ChargeOver_Quote_Line_Item__c> coliList = new List<ChargeOver_Quote_Line_Item__c>();

        for(GuidedSellingProduct p : prodSelectedList) {
            System.debug(p);
            //System.debug('processing '+p.Product.Name+', '+p.currentBillingFrequency+', '+p.Product.Billing_Frequency__c);
            //System.debug('No Split Allowed: '+p.Product.No_Split_Allowed__c);
            if (Integer.valueOf(p.delayDays) > 0) {
                holdDate = System.today() + Integer.valueOf(p.delayDays);
                holdDateString = String.valueOf(holdDate);
            }
            Boolean customMonthly = p.currentBillingFrequency == 'Monthly' && p.Product.Billing_Frequency__c != 'Monthly';
            Integer qty = p.currentQuantity;
            Integer numPayments = p.numOfPayments;
            Id pbeId = Id.valueOf(p.pbeId);
            Id prodId = Id.valueOf(p.Product.Id);
            //String OLIPayInstall = '';
            String OLIPayCycle = '';
            String COQuoteId;
            quoteSalesPrice = p.subtotal/qty;
            if(customMonthly){
                quoteSalesPrice *= numPayments;
            }                  
            // if(billingFinance == 'mon'){
            //     quoteSalesPrice *= 1.2;
            // }              
            quoteSubtotal = quoteSalesPrice*qty;
            quoteFirstChargeTotal = quoteSubtotal / numPayments;
            quoteFirstChargePrice = quoteFirstChargeTotal / qty;

            if (p.currentBillingFrequency == 'One-Time' 
            && (p.Product.No_Split_Allowed__c == true || billingFinance == 'yrl')){ //if billingFinance != 'yrl', product must not be splittable
                COQuoteId = coOneTimeQuoteId;
                OLIPayCycle = 'one';
                OLIPayInstall = 'One-Time';
            } else if(p.currentBillingFrequency == 'Monthly' || billingFinance == 'mon'){
                COQuoteId = coMonthQuoteId;
                OLIPayCycle = 'mon';
                OLIPayInstall = 'Monthly';
            } else if (p.currentBillingFrequency == 'Annual' || (p.currentBillingFrequency == 'One-Time' && p.Product.No_Split_Allowed__c == false)){
                COQuoteId = coAnnualQuoteId;
                OLIPayCycle = 'yrl';
                if (billingFinance == '2pay') {
                    OLIPayInstall = '2-Pay';
                } else if (billingFinance == '3pay') {
                    OLIPayInstall = '3-Pay';
                } else if (billingFinance == '4pay') {
                    OLIPayInstall = '4-Pay';
                } else if (billingFinance == '6pay') {
                    OLIPayInstall = '6-Pay';
                } else {
                    if (p.currentBillingFrequency == 'Annual') {
                        OLIPayInstall = 'Yearly';
                    } else if(p.currentBillingFrequency == 'One-Time') {
                        OLIPayInstall = 'One-Time';
                    }
                }
            }
            System.debug('COQuoteId result: '+COQuoteId);

            OpportunityLineItem oli;
            if(oppId != null && String.valueOf(oppId) != '') {
                oli = new OpportunityLineItem(
                   Description = p.Product.Name,
                   OpportunityId = Id.valueOf(oppId),
                   PricebookEntryId = pbeId,
                   Product2Id = prodId,
                   Quantity = qty,
                   UnitPrice = quoteSalesPrice,
                   Payment_Cycle__c = OLIPayCycle,
                   First_Charge_Price__c = quoteFirstChargePrice,
                   First_Charge_Total__c = quoteFirstChargeTotal,
                   Installment_Payment_Schedule__c = OLIPayInstall
               );
               if(oli != null) {
                   //oliList.add(oli);
                   System.debug(oli);
                   insert oli;
               }
           }

            if(qId != null && qId != '') {
                QuoteLineItem qli = new QuoteLineItem(
                    QuoteId = Id.valueOf(qId),
                    OpportunityLineItemId = oli.Id,
                    PricebookEntryId =pbeId,
                    Product2Id = prodId,
                    Quantity = qty,
                    UnitPrice = quoteSalesPrice,
                    First_Charge_Price__c = quoteFirstChargePrice,
                    First_Charge_Total__c = quoteFirstChargeTotal
                );
                if(qli != null) {
                    System.debug(qli);
                    qliList.add(qli);
                }
            }

            if(COQuoteId != null && COQuoteId != '') {
                String descrip = p.Product.Description;
                String HTMLDesc = p.Product.HTML_Description__c;
                System.debug(COQuoteId);
                if(backBookkeepingIds.contains(prodId) || bookkeepingIds.contains(prodId)){
                    descrip += ' For ' +monthlyTransactions+ ' transactions per month.';
                    HTMLDesc += ' For ' +monthlyTransactions+ ' transactions per month.';
                }
                if(backBookkeepingIds.contains(prodId)){
                    descrip += ' Back Bookkeeping services will cover the period beginning ' + bookStartDate;
                    HTMLDesc += ' Back Bookkeeping services will cover the period beginning ' + bookStartDate;
                    if(bookEndDate != null && bookEndDate != ''){
                        descrip += ' and ending ' + bookEndDate;
                        HTMLDesc += ' and ending ' + bookEndDate;
                    }
                }
                ChargeOver_Quote_Line_Item__c coli = new ChargeOver_Quote_Line_Item__c(
                    ChargeOver_Quote__c = Id.valueOf(COQuoteId),
                    Product__c = prodId,
                    Price_Per_Unit__c = (billingFinance == 'mon' ? quoteFirstChargePrice : p.subtotal/qty),
                    Quantity__c = qty,
                    Contract_Amount__c = quoteSubtotal,
                    Product_Description__c =  descrip,
                    HTML_Description__c = HTMLdesc,
                    Account__c = accId,
                    Sales_Source__c = 'Sales',
                    sort_Order__c = p.Product.sort_Order__c,
                    Sold_in_Offer__c = p.isInOffer,
                    Date_Time_Invoice_Being_Held_Until__c = holdDateString
                );
                if(coli != null) {
                    System.debug(coli);
                    coliList.add(coli);
                }
            }



            
        }
        insert qliList;
        insert coliList;
    }

    // public static List<GuidedSellingProduct> getProductFromLineItem(List<OpportunityLineItem> items){

    // }

    public static void sleep(Long milliSeconds) {
        Long timeDiff = 0;
        DateTime firstTime = System.now(); 
        do {
            timeDiff = System.now().getTime() - firstTime.getTime();
        } while(timeDiff <= milliSeconds);
    }

    public List<SelectOption> getStateOfIncorporation() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Select a State', 'Select a State', true));
        options.add(new SelectOption('Alabama', 'Alabama'));
        options.add(new SelectOption('Alaska', 'Alaska'));
        options.add(new SelectOption('Arizona', 'Arizona'));
        options.add(new SelectOption('Arkansas', 'Arkansas'));
        options.add(new SelectOption('California', 'California'));
        options.add(new SelectOption('Colorado', 'Colorado'));
        options.add(new SelectOption('Connecticut', 'Connecticut'));
        options.add(new SelectOption('Delaware', 'Delaware'));
        options.add(new SelectOption('Dist. of Columbia', 'Dist. of Columbia'));
        options.add(new SelectOption('Florida', 'Florida'));
        options.add(new SelectOption('Georgia', 'Georgia'));
        options.add(new SelectOption('Hawaii', 'Hawaii'));
        options.add(new SelectOption('Idaho', 'Idaho'));
        options.add(new SelectOption('Illinois', 'Illinois'));
        options.add(new SelectOption('Indiana', 'Indiana'));
        options.add(new SelectOption('Iowa', 'Iowa'));
        options.add(new SelectOption('Kansas', 'Kansas'));
        options.add(new SelectOption('Kentucky', 'Kentucky'));
        options.add(new SelectOption('Louisiana', 'Louisiana'));
        options.add(new SelectOption('Maine', 'Maine'));
        options.add(new SelectOption('Maryland', 'Maryland'));
        options.add(new SelectOption('Massachusetts', 'Massachusetts'));
        options.add(new SelectOption('Michigan', 'Michigan'));
        options.add(new SelectOption('Minnesota', 'Minnesota'));
        options.add(new SelectOption('Mississippi', 'Mississippi'));
        options.add(new SelectOption('Missouri', 'Missouri'));
        options.add(new SelectOption('Montana', 'Montana'));
        options.add(new SelectOption('Nebraska', 'Nebraska'));
        options.add(new SelectOption('Nevada', 'Nevada'));
        options.add(new SelectOption('New Hampshire', 'New Hampshire'));
        options.add(new SelectOption('New Jersey', 'New Jersey'));
        options.add(new SelectOption('New Mexico', 'New Mexico'));
        options.add(new SelectOption('New York', 'New York'));
        options.add(new SelectOption('North Carolina', 'North Carolina'));
        options.add(new SelectOption('North Dakota', 'North Dakota'));
        options.add(new SelectOption('Ohio', 'Ohio'));
        options.add(new SelectOption('Oklahoma', 'Oklahoma'));
        options.add(new SelectOption('Oregon', 'Oregon'));
        options.add(new SelectOption('Pennsylvania', 'Pennsylvania'));
        options.add(new SelectOption('Rhode Island', 'Rhode Island'));
        options.add(new SelectOption('South Carolina', 'South Carolina'));
        options.add(new SelectOption('South Dakota', 'South Dakota'));
        options.add(new SelectOption('Tennessee', 'Tennessee'));
        options.add(new SelectOption('Texas', 'Texas'));
        options.add(new SelectOption('Utah', 'Utah'));
        options.add(new SelectOption('Vermont', 'Vermont'));
        options.add(new SelectOption('Virginia', 'Virginia'));
        options.add(new SelectOption('Washington', 'Washington'));
        options.add(new SelectOption('West Virginia', 'West Virginia'));
        options.add(new SelectOption('Wisconsin', 'Wisconsin'));
        options.add(new SelectOption('Wyoming', 'Wyoming'));
        return options;
    }
    public List<SelectOption> getEntityType() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Select an Entity Type', 'Select an Entity Type', true));
        options.add(new SelectOption('LLC', 'LLC'));
        //options.add(new SelectOption('C Corporation', 'C Corporation'));
        options.add(new SelectOption('S Corporation', 'S Corporation'));
        //options.add(new SelectOption('Partnership', 'Partnership'));
        //options.add(new SelectOption('DBA', 'DBA'));
        //options.add(new SelectOption('Non-Profit', 'Non-Profit'));
        //options.add(new SelectOption('Personal Only', 'Personal Only'));
        return options;
    }
    public List<SelectOption> getIndustryType() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Select an Industry', 'Select an Industry', true));
        options.add(new SelectOption('Other', 'Other'));
        options.add(new SelectOption('Agriculture', 'Agriculture'));
        options.add(new SelectOption('Animal Services', 'Animal Services'));
        options.add(new SelectOption('Apparel', 'Apparel'));
        options.add(new SelectOption('Architecture', 'Architecture'));
        options.add(new SelectOption('Automotive', 'Automotive'));
        options.add(new SelectOption('Banking', 'Banking'));
        options.add(new SelectOption('Business', 'Business'));
        options.add(new SelectOption('Childcare', 'Childcare'));
        options.add(new SelectOption('Coffee', 'Coffee'));
        options.add(new SelectOption('Communications', 'Communications'));
        options.add(new SelectOption('Construction', 'Construction'));
        options.add(new SelectOption('Consulting', 'Consulting'));
        options.add(new SelectOption('Cryptocurrency', 'Cryptocurrency'));
        options.add(new SelectOption('Dentistry', 'Dentistry'));
        options.add(new SelectOption('E-Commerce', 'E-Commerce'));
        options.add(new SelectOption('Education', 'Education'));
        options.add(new SelectOption('Electronics', 'Electronics'));
        options.add(new SelectOption('Engineering', 'Engineering'));
        options.add(new SelectOption('Entertainment', 'Entertainment'));
        options.add(new SelectOption('Environmental', 'Environmental'));
        options.add(new SelectOption('Finance', 'Finance'));
        options.add(new SelectOption('Floristry', 'Floristry'));
        options.add(new SelectOption('Food and Beverage', 'Food and Beverage'));
        options.add(new SelectOption('Government', 'Government'));
        options.add(new SelectOption('Health and Beauty', 'Health and Beauty'));
        options.add(new SelectOption('Healthcare', 'Healthcare'));
        options.add(new SelectOption('Hospitality', 'Hospitality'));
        options.add(new SelectOption('Insurance', 'Insurance'));
        options.add(new SelectOption('Investments', 'Investments'));
        options.add(new SelectOption('Landscaping', 'Landscaping'));
        options.add(new SelectOption('Legal', 'Legal'));
        options.add(new SelectOption('Machinery', 'Machinery'));
        options.add(new SelectOption('Manufacturing', 'Manufacturing'));
        options.add(new SelectOption('Media', 'Media'));
        options.add(new SelectOption('Not For Profit', 'Not For Profit'));
        options.add(new SelectOption('Optometry', 'Optometry'));
        options.add(new SelectOption('Publishing', 'Publishing'));
        options.add(new SelectOption('Real Estate', 'Real Estate'));
        options.add(new SelectOption('Recreation', 'Recreation'));
        options.add(new SelectOption('Retail', 'Retail'));
        options.add(new SelectOption('Sales and Marketing', 'Sales and Marketing'));
        options.add(new SelectOption('Service', 'Service'));
        options.add(new SelectOption('Shipping', 'Shipping'));
        options.add(new SelectOption('Software and Internet', 'Software and Internet'));
        options.add(new SelectOption('Technology', 'Technology'));
        options.add(new SelectOption('Telecommunications', 'Telecommunications'));
        options.add(new SelectOption('Transportation', 'Transportation'));
        options.add(new SelectOption('Travel Recreation and Leisure', 'Travel Recreation and Leisure'));
        options.add(new SelectOption('Utilities', 'Utilities'));
        options.add(new SelectOption('Wholesale and Distribution', 'Wholesale and Distribution'));
        return options;
    }
    public List<SelectOption> getMoneyAmount() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('---', '---', true));
        options.add(new SelectOption('0', '$0'));
        options.add(new SelectOption('5000', '$5,000'));
        options.add(new SelectOption('10000', '$10,000'));
        options.add(new SelectOption('25000', '$25,000'));
        options.add(new SelectOption('50000', '$50,000'));
        options.add(new SelectOption('75000', '$75,000'));
        options.add(new SelectOption('100000', '$100,000'));
        options.add(new SelectOption('150000', '$150,000'));
        options.add(new SelectOption('250000', '$250,000'));
        options.add(new SelectOption('500000', '$500,000'));
        options.add(new SelectOption('1000000', '$1,000,000'));

        return options;
    }
    public List<SelectOption> getMileage() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('---', '---', true));
        options.add(new SelectOption('0','0'));
        options.add(new SelectOption('5000','5,000'));
        options.add(new SelectOption('7500','7,500'));
        options.add(new SelectOption('10000','10,000'));
        options.add(new SelectOption('15000','15,000'));
        options.add(new SelectOption('20000','20,000'));
        options.add(new SelectOption('25000','25,000'));
        return options;
    }

    public List<SelectOption> getOffice() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('---', '---', true));
        options.add(new SelectOption('0','0'));
        options.add(new SelectOption('100','100'));
        options.add(new SelectOption('150','150'));
        options.add(new SelectOption('200','200'));
        options.add(new SelectOption('250','250'));
        options.add(new SelectOption('275','275'));
        options.add(new SelectOption('300','300'));
        return options;
    }

    public List<SelectOption> getFilingStatus() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Select a Filing Status', 'Select a Filing Status', true));
        options.add(new SelectOption('Single','Single'));
        options.add(new SelectOption('Married Filing Separate','Married Filing Separate'));
        options.add(new SelectOption('Married Filing Jointly','Married Filing Jointly'));
        options.add(new SelectOption('Head of Household','Head of Household'));
        return options;
    }

    public List<SelectOption> getNumberOf() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('---', '---', true));
        options.add(new SelectOption('0', '0'));
        options.add(new SelectOption('1', '1'));
        options.add(new SelectOption('2', '2'));
        options.add(new SelectOption('3', '3'));
        options.add(new SelectOption('4', '4'));
        options.add(new SelectOption('5', '5'));
        options.add(new SelectOption('6', '6'));
        options.add(new SelectOption('7', '7'));
        options.add(new SelectOption('8', '8'));
        options.add(new SelectOption('9', '9'));
        options.add(new SelectOption('10', '10'));
        return options;
    } 

    public List<SelectOption> getYearsInBusiness() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('---', '---', true));
        options.add(new SelectOption('0', '0'));
        options.add(new SelectOption('1-2', '1-2'));
        options.add(new SelectOption('3-5', '3-5'));
        options.add(new SelectOption('6-10', '6-10'));
        options.add(new SelectOption('10+', '10+'));
        return options;
    } 

    public List<SelectOption> getNumberOfTransactions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('---', '---', true));
        options.add(new SelectOption('0-75', '0-75'));
        options.add(new SelectOption('76-150', '76-150'));
        options.add(new SelectOption('151-250', '151-250'));
        options.add(new SelectOption('251-500', '251-500'));
        options.add(new SelectOption('501-750', '501-750'));
        options.add(new SelectOption('751-1000', '751-1000'));
        options.add(new SelectOption('1001-1250', '1001-1250'));
        options.add(new SelectOption('1251-1500', '1251-1500'));
        return options;
    } 

    public List<SelectOption> getNumberOfEmployeeContractors() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('---', '---', true));
        options.add(new SelectOption('0', '0'));
        options.add(new SelectOption('1', '1'));
        options.add(new SelectOption('2', '2'));
        options.add(new SelectOption('3', '3'));
        options.add(new SelectOption('4', '4'));
        options.add(new SelectOption('5', '5'));
        options.add(new SelectOption('6', '6'));
        options.add(new SelectOption('7', '7'));
        options.add(new SelectOption('8', '8'));
        options.add(new SelectOption('9', '9'));
        options.add(new SelectOption('10', '10'));
        options.add(new SelectOption('11', '11'));
        options.add(new SelectOption('12', '12'));
        options.add(new SelectOption('13', '13'));
        options.add(new SelectOption('14', '14'));
        options.add(new SelectOption('15', '15'));
        options.add(new SelectOption('16', '16'));
        options.add(new SelectOption('17', '17'));
        options.add(new SelectOption('18', '18'));
        options.add(new SelectOption('19', '19'));
        options.add(new SelectOption('20', '20'));
        options.add(new SelectOption('21', '21'));
        options.add(new SelectOption('22', '22'));
        options.add(new SelectOption('23', '23'));
        options.add(new SelectOption('24', '24'));
        options.add(new SelectOption('25', '25'));
        options.add(new SelectOption('26', '26'));
        options.add(new SelectOption('27', '27'));
        options.add(new SelectOption('28', '28'));
        options.add(new SelectOption('29', '29'));
        options.add(new SelectOption('30', '30'));
        options.add(new SelectOption('31', '31'));
        options.add(new SelectOption('32', '32'));
        options.add(new SelectOption('33', '33'));
        options.add(new SelectOption('34', '34'));
        options.add(new SelectOption('35', '35'));
        options.add(new SelectOption('36', '36'));
        options.add(new SelectOption('37', '37'));
        options.add(new SelectOption('38', '38'));
        options.add(new SelectOption('39', '39'));
        options.add(new SelectOption('40', '40'));
        options.add(new SelectOption('41', '41'));
        options.add(new SelectOption('42', '42'));
        options.add(new SelectOption('43', '43'));
        options.add(new SelectOption('44', '44'));
        options.add(new SelectOption('45', '45'));
        options.add(new SelectOption('46', '46'));
        options.add(new SelectOption('47', '47'));
        options.add(new SelectOption('48', '48'));
        options.add(new SelectOption('49', '49'));
        options.add(new SelectOption('50', '50'));
        options.add(new SelectOption('51+', '51+'));

        return options;
    } 

    public List<SelectOption> getNumberOfRentalProperties() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('---', '---', true));
        options.add(new SelectOption('0', '0'));
        options.add(new SelectOption('1', '1'));
        options.add(new SelectOption('2', '2'));
        options.add(new SelectOption('3', '3'));
        options.add(new SelectOption('4', '4'));
        options.add(new SelectOption('5', '5'));
        options.add(new SelectOption('6', '6'));
        options.add(new SelectOption('7', '7'));
        options.add(new SelectOption('8', '8'));
        options.add(new SelectOption('9', '9'));
        options.add(new SelectOption('10', '10'));
        options.add(new SelectOption('11', '11'));
        options.add(new SelectOption('12', '12'));
        options.add(new SelectOption('13', '13'));

        return options;
    } 


    public List<SelectOption> getContries() {
        List<SelectOption> billingCountryItems = new List<SelectOption>();
        billingCountryItems.add(new SelectOption('Select a Country', 'Select a Country', true));
        billingCountryItems.add(new SelectOption('Afghanistan','Afghanistan'));
        billingCountryItems.add(new SelectOption('Albania','Albania'));
        billingCountryItems.add(new SelectOption('Algeria','Algeria'));
        billingCountryItems.add(new SelectOption('Andorra','Andorra'));
        billingCountryItems.add(new SelectOption('Angola','Angola'));
        billingCountryItems.add(new SelectOption('Anguilla','Anguilla'));
        billingCountryItems.add(new SelectOption('Antigua','Antigua'));
        billingCountryItems.add(new SelectOption('Argentina','Argentina'));
        billingCountryItems.add(new SelectOption('Armenia','Armenia'));
        billingCountryItems.add(new SelectOption('Aruba','Aruba'));
        billingCountryItems.add(new SelectOption('Ascension Island','Ascension Island'));
        billingCountryItems.add(new SelectOption('Australia','Australia'));
        billingCountryItems.add(new SelectOption('Austria','Austria'));
        billingCountryItems.add(new SelectOption('Azerbaijan','Azerbaijan'));
        billingCountryItems.add(new SelectOption('Bahamas','Bahamas'));
        billingCountryItems.add(new SelectOption('Bahrain','Bahrain'));
        billingCountryItems.add(new SelectOption('Bangladesh','Bangladesh'));
        billingCountryItems.add(new SelectOption('Barbados','Barbados'));
        billingCountryItems.add(new SelectOption('Barbuda','Barbuda'));
        billingCountryItems.add(new SelectOption('Belarus','Belarus'));
        billingCountryItems.add(new SelectOption('Belgium','Belgium'));
        billingCountryItems.add(new SelectOption('Belize','Belize'));
        billingCountryItems.add(new SelectOption('Benin','Benin'));
        billingCountryItems.add(new SelectOption('Bermuda','Bermuda'));
        billingCountryItems.add(new SelectOption('Bhutan','Bhutan'));
        billingCountryItems.add(new SelectOption('Bolivia','Bolivia'));
        billingCountryItems.add(new SelectOption('Bosnia and Herzegovina','Bosnia and Herzegovina'));
        billingCountryItems.add(new SelectOption('Botswana','Botswana'));
        billingCountryItems.add(new SelectOption('Brazil','Brazil'));
        billingCountryItems.add(new SelectOption('Brunei','Brunei'));
        billingCountryItems.add(new SelectOption('Bulgaria','Bulgaria'));
        billingCountryItems.add(new SelectOption('Burkina Faso','Burkina Faso'));
        billingCountryItems.add(new SelectOption('Burundi','Burundi'));
        billingCountryItems.add(new SelectOption('Cambodia','Cambodia'));
        billingCountryItems.add(new SelectOption('Cameroon','Cameroon'));
        billingCountryItems.add(new SelectOption('Canada','Canada'));
        billingCountryItems.add(new SelectOption('Cape Verde Islands','Cape Verde Islands'));
        billingCountryItems.add(new SelectOption('Cayman Islands','Cayman Islands'));
        billingCountryItems.add(new SelectOption('Central African Republic','Central African Republic'));
        billingCountryItems.add(new SelectOption('Chad','Chad'));
        billingCountryItems.add(new SelectOption('Chile','Chile'));
        billingCountryItems.add(new SelectOption('China','China'));
        billingCountryItems.add(new SelectOption('Christmas Island','Christmas Island'));
        billingCountryItems.add(new SelectOption('Cocos-Keeling Islands','Cocos-Keeling Islands'));
        billingCountryItems.add(new SelectOption('Colombia','Colombia'));
        billingCountryItems.add(new SelectOption('Comoros','Comoros'));
        billingCountryItems.add(new SelectOption('Congo','Congo'));
        billingCountryItems.add(new SelectOption('Cook Islands','Cook Islands'));
        billingCountryItems.add(new SelectOption('Costa Rica','Costa Rica'));
        billingCountryItems.add(new SelectOption('Croatia','Croatia'));
        billingCountryItems.add(new SelectOption('Cuba','Cuba'));
        billingCountryItems.add(new SelectOption('Cyprus','Cyprus'));
        billingCountryItems.add(new SelectOption('Czech Republic','Czech Republic'));
        billingCountryItems.add(new SelectOption('Denmark','Denmark'));
        billingCountryItems.add(new SelectOption('Djibouti','Djibouti'));
        billingCountryItems.add(new SelectOption('Dominica','Dominica'));
        billingCountryItems.add(new SelectOption('Dominican Republic','Dominican Republic'));
        billingCountryItems.add(new SelectOption('Ecuador','Ecuador'));
        billingCountryItems.add(new SelectOption('Egypt','Egypt'));
        billingCountryItems.add(new SelectOption('El Salvador','El Salvador'));
        billingCountryItems.add(new SelectOption('England','England'));
        billingCountryItems.add(new SelectOption('Equatorial Guinea','Equatorial Guinea'));
        billingCountryItems.add(new SelectOption('Eritrea','Eritrea'));
        billingCountryItems.add(new SelectOption('Estonia','Estonia'));
        billingCountryItems.add(new SelectOption('Ethiopia','Ethiopia'));
        billingCountryItems.add(new SelectOption('Faeroe Islands','Faeroe Islands'));
        billingCountryItems.add(new SelectOption('Falkland Islands','Falkland Islands'));
        billingCountryItems.add(new SelectOption('Fiji Islands','Fiji Islands'));
        billingCountryItems.add(new SelectOption('Finland','Finland'));
        billingCountryItems.add(new SelectOption('France','France'));
        billingCountryItems.add(new SelectOption('French Antilles','French Antilles'));
        billingCountryItems.add(new SelectOption('French Guiana','French Guiana'));
        billingCountryItems.add(new SelectOption('French Polynesia','French Polynesia'));
        billingCountryItems.add(new SelectOption('Gabon','Gabon'));
        billingCountryItems.add(new SelectOption('Gambia','Gambia'));
        billingCountryItems.add(new SelectOption('Georgia','Georgia'));
        billingCountryItems.add(new SelectOption('Germany','Germany'));
        billingCountryItems.add(new SelectOption('Ghana','Ghana'));
        billingCountryItems.add(new SelectOption('Gibraltar','Gibraltar'));
        billingCountryItems.add(new SelectOption('Ginea-Bissau','Ginea-Bissau'));
        billingCountryItems.add(new SelectOption('Greece','Greece'));
        billingCountryItems.add(new SelectOption('Greenland','Greenland'));
        billingCountryItems.add(new SelectOption('Grenada','Grenada'));
        billingCountryItems.add(new SelectOption('Guadeloupe','Guadeloupe'));
        billingCountryItems.add(new SelectOption('Guam','Guam'));
        billingCountryItems.add(new SelectOption('Guantanamo Bay','Guantanamo Bay'));
        billingCountryItems.add(new SelectOption('Guatemala','Guatemala'));
        billingCountryItems.add(new SelectOption('Guinea','Guinea'));
        billingCountryItems.add(new SelectOption('Guyana','Guyana'));
        billingCountryItems.add(new SelectOption('Haiti','Haiti'));
        billingCountryItems.add(new SelectOption('Honduras','Honduras'));
        billingCountryItems.add(new SelectOption('Hong Kong','Hong Kong'));
        billingCountryItems.add(new SelectOption('Hungary','Hungary'));
        billingCountryItems.add(new SelectOption('Iceland','Iceland'));
        billingCountryItems.add(new SelectOption('India','India'));
        billingCountryItems.add(new SelectOption('Indonesia ','Indonesia'));
        billingCountryItems.add(new SelectOption('Iran','Iran'));
        billingCountryItems.add(new SelectOption('Iraq','Iraq'));
        billingCountryItems.add(new SelectOption('Ireland','Ireland'));
        billingCountryItems.add(new SelectOption('Israel','Israel'));
        billingCountryItems.add(new SelectOption('Italy','Italy'));
        billingCountryItems.add(new SelectOption('Ivory Coast','Ivory Coast'));
        billingCountryItems.add(new SelectOption('Jamaica','Jamaica'));
        billingCountryItems.add(new SelectOption('Japan','Japan'));
        billingCountryItems.add(new SelectOption('Jordan','Jordan'));
        billingCountryItems.add(new SelectOption('Kazakhstan','Kazakhstan'));
        billingCountryItems.add(new SelectOption('Kenya','Kenya'));
        billingCountryItems.add(new SelectOption('Kiribati Republic','Kiribati Republic'));
        billingCountryItems.add(new SelectOption('Korea North','Korea North'));
        billingCountryItems.add(new SelectOption('Korea South','Korea South'));
        billingCountryItems.add(new SelectOption('Kuwait','Kuwait'));
        billingCountryItems.add(new SelectOption('Kyrgyzstan','Kyrgyzstan'));
        billingCountryItems.add(new SelectOption('Laos','Laos'));
        billingCountryItems.add(new SelectOption('Latvia','Latvia'));
        billingCountryItems.add(new SelectOption('Lebanon','Lebanon'));
        billingCountryItems.add(new SelectOption('Lesotho','Lesotho'));
        billingCountryItems.add(new SelectOption('Liberia','Liberia'));
        billingCountryItems.add(new SelectOption('Libya','Libya'));
        billingCountryItems.add(new SelectOption('Liechtenstein','Liechtenstein'));
        billingCountryItems.add(new SelectOption('Lithuania','Lithuania'));
        billingCountryItems.add(new SelectOption('Luxembourg','Luxembourg'));
        billingCountryItems.add(new SelectOption('Macao','Macao'));
        billingCountryItems.add(new SelectOption('Macedonia','Macedonia'));
        billingCountryItems.add(new SelectOption('Madagascar','Madagascar'));
        billingCountryItems.add(new SelectOption('Malawi','Malawi'));
        billingCountryItems.add(new SelectOption('Malaysia','Malaysia'));
        billingCountryItems.add(new SelectOption('Maldives','Maldives'));
        billingCountryItems.add(new SelectOption('Mali','Mali'));
        billingCountryItems.add(new SelectOption('Malta','Malta'));
        billingCountryItems.add(new SelectOption('Marshall Islands','Marshall Islands'));
        billingCountryItems.add(new SelectOption('Martinique','Martinique'));
        billingCountryItems.add(new SelectOption('Mauritania','Mauritania'));
        billingCountryItems.add(new SelectOption('Mauritius','Mauritius'));
        billingCountryItems.add(new SelectOption('Mayotte Island','Mayotte Island'));
        billingCountryItems.add(new SelectOption('Mexico','Mexico'));
        billingCountryItems.add(new SelectOption('Micronesia','Micronesia'));
        billingCountryItems.add(new SelectOption('Moldova','Moldova'));
        billingCountryItems.add(new SelectOption('Monaco','Monaco'));
        billingCountryItems.add(new SelectOption('Mongolia','Mongolia'));
        billingCountryItems.add(new SelectOption('Montserrat','Montserrat'));
        billingCountryItems.add(new SelectOption('Morocco','Morocco'));
        billingCountryItems.add(new SelectOption('Mozambique','Mozambique'));
        billingCountryItems.add(new SelectOption('Myanmar','Myanmar'));
        billingCountryItems.add(new SelectOption('Namibia','Namibia'));
        billingCountryItems.add(new SelectOption('Nauru','Nauru'));
        billingCountryItems.add(new SelectOption('Nepal','Nepal'));
        billingCountryItems.add(new SelectOption('Netherlands','Netherlands'));
        billingCountryItems.add(new SelectOption('Nevis','Nevis'));
        billingCountryItems.add(new SelectOption('New Caledonia','New Caledonia'));
        billingCountryItems.add(new SelectOption('New Zealand','New Zealand'));
        billingCountryItems.add(new SelectOption('Nicaragua','Nicaragua'));
        billingCountryItems.add(new SelectOption('Niger','Niger'));
        billingCountryItems.add(new SelectOption('Nigeria','Nigeria'));
        billingCountryItems.add(new SelectOption('Niue','Niue'));
        billingCountryItems.add(new SelectOption('Norfolk Island','Norfolk Island'));
        billingCountryItems.add(new SelectOption('Norway','Norway'));
        billingCountryItems.add(new SelectOption('Oman','Oman'));
        billingCountryItems.add(new SelectOption('Pakistan','Pakistan'));
        billingCountryItems.add(new SelectOption('Palau ','Palau'));
        billingCountryItems.add(new SelectOption('Panama','Panama'));
        billingCountryItems.add(new SelectOption('Papua New Guinea','Papua New Guinea'));
        billingCountryItems.add(new SelectOption('Paraguay','Paraguay'));
        billingCountryItems.add(new SelectOption('Peru','Peru'));
        billingCountryItems.add(new SelectOption('Philippines','Philippines'));
        billingCountryItems.add(new SelectOption('Poland','Poland'));
        billingCountryItems.add(new SelectOption('Portugal','Portugal'));
        billingCountryItems.add(new SelectOption('Principe','Principe'));
        billingCountryItems.add(new SelectOption('Puerto Rico','Puerto Rico'));
        billingCountryItems.add(new SelectOption('Qatar','Qatar'));
        billingCountryItems.add(new SelectOption('Reunion Island','Reunion Island'));
        billingCountryItems.add(new SelectOption('Romania','Romania'));
        billingCountryItems.add(new SelectOption('Rota Island','Rota Island'));
        billingCountryItems.add(new SelectOption('Russia','Russia'));
        billingCountryItems.add(new SelectOption('Rwanda','Rwanda'));
        billingCountryItems.add(new SelectOption('Saint Lucia','Saint Lucia'));
        billingCountryItems.add(new SelectOption('Saipan Islands','Saipan Islands'));
        billingCountryItems.add(new SelectOption('San Marino','San Marino'));
        billingCountryItems.add(new SelectOption('Sao Tome','Sao Tome'));
        billingCountryItems.add(new SelectOption('Saudi Arabia','Saudi Arabia'));
        billingCountryItems.add(new SelectOption('Senegal Republic','Senegal Republic'));
        billingCountryItems.add(new SelectOption('Serbia (Republic of)','Serbia (Republic of)'));
        billingCountryItems.add(new SelectOption('Seychelles','Seychelles'));
        billingCountryItems.add(new SelectOption('Sierra Leone','Sierra Leone'));
        billingCountryItems.add(new SelectOption('Singapore','Singapore'));
        billingCountryItems.add(new SelectOption('Slovak Republic','Slovak Republic'));
        billingCountryItems.add(new SelectOption('Slovenia','Slovenia'));
        billingCountryItems.add(new SelectOption('Solomon Islands','Solomon Islands'));
        billingCountryItems.add(new SelectOption('Somalia','Somalia'));
        billingCountryItems.add(new SelectOption('South Africa','South Africa'));
        billingCountryItems.add(new SelectOption('Spain','Spain'));
        billingCountryItems.add(new SelectOption('Sri Lanka','Sri Lanka'));
        billingCountryItems.add(new SelectOption('Sudan','Sudan'));
        billingCountryItems.add(new SelectOption('Suriname','Suriname'));
        billingCountryItems.add(new SelectOption('Swaziland','Swaziland'));
        billingCountryItems.add(new SelectOption('Sweden','Sweden'));
        billingCountryItems.add(new SelectOption('Switzerland','Switzerland'));
        billingCountryItems.add(new SelectOption('Syria','Syria'));
        billingCountryItems.add(new SelectOption('Taiwan','Taiwan'));
        billingCountryItems.add(new SelectOption('Tajikistan','Tajikistan'));
        billingCountryItems.add(new SelectOption('Tanzania','Tanzania'));
        billingCountryItems.add(new SelectOption('Thailand','Thailand'));
        billingCountryItems.add(new SelectOption('Togo','Togo'));
        billingCountryItems.add(new SelectOption('Tokelau','Tokelau'));
        billingCountryItems.add(new SelectOption('Tonga','Tonga'));
        billingCountryItems.add(new SelectOption('Trinidad and Tabago','Trinidad and Tabago'));
        billingCountryItems.add(new SelectOption('Tunisia','Tunisia'));
        billingCountryItems.add(new SelectOption('Turkey','Turkey'));
        billingCountryItems.add(new SelectOption('Uganda','Uganda'));
        billingCountryItems.add(new SelectOption('Ukraine','Ukraine'));
        billingCountryItems.add(new SelectOption('United Arab Emirates','United Arab Emirates'));
        billingCountryItems.add(new SelectOption('United Kingdom','United Kingdom'));
        billingCountryItems.add(new SelectOption('United States','United States'));
        billingCountryItems.add(new SelectOption('Uruguay','Uruguay'));
        billingCountryItems.add(new SelectOption('Uzbekistan','Uzbekistan'));
        billingCountryItems.add(new SelectOption('Vanuatu','Vanuatu'));
        billingCountryItems.add(new SelectOption('Vatican city','Vatican city'));
        billingCountryItems.add(new SelectOption('Venezuela','Venezuela'));
        billingCountryItems.add(new SelectOption('Vietnam','Vietnam'));
        billingCountryItems.add(new SelectOption('Virgin Islands','Virgin Islands'));
        billingCountryItems.add(new SelectOption('Western Somoa','Western Somoa'));
        billingCountryItems.add(new SelectOption('Yemen','Yemen'));
        billingCountryItems.add(new SelectOption('Yugoslavia','Yugoslavia'));
        billingCountryItems.add(new SelectOption('Zaire','Zaire'));
        billingCountryItems.add(new SelectOption('Zambia','Zambia'));
        billingCountryItems.add(new SelectOption('Zimbabwe','Zimbabwe'));
        return billingCountryItems;
    }

    public static String getCountryCode(String countryName) {
        Map<String, String> countryCodes = new Map<String, String> {
            'Afghanistan' => 'AF',
            'Albania' => 'AL',
            'Algeria' => 'DZ',
            'Andorra' => 'AD',
            'Angola' => 'AO',
            'Anguilla' => 'AI',
            'Antigua' => 'AG',
            'Argentina' => 'AR',
            'Armenia' => 'AM',
            'Aruba' => 'AW',
            'Ascension Island' => 'SH',
            'Australia' => 'AU',
            'Austria' => 'AT',
            'Azerbaijan' => 'AZ',
            'Bahamas' => 'BS',
            'Bahrain' => 'BH',
            'Bangladesh' => 'BD',
            'Barbados' => 'BB',
            'Barbuda' => 'AG',
            'Belarus' => 'BY',
            'Belgium' => 'BE',
            'Belize' => 'BZ',
            'Benin' => 'BJ',
            'Bermuda' => 'BM',
            'Bhutan' => 'BT',
            'Bolivia' => 'BO',
            'Bosnia and Herzegovina' => 'BA',
            'Botswana' => 'BW',
            'Brazil' => 'BR',
            'Brunei' => 'BN',
            'Bulgaria' => 'BG',
            'Burkina Faso' => 'BF',
            'Burundi' => 'BI',
            'Cambodia' => 'KH',
            'Cameroon' => 'CM',
            'Canada' => 'CA',
            'Cape Verde Islands' => 'CV',
            'Cayman Islands' => 'KY',
            'Central African Republic' => 'CF',
            'Chad' => 'TD',
            'Chile' => 'CL',
            'China' => 'CN',
            'Christmas Island' => 'CX',
            'Cocos-Keeling Islands' => 'CC',
            'Colombia' => 'CO',
            'Comoros' => 'KM',
            'Congo' => 'CG',
            'Cook Islands' => 'CK',
            'Costa Rica' => 'CR',
            'Croatia' => 'HR',
            'Cuba' => 'CU',
            'Cyprus' => 'CY',
            'Czech Republic' => 'CZ',
            'Denmark' => 'DK',
            'Djibouti' => 'DJ',
            'Dominica' => 'DM',
            'Dominican Republic' => 'DO',
            'Ecuador' => 'EC',
            'Egypt' => 'EG',
            'El Salvador' => 'SV',
            'England' => 'GB',
            'Equatorial Guinea' => 'GQ',
            'Eritrea' => 'ER',
            'Estonia' => 'EE',
            'Ethiopia' => 'ET',
            'Faeroe Islands' => 'FO',
            'Falkland Islands' => 'FK',
            'Fiji Islands' => 'FJ',
            'Finland' => 'FI',
            'France' => 'FR',
            'French Antilles' => 'FR',
            'French Guiana' => 'GF',
            'French Polynesia' => 'PF',
            'Gabon' => 'GA',
            'Gambia' => 'GM',
            'Georgia' => 'GE',
            'Germany' => 'DE',
            'Ghana' => 'GH',
            'Gibraltar' => 'GI',
            'Ginea-Bissau' => 'GW',
            'Greece' => 'GR',
            'Greenland' => 'GL',
            'Grenada' => 'GD',
            'Guadeloupe' => 'GP',
            'Guam' => 'GU',
            'Guantanamo Bay' => 'CU',
            'Guatemala' => 'GT',
            'Guinea' => 'GN',
            'Guyana' => 'GY',
            'Haiti' => 'HT',
            'Honduras' => 'HN',
            'Hong Kong' => 'HK',
            'Hungary' => 'HU',
            'Iceland' => 'IceISland',
            'India' => 'IN',
            'Indonesia ' => 'ID',
            'Iran' => 'IR',
            'Iraq' => 'IQ',
            'Ireland' => 'IE',
            'Israel' => 'IL',
            'Italy' => 'IT',
            'Ivory Coast' => 'CI',
            'Jamaica' => 'JM',
            'Japan' => 'JP',
            'Jordan' => 'JO',
            'Kazakhstan' => 'KZ',
            'Kenya' => 'KE',
            'Kiribati Republic' => 'KI',
            'Korea North' => 'KP',
            'Korea South' => 'KR',
            'Kuwait' => 'KW',
            'Kyrgyzstan' => 'KG',
            'Laos' => 'LA',
            'Latvia' => 'LV',
            'Lebanon' => 'LB',
            'Lesotho' => 'LS',
            'Liberia' => 'LR',
            'Libya' => 'LY',
            'Liechtenstein' => 'LI',
            'Lithuania' => 'LT',
            'Luxembourg' => 'LU',
            'Macao' => 'MO',
            'Macedonia' => 'MK',
            'Madagascar' => 'MG',
            'Malawi' => 'MW',
            'Malaysia' => 'MY',
            'Maldives' => 'MV',
            'Mali' => 'ML',
            'Malta' => 'MT',
            'Marshall Islands' => 'MH',
            'Martinique' => 'MQ',
            'Mauritania' => 'MR',
            'Mauritius' => 'MU',
            'Mayotte Island' => 'YT',
            'Mexico' => 'MX',
            'Micronesia' => 'FM',
            'Moldova' => 'MD',
            'Monaco' => 'MC',
            'Mongolia' => 'MN',
            'Montserrat' => 'MS',
            'Morocco' => 'MA',
            'Mozambique' => 'MZ',
            'Myanmar' => 'MM',
            'Namibia' => 'NA',
            'Nauru' => 'NR',
            'Nepal' => 'NP',
            'Netherlands' => 'NL',
            'Nevis' => 'KN',
            'New Caledonia' => 'NC',
            'New Zealand' => 'NZ',
            'Nicaragua' => 'NI',
            'Niger' => 'NE',
            'Nigeria' => 'NG',
            'Niue' => 'NU',
            'Norfolk Island' => 'NF',
            'Norway' => 'NO',
            'Oman' => 'OM',
            'Pakistan' => 'PK',
            'Palau ' => 'PW',
            'Panama' => 'PA',
            'Papua New Guinea' => 'PG',
            'Paraguay' => 'PY',
            'Peru' => 'PE',
            'Philippines' => 'PH',
            'Poland' => 'PL',
            'Portugal' => 'PT',
            'Principe' => 'ST',
            'Puerto Rico' => 'PR',
            'Qatar' => 'QA',
            'Reunion Island' => 'RE',
            'Romania' => 'RO',
            'Rota Island' => 'MP',
            'Russia' => 'RU',
            'Rwanda' => 'RW',
            'Saint Lucia' => 'LC',
            'Saipan Islands' => 'MP',
            'San Marino' => 'SM',
            'Sao Tome' => 'ST',
            'Saudi Arabia' => 'SA',
            'Senegal Republic' => 'SN',
            'Serbia (Republic of)' => 'RS',
            'Seychelles' => 'SC',
            'Sierra Leone' => 'SL',
            'Singapore' => 'SG',
            'Slovak Republic' => 'SK',
            'Slovenia' => 'SI',
            'Solomon Islands' => 'SB',
            'Somalia' => 'SO',
            'South Africa' => 'ZA',
            'Spain' => 'ES',
            'Sri Lanka' => 'LK',
            'Sudan' => 'SD',
            'Suriname' => 'SR',
            'Swaziland' => 'SZ',
            'Sweden' => 'SE',
            'Switzerland' => 'CH',
            'Syria' => 'SY',
            'Taiwan' => 'TW',
            'Tajikistan' => 'TJ',
            'Tanzania' => 'TZ',
            'Thailand' => 'TH',
            'Togo' => 'TG',
            'Tokelau' => 'TK',
            'Tonga' => 'TO',
            'Trinidad and Tabago' => 'TT',
            'Tunisia' => 'TN',
            'Turkey' => 'TR',
            'Uganda' => 'UG',
            'Ukraine' => 'UA',
            'United Arab Emirates' => 'AE',
            'United Kingdom' => 'GB',
            'United States' => 'US',
            'Uruguay' => 'UY',
            'Uzbekistan' => 'UZ',
            'Vanuatu' => 'VU',
            'Vatican city' => 'VA',
            'Venezuela' => 'VE',
            'Vietnam' => 'VN',
            'Virgin Islands' => 'VG',
            'Western Somoa' => 'WS',
            'Yemen' => 'YE',
            'Yugoslavia' => 'MK',
            'Zaire' => 'CD',
            'Zambia' => 'ZM',
            'Zimbabwe' => 'ZW'
        };
        return countryCodes.get(countryName);
    }

    public static String getStateCode(String stateName) {
        Map<String, String> stateCodes = new Map<String, String> {
            'Alabama' => 'AL',
            'Alaska' => 'AK', 
            'Arizona' => 'AZ',
            'Arkansas' => 'AR', 
            'California' => 'CA', 
            'Colorado' => 'CO', 
            'Connecticut' => 'CT',
            'Delaware' => 'DE', 
            'Florida' => 'FL',
            'Georgia' => 'GA',
            'Hawaii' => 'HI', 
            'Idaho' => 'ID',
            'Illinois' => 'IL', 
            'Indiana' => 'IN',
            'Iowa' => 'IA', 
            'Kansas' => 'KS', 
            'Kentucky' => 'KY', 
            'Louisiana' => 'LA',
            'Maine' => 'ME',
            'Maryland' => 'MD', 
            'Massachusetts' => 'MA',
            'Michigan' => 'MI', 
            'Minnesota' => 'MN',
            'Mississippi' => 'MS',
            'Missouri' => 'MO', 
            'Montana' => 'MT',
            'Nebraska' => 'NE', 
            'Nevada' => 'NV', 
            'New Hampshire' => 'NH',
            'New Jersey' => 'NJ', 
            'New Mexico' => 'NM', 
            'New York' => 'NY', 
            'North Carolina ' => 'NC',
            'North Dakota' => 'ND', 
            'Ohio' => 'OH', 
            'Oklahoma' => 'OK', 
            'Oregon' => 'OR', 
            'Pennsylvania' => 'PA', 
            'Rhode Island' => 'RI', 
            'South Carolina' => 'SC', 
            'South Dakota' => 'SD', 
            'Tennessee' => 'TN',
            'Texas' => 'TX',
            'Utah' => 'UT', 
            'Vermont' => 'VT',
            'Virginia' => 'VA', 
            'Washington' => 'WA', 
            'West Virginia' => 'WV',
            'Wisconsin' => 'WI',
            'Wyoming' => 'WY'
        };
        return stateCodes.get(stateName);
    }
}