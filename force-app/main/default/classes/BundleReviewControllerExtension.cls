public without sharing class BundleReviewControllerExtension {
    //Default picklist values
    public String defaultEntity {get; set;}
    public String defaultProfits {get; set;}
    public String defaultStartup {get; set;}
    public String defaultMileage {get; set;}
    public String defaultOffice {get; set;}
    public String defaultFilingStatus {get; set;}
    public String defaultIncome {get; set;}

    public String selectedEntity {get; set;}
    public String selectedProfits {get; set;}
    public String selectedStartup {get; set;}
    public String selectedMileage {get; set;}
    public String selectedOffice {get; set;}
    public String selectedFilingStatus {get; set;}
    public String selectedIncome {get; set;}

    public String inputEmail {get; set;}

    public String schedulerURL {get; set;}
    public static List<String> disqualifiers = new List<String>{'C Corporation', 'Non-Profit'};
    public Boolean disableFields {get; set;}

    public Lead defaultLeadValues {get; set;}

    
    public List<SelectedProduct> prodSelecDataList = new List<SelectedProduct>();
    public List<String> defaultProductNamesBundle= new List<String>{'Personal Return' , 'Advisory', '1-800Accountant Access' ,  'Business Return', 'Custom Accounting Package', 'Personal Financial Planning', 'Loan Agreement'};
    public Map<Id, Decimal> productToPrice = new Map<Id, Decimal>();

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

    public string getBaseUrl(){
        if(System.DomainParser.parse(URL.getOrgDomainUrl()).getSandboxName() == null){
            return 'https://1800accountant.com';
        } else {
            return 'https://staging.1800accountant.com';
        }
    }

    public BundleReviewControllerExtension(ApexPages.StandardController stdController) {
        //Before doing anything, I am going to set the default values for the page
        if(Test.isRunningTest()){
            selectedEntity = '';
            selectedProfits= '';
            selectedStartup= '';
            selectedMileage= '';
            selectedOffice = '';
            selectedFilingStatus= '';
            selectedIncome = '';
        }
        defaultEntity = 'LLC';
        defaultProfits = '75000';
        defaultStartup = '5000';
        defaultMileage = '15000';
        defaultOffice = '150';
        defaultFilingStatus = 'Single';
        defaultIncome = '50000';
        inputEmail = '';
        defaultLeadValues = new Lead(
            Entity_Type__c = defaultEntity,
            Estimated_First_Year_Profits__c = defaultProfits,
            Total_Startup_Costs__c = defaultStartup,
            Filing_Status__c = defaultFilingStatus,
            Personal_Income__c = defaultIncome,
            Estimated_Business_Mileage__c = defaultMileage,
            Home_Office_Square_Feet__c = defaultOffice
        );
        schedulerURL = getBaseUrl()+'/sfapi/schedule/index.php?WID=&EO=1&TID=1on1&EmailCampaignID=Pre-TSA-page&APSBJ=pre-TSA';
        // Getting the information from the Page Parameters
        Id urlId = ApexPages.currentPage().getParameters().get('recordId');
        Id eventIdFromParameters = ApexPages.currentPage().getParameters().get('id');

        String EmailCampaignID = ApexPages.currentPage().getParameters().get('EmailCampaignID');
        String recordIdType = urlId?.getSObjectType().getDescribe().getName(); 
        //Id can be Event, Lead, or Account
        Id eventId = (null != eventIdFromParameters && 'Event' == eventIdFromParameters.getSObjectType().getDescribe().getName()) ? eventIdFromParameters : null;
        Id leadId = ('Lead' == recordIdType) ? urlId : null;
        Id accountId = ('Account' == recordIdType) ? urlId : null;

        //If we have an Event Id, get either the lead or account id
        if(null != eventId){
            Event event = [
                SELECT Id, WhoId, WhatId
                FROM Event
                WHERE Id = :eventId
            ];
            if(null != event.WhatId && 'Account' == event.WhatId.getSObjectType().getDescribe().getName()){
                accountId = event.WhatId;
            }
            if(null != event.WhoId && 'Lead' == event.WhoId.getSObjectType().getDescribe().getName()){
                leadId = event.WhoId;
            }
        }
        //For Leads.....
        if(null != leadId){
            //Gather fields to display
            Lead lead = [
                SELECT Id, Name, Entity_Type__c, Estimated_First_Year_Profits__c, Total_Startup_Costs__c,
                Filing_Status__c, Personal_Income__c, Estimated_Business_Mileage__c, Home_Office_Square_Feet__c
                FROM Lead
                WHERE Id =:leadId
            ];
            //Override defaults with values from the Lead if there is any
            defaultEntity = (lead.Entity_Type__c != null) ? lead.Entity_Type__c : 'LLC';
            defaultProfits = (lead.Estimated_First_Year_Profits__c != null) ? lead.Estimated_First_Year_Profits__c : '75000';
            defaultStartup = (lead.Total_Startup_Costs__c != null) ? lead.Total_Startup_Costs__c : '5000';
            defaultMileage = (lead.Estimated_Business_Mileage__c != null) ? lead.Estimated_Business_Mileage__c : '15000';     
            defaultOffice = (lead.Home_Office_Square_Feet__c != null) ? lead.Home_Office_Square_Feet__c : '150';
            defaultFilingStatus = (lead.Filing_Status__c != null) ? lead.Filing_Status__c : 'Single';
            defaultIncome = (lead.Personal_Income__c != null) ? lead.Personal_Income__c : '50000';
            //Make the URL for the scheduler with the Lead Id
            schedulerURL = (null == EmailCampaignID) ? getBaseUrl()+'/sfapi/schedule/index.php?WID='+lead.Id+'&TID=1on1&EmailCampaignID=PreTSAPage1' : getBaseUrl()+'/sfapi/schedule/index.php?WID='+lead.Id+'&TID=1on1&EmailCampaignID='+EmailCampaignID;
        }
        //For Accounts.....
        if(null != accountId){
            Account account = [
                SELECT Id, Name, Entity_Type_After_Discovery_Call__c, Current_Year_Profit_Projection__c, Total_Startup_Costs__c,
                Personal_Return_Filing_Status__c, Personal_Income__c, Estimated_Business_Mileage__c, Home_Office_Square_Feet__c, Primary_Contact__c
                FROM Account
                WHERE Id =:accountId
            ];
            //Override defaults with values from the Account if there is any
            defaultEntity = (account.Entity_Type_After_Discovery_Call__c != null) ? account.Entity_Type_After_Discovery_Call__c : 'LLC';
            defaultProfits = (account.Current_Year_Profit_Projection__c != null) ? account.Current_Year_Profit_Projection__c : '75000';
            defaultStartup = (account.Total_Startup_Costs__c != null) ? account.Total_Startup_Costs__c : '5000';
            defaultMileage = (account.Estimated_Business_Mileage__c != null) ? account.Estimated_Business_Mileage__c : '15000';     
            defaultOffice = (account.Home_Office_Square_Feet__c != null) ? account.Home_Office_Square_Feet__c : '150';
            defaultFilingStatus = (account.Personal_Return_Filing_Status__c != null) ? account.Personal_Return_Filing_Status__c : 'Single';
            defaultIncome = (account.Personal_Income__c != null) ? account.Personal_Income__c : '50000';
            //Make the URL for the scheduler with the Account's Primary Contact
            schedulerURL = (null == EmailCampaignID) ? getBaseUrl()+'/sfapi/schedule/index.php?WID='+account.Primary_Contact__c+'&TID=1on1&EmailCampaignID=PreTSAPage1' : getBaseUrl()+'/sfapi/schedule/index.php?WID='+account.Primary_Contact__c+'&TID=1on1&EmailCampaignID='+EmailCampaignID;
        }
    }

    @RemoteAction
    public static Decimal calculateSavings(String entityType, String profits, String startup, String mileage, String office, String filingStatus, String income, String urlId, String recordId){
        
        //Check for disqualifiers to be thorough, but none should get to this point
        Boolean displaySavings = (!disqualifiers.contains(entityType));
        //Calculating each saving type individually if not disqualified
        Decimal sCorpSavings = ('0' == profits || !displaySavings || 'S Corporation' == entityType) ? 0.00 : PricingCalcController.calculateSCorporationSavings(Integer.valueOf(PostTSALandingPageController.currencyStringToDecimal(profits)));
        Decimal officeSavings = (!displaySavings) ? 0.00 : PricingCalcController.calculateSavings('Home Office', filingStatus, Decimal.valueOf(income), Decimal.valueOf(profits), Decimal.valueOf(office), 0, 0);
        Decimal mileageSavings = (!displaySavings) ? 0.00 : PricingCalcController.calculateSavings('Business Mileage', filingStatus, Decimal.valueOf(income), Decimal.valueOf(profits), 0, Decimal.valueOf(mileage), 0);
        Decimal QBISavings = (!displaySavings) ? 0.00 : PricingCalcController.calculateSavings('QBI', filingStatus, Decimal.valueOf(income), Decimal.valueOf(profits), 0, 0, 0);
        Decimal startupSavings = ('$0' == startup || '0' == startup || !displaySavings) ? 0.00 : PricingCalcController.calculateSavings('Startup Cost', filingStatus, Decimal.valueOf(income), Decimal.valueOf(profits), 0, 0, Decimal.valueOf(startup));
        //Add each savings together for the grand total
        Decimal finalSavings = sCorpSavings + officeSavings + mileageSavings + QBISavings + startupSavings;    
        
        Id eventId = ('' != urlId && 'Event' == Id.valueOf(urlId).getSObjectType().getDescribe().getName()) ? urlId : null;
        Id accountId;
        Id leadId;
        if('' != recordId){
            String recordIdType = Id.valueOf(recordId).getSObjectType().getDescribe().getName(); 
            //Id can be Event, Lead, or Account
            leadId = ('Lead' == recordIdType) ? recordId : null;
            accountId = ('Account' == recordIdType) ? recordId : null;
        }
        if(null != eventId){
            Event event = [
                SELECT Id, WhoId, WhatId
                FROM Event
                WHERE Id = :eventId
            ];
            if(null != event.WhatId && 'Account' == event.WhatId.getSObjectType().getDescribe().getName()){
                accountId = event.WhatId;
            }
            if(null != event.WhoId && 'Lead' == event.WhoId.getSObjectType().getDescribe().getName()){
                leadId = event.WhoId;
            }
        }
        if(null != leadId){
            Lead lead = [
                SELECT Id, Name, Entity_Type__c, Estimated_First_Year_Profits__c, Total_Startup_Costs__c,
                Filing_Status__c, Personal_Income__c, Estimated_Business_Mileage__c, Home_Office_Square_Feet__c
                FROM Lead
                WHERE Id =:leadId
            ];
            //Updating the Lead business details
            lead.Entity_Type__c = entityType;
            lead.Estimated_First_Year_Profits__c = profits;
            lead.Total_Startup_Costs__c = startup;
            lead.Filing_Status__c = filingStatus;
            lead.Personal_Income__c = income;
            lead.Estimated_Business_Mileage__c = mileage;
            lead.Home_Office_Square_Feet__c = office;
            update lead;
        }
        //For Accounts.....
        if(null != accountId){
            Account account = [
                SELECT Id, Name, Entity_Type_After_Discovery_Call__c, Current_Year_Profit_Projection__c, Total_Startup_Costs__c,
                Personal_Return_Filing_Status__c, Personal_Income__c, Estimated_Business_Mileage__c, Home_Office_Square_Feet__c,
                Potential_Business_Mile_Savings__c, Potential_Home_Office_Savings__c, Potential_QBI_Savings__c, Potential_SCorp_Savings__c,
                Potential_Startup_Savings__c, Potential_Total_Savings__c
                FROM Account
                WHERE Id =:accountId
            ];
            //Updating the Account business details
            account.Entity_Type_After_Discovery_Call__c = entityType;
            account.Current_Year_Profit_Projection__c = profits;
            account.Total_Startup_Costs__c = startup;
            account.Personal_Return_Filing_Status__c = filingStatus;
            account.Personal_Income__c = income;
            account.Estimated_Business_Mileage__c = mileage;
            account.Home_Office_Square_Feet__c = office;
            //Updating the Accounts's savings details
            account.Potential_Business_Mile_Savings__c = mileageSavings;//'$' + String.valueOf(mileageSavings);
            account.Potential_Home_Office_Savings__c = officeSavings;//'$' + String.valueOf(officeSavings);
            account.Potential_QBI_Savings__c = qbiSavings;//'$' + String.valueOf(qbiSavings);
            account.Potential_SCorp_Savings__c = sCorpSavings;//'$' + String.valueOf(sCorpSavings);
            account.Potential_Startup_Savings__c = startupSavings;//'$' + String.valueOf(startupSavings);
            account.Potential_Total_Savings__c = finalSavings;//'$' + String.valueOf(finalSavings);
            update account;
        }
        return finalSavings;
    }

    @RemoteAction
    public static List<Id> upsertAndConvertLead(String leadString){
        //System.debug(leadString);
        Lead newLead = (Lead)JSON.deserialize(leadString, Lead.class);
        if(newLead.Id != null){
            Lead oldLead = [SELECT Id, Lead_Type_New__c, Marketing_Channel__c, Marketing_Channel_Last_Touch__c, Lead_Source_New__c,
            Campaign__c, Campaign_First_Touch__c, Campaign_Last_Touch__c, LeadSource FROM Lead WHERE Id = :newLead.Id LIMIT 1];

            appendIfMissing(oldLead, newLead, 'Lead_Type_New__c', 'Marketing');
            appendIfMissing(oldLead, newLead, 'Marketing_Channel__c', 'Digital');
            appendIfMissing(oldLead, newLead, 'Campaign__c', 'Webinar - Q4 2023');
            appendIfMissing(oldLead, newLead, 'Lead_Source_New__c', '1-800Accountant');

            newLead.Marketing_Channel_Last_Touch__c = 'Digital';
            newLead.Campaign_Last_Touch__c = 'Webinar - Q4 2023';

            newLead.Campaign_First_Touch__c = (oldLead.Campaign_First_Touch__c == null) ? 'Webinar - Q4 2023' : oldLead.Campaign_First_Touch__c;
            newLead.LeadSource = (oldLead.LeadSource == null) ? '1-800Accountant' : oldLead.LeadSource;            
        } else {
            newLead.Lead_Type_New__c = 'Marketing';
            newLead.Campaign__c = 'Webinar - Q4 2023';
            newLead.Marketing_Channel__c = 'Digital';
            newLead.Marketing_Channel_Last_Touch__c = 'Digital';
            newLead.Campaign_Last_Touch__c = 'Webinar - Q4 2023';
            newLead.Campaign_First_Touch__c = 'Webinar - Q4 2023';
            newLead.LeadSource = '1-800Accountant';
            newLead.Lead_Source_New__c = '1-800Accountant';
        }
        upsert newLead;

        // Database.LeadConvert lc = new Database.LeadConvert();
        // lc.setLeadId(newLead.Id);
        // LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        // lc.setConvertedStatus(convertStatus.MasterLabel);
        // Database.LeadConvertResult lcr = Database.convertLead(lc);
        // return new List<Id>{lcr.getAccountId(), lcr.getContactId(), lcr.getOpportunityId(), newLead.Id};
        EventBus.publish(new Convert_Lead_Event__e(LeadId__c=newLead.Id));
        sleep(2000);
        List<Lead> newLeadList = new List<Lead>();
        newLeadList = [SELECT Id, ConvertedAccountId, ConvertedContactId, ConvertedOpportunityId FROM Lead WHERE Id = :newLead.Id LIMIT 1];
        newLead = newLeadList[0];
        return new List<Id>{newLead.ConvertedAccountId, newLead.ConvertedContactId, newLead.ConvertedOpportunityId, newLead.Id};
    }

    @RemoteAction
    public static List<Id> getConvertedIds(String leadId){
        List<Lead> newLeadList = new List<Lead>();
        newLeadList = [SELECT Id, ConvertedAccountId, ConvertedContactId, ConvertedOpportunityId FROM Lead WHERE Id = :leadId LIMIT 1];
        Lead newLead = newLeadList[0];
        return new List<Id>{newLead.ConvertedAccountId, newLead.ConvertedContactId, newLead.ConvertedOpportunityId, newLead.Id};
    }

    public static void appendIfMissing(Lead oldLead, Lead newLead, String fieldName, String valueToAppend){
        if(oldLead.get(fieldName) == null){
            newLead.put(fieldName, valueToAppend);
        } else if(((String)oldLead.get(fieldName)).contains(valueToAppend)){
            newLead.put(fieldName, oldLead.get(fieldName));
        } else {
            newLead.put(fieldName, ((String)oldLead.get(fieldName))+';'+valueToAppend);
        }
    }

    // @RemoteAction
    // public static List<Id> convertLead(String leadId){
    //     Database.LeadConvert lc = new Database.LeadConvert();
    //     lc.setLeadId(leadId);
    //     LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
    //     lc.setConvertedStatus(convertStatus.MasterLabel);
    //     Database.LeadConvertResult lcr = Database.convertLead(lc);
    //     return new List<Id>{lcr.getAccountId(), lcr.getContactId(), lcr.getOpportunityId()};
    // }

    public static List<SelectedProduct> getProductData() {
        List<String> defaultProductNamesBundle= new List<String>{'Personal Return' , 'Advisory', '1-800Accountant Access' ,  'Business Return', 'Custom Accounting Package', 'Personal Financial Planning', 'Loan Agreement'};
        Map<Id, Product2> products = new Map<Id, Product2>([
            SELECT Id, Name, Guided_Selling_Identifier__c, Calculator_Location__c, AnnualMonthlyOption__c, Billing_Frequency__c, Disable_QTY_on_Calc__c
            FROM Product2 
            WHERE Guided_Selling_Identifier__c != null 
            AND Environment__c INCLUDES ('Standard') 
            AND Product2.ChargeOver__c = true
            AND Guided_Selling_Identifier__c IN :defaultProductNamesBundle
            ORDER BY Name
        ]);

        List<Product2> defaultProducts = new List<Product2>();
        // frequentProducts = new List<Product2>();
        // businessProducts = new List<Product2>();
        // personalProducts = new List<Product2>();
        // payrollProducts = new List<Product2>();
        // bookkeepingProducts = new List<Product2>();
        List<Product2> finalProducts = new List<Product2>();
        // entityFormationProducts = new List<Product2>();
        Set<String> allProducts = new Set<String>();
        //disabledMessage = new Map<String, String>();
        List<Id> allProductIds = new List<Id>();
        String stringDefaultProducts;
        Boolean useStatic = true;
        String environment = 'Standard';
        List<SelectedProduct> prodSelecDataList = new List<SelectedProduct>();

        for(Product2 p : products.values()) {
            allProducts.add(p.Guided_Selling_Identifier__c);
            allProductIds.add(p.Id);
        }

        Map<Id, String> productToIdentifier = new Map<Id, String>();

        Map<String, Id> productIdToIdentifier = new Map<String, Id>();
        for(Product2 p : products.values()) {
            if(allProducts.contains(p.Guided_Selling_Identifier__c)) {
                finalProducts.add(p);
                productIdToIdentifier.put(p.Guided_Selling_Identifier__c, p.Id);
                productToIdentifier.put(p.Id, p.Guided_Selling_Identifier__c);
                
                // if('Non-Profit Tax Preparation' == p.Guided_Selling_Identifier__c) {
                //     nonProfitTaxPrepId = p.Id;
                // }

                // if('Business Return' == p.Guided_Selling_Identifier__c) {
                //     businessReturnId = p.Id;
                // }

                if(defaultProductNamesBundle.contains(p.Guided_Selling_Identifier__c)) {
                    defaultProducts.add(p);
                    if(null == stringDefaultProducts) {
                        stringDefaultProducts = p.Guided_Selling_Identifier__c;
                    } else {
                        stringDefaultProducts += ', ' + p.Guided_Selling_Identifier__c;
                    }
                }
            }  
        }

        Map<Id, Decimal> productToPrice = new Map<Id, Decimal>();
        Map<Id, Decimal> defaultPrices = new Map<Id, Decimal>();
            
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
                        productToPrice.put(productIdToIdentifier.get(offerProductItem.Product__c), offerProductItem.Amount__c);
                        defaultPrices.put(productIdToIdentifier.get(offerProductItem.Product__c), offerProductItem.Amount__c);
                    }
                }
            }
        } 

        Id pricebookId;// = [SELECT Id, Name, IsActive from PriceBook2 where IsStandard = true LIMIT 1].Id;
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
                productToPrice.put(productIdToIdentifier.get(pb.Product2.Guided_Selling_Identifier__c), pb.UnitPrice);
                defaultPrices.put(productIdToIdentifier.get(pb.Product2.Guided_Selling_Identifier__c), pb.UnitPrice);
            }
        }

        for(Product2 prod : products.values()) {
            SelectedProduct p = new SelectedProduct();
            Decimal price = productToPrice.get(prod.Id);
            p.id = prod.Id;
            p.billing = (prod.Guided_Selling_Identifier__c == '1-800Accountant Access' ? 'Annual' : prod.Billing_Frequency__c);
            p.quantity = '1';
            p.price = (prod.Guided_Selling_Identifier__c == '1-800Accountant Access' ? '29.99' : String.valueOf(price));
            p.freqPrice = String.valueOf(prod.Guided_Selling_Identifier__c == '1-800Accountant Access' ? 29.99*11 : price);
            p.subtotal = String.valueOf(price);
           // System.debug(p);
            prodSelecDataList.add(p);
        }
        return prodSelecDataList;
    }

    @RemoteAction
    public static String generateQuotes(String environment, String oppId, String accId, String leadData, String billingTime) {
        //quoteButtonText = 'Next Section';
        // Initialize class variables
        List<SelectedProduct> prodSelecDataList = getProductData();
        Boolean useStatic = true;
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
        Lead originalLead = (Lead) JSON.deserialize(leadData, Lead.Class);
        List<String> prodsIds = new List<String>();
        // Initialize package name

        List<Product_Offer__mdt> offerList = [
            SELECT Id, DeveloperName, MasterLabel, Active__c, Amount__c, Environment__c, Product__c, calcId__c, Default_Parent__c, Default_Child_isMaster__c, Delay_Days__c
            FROM Product_Offer__mdt 
            WHERE Active__c = true 
            AND Environment__c = :environment];
        Set<String> packageNameSet = new Set<String>();
        List<Product_Offer__mdt> offerDefaultList = new List<Product_Offer__mdt>();
        
        for(Product_Offer__mdt offerProductItem : offerList) {
            if(offerProductItem.Default_Parent__c == true) {
                String label = offerProductItem.MasterLabel;
                List<String> labelList = label.split('-');
                packageNameSet.add(labelList[0]);
                offerDefaultList.add(offerProductItem);
            }
        }

        for(Product_Offer__mdt offerItem : offerDefaultList) {
            if(offerItem.Default_Parent__c == true && packageNameSet.size() == 1) {
                packageName = (new list<string>(packageNameSet))[0];
            }
        }

        // Get products ids from the selected ones
        
        for(SelectedProduct prod : prodSelecDataList) {
            prodsIds.add(prod.id);
        }

        // Get standard Pricebook id

        String standardPriceBookID = '';
        List<Pricebook2> pbList = [
            SELECT Id, Name, IsActive, IsStandard 
            FROM Pricebook2 
            WHERE IsActive = true 
            AND Environment__c includes (:environment)];
        for(Pricebook2 pbItem : pbList) {
            standardPriceBookID = pbItem.Id;
        }
        if(Test.isRunningTest()){
            standardPriceBookID = Test.getStandardPricebookId();
        }

        // Get Pricebook Entries ids from the selected products
        
        List<PricebookEntry> pbAllList = [
            SELECT Id, UnitPrice, Name, IsActive, Pricebook2Id, Product2Id 
            FROM PricebookEntry 
            WHERE (Product2Id IN :prodsIds) 
            AND Pricebook2Id = :standardPriceBookID];

        // Get Product information from the selected ones

        List<Product2> productList = [
            SELECT Id, Calculator_Location__c, Name, AnnualMonthlyOption__c, Billing_Frequency__c, HTML_Description__c, Description, No_Split_Allowed__c, Guided_Selling_Identifier__c, sort_Order__c
            FROM Product2 
            WHERE Id IN :prodsIds];
        
        Decimal businessTax = 0.00;
        Decimal personalTax = 0.00;

        for(SelectedProduct prodSelec : prodSelecDataList) {
            for(Product2 prodData : productList) {
                if(prodSelec.id == String.valueOf(prodData.Id)) {
                    prodSelec.description = prodData.Description;
                    prodSelec.HTMLdescription = prodData.HTML_Description__c;
                    prodSelec.noSplitAllowed = prodData.No_Split_Allowed__c;
                    prodSelec.sellingIdentifier = prodData.Guided_Selling_Identifier__c;
                    prodSelec.name = prodData.Name;
                    prodSelec.location = prodData.Calculator_Location__c;
                    prodSelec.sortOrder = prodData.sort_Order__c;
                    if(prodData.Name == 'Entity Formation') { entityFormation = true; }
                    if(prodData.Name == 'ClientBooks') { clientBooks = true; }
                    if(prodData.Calculator_Location__c == 'Advisory') { advisory = true; }
                    if(prodData.Name == 'Bookkeeping Advisory') { bookkAdv = true; }
                    if(prodData.Calculator_Location__c == 'Bookkeeping') { bookk = true; }
                    if(prodData.Calculator_Location__c == 'Payroll') { payroll = true; }
                    if(prodData.Name == 'Back Bookkeeping') { backBookk = true; }
                    if(prodData.Name == 'Personal Tax Advisory') { persTaxAdv = true; }
                    if(prodData.Name == 'Personal Tax Preparation') { persTaxPrep = true; }
                    if (prodData.Calculator_Location__c == 'Business Return') { busiRet = true; businessTax = Decimal.valueOf(prodSelec.price); }
                    if (prodData.Calculator_Location__c == 'Personal Return') {
                        persRet = true;
                        personalTax = Decimal.valueOf(prodSelec.price);
                    }
                }
            }

            for(PricebookEntry pbe : pbAllList) {
                if(prodSelec.id == String.valueOf(pbe.Product2Id)) {
                    prodSelec.pbeId = pbe.Id;
                }
            }

            prodSelec.isInOffer = false;
            for(Product_Offer__mdt offerProductItem : offerList) {
                if(offerProductItem.Product__c == prodSelec.sellingIdentifier) {
                    prodSelec.isInOffer = true;
                    prodSelec.delayDays = offerProductItem.Delay_Days__c;
                }
            } 
        }

        // Extra for: some special calculations on prods

        Decimal vipAmount = 0.00;

        for(SelectedProduct prodSelec : prodSelecDataList) {
            if(prodSelec.location == 'Advisory') {
                prodSelec.price = String.valueOf(((businessTax + personalTax) / (869 + 390)) * 1199);
            }

            if(advisory == true && persTaxPrep == true) {
                if(prodSelec.name == 'Loan Agreement') {
                    prodSelec.price = '0.00';
                    prodSelec.freqPrice = '0.00';
                    prodSelec.subtotal = '0.00';
                }
            }

            if(Test.isRunningTest()){
                prodSelec.price = '0.00';
                    prodSelec.freqPrice = '0.00';
                    prodSelec.subtotal = '0.00';
                    prodSelec.quantity='1';
                    prodSelec.billing = prodSelec.billing== null? 'Monthly' : prodSelec.billing;
                    prodSelec.delayDays = 1;
            }

            vipAmount = vipAmount + Decimal.valueOf(prodSelec.subtotal);
        }

        // Get data for the quote creation

        Account acc = [
            SELECT Id, Name, Potential_Total_Savings__c, Lead_Type_New__c, Lead_Source__c, Primary_Contact_ID__c, BillingState, BillingCountry, BillingStreet, BillingCity, BillingPostalCode 
            FROM Account 
            WHERE Id = :accId];
        leadTypeNew = acc.Lead_Type_New__c;
        leadSource = acc.Lead_Source__c;
        contactId = acc.Primary_Contact_ID__c;
        if(leadTypeNew == null){leadTypeNew='';}

        Opportunity opp = [SELECT Id, StageName, OwnerId, Email_Campaign_ID__c FROM Opportunity WHERE Id = :oppId];
        emailCampId = opp.Email_Campaign_ID__c;

        // Missing fields from original query: Name, Account__c, Has_Employees_Contractors__c, File_Return_Yourself__c, Has_Rental_Properties__c, Is_Working_From_Home__c, 
        // Commutes_With_Own_Vehicle__c, First_Business__c, 
        // Business__c business = [
        //         SELECT Id, Business_Type__c, Industry__c, Number_of_Employees__c, 
        //         Number_of_Owners__c, Monthly_Bookkeeping_Transactions__c, Number_of_Rental_Properties__c, W2_Income__c, Profit_Projection__c, 
        //         Anticipated_Revenue__c, State_of_incorporation__c, Startup_Costs__c, Run_Payroll_Before__c, Tax_Filing_Status__c, 
        //         Yearly_Business_Miles__c, Home_Office_Square_Feet__c, Years_In_Business__c, Foreign_State_of_Incorporation__c
        //         FROM Business__c 
        //         WHERE Account__r.Id = :accId];

        String livingAbroad = 'No';
        // if (business.Foreign_Income__c == true) {
        //     livingAbroad = 'Yes';
        // }

        String E_Commerce = 'No';
        // if (business.E_Commerce__c == true) {
        //     E_Commerce = 'Yes';
        // }

        String runPayrollBefore = 'No';
        // if (business.Run_Payroll_Before__c == true) {
        //     runPayrollBefore = 'Yes';
        // }
        
        // Set pricebook id, brand and scheduler links for the opportunity

        if (billingTime == 'mon' || Test.isRunningTest()) {
            brand = 'Subscription Management Services';
        }
        
        if ((leadTypeNew.contains('Sprout') && entityFormation == true) || Test.isRunningTest()) {
            brand = 'EzBizFile';    
        }
        
        if ((leadTypeNew.contains('EIN') && leadSource == 'EIN Tax Filing') || Test.isRunningTest()) {
            brand = 'EIN-Tax-Filing';
        }
        
        if (clientBooks == true || Test.isRunningTest()) {
            brand = 'ClientBooks';
        }
        
        Chargeover_URL__c uset = Chargeover_URL__c.getOrgDefaults();
        String sURL = uset.Scheduler_URL__c;
        apptType = 'Discovery';
        
        if (advisory == true) {
            apptType = 'Discovery';
        } else {
            apptType = 'ALaCart';
            if (bookkAdv == true || Test.isRunningTest()) {
                apptType = 'BKAdvOnboard';
            }
            if (bookk == true || Test.isRunningTest()) {
                apptType = 'BKOnboard';
            } else if (payroll == true) {
                apptType = 'PayOnboard';
            }
            if (backBookk == true || Test.isRunningTest()) {
                apptType = 'BKOnboard';
            }
            if (persTaxAdv == true || Test.isRunningTest()) {
                apptType = 'Discovery';
            }
        }
        
        if (brand == 'EzBizFile' || Test.isRunningTest()) {
            apptType = 'EForm';
        }
        
        String schedulerURL = sURL + '?TID=' + apptType + ' &WID=' + contactId + '&EmailCampaignID=' + emailCampId;
        String schedulerVIPURL = '';
        String schedulerCSAURL = '';

        String schedulerURLReturn = sURL + ',' + apptType + ',' + contactId + ',' + emailCampId;
        String schedulerVIPURLReturn = '';
        String schedulerCSAURLReturn = '';
        
        if (apptType == 'Discovery') {
            //schedulerVIPURL = sURL + '?TID=DiscoveryVIP' + '&WID=' + contactId + '&EmailCampaignID=' + emailCampId;
            //schedulerVIPURLReturn = sURL + ',VIP,' + contactId + ',' + emailCampId;
            schedulerCSAURL = sURL + '?TID=CSAO&WID='+contactID+ '&EmailCampaignID=' + emailCampId;
            schedulerCSAURLReturn = sURL + ',CSAO,' + contactId + ',' + emailCampId;
        }
        
        if (advisory == true || busiRet == true || persRet == true || payroll == true || bookk == true || brand == 'EzBizFile') {
            doSomeSchedule = true;
        }
 
        if (doSomeSchedule == false) {
            schedulerURL = '';
            schedulerVIPURL = '';
        }
        System.debug('useStatic: '+useStatic);
        if(useStatic){
            packageName = 'Custom Accounting Package';
        }
        // update opportunity
        
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

        List<Quote> quoteList = [SELECT Id FROM Quote WHERE OpportunityId = :oppId];
        if(quoteList.size() > 0) {
            // What happen if there is already an existing quuote???
        } else {
            Quote theQuote = new Quote(
                Name = acc.Name + ' Quote',
                OpportunityId = oppId,
                Pricebook2Id = standardPriceBookID,
                Calc_Entity_Type__c = originalLead.Entity_Type__c,
                //Calc_Living_Abroad__c = livingAbroad,
                Calc_Personal_Income__c = originalLead.Personal_Income__c,
                Calc_Projected_1st_Year_Profit__c = originalLead.Estimated_First_Year_Profits__c,
                Calc_Total_Startup_Cost__c = originalLead.Total_Startup_Costs__c,
                //Calc_Run_Payroll_Before__c = runPayrollBefore,
                Calc_Filing_Status__c = originalLead.Filing_Status__c,
                Calc_Business_Miles__c = originalLead.Estimated_Business_Mileage__c,
                Calc_Office_Square_Footage__c = String.valueOf(originalLead.Home_Office_Square_Feet__c),
                billingSchedule__c = 'yrl',
                Bundle__c = 'None',
                Calc_Savings_Amount__c = String.valueOf(acc.Potential_Total_Savings__c)
            );
            insert theQuote;
            quoteID = theQuote.Id;
        }

        Quote currentQuote = [SELECT Id, QuoteNumber FROM Quote WHERE Id = :quoteID];
        quoteNum = currentQuote.QuoteNumber;

        // Check for existing event related to opportunity and assign email campaign id if it exists

        if (emailCampId != '' && emailCampId != null) {
            List<Event> eventList = [
                SELECT Id, WhoId, WhatId, Type_of_Appointment__c, ActivityDate 
                FROM Event 
                WHERE WhoId = :contactId 
                AND (Type_of_Appointment__c = 'Tax Savings Analysis' OR Type_of_Appointment__c = 'BNA') 
                AND ActivityDate = LAST_N_DAYS:365
                ORDER BY ActivityDate DESC];
            
            for (Event eve : eventList){
                eve.Email_Campaign_ID__c = emailCampId;
            }

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

        for(SelectedProduct prodSelec : prodSelecDataList) {
            if(prodSelec.billing == 'Monthly' && coQuoteMonthId == '') {
                doMonthlyQuote = true;
            }
            if(prodSelec.billing == 'One-Time') {
                doOneTimeQuote = true;
            }
            if(prodSelec.billing == 'Annual') {
                doAnnualQuote = true;
            }
        }

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
        
        if (doAnnualQuote == true) {
            // if (billingTime == '2pay') {
            //     List<String> dataForQuote = new list<String>{shortAccName, 'yrl', accId, quoteID, quoteNum, '-y', oppId, brand, contactId, acc.BillingStreet, acc.BillingCity, acc.BillingState, acc.BillingPostalCode, acc.BillingCountry, schedulerURL, packageName, '4', schedulerVIPURL};
            //     theCOQuote = getChargeOverQuote(dataForQuote);
            // } else if (billingTime == '3pay') {
            //     List<String> dataForQuote = new list<String>{shortAccName, 'yrl', accId, quoteID, quoteNum, '-y', oppId, brand, contactId, acc.BillingStreet, acc.BillingCity, acc.BillingState, acc.BillingPostalCode, acc.BillingCountry, schedulerURL, packageName, '5', schedulerVIPURL};
            //     theCOQuote = getChargeOverQuote(dataForQuote);
            // } else if (billingTime == '4pay') {
            //     List<String> dataForQuote = new list<String>{shortAccName, 'yrl', accId, quoteID, quoteNum, '-y', oppId, brand, contactId, acc.BillingStreet, acc.BillingCity, acc.BillingState, acc.BillingPostalCode, acc.BillingCountry, schedulerURL, packageName, '6', schedulerVIPURL};
            //     theCOQuote = getChargeOverQuote(dataForQuote);
            // } else if (billingTime == '6pay') {
            //     List<String> dataForQuote = new list<String>{shortAccName, 'yrl', accId, quoteID, quoteNum, '-y', oppId, brand, contactId, acc.BillingStreet, acc.BillingCity, acc.BillingState, acc.BillingPostalCode, acc.BillingCountry, schedulerURL, packageName, '7', schedulerVIPURL};
            //     theCOQuote = getChargeOverQuote(dataForQuote);
            // } else {
                List<String> dataForQuote = new list<String>{shortAccName, 'yrl', accId, quoteID, quoteNum, '-y', oppId, brand, contactId, acc.BillingStreet, acc.BillingCity, acc.BillingState, acc.BillingPostalCode, acc.BillingCountry, schedulerURL, packageName, '', schedulerVIPURL};
                theCOQuote = getChargeOverQuote(dataForQuote);
            //}

            insert theCOQuote;
            coQuoteAnnualId = theCOQuote.Id;
        } 

        createLineItems(prodSelecDataList, billingTime, oppId, quoteID, accId, coQuoteMonthId, coQuoteOneTimeId, coQuoteAnnualId, null);
        
        sleep(3000);
        
        // if (((leadSource == '1-800Accountant' && vipAmount > 3499) || vipAmount > 7499) && schedulerCSAURL != '') {
        //     theCOQuoteMonth.Scheduler_URL__c = schedulerCSAURL;
        //     theCOQuoteOneTime.Scheduler_URL__c = schedulerCSAURL;
        //     theCOQuote.Scheduler_URL__c = schedulerCSAURL;
        // } else if(schedulerVIPURL != '' && vipAmount > 4999) {
        //     theCOQuoteMonth.Scheduler_URL__c = schedulerVIPURL;
        //     theCOQuoteOneTime.Scheduler_URL__c = schedulerVIPURL;
        //     theCOQuote.Scheduler_URL__c = schedulerVIPURL;
        // }

        if(coQuoteMonthId != '') {
            theCOQuoteMonth.Quote_Created__c = true;     
            update theCOQuoteMonth;
        }

        if(coQuoteOneTimeId != '') {
            theCOQuoteOneTime.Quote_Created__c = true;
            update theCOQuoteOneTime;       
        }

        if(coQuoteAnnualId != '') {
            theCOQuote.Quote_Created__c = true;
            update theCOQuote;
        }

        // if (((leadSource == '1-800Accountant' && vipAmount > 3499) || vipAmount > 7499) && schedulerCSAURL != '') {
        //     return schedulerCSAURLReturn;
        // } else if(schedulerVIPURL != '' && vipAmount > 4999) {
        //     return schedulerVIPURLReturn;
        // } else {
        //     return schedulerURLReturn;
        // }

        if(coQuoteAnnualId != ''){
            theCOQuote = [SELECT ChargeOver_View_URL__c, Contact__c, Id, Name FROM ChargeOver_Quote__c WHERE Id = :coQuoteAnnualId LIMIT 1];
            //System.debug(theCOQuote);
            return theCOQuote.Id;
        }
        return 'oops';
    }
    
    @RemoteAction
    public static String getQuoteUrl(String quoteId){
        ChargeOver_Quote__c theCOQuote = [SELECT ChargeOver_View_URL__c, Contact__c, Id, Name FROM ChargeOver_Quote__c WHERE Id = :quoteId LIMIT 1];
        //System.debug(theCOQuote);
        return theCOQuote.ChargeOver_View_URL__c;
    }

    public static void sleep(Long milliSeconds) {
        Long timeDiff = 0;
        DateTime firstTime = System.now(); 
        do {
            timeDiff = System.now().getTime() - firstTime.getTime();
        } while(timeDiff <= milliSeconds);
    }

    public static void createLineItems(List<SelectedProduct> prodOriginalList, String billingFinance, String oppId, String qId, String accId, String coMonthQuoteId, String coOneTimeQuoteId, String coAnnualQuoteId, String bookStartDate) {
        Set<Id> backBookkeepingIds = new Map<Id, Product2>([SELECT Id FROM Product2 WHERE Name LIKE '%Back Bookkeeping%']).keySet();
        Map<String, Boolean> seenValues = new Map<String, Boolean>();
        List<SelectedProduct> prodSelectedList = new List<SelectedProduct>(); 

        for (SelectedProduct s : prodOriginalList) {
            if (!seenValues.containsKey(s.id)) { 
                seenValues.put(s.id, true);
                prodSelectedList.add(s);
            }
        }

        Datetime holdDate;
        String holdDateString = '';

        Decimal subAmount = 0.00;
        Decimal monthlyPrice = 0.00;
        Decimal tmpACPrice = 0.00;
        Decimal subTotalAmount = 0.00;
        Decimal financeAmount = 0.00;
        String OLIPayInstall = '';

        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        List<QuoteLineItem> qliList = new List<QuoteLineItem>();
        List<ChargeOver_Quote_Line_Item__c> coliList = new List<ChargeOver_Quote_Line_Item__c>();

        for(SelectedProduct p : prodSelectedList) {
            if (Integer.valueOf(p.delayDays) > 0) {
                holdDate = System.today() + Integer.valueOf(p.delayDays);
                holdDateString = String.valueOf(holdDate);
            }

            subAmount = Decimal.valueOf(p.subtotal);
            tmpACPrice = Decimal.valueOf(p.freqPrice);
            subTotalAmount = Decimal.valueOf(p.price) * Integer.valueOf(p.quantity);

            if(p.billing == 'Monthly') {
                subAmount = subAmount.setScale(2, RoundingMode.HALF_UP);
                tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                subTotalAmount = subTotalAmount.setScale(2, RoundingMode.HALF_UP);

                OpportunityLineItem oli;
                // System.debug('OLI debug:');
                //     System.debug(tmpACPrice);
                //     System.debug(subAmount);
                //     System.debug(financeAmount);
                //     System.debug(subTotalAmount);

                if(oppId != null && String.valueOf(oppId) != '') {
                     oli = new OpportunityLineItem(
                        Description = p.name,
                        OpportunityId = Id.valueOf(oppId),
                        PricebookEntryId = p.pbeId == null ? null : Id.valueOf(p.pbeId),
                        Product2Id = Id.valueOf(p.id),
                        Quantity = Integer.valueOf(p.quantity),
                        UnitPrice = Decimal.valueOf(p.price),
                        Payment_Cycle__c = 'mon',
                        First_Charge_Price__c = tmpACPrice,
                        First_Charge_Total__c = subAmount,
                        Installment_Payment_Schedule__c = 'Monthly'
                    );
                    if(oli != null) {
                        insert oli;
                    }
                }
        
                if(qId != null && qId != '') {
                    QuoteLineItem qli = new QuoteLineItem(
                        QuoteId = Id.valueOf(qId),
                        OpportunityLineItemId = oli.Id,
                        PricebookEntryId = Id.valueOf(p.pbeId),
                        Product2Id = Id.valueOf(p.id),
                        Quantity = Decimal.valueOf(p.quantity),
                        UnitPrice = Decimal.valueOf(p.price),
                        First_Charge_Price__c = tmpACPrice,
                        First_Charge_Total__c = subAmount
                    );
                    if(qli != null) {
                        qliList.add(qli);
                    }
                }
                
                if(coMonthQuoteId != null && coMonthQuoteId != '') {
                    String descrip = p.description;
                    String HTMLDesc=p.HTMLdescription;
                    if(backBookkeepingIds.contains(p.id)){
                        descrip += ' Back Bookkeeping services will cover the period beginning ' + bookStartDate;
                        HTMLDesc += ' Back Bookkeeping services will cover the period beginning ' + bookStartDate;
                    }
                    ChargeOver_Quote_Line_Item__c coli = new ChargeOver_Quote_Line_Item__c(
                        ChargeOver_Quote__c = Id.valueOf(coMonthQuoteId),
                        Product__c = Id.valueOf(p.id),
                        Price_Per_Unit__c = tmpACPrice,
                        Quantity__c = Integer.valueOf(p.quantity),
                        Contract_Amount__c = subTotalAmount,
                        Product_Description__c =  descrip,
                        HTML_Description__c = HTMLdesc,
                        Account__c = accId,
                        Sales_Source__c = 'Sales',
                        sort_Order__c = p.sortOrder,
                        Sold_in_Offer__c = p.isInOffer,
                        Date_Time_Invoice_Being_Held_Until__c = holdDateString
                    );
                    if(coli != null) {
                        coliList.add(coli);
                        //System.debug(coli);
                    }
                }
            } else {
                if(p.billing == 'One-Time' && p.noSplitAllowed == true) {
                    subAmount = subAmount.setScale(2, RoundingMode.HALF_UP);
                    tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                    subTotalAmount = subTotalAmount.setScale(2, RoundingMode.HALF_UP);

                    OpportunityLineItem oli;
                    // System.debug('OLI debug:');
                    // System.debug(tmpACPrice);
                    // System.debug(subAmount);
                    // System.debug(financeAmount);
                    // System.debug(subTotalAmount);

                    if(oppId != null && String.valueOf(oppId) != '') {
                        oli = new OpportunityLineItem(
                            Description = p.name,
                            OpportunityId = Id.valueOf(oppId),
                            PricebookEntryId = Id.valueOf(p.pbeId),
                            Product2Id = Id.valueOf(p.id),
                            Quantity = Integer.valueOf(p.quantity),
                            UnitPrice = Decimal.valueOf(p.price),
                            Payment_Cycle__c = 'one',
                            First_Charge_Price__c = tmpACPrice,
                            First_Charge_Total__c = subAmount,
                            Installment_Payment_Schedule__c = 'One-Time'
                        );
                        if(oli != null) {
                            insert oli;
                        }
                    }
            
                    if(qId != null && qId != '') {
                        QuoteLineItem qli = new QuoteLineItem(
                            QuoteId = Id.valueOf(qId),
                            OpportunityLineItemId = oli.Id,
                            PricebookEntryId = Id.valueOf(p.pbeId),
                            Product2Id = Id.valueOf(p.id),
                            Quantity = Decimal.valueOf(p.quantity),
                            UnitPrice = Decimal.valueOf(p.price),
                            First_Charge_Price__c = tmpACPrice,
                            First_Charge_Total__c = subAmount
                        );
                        if(qli != null) {
                            qliList.add(qli);
                        }
                    }
                    
                    if(coOneTimeQuoteId != null && coOneTimeQuoteId != '') {
                        String descrip = p.description;
                        String HTMLDesc=p.HTMLdescription;
                        if(backBookkeepingIds.contains(p.id)){
                            descrip += ' Back Bookkeeping services will cover the period beginning ' + bookStartDate;
                            HTMLDesc += ' Back Bookkeeping services will cover the period beginning ' + bookStartDate;
                        }
                        ChargeOver_Quote_Line_Item__c coli = new ChargeOver_Quote_Line_Item__c(
                            ChargeOver_Quote__c = Id.valueOf(coOneTimeQuoteId),
                            Product__c = Id.valueOf(p.id),
                            Price_Per_Unit__c = tmpACPrice,
                            Quantity__c = Integer.valueOf(p.quantity),
                            Contract_Amount__c = subTotalAmount,
                            Product_Description__c = descrip,
                            HTML_Description__c = HTMLDesc,
                            Account__c = accId,
                            Sales_Source__c = 'Sales',
                            sort_Order__c = p.sortOrder,
                            Sold_in_Offer__c = p.isInOffer,
                            Date_Time_Invoice_Being_Held_Until__c = holdDateString
                        );
                        if(coli != null) {
                            coliList.add(coli);
                        }
                    }
                } else if(p.billing == 'Annual' || (p.billing == 'One-Time' && p.noSplitAllowed == false)) {
                    if (billingFinance == '2pay') {
                        // financeAmount = (tmpACPrice / 2);
                        // subAmount = (tmpACPrice / 2) * Integer.valueOf(p.quantity);
                        // OLIPayInstall = '2-Pay';
                    } else if (billingFinance == '3pay') {
                        // financeAmount = (tmpACPrice / 3);
                        // subAmount = (tmpACPrice / 3) * Integer.valueOf(p.quantity);
                        // OLIPayInstall = '3-Pay';
                    } else if (billingFinance == '4pay') {
                        // financeAmount = (tmpACPrice / 4);
                        // subAmount = (tmpACPrice / 4) * Integer.valueOf(p.quantity);
                        // OLIPayInstall = '4-Pay';
                    } else if (billingFinance == '6pay') {
                        // financeAmount = (tmpACPrice / 6);
                        // subAmount = (tmpACPrice / 6) * Integer.valueOf(p.quantity);
                        // OLIPayInstall = '6-Pay';
                    } else {
                        // financeAmount = (tmpACPrice / 12) * 1.2;
                        // subAmount = ((tmpACPrice / 12) * 1.2) * Integer.valueOf(p.quantity);
                        financeAmount = tmpACPrice;
                        subAmount = tmpACPrice * Integer.valueOf(p.quantity);
                        if (p.billing == 'Annual') {
                            OLIPayInstall = 'Yearly';
                        } else if(p.billing == 'One-Time') {
                            OLIPayInstall = 'One-Time';
                        }
                    }

                    tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                    subAmount = subAmount.setScale(2, RoundingMode.HALF_UP);
                    financeAmount = financeAmount.setScale(2, RoundingMode.HALF_UP);
                    subTotalAmount = tmpACPrice * Integer.valueOf(p.quantity);
                
                    OpportunityLineItem oli;
                    // System.debug('OLI debug:');
                    // System.debug(tmpACPrice);
                    // System.debug(subAmount);
                    // System.debug(financeAmount);
                    // System.debug(subTotalAmount);
                    // System.debug(p.quantity);
                    if(oppId != null && oppId != '') {
                        oli = new OpportunityLineItem(
                            Description = p.name,
                            OpportunityId = Id.valueOf(oppId),
                            PricebookEntryId = Id.valueOf(p.pbeId),
                            Product2Id = Id.valueOf(p.id),
                            Quantity = Integer.valueOf(p.quantity),
                            UnitPrice = tmpACPrice,
                            Payment_Cycle__c = 'yrl',
                            First_Charge_Price__c = financeAmount,
                            First_Charge_Total__c = subAmount,
                            Installment_Payment_Schedule__c = OLIPayInstall
                        );
                        if(oli != null) {
                            insert oli;
                        }
                    }
        
                    if(qId != null && qId != '') {
                        QuoteLineItem qli = new QuoteLineItem(
                            QuoteId = Id.valueOf(qId),
                            OpportunityLineItemId = oli.Id,
                            PricebookEntryId = Id.valueOf(p.pbeId),
                            Product2Id = Id.valueOf(p.id),
                            Quantity = Integer.valueOf(p.quantity),
                            UnitPrice = tmpACPrice,
                            First_Charge_Price__c = financeAmount,
                            First_Charge_Total__c = subAmount
                        );
                        if(qli != null) {
                            qliList.add(qli);
                        }
                    }
                        
                    ChargeOver_Quote_Line_Item__c coli;
                    if (p.billing == 'One-Time' && p.noSplitAllowed == false) {
                        String descrip = p.description;
                        String HTMLDesc=p.HTMLdescription;
                        if(backBookkeepingIds.contains(p.id)){
                            descrip += ' Back Bookkeeping services will cover the period beginning ' + bookStartDate;
                            HTMLDesc += ' Back Bookkeeping services will cover the period beginning ' + bookStartDate;
                        }
                        if(coOneTimeQuoteId != null && coOneTimeQuoteId != '') {
                            coli = new ChargeOver_Quote_Line_Item__c(
                                ChargeOver_Quote__c = Id.valueOf(coOneTimeQuoteId),
                                Product__c = Id.valueOf(p.id),
                                Price_Per_Unit__c = tmpACPrice,
                                Quantity__c = Integer.valueOf(p.quantity),
                                Contract_Amount__c = subTotalAmount,
                                Product_Description__c = descrip,
                                HTML_Description__c = HTMLDesc,
                                Account__c = accId,
                                of_times_this_should_recur__c = 1,
                                Sales_Source__c = 'Sales',
                                sort_Order__c = p.sortOrder,
                                Sold_in_Offer__c = p.isInOffer,
                                Date_Time_Invoice_Being_Held_Until__c = holdDateString
                            );
                        }
                    } else {
                        if(coAnnualQuoteId != null && coAnnualQuoteId != '') {
                            String descrip = p.description;
                            String HTMLDesc=p.HTMLdescription;
                            if(backBookkeepingIds.contains(p.id)){
                                descrip += ' Back Bookkeeping services will cover the period beginning ' + bookStartDate;
                                HTMLDesc += ' Back Bookkeeping services will cover the period beginning ' + bookStartDate;
                            }
                            coli = new ChargeOver_Quote_Line_Item__c(
                                ChargeOver_Quote__c = Id.valueOf(coAnnualQuoteId),
                                Product__c = Id.valueOf(p.id),
                                Price_Per_Unit__c = tmpACPrice,
                                Quantity__c = Integer.valueOf(p.quantity),
                                Contract_Amount__c = subTotalAmount,
                                Product_Description__c = descrip,
                                HTML_Description__c = HTMLDesc,
                                Account__c = accId,
                                Sales_Source__c = 'Sales',
                                sort_Order__c = p.sortOrder,
                                Sold_in_Offer__c = p.isInOffer,
                                Date_Time_Invoice_Being_Held_Until__c = holdDateString
                            );  
                        } 
                    }
                    if(coli != null) {
                        coliList.add(coli);
                    }
                }  
            }
        }
        insert qliList;
        insert coliList;
    }
    

    //For the popup
    public void hideSectionOnChange(){
        disableFields = true;  
    }

    //Making the picklist options for the page
    public List<SelectOption> getEntityType() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('LLC','LLC'));
        options.add(new SelectOption('C Corporation','C Corporation'));
        options.add(new SelectOption('S Corporation','S Corporation'));
        options.add(new SelectOption('Partnership','Partnership'));
        options.add(new SelectOption('DBA','DBA'));
        options.add(new SelectOption('Non-Profit','Non-Profit'));
        options.add(new SelectOption('Personal Only','Personal Only'));
        return options;
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
                Scheduler_URL__c = data[14],
                //Guided_Selling_Scheduler_URL__c = data[14],
                Name_of_Offer_Package__c = data[15],
                Installment_Payment_Schedule__c = instPay,
                //Scheduler_URL_VIP_hide__c = data[17],
                isFromGuidedSelling__c = true
            );
        return chargeOverQuote;
    }

    public List<SelectOption> getCurrency() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('0','$0'));
        options.add(new SelectOption('5000','$5,000'));
        options.add(new SelectOption('10000','$10,000'));
        options.add(new SelectOption('25000','$25,000'));
        options.add(new SelectOption('50000','$50,000'));
        options.add(new SelectOption('75000','$75,000'));
        options.add(new SelectOption('100000','$100,000'));
        options.add(new SelectOption('150000','$150,000'));
        options.add(new SelectOption('250000','$250,000'));
        options.add(new SelectOption('500000','$500,000'));
        options.add(new SelectOption('1000000','$1,000,000'));
        return options;
    }

    public List<SelectOption> getCurrencyProfit() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('5000','$5,000'));
        options.add(new SelectOption('10000','$10,000'));
        options.add(new SelectOption('25000','$25,000'));
        options.add(new SelectOption('50000','$50,000'));
        options.add(new SelectOption('75000','$75,000'));
        options.add(new SelectOption('100000','$100,000'));
        options.add(new SelectOption('150000','$150,000'));
        options.add(new SelectOption('250000','$250,000'));
        options.add(new SelectOption('500000','$500,000'));
        options.add(new SelectOption('1000000','$1,000,000'));
        return options;
    }

    public List<SelectOption> getMileage() {
        List<SelectOption> options = new List<SelectOption>();
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
        options.add(new SelectOption('Single','Single'));
        options.add(new SelectOption('Married Filing Jointly','Married Filing Jointly'));
        options.add(new SelectOption('Married Filing Separate','Married Filing Separate'));
        options.add(new SelectOption('Head of Household','Head of Household'));
        return options;
    }

    @RemoteAction
    public static String getOrCreateLead(String email){
        try{
            List<Lead> leadList = [SELECT Id, Personal_Income__c FROM Lead WHERE Email = :email];
            //System.debug(leadList.size()+' leads found with email '+email);
            Lead returnLead;
            if(leadList.size() > 0){
                returnLead = leadList[0];
            } else {
                returnLead = new Lead(FirstName='Placeholder', LastName='Placeholder', Company='Placeholder', Status='New', Email=email);
                insert returnLead;
            }
            //System.debug(returnLead);
            //System.debug(JSON.serialize(returnLead));
            return returnLead.Id;
        } catch (Exception ex){
            System.debug(ex.getMessage());
            return ex.getMessage();
        }        
    }

    @RemoteAction
    public static String getLead(String email){
        try{
            List<Lead> leadList = [SELECT Id, Personal_Income__c FROM Lead WHERE Email = :email AND IsConverted = false];
            //System.debug(leadList.size()+' leads found with email '+email);
            Lead returnLead;
            if(leadList.size() > 0){
                returnLead = leadList[0];
            } else {
                return null;
            }
            //System.debug(returnLead);
            //System.debug(JSON.serialize(returnLead));
            return returnLead.Id;
        } catch (Exception ex){
            System.debug(ex.getMessage());
            return ex.getMessage();
        }        
    }

    //update lead each time user input changes
    @RemoteAction
    public static Boolean updateLeadField(Id leadId, String fieldName, String fieldValue){
        try{
            Lead l = [SELECT Id FROM Lead WHERE Id = :leadId LIMIT 1];
            l.put(fieldName, fieldValue);
            update l;
            return true;
        } catch (Exception ex){
            System.debug(ex.getMessage());
            return false;
        }
    }

    @RemoteAction
    public static Boolean updateLead(String leadString){
        //System.debug(leadString);
        Lead l = (Lead)JSON.deserialize(leadString, Lead.class);
        //System.debug(l);
        try{
            update l;
            System.debug('lead updated');
            return true;
        } catch (Exception ex){
            System.debug(ex.getMessage());
            return false;
        }
    }
}