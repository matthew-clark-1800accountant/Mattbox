public without sharing class GuidedSellingEditControllerExtension {
    
    // Classes extends
    public class NoOpportunityIdFoundException extends Exception {}
    public class FoundMoreThanOneScriptException extends Exception {}

    // Variables String 
    public String FoundMoreThanOneScript = 'More than one script was found in the TSA Introduction Script Metadata for the Lead Source.';
    public String noOpportunityFound = 'No Opportunity Id Found.';

    public String dynamicScript { get; set; }
    public String environment { get; set; }
    public String defaultNumForeignOwners { get; set; }
    public String defaultYearsInBusiness { get; set; }
    public String defaultEntity { get; set; }
    public String defaultIndustry { get; set; } 
    public String defaultDomesticState { get; set; }
    public String defaultForeignState { get; set; }
    public String defaultPersonalState { get; set; }
    public String defaultStartupCosts { get; set; }
    public String defaultRevenue { get; set; }
    public String defaultFirstYearProfit { get; set; }
    public String defaultInvestorFunding { get; set; }
    public String defaultNumTransactions { get; set; }
    public String defaultNumOwners { get; set; }
    public String defaultNumEmployees { get; set; }
    public String defaultNumContractors { get; set; }
    public String defaultFilingStatus { get; set; }
    public String defaultPersonalIncome { get; set; }
    public String defaultNumberOfRentalProperties { get; set; }
    public String defaultOtherInvestments { get; set; }
    public String defaultOffice { get; set; }
    public String defaultMileage { get; set; }
    public String defaultState { get; set; }
    public String defaultNumberOfEmployeeContractors { get; set; }
    public String requiredfields { get; set; }
    public String disabledProducts { get; set; }
    public String stringDefaultProducts { get; set; }
    public String theAccountId { get; set; }
    public String defaultCountry { get; set; }

    // Variables Boolean 
    public Boolean hasRecordId { get; set; }
    public Boolean useBTPLegalZoomScript { get; set; }
    public Boolean useBAPLegalZoomScript { get; set; }
    public Boolean firstBusiness { get; set; }
    public Boolean runPayrollBefore { get; set; }
    public Boolean hasEmployeesContractors { get; set; }
    public Boolean foreignIncome { get; set; }
    public Boolean hasRentalProperties { get; set; }
    public Boolean isWorkingFromHome { get; set; }
    public Boolean commutesWithOwnVehicle { get; set; }
    public Boolean eCommerce { get; set; }
    public Boolean btp { get; set; }

    // Variables Integer 
    public Integer numRequiredFields {get; set;}

    //Record Variables
    public Opportunity opportunity { get; set; }
    public User user { get; set; }
    public Account account { get; set; }
    public Business__c business { get; set; }
    public Business_Owner__c businessOwner { get; set; }

    //List Variables
    public List<Business_Owner__c> partners { get; set; }
    public List<Product2> finalProducts { get; set; }
    public List<Product2> defaultProducts { get; set; }
    public List<Product2> frequentProducts { get; set; }
    public List<Product2> businessProducts { get; set; }
    public List<Product2> personalProducts { get; set; }
    public List<Product2> payrollProducts { get; set; }
    public List<Product2> bookkeepingProducts { get; set; }
    public List<Product2> entityFormationProducts { get; set; }
    public List<Product_Offer__mdt> offersOfProducts { get; set; }
    
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
    public static String getsfBaseUrl(){
        return GuidedSellingControllerExtension.getsfBaseUrl();
    }

    public static String getsiteBaseUrl(){
        return GuidedSellingControllerExtension.getsiteBaseUrl();
    }

    public static String getschedulerBaseUrl(){
        return GuidedSellingControllerExtension.getschedulerBaseUrl();
    }

    public static String getsocketBaseUrl(){
        return GuidedSellingControllerExtension.getsocketBaseUrl();
    }

    public void setproductToPrice(Map<Id, Decimal> dumperVar) {
        this.productToPrice = dumperVar;
    }

    public String getproductToPrice() { 
        return JSON.serialize(this.productToPrice); 
    }

    public void setproductToIdentifier(Map<Id, String> dumperVar) {
        this.productToIdentifier = dumperVar;
    }

    public String getproductToIdentifier() { 
        return JSON.serialize(this.productToIdentifier); 
    }

    public GuidedSellingEditControllerExtension(ApexPages.StandardController stdController) {
        
        //First identify the record Id passed in the parameters through the flow
        Id recordId = ApexPages.currentPage().getParameters().get('rId');
        hasRecordId = (null == recordId) ? false : true;

        firstBusiness = false;
        runPayrollBefore = false;
        hasEmployeesContractors = false;
        foreignIncome = false; 
        hasRentalProperties = false; 
        isWorkingFromHome = false;
        commutesWithOwnVehicle = false; 
        eCommerce = false; 
        defaultCountry = 'United States';
        defaultNumForeignOwners = '---';
        defaultState = 'Select a State';
        defaultYearsInBusiness = '---';
        defaultEntity = 'Select an Entity Type';
        defaultIndustry = 'Select an Industry';
        defaultDomesticState = 'Select a State';
        defaultForeignState = 'Select a State';
        defaultPersonalState = 'Select a State';
        defaultStartupCosts = '---';
        defaultRevenue = '---';
        defaultFirstYearProfit = '---';
        defaultInvestorFunding = '---';
        defaultNumTransactions = '---';
        defaultNumOwners = '---';
        defaultNumEmployees = '---';
        defaultNumContractors = '---';
        defaultFilingStatus = 'Select a Filing Status';
        defaultPersonalIncome = '---';
        defaultNumberOfRentalProperties = '---';
        defaultOtherInvestments = '---';
        defaultOffice = '---';
        defaultMileage = '---';
        
        String recordIdType = recordId?.getSObjectType().getDescribe().getName(); 
        
        Id eventId = ('Event' == recordIdType) ? recordId : null;
        Id leadId = ('Lead' == recordIdType) ? recordId : null;
        Id accountId = ('Account' == recordIdType) ? recordId : null;
        Id opportunityId = ('Opportunity' == recordIdType) ? recordId : null;

        //If there is an Event Id, get either an Opportunity or Account
        if(null != eventId) {
            Event event = [SELECT Id, WhatId, WhoId FROM Event WHERE Id = :recordId];

            //Getting either an Account or Opportunity from the Event
            if(null != event.WhatId && 'Account' == event.WhatId.getSObjectType().getDescribe().getName()) {
                accountId = event.WhatId;
            }
            
            if(null != event.WhatId && 'Opportunity' == event.WhatId.getSObjectType().getDescribe().getName()) {
                opportunityId = event.WhatId;
            }
        }

        //If there is a Lead Id, it was converted and we can get the Opportunity Id
        if(null != leadId) {
            Lead lead = [
                SELECT Id, Name, Entity_Type__c, Company, LeadSource, Email, Owner.Name, Owner.Email, ConvertedOpportunityId
                FROM Lead
                WHERE Id = :leadId
            ];
            opportunityId = lead.ConvertedOpportunityId;
        }

        //In the case an Event has an Account and Opportunity, we only want the Opportunity
        if(null == opportunityId && null != accountId) {
            Opportunity findLatestOpportunity = [
                SELECT Id, Name, AccountId FROM Opportunity WHERE AccountId = :accountId ORDER BY CreatedDate DESC LIMIT 1
            ];
            opportunityId = findLatestOpportunity.Id;
        }

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
                Account.Foreign_State__c, Account.State_of_Residence__c, Account.Total_Startup_Costs__c, Account.Expected_1st_year_revenue__c, Account.Trans_Per_Month__c, 
                Account.How_much_funding__c, Account.Current_Year_Profit_Projection__c, Account.Number_of_owners__c, Account.NumberOfEmployees, Account.Number_of_Contractors__c,
                Account.Personal_Income__c, Account.Foreign_Income__c, Account.Rental_Properties__c, Account.Home_Office_Square_Feet__c, Account.Estimated_Business_Mileage__c, 
                Account.Lead_Source_Date__c        
                FROM Opportunity 
                WHERE Id = :opportunityId
            ];
        }

        theAccountId = opportunity.AccountId;

        if(opportunity.AccountId != null) {
            business = [
                SELECT Id, Name, Account__c, Anticipated_Revenue__c, Industry__c, Business_Type__c, Number_of_Owners__c, Startup_Costs__c, Years_In_Business__c, 
                Foreign_State_of_Incorporation__c, State_of_Residence__c, Profit_Projection__c, Number_of_Contractors__c, Home_Office_Square_Feet__c,
                State_of_incorporation__c, Number_of_Foreign_Owners__c, Monthly_Bookkeeping_Transactions__c, Investor_Funding__c, Number_of_Employees__c, Tax_Filing_Status__c,
                W2_Income__c, Number_of_Rental_Properties__c, Number_of_K1_Investments__c, Yearly_Business_Miles__c, 
                Run_Payroll_Before__c, Has_Employees_Contractors__c, File_Return_Yourself__c, Has_Rental_Properties__c, Is_Working_From_Home__c, Commutes_With_Own_Vehicle__c, 
                E_Commerce__c, First_Business__c, Foreign_Income__c
                FROM Business__c 
                WHERE Account__r.Id = :opportunity.AccountId
            ];
        }

        // Number of employees need to take -1 since this one is the client itself
        Integer numEmpl = 0;
        if(business.Number_of_Employees__c != null) {
            numEmpl = Integer.valueOf(business.Number_of_Employees__c) - 1;
        }

        // The entity type should be only the accepted ones, if is an old one is set as null 
        String businessEntity = '';
        if(business.Business_Type__c != 'LLC' && business.Business_Type__c != 'C Corporation' && business.Business_Type__c != 'S Corporation' &&
           business.Business_Type__c != 'Partnership' && business.Business_Type__c != 'DBA' && business.Business_Type__c != 'Non-Profit' &&
           business.Business_Type__c != 'Personal Only') {
            businessEntity = null;
        } else {
            businessEntity = business.Business_Type__c;
        }

        defaultRevenue = (business.Anticipated_Revenue__c != null) ? business.Anticipated_Revenue__c : '---';
        defaultIndustry = (business.Industry__c != null) ? business.Industry__c : 'Select an Industry';
        defaultEntity = (businessEntity != null) ? businessEntity : 'Select an Entity Type';
        defaultNumOwners = (business.Number_of_Owners__c != null) ? business.Number_of_Owners__c : '---';
        defaultStartupCosts = (business.Startup_Costs__c != null) ? business.Startup_Costs__c : '---';
        defaultYearsInBusiness = (business.Years_In_Business__c != null) ? business.Years_In_Business__c : '---';
        defaultPersonalState = (business.State_of_Residence__c != null) ? business.State_of_Residence__c : 'Select a State';
        defaultFirstYearProfit = (business.Profit_Projection__c != null) ? business.Profit_Projection__c : '---';
        defaultNumContractors = (business.Number_of_Contractors__c != null) ? business.Number_of_Contractors__c : '---';
        defaultOffice = (business.Home_Office_Square_Feet__c != null) ? String.valueOf(business.Home_Office_Square_Feet__c) : '---';
        defaultDomesticState = (business.State_of_incorporation__c != null) ? business.State_of_incorporation__c : 'Select a State';
        defaultForeignState = (business.Foreign_State_of_Incorporation__c != null) ? business.Foreign_State_of_Incorporation__c : 'Select a State';
        defaultInvestorFunding = (business.Investor_Funding__c != null) ? business.Investor_Funding__c : '---';
        defaultNumTransactions = (business.Monthly_Bookkeeping_Transactions__c != null) ? String.valueOf(business.Monthly_Bookkeeping_Transactions__c) : '---';
        defaultNumForeignOwners = (business.Number_of_Foreign_Owners__c != null) ? business.Number_of_Foreign_Owners__c : '---';
        defaultNumEmployees = (business.Number_of_Employees__c != null) ? String.valueOf(numEmpl) : '---';
        defaultFilingStatus = (business.Tax_Filing_Status__c != null) ? business.Tax_Filing_Status__c : 'Select a Filing Status';
        defaultPersonalIncome = (business.W2_Income__c != null) ? business.W2_Income__c : '---';
        defaultNumberOfRentalProperties = (business.Number_of_Rental_Properties__c != null) ? business.Number_of_Rental_Properties__c : '---';
        defaultOtherInvestments = (business.Number_of_K1_Investments__c != null) ? business.Number_of_K1_Investments__c : '---';
        defaultMileage = (business.Yearly_Business_Miles__c != null) ? business.Yearly_Business_Miles__c : '---';
        firstBusiness = business.First_Business__c;
        runPayrollBefore = business.Run_Payroll_Before__c;
        hasEmployeesContractors = business.Has_Employees_Contractors__c;
        foreignIncome = business.Foreign_Income__c;
        hasRentalProperties = business.Has_Rental_Properties__c;
        isWorkingFromHome = business.Is_Working_From_Home__c;
        commutesWithOwnVehicle = business.Commutes_With_Own_Vehicle__c;
        eCommerce = business.E_Commerce__c;

        user = [SELECT Id, Name, Skills_Sales__c, Sell_Client_Books__c FROM User WHERE Id = :opportunity.Account.Owner.Id];

        account = [SELECT Id, Lead_Type_New__c, Lead_Source__c FROM Account WHERE Id = :opportunity.AccountId];
        
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
            ];
        }

        defaultCountry = (businessOwner.Country__c != null) ? businessOwner.Country__c : 'United States';
        defaultState = (businessOwner.State__c != null) ? businessOwner.State__c : 'Select a State';

        //Logic based on Lead Source here
        btp = false;
        if(null != opportunity.Account.Lead_Source__c) {
                
            //Setting the LegalZoom script here: Priority for LegalZoom script: 1.BTP 2.BAP
            if('LegalZoom' == opportunity.Account.Lead_Source__c) {
                if(opportunity.Account.Lead_Type_New__c?.contains('BTP')) {
                    btp = true;
                    useBTPLegalZoomScript = true;   
                } else if(opportunity.Account.Lead_Type_New__c?.contains('BAP') && !opportunity.Account.Lead_Type_New__c?.contains('BTP')) {
                    useBAPLegalZoomScript = true;
                }
            }
            
            //Calculator Environment logic
            environment = 'Standard';
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

        String queryEnvironment = '%'+environment+'%';
        List<Required_Fields_Guided_Selling__mdt> getRequired = [
            SELECT Guided_Selling_Field_Name__c, Required__c, Label FROM Required_Fields_Guided_Selling__mdt WHERE Required__c LIKE :queryEnvironment
        ];

        for(Required_Fields_Guided_Selling__mdt rf : getRequired) {
            if(null == requiredfields) {
                requiredfields = rf.Label;
                numRequiredFields = 1;
            } else {
                requiredfields += ', ' + rf.Label;
                numRequiredFields++;
            }
        }

        getProductData();
    }

    public void getProductData() {
        
        Map<Id, Product2> products = new Map<Id, Product2>([
            SELECT Id, Name, Guided_Selling_Identifier__c, Calculator_Location__c, AnnualMonthlyOption__c, Billing_Frequency__c, Disable_QTY_on_Calc__c
            FROM Product2 
            WHERE Guided_Selling_Identifier__c != null 
            AND Environment__c INCLUDES (:environment) 
            AND Product2.ChargeOver__c = true
            ORDER BY Name
        ]);

        defaultProducts = new List<Product2>();
        frequentProducts = new List<Product2>();
        businessProducts = new List<Product2>();
        personalProducts = new List<Product2>();
        payrollProducts = new List<Product2>();
        bookkeepingProducts = new List<Product2>();
        finalProducts = new List<Product2>();
        entityFormationProducts = new List<Product2>();
        Set<String> allProducts = new Set<String>();
        disabledMessage = new Map<String, String>();
        List<Id> allProductIds = new List<Id>();

        for(Product2 p : products.values()) {
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
                if('Equals' == rule.Operator__c) {
                    if(userValue == rule.Value__c) {
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

                if('Not Equal' == rule.Operator__c) {
                    if(userValue != rule.Value__c) {
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

                if('Contains String' == rule.Operator__c) {
                    if(userValue.containsIgnoreCase(rule.Value__c)) {
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

                if('Does Not Contain String' == rule.Operator__c) {
                    if(!userValue.containsIgnoreCase(rule.Value__c)) {
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

            if(null != accountFieldValue) {
                Map<String, Object> serializedAccount = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(account));
                String accountValue = String.valueOf(serializedAccount.get(accountFieldValue));
                if('Equals' == rule.Operator__c) {
                    if(accountValue == rule.Value__c) {
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

                if('Not Equal' == rule.Operator__c) {
                    if(accountValue != rule.Value__c) {
                        if('Remove Product' == rule.Action__c) {
                            allProducts.remove(rule.Product_Name__c);
                        } else {
                            if(null == disabledProducts) {
                                disabledProducts = rule.Product_Name__c;
                            } else {
                                disabledProducts += ', ' + rule.Product_Name__c;
                            }
                        }
                    }
                }

                if('Contains String' == rule.Operator__c) {
                    if(accountValue.containsIgnoreCase(rule.Value__c)) {
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

                if('Does Not Contain String' == rule.Operator__c) {
                    if(!accountValue.containsIgnoreCase(rule.Value__c)) {
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
        }

        productToIdentifier = new Map<Id, String>();

        Map<String, Id> productIdToIdentifier = new Map<String, Id>();
        for(Product2 p : products.values()) {
            if(allProducts.contains(p.Guided_Selling_Identifier__c)) {
                finalProducts.add(p);
                productIdToIdentifier.put(p.Guided_Selling_Identifier__c, p.Id);
                productToIdentifier.put(p.Id, p.Guided_Selling_Identifier__c);
                
                if('Non-Profit Tax Preparation' == p.Guided_Selling_Identifier__c) {
                    nonProfitTaxPrepId = p.Id;
                }

                if('Business Return' == p.Guided_Selling_Identifier__c) {
                    businessReturnId = p.Id;
                }

                //BTP default products
                if(btp){
                    if('Personal Return' == p.Guided_Selling_Identifier__c || 'Advisory'== p.Guided_Selling_Identifier__c || '1-800Accountant Access' == p.Guided_Selling_Identifier__c
                    || 'Audit Defense - Business' == p.Guided_Selling_Identifier__c || 'Audit Defense - Personal' == p.Guided_Selling_Identifier__c
                    || 'Two-Year Review' == p.Guided_Selling_Identifier__c || 'Loan Agreement' == p.Guided_Selling_Identifier__c) {
                        defaultProducts.add(p);
                        if(null == stringDefaultProducts) {
                            stringDefaultProducts = p.Guided_Selling_Identifier__c;
                        } else {
                            stringDefaultProducts += ', ' + p.Guided_Selling_Identifier__c;
                        }
                    }
                } else {
                    if('Personal Return' == p.Guided_Selling_Identifier__c || 'Advisory'== p.Guided_Selling_Identifier__c || '1-800Accountant Access' == p.Guided_Selling_Identifier__c
                    || 'Loan Agreement' == p.Guided_Selling_Identifier__c || 'Business Return' == p.Guided_Selling_Identifier__c) {
                        defaultProducts.add(p);
                        if(null == stringDefaultProducts) {
                            stringDefaultProducts = p.Guided_Selling_Identifier__c;
                        } else {
                            stringDefaultProducts += ', ' + p.Guided_Selling_Identifier__c;
                        }
                    }

                    if(null != opportunity.Account.Entity_Tax_Classification__c) {
                        if('Non-Profit' != opportunity.Account.Entity_Tax_Classification__c) {
                            if('Business Return' == p.Guided_Selling_Identifier__c) {
                                if(!defaultProducts.contains(p)) {
                                    defaultProducts.add(p);
                                    if(null == stringDefaultProducts) {
                                        stringDefaultProducts = p.Guided_Selling_Identifier__c;
                                    } else {
                                        stringDefaultProducts += ', ' + p.Guided_Selling_Identifier__c;
                                    }
                                }
                            }
                        } else {
                            if('Non-Profit Tax Preparation' == p.Guided_Selling_Identifier__c) {
                                defaultProducts.add(p);
                                if(null == stringDefaultProducts) {
                                    stringDefaultProducts = p.Guided_Selling_Identifier__c;
                                } else {
                                    stringDefaultProducts += ', ' + p.Guided_Selling_Identifier__c;
                                }
                            }
                        }
                        if('S Corporation' == opportunity.Account.Entity_Tax_Classification__c) {
                            if('Payroll' == p.Guided_Selling_Identifier__c) {
                                defaultProducts.add(p);
                                if(null == stringDefaultProducts) {
                                    stringDefaultProducts = p.Guided_Selling_Identifier__c;
                                } else {
                                    stringDefaultProducts += ', ' + p.Guided_Selling_Identifier__c;
                                }
                            }
                        }
                    }
                    if(null != opportunity.Account.Website_Selling_Goods__c && true == opportunity.Account.Website_Selling_Goods__c) {
                        if('Sales & Use Tax' == p.Guided_Selling_Identifier__c) {
                            defaultProducts.add(p);
                            if(null == stringDefaultProducts) {
                                stringDefaultProducts = p.Guided_Selling_Identifier__c;
                            } else {
                                stringDefaultProducts += ', ' + p.Guided_Selling_Identifier__c;
                            }
                        }
                    }
                }
                        
                if('A La Carte' != p.Calculator_Location__c) {
                    frequentProducts.add(p);
                }

                if(p.Name.containsIgnoreCase('business')) {
                    businessProducts.add(p);
                }

                if(p.Name.containsIgnoreCase('personal')) {
                    personalProducts.add(p);
                }

                if(p.Name.containsIgnoreCase('payroll')) {
                    payrollProducts.add(p);
                }

                if(p.Name.containsIgnoreCase('bookkeeping') || p.Name.containsIgnoreCase('books')) {
                    bookkeepingProducts.add(p);
                }

                if(p.Name.containsIgnoreCase('entity') || p.Name.containsIgnoreCase('Corp State Filing Fee') || p.Name.containsIgnoreCase('LLC State Filing Fee')) {
                    entityFormationProducts.add(p);
                }
            }  
        }

        List<Product_Pricing_Rule__mdt> overrideRules = [
            SELECT Id, MasterLabel, Quote_Field2__c, Product_Name__c, Field_Value__c, Price_Adjustment__c, User_Field__c, Account_Field__c, Flat_Price_Override__c
            FROM Product_Pricing_Rule__mdt
            WHERE Product_Name__c IN :allProducts
            AND Flat_Price_Override__c = true
            AND Active__c = true
        ];

        Business__c b = [
                SELECT Id, Name, Account__c, Anticipated_Revenue__c, Industry__c, Business_Type__c, Number_of_Owners__c, Startup_Costs__c, Years_In_Business__c, 
                Foreign_State_of_Incorporation__c, State_of_Residence__c, Profit_Projection__c, Number_of_Contractors__c, Home_Office_Square_Feet__c,
                State_of_incorporation__c, Number_of_Foreign_Owners__c, Monthly_Bookkeeping_Transactions__c, Investor_Funding__c, Number_of_Employees__c, Tax_Filing_Status__c,
                W2_Income__c, Number_of_Rental_Properties__c, Number_of_K1_Investments__c, Yearly_Business_Miles__c, 
                Run_Payroll_Before__c, Has_Employees_Contractors__c, File_Return_Yourself__c, Has_Rental_Properties__c, Is_Working_From_Home__c, Commutes_With_Own_Vehicle__c, 
                E_Commerce__c, First_Business__c, Foreign_Income__c
                FROM Business__c 
                WHERE Account__r.Id = :opportunity.AccountId
            ];

        User u = [SELECT Id, Name, Skills_Sales__c, Sell_Client_Books__c FROM User WHERE Id = :opportunity.Account.Owner.Id];
        Account a = [SELECT Id, Lead_Type_New__c, Lead_Source__c FROM Account WHERE Id = :opportunity.AccountId];

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
                if(null == productToPrice.get(productIdToIdentifier.get(rule.Product_Name__c))) {
                    productToPrice.put(productIdToIdentifier.get(rule.Product_Name__c), rule.Price_Adjustment__c);
                    defaultPrices.put(productIdToIdentifier.get(rule.Product_Name__c), rule.Price_Adjustment__c);
                } else {
                    Decimal totalPrice = productToPrice.get(productIdToIdentifier.get(rule.Product_Name__c)) + rule.Price_Adjustment__c;
                    productToPrice.put(productIdToIdentifier.get(rule.Product_Name__c), totalPrice);
                    defaultPrices.put(productIdToIdentifier.get(rule.Product_Name__c), totalPrice);
                }
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
                        productToPrice.put(productIdToIdentifier.get(offerProductItem.Product__c), offerProductItem.Amount__c);
                        defaultPrices.put(productIdToIdentifier.get(offerProductItem.Product__c), offerProductItem.Amount__c);
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
                productToPrice.put(productIdToIdentifier.get(pb.Product2.Guided_Selling_Identifier__c), pb.UnitPrice);
                defaultPrices.put(productIdToIdentifier.get(pb.Product2.Guided_Selling_Identifier__c), pb.UnitPrice);
            }
        }

        ApexPages.currentPage().getParameters().put('rerender', 'dProds, fProds, frProds, bProds, pProds, payProds, bkkProds, eProds');
    }

    @RemoteAction
    public static String createUpdatePartner(String businessId, String contactId, String partnerData) {
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
                
                Account acc = [SELECT Id, Name, Account_Status__c, CreatedDate FROM Account WHERE Id = :checkForContacts[0].AccountId];
                
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
    public static String calculateSavingsGuidedSelling(String entityType, String profits, String startup, String mileage, String office, String filingStatus, String income, String industryType, String numForeignOwners, String accountId) {
        
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

        String result = String.valueOf(sCorpSavings) +','+ String.valueOf(officeSavings) +','+ String.valueOf(mileageSavings) +','+ String.valueOf(qbiSavings) +','+ String.valueOf(startupSavings) +','+ String.valueOf(finalSavings);
        
        return result;
    }

    public class businessWrapper {
        public String businessId { get;set; }
        public String businessOwnerId { get;set; }
    }

    @RemoteAction
    public static void dispositionEvent(String rId, String secdis, String primDis, String accId) {

        Event event = new Event();

        if(Test.isRunningTest()) {
            event = [
                SELECT Id, StartDateTime, Appointment_Disposition__c, Secondary_Disposition_Details__c 
                FROM Event 
                WHERE Type_of_Appointment__c = 'Tax Savings Analysis' 
                AND (WhoId =:rId OR WhatId =:rId OR Id =:rId) 
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
                WHERE Type_of_Appointment__c = 'Tax Savings Analysis' 
                AND (WhoId =:rId OR WhatId =:rId OR Id =:rId) 
                AND (Account__c =:accId) 
                AND StartDateTime = TODAY
            ];
        }

        event.Appointment_Disposition__c = primDis;
        event.Secondary_Disposition_Details__c = secdis;

        update event;
    }
    
    @RemoteAction
    public static void sentEmail(String oppId) {
               
        update new Opportunity(
            Id = oppId,
            StageName = 'Quote Sent'
        );
    }

    @RemoteAction
    public static String isOpportunityPaid(String oppId) {
               
        Opportunity opp = [SELECT Id, StageName FROM Opportunity WHERE Id =:oppId];
        return opp.StageName;
    }

    @RemoteAction
    public static void saveAnswers(String answers, String businessId, String accId, String environment) {

        Map<String,String> answersMap = new Map<String,String>();
        List<String> answersList = new List<String>();
        List<String> answersSplitList = new List<String>();

        if(!String.isBlank(answers)) {
            answersList = answers.split('///');
        }

        if(!answersList.isEmpty()) {
            for(String s : answersList) {
                answersSplitList = s.split('\\?');
                if(!answersSplitList.isEmpty()) {
                    answersMap.put(answersSplitList[0], answersSplitList[1]);
                }
            }
        }

        if(!answersMap.isEmpty()) {
            Business__c bus = new Business__c(Id = businessId);
            bus.First_Business__c = (answersMap.get('Is this your first business') == 'Yes') ? true : false;
            bus.Years_In_Business__c = answersMap.get('How many years have you been in business');
            bus.Business_Type__c = answersMap.get('What entity type is your business');
            bus.Industry__c = answersMap.get('What industry is your business in');
            bus.State_of_incorporation__c = answersMap.get('What is your state of incorporation');
            bus.Foreign_State_of_Incorporation__c = answersMap.get('What is your foreign state of incorporation');
            bus.State_of_Residence__c = answersMap.get('What is your state of residence');
            bus.Startup_Costs__c = answersMap.get('How much have you invested so far in start-up costs');
            bus.Anticipated_Revenue__c = answersMap.get('What do you anticipate your revenue to be over the next 12 months');
            bus.Profit_Projection__c = answersMap.get('What do you project your 1st year profit to be over the next 12 months');
            bus.Investor_Funding__c = answersMap.get('What is your total investor funding');
            bus.Monthly_Bookkeeping_Transactions__c = answersMap.get('How many monthly bookkeeping transactions do you have');
            bus.Number_of_Owners__c = answersMap.get('How many owners does your business have');
            bus.Number_of_Foreign_Owners__c = answersMap.get('How many owners are outside the USA');
            bus.Run_Payroll_Before__c = (answersMap.get('Have you run payroll before') == 'Yes') ? true : false;
            bus.Has_Employees_Contractors__c = (answersMap.get('Do you currently have any employees or contractors') == 'Yes') ? true : false;
            bus.Number_of_Employees__c = String.valueOf(answersMap.get('How many employees do you have'));
            bus.Number_of_Contractors__c = answersMap.get('How many contractors do you have');
            bus.Tax_Filing_Status__c = answersMap.get('What is your tax filing status');
            bus.W2_Income__c = answersMap.get('What was your household W-2 income last year');
            bus.Foreign_Income__c = (answersMap.get('Do you have any foreign sourced income') == 'Yes') ? true : false;
            bus.Has_Rental_Properties__c = (answersMap.get('Do you currently have any rental properties') == 'Yes') ? true : false;
            bus.Number_of_Rental_Properties__c = answersMap.get('How many rental properties do you have');
            bus.Number_of_K1_Investments__c = answersMap.get('How many K-1s are from other investments');
            bus.Is_Working_From_Home__c = (answersMap.get('Will you be working from home') == 'Yes') ? true : false;
            bus.Home_Office_Square_Feet__c = Decimal.valueOf(answersMap.get('What is the approximate square footage of your home office'));
            bus.Commutes_With_Own_Vehicle__c = (answersMap.get('Will you use your personal vehicle for business purposes') == 'Yes') ? true : false;
            bus.Yearly_Business_Miles__c = answersMap.get('How many business-related miles do you estimate you’ll drive per year');
            bus.E_Commerce__c = (answersMap.get('Will your business have a web or e-commerce presence') == 'Yes') ? true : false;

            update bus;

            Account acc = new Account(Id = accId);
            acc.State_of_Formation__c = answersMap.get('What is your state of incorporation');
            acc.Entity_Tax_Classification__c = answersMap.get('What entity type is your business');
            acc.Industry = answersMap.get('What industry is your business in');
            //acc.Total_Startup_Costs__c = answersMap.get('How much have you invested so far in start-up costs');
            acc.Expected_1st_year_revenue__c = answersMap.get('What do you anticipate your revenue to be over the next 12 months');
            acc.Current_Year_Profit_Projection__c = answersMap.get('What do you project your 1st year profit to be over the next 12 months');
            //acc.NumberOfEmployees = Integer.valueOf(answersMap.get('How many employees do you have'));
            //acc.Number_of_Contractors__c = Integer.valueOf(answersMap.get('How many contractors do you have'));
            acc.Number_of_owners__c = answersMap.get('How many owners does your business have');
            acc.Personal_Income__c = answersMap.get('What was your household W-2 income last year');
            //acc.Rental_Properties__c = Integer.valueOf(answersMap.get('How many rental properties do you have'));
            acc.Personal_Return_Filing_Status__c = answersMap.get('What is your tax filing status');
            acc.Home_Office_Square_Feet__c = answersMap.get('What is the approximate square footage of your home office');
            acc.Estimated_Business_Mileage__c = answersMap.get('How many business-related miles do you estimate you’ll drive per year');
            acc.Foreign_State__c = answersMap.get('What is your foreign state of incorporation');
            acc.Years_in_Business__c = answersMap.get('How many years have you been in business');
            acc.State_of_Residence__c = answersMap.get('What is your state of residence');
            acc.Trans_Per_Month__c = answersMap.get('How many monthly bookkeeping transactions do you have');
            acc.How_much_funding__c = answersMap.get('What is your total investor funding');
            acc.Worked_With_CPA_Accountant__c = (answersMap.get('Is this your first business') == 'Yes') ? true : false;
            acc.Website_Selling_Goods__c = (answersMap.get('Will your business have a web or e-commerce presence') == 'Yes') ? true : false;
            acc.Foreign_Income__c = (answersMap.get('Do you have any foreign sourced income') == 'Yes') ? true : false;

            if(environment != 'Entity Formation') {
                String value = answersMap.get('How many employees do you have');
                String numEmpl = value.replace('+', '');
                acc.Total_Startup_Costs__c = answersMap.get('How much have you invested so far in start-up costs');
                acc.Number_of_Contractors__c = Integer.valueOf(answersMap.get('How many contractors do you have'));
                acc.NumberOfEmployees = Integer.valueOf(numEmpl);
                acc.Rental_Properties__c = Integer.valueOf(answersMap.get('How many rental properties do you have'));
            }

            update acc;
            
        }
    }

    @RemoteAction
    public static void saveNote(String accId, String title, String note) {
        
        Contact con = [SELECT Id, Description FROM Contact WHERE Id =:accId];
        String d = con.Description;
        if(d == null || d == '') {
            con.Description = title + ': ' + note;
        } else {
            con.Description = d + '\n' + title + ': ' + note;
        }
        update con;
    }

    @RemoteAction
    public static void saveClientInfo(String infoType, String businessId, String businessOwnerId, String accId, String email, String phone, String address, String city, String state, String zip, String country) {
        Boolean needBusUpdate = false;
        Boolean needAccUpdate = false;
        Boolean needConUpdate = false;
        Business_Owner__c busOwner = new Business_Owner__c(Id = businessOwnerId);
        Business__c bus = new Business__c(Id = businessId);
        Account acc = [SELECT Id, Primary_Contact__c, BillingState, BillingCountry, BillingStreet, BillingPostalCode, BillingCity FROM Account WHERE Id = :accId];
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
                Foreign_State_of_Incorporation__c, State_of_Residence__c, Profit_Projection__c, Number_of_Contractors__c, Home_Office_Square_Feet__c,
                State_of_incorporation__c, Number_of_Foreign_Owners__c, Monthly_Bookkeeping_Transactions__c, Investor_Funding__c, Number_of_Employees__c, Tax_Filing_Status__c,
                W2_Income__c, Number_of_Rental_Properties__c, Number_of_K1_Investments__c, Yearly_Business_Miles__c, 
                Run_Payroll_Before__c, Has_Employees_Contractors__c, File_Return_Yourself__c, Has_Rental_Properties__c, Is_Working_From_Home__c, Commutes_With_Own_Vehicle__c, 
                E_Commerce__c, First_Business__c, Foreign_Income__c
                FROM Business__c 
                WHERE Account__r.Id = :accId
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

    @RemoteAction
    public static String doSubmit(String environment, String listProdSelected, String oppId, String accId, String billingTime, String delProds) {
        
        // Initialize class variables

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

        // Get data for each selected product
        
        List<String> prodSelectedList = listProdSelected.split(',');
        List<SelectedProduct> prodSelecDataList = new List<SelectedProduct>();
        Set<String> prodSelecDataSet = new Set<String>();
        Set<String> prodsIds = new Set<String>();
        
        for(String prod : prodSelectedList) {
            String pro = prod.replace('[', '');
            String p = pro.replace(']', '');
            prodSelecDataSet.add(p);
        }

        List<String> deletedProdsList = delProds.split(',');
        Set<String> deletedProdsSet = new Set<String>();
        
        for(String dp : deletedProdsList) {
            String pro = dp.replace('[', '');
            String pr = pro.replace(']', '');
            String p = pr.replace(' ', '');
            deletedProdsSet.add(p);
        }

        for(String prod : prodSelecDataSet) {
            List<String> dataProdList = prod.split('//');
            SelectedProduct p = new SelectedProduct();
            String oldId = dataProdList[0];
            String newId = oldId.replace(' ', '');

            if(deletedProdsSet.size() > 0) {
                if(!deletedProdsSet.contains(newId)) { 
                    p.id = newId;
                    p.billing = dataProdList[1];
                    p.quantity = dataProdList[2];
                    p.price = dataProdList[3];
                    p.freqPrice = dataProdList[4];
                    p.subtotal = dataProdList[5];
                    
                    prodSelecDataList.add(p);
                }
            } else {
                p.id = newId;
                p.billing = dataProdList[1];
                p.quantity = dataProdList[2];
                p.price = dataProdList[3];
                p.freqPrice = dataProdList[4];
                p.subtotal = dataProdList[5];
                
                prodSelecDataList.add(p);
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
                    if(prodData.Name == 'Entity Formation') {
                        entityFormation = true;
                    }
                    if(prodData.Name == 'ClientBooks') {
                        clientBooks = true;
                    }
                    if(prodData.Calculator_Location__c == 'Advisory') {
                        advisory = true;
                    }
                    if(prodData.Name == 'Bookkeeping Advisory') {
                        bookkAdv = true;
                    }
                    if(prodData.Calculator_Location__c == 'Bookkeeping') {
                        bookk = true;
                    }
                    if(prodData.Calculator_Location__c == 'Payroll') {
                        payroll = true;
                    }
                    if(prodData.Name == 'Back Bookkeeping') {
                        backBookk = true;
                    }
                    if(prodData.Name == 'Personal Tax Advisory') {
                        persTaxAdv = true;
                    }
                    if(prodData.Name == 'Personal Tax Preparation') {
                        persTaxPrep = true;
                    }
                    if (prodData.Calculator_Location__c == 'Business Return') {
                        busiRet = true;
                        businessTax = Decimal.valueOf(prodSelec.price);
                    }
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

            for(Product_Offer__mdt offerProductItem : offerList) {
                if(offerProductItem.Product__c == prodSelec.sellingIdentifier) {
                    prodSelec.isInOffer = true;
                    prodSelec.delayDays = offerProductItem.Delay_Days__c;
                } else {
                    prodSelec.isInOffer = false;
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

        Opportunity opp = [SELECT Id, StageName, OwnerId, Email_Campaign_ID__c FROM Opportunity WHERE Id = :oppId];
        emailCampId = opp.Email_Campaign_ID__c;

        // Missing fields from original query: Name, Account__c, Has_Employees_Contractors__c, File_Return_Yourself__c, Has_Rental_Properties__c, Is_Working_From_Home__c, 
        // Commutes_With_Own_Vehicle__c, First_Business__c, 
        Business__c business = [
                SELECT Id, Business_Type__c, Number_of_Foreign_Owners__c, Industry__c, Foreign_Income__c, Number_of_Contractors__c, Number_of_Employees__c, 
                Number_of_K1_Investments__c, Number_of_Owners__c, Monthly_Bookkeeping_Transactions__c, Number_of_Rental_Properties__c, W2_Income__c, Profit_Projection__c, 
                Anticipated_Revenue__c, State_of_incorporation__c, Investor_Funding__c, Startup_Costs__c, E_Commerce__c, Run_Payroll_Before__c, Tax_Filing_Status__c, 
                Yearly_Business_Miles__c, Home_Office_Square_Feet__c, Foreign_State_of_Incorporation__c, Years_In_Business__c, State_of_Residence__c
                FROM Business__c 
                WHERE Account__r.Id = :accId];

        String livingAbroad = 'No';
        if (business.Foreign_Income__c == true) {
            livingAbroad = 'Yes';
        }

        String E_Commerce = 'No';
        if (business.E_Commerce__c == true) {
            E_Commerce = 'Yes';
        }

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
        
        String schedulerURL = sURL + '?TID=' + apptType + '	&WID=' + contactId + '&EmailCampaignID=' + emailCampId;
        String schedulerVIPURL = '';

        String schedulerURLReturn = sURL + ',' + apptType + ',' + contactId + ',' + emailCampId;
        String schedulerVIPURLReturn = '';
        
        if (apptType == 'Discovery') {
            schedulerVIPURL = sURL + '?TID=DiscoveryVIP' + '&WID=' + contactId + '&EmailCampaignID=' + emailCampId;
            schedulerVIPURLReturn = sURL + ',VIP,' + contactId + ',' + emailCampId;
        }
        
        if (advisory == true || busiRet == true || persRet == true || payroll == true || bookk == true || brand == 'EzBizFile') {
            doSomeSchedule = true;
        }
 
        if (doSomeSchedule == false) {
            schedulerURL = '';
            schedulerVIPURL = '';
        }
        
        // update opportunity
        
        update new Opportunity(
            Id = oppId,
            Pricebook2Id = standardPriceBookID,
            Customized_Bundle__c = false,
            Name_of_Offer_Package__c = packageName,
            Brand__c = brand,
            Email_Campaign_ID__c = emailCampId
        );

        // update of the quote: main difference with GuidedSellingControllerExtension

        List<Quote> quoteList = [SELECT Id FROM Quote WHERE OpportunityId = :oppId];
        System.debug('quoteList: '+quoteList);
        if(quoteList.size() > 0) {
            update new Quote(
                Id = quoteList[0].Id,
                Name = acc.Name + ' Quote',
                OpportunityId = oppId,
                Pricebook2Id = standardPriceBookID,
                Calc_Entity_Type__c = business.Business_Type__c,
                Calc_Foreign_Owners__c = business.Number_of_Foreign_Owners__c,
                Calc_Industry_Type__c = business.Industry__c,
                Calc_Living_Abroad__c = livingAbroad,
                Calc_Number_of_Contractors__c = business.Number_of_Contractors__c,
                Calc_Number_of_Employees__c = business.Number_of_Employees__c,
                Calc_Number_of_K1s__c = business.Number_of_K1_Investments__c,
                Calc_Number_of_Owners__c = business.Number_of_Owners__c,
                Calc_Number_of_Transactions__c = business.Monthly_Bookkeeping_Transactions__c,
                Calc_Number_of_Rental_Properties__c = business.Number_of_Rental_Properties__c,
                Calc_Personal_Income__c = business.W2_Income__c,
                Calc_Projected_1st_Year_Profit__c = business.Profit_Projection__c,
                Calc_Projected_1st_Year_Revenue__c = business.Anticipated_Revenue__c,
                Calc_State_of_Incorporation__c = business.State_of_incorporation__c,
                Calc_Total_Investor_Funding__c = business.Investor_Funding__c,
                Calc_Total_Startup_Cost__c = business.Startup_Costs__c,
                Calc_Website_Selling_Goods__c = E_Commerce,
                //Calc_Worked_with_Accountant__c = business.workedWithAccountantInPastInput,
                Calc_Run_Payroll_Before__c = runPayrollBefore,
                Calc_Filing_Status__c = business.Tax_Filing_Status__c,
                Calc_Business_Miles__c = business.Yearly_Business_Miles__c,
                Calc_Office_Square_Footage__c = String.valueOf(business.Home_Office_Square_Feet__c),
                Calc_Foreign_State__c = business.Foreign_State_of_Incorporation__c,
                Calc_Years_in_Business__c = business.Years_In_Business__c,
                Calc_State_of_Residence__c = business.State_of_Residence__c,
                billingSchedule__c = billingTime,
                Bundle__c = 'None',
                Calc_Savings_Amount__c = String.valueOf(acc.Potential_Total_Savings__c)
            );

            quoteID = quoteList[0].Id;
            
            // deletion of all the records just right before the creation of the new ones

            List<QuoteLineItem> oldQLI = [SELECT Id FROM QuoteLineItem WHERE QuoteId =:quoteID];
            delete oldQLI;
            
            List<OpportunityLineItem> oldOLI = [SELECT Id FROM OpportunityLineItem WHERE OpportunityId =:oppId];
            delete oldOLI;
            
            List<ChargeOver_Quote__c> oldCOQ = [SELECT Id FROM ChargeOver_Quote__c WHERE Quote__c =:quoteID];

            for(ChargeOver_Quote__c cOQItem : oldCOQ) {
                List<ChargeOver_Quote_Line_Item__c> oldCOQLI = [SELECT Id FROM ChargeOver_Quote_Line_Item__c WHERE ChargeOver_Quote__c =:cOQItem.Id];
                delete oldCOQLI;
            }
            
            delete oldCOQ;
            
            sleep(3000);      
        } else {
            
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

        createLineItems(prodSelecDataList, billingTime, oppId, quoteID, accId, coQuoteMonthId, coQuoteOneTimeId, coQuoteAnnualId);
        
        sleep(3000);

        if(schedulerVIPURL != '' && vipAmount > 4999) {
            theCOQuoteMonth.Scheduler_URL__c = schedulerVIPURL;
            theCOQuoteOneTime.Scheduler_URL__c = schedulerVIPURL;
            theCOQuote.Scheduler_URL__c = schedulerVIPURL;
        }

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


        if(schedulerVIPURL != '' && vipAmount > 4999) {
            return schedulerVIPURLReturn;
        } else {
            return schedulerURLReturn;
        }
    }

    //Decimal productPassAdjustment, List<SelectedProduct> prodSelectedList, String calcIdPass, String bundlePass, String productDescription, String opportunityIdPass, String pricebookEntryIdPass, String productIdPass, Integer quantityPass, String timePass, String timeDefPass, String billingTimePass, String quoteIdPass, String coQuoteIdPass, String coQuoteIdMonthPass, String coQuoteIdOneTimePass, String sowDescPass, String sowDescPassHTML, String accountIdPass, Decimal sortOrderPass, Boolean doFeePass, Decimal feeAmountPass, String feeDesc, Boolean oneTimePass, Boolean noSplitPass)
    public static void createLineItems(List<SelectedProduct> prodOriginalList, String billingFinance, String oppId, String qId, String accId, String coMonthQuoteId, String coOneTimeQuoteId, String coAnnualQuoteId) {
        
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

                if(oppId != null && String.valueOf(oppId) != '') {
                     oli = new OpportunityLineItem(
                        Description = p.name,
                        OpportunityId = Id.valueOf(oppId),
                        PricebookEntryId = Id.valueOf(p.pbeId),
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
                    ChargeOver_Quote_Line_Item__c coli = new ChargeOver_Quote_Line_Item__c(
                        ChargeOver_Quote__c = Id.valueOf(coMonthQuoteId),
                        Product__c = Id.valueOf(p.id),
                        Price_Per_Unit__c = tmpACPrice,
                        Quantity__c = Integer.valueOf(p.quantity),
                        Contract_Amount__c = subTotalAmount,
                        Product_Description__c = p.description,
                        HTML_Description__c = p.HTMLdescription,
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
            } else {
                if(p.billing == 'One-Time' && p.noSplitAllowed == true) {
                    subAmount = subAmount.setScale(2, RoundingMode.HALF_UP);
                    tmpACPrice = tmpACPrice.setScale(2, RoundingMode.HALF_UP);
                    subTotalAmount = subTotalAmount.setScale(2, RoundingMode.HALF_UP);

                    OpportunityLineItem oli;

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
                        ChargeOver_Quote_Line_Item__c coli = new ChargeOver_Quote_Line_Item__c(
                            ChargeOver_Quote__c = Id.valueOf(coOneTimeQuoteId),
                            Product__c = Id.valueOf(p.id),
                            Price_Per_Unit__c = tmpACPrice,
                            Quantity__c = Integer.valueOf(p.quantity),
                            Contract_Amount__c = subTotalAmount,
                            Product_Description__c = p.description,
                            HTML_Description__c = p.HTMLdescription,
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
                        financeAmount = (tmpACPrice / 2);
                        subAmount = (tmpACPrice / 2) * Integer.valueOf(p.quantity);
                        OLIPayInstall = '2-Pay';
                    } else if (billingFinance == '3pay') {
                        financeAmount = (tmpACPrice / 3);
                        subAmount = (tmpACPrice / 3) * Integer.valueOf(p.quantity);
                        OLIPayInstall = '3-Pay';
                    } else if (billingFinance == '4pay') {
                        financeAmount = (tmpACPrice / 4);
                        subAmount = (tmpACPrice / 4) * Integer.valueOf(p.quantity);
                        OLIPayInstall = '4-Pay';
                    } else if (billingFinance == '6pay') {
                        financeAmount = (tmpACPrice / 6);
                        subAmount = (tmpACPrice / 6) * Integer.valueOf(p.quantity);
                        OLIPayInstall = '6-Pay';
                    } else {
                        financeAmount = (tmpACPrice / 12) * 1.2;
                        subAmount = ((tmpACPrice / 12) * 1.2) * Integer.valueOf(p.quantity);
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
                        if(coOneTimeQuoteId != null && coOneTimeQuoteId != '') {
                            coli = new ChargeOver_Quote_Line_Item__c(
                                ChargeOver_Quote__c = Id.valueOf(coOneTimeQuoteId),
                                Product__c = Id.valueOf(p.id),
                                Price_Per_Unit__c = tmpACPrice,
                                Quantity__c = Integer.valueOf(p.quantity),
                                Contract_Amount__c = subTotalAmount,
                                Product_Description__c = p.description,
                                HTML_Description__c = p.HTMLdescription,
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
                            coli = new ChargeOver_Quote_Line_Item__c(
                                ChargeOver_Quote__c = Id.valueOf(coAnnualQuoteId),
                                Product__c = Id.valueOf(p.id),
                                Price_Per_Unit__c = tmpACPrice,
                                Quantity__c = Integer.valueOf(p.quantity),
                                Contract_Amount__c = subTotalAmount,
                                Product_Description__c = p.description,
                                HTML_Description__c = p.HTMLdescription,
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