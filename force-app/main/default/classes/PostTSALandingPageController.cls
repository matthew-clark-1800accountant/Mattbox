public class PostTSALandingPageController {
    //Variables used for display purposes
    public Boolean isMobile {get; set;}
    public Boolean pageHasEvent {get; set;}
    public Boolean pageHasOpportunity {get; set;}

    public Boolean eventHasOpportunity {get; set;}
    public List<Integer> productsPastSix {get; set;}
    public Integer numberOfProducts {get; set;}
    public String whatBoxClass {get; set;}
    public String schedulerURL {get; set;}
    public String fullServiceSchedulerURL {get; set;}

    //The main Opportunity & Product Names
    public Opportunity opportunity {get; set;}
    public List<String> productNames {get; set;}
    //Savings currency variables
    public Decimal potentialSavings {get; set;}
    public Decimal sSavings {get; set;}
    public Decimal homeOfficeSavings {get; set;}
    public Decimal businessMileageSavings {get; set;}
    public Decimal qbiSavings {get; set;}
    public Decimal startupSavings {get; set;}
    //Account information variables
    public Decimal totalStartupCosts {get; set;}
    public Decimal projectedRevenue {get; set;}
    public Decimal projectedProfit {get; set;}
    public Decimal personalIncome {get; set;}
    public Decimal homeOfficeSqFt {get; set;}
    public Decimal businessMileage {get; set;}

    public String firstName {get; set;}



    public PostTSALandingPageController(ApexPages.StandardController stdController) {
        isMobile = (UserInfo.getUiTheme() == 'Theme4t') ? true : false;
        System.debug(isMobile);
        System.debug(ApexPages.currentPage().getParameters());
        // Get the Event Id from the Page Parameters
        Id eventId = ApexPages.currentPage().getParameters().get('id');
        Id oppId = ApexPages.currentPage().getParameters().get('o');
        System.debug(oppId);

        pageHasEvent = (null != eventId && eventId.getSObjectType().getDescribe().getName() == 'Event') ? true : false;
        pageHasOpportunity = (null != oppId && oppId.getSObjectType().getDescribe().getName() == 'Opportunity') ? true : false;
        System.debug(pageHasOpportunity);
        System.debug(pageHasEvent);



        //If we have an Event Id, go ahead and query for it
        if(pageHasEvent || pageHasOpportunity){
            if(pageHasEvent){
                Event event = [
                    SELECT Id, WhatId
                    FROM Event
                    WHERE Id = :eventId
                ];
                //We are only working with Events related to Opportunities
                eventHasOpportunity = (null != event.WhatId && event.WhatId.getSObjectType().getDescribe().getName() == 'Opportunity') ? true : false;
                if(eventHasOpportunity){
                    oppId = event.WhatId;
                }
            }
            if(null != eventHasOpportunity || pageHasOpportunity){
                
                //Gather fields to display
                opportunity = [
                    SELECT Id, Name, Amount, ChargeOver_Quote_URL__c, Account.Name, AccountId, Account.Potential_Total_Savings__c, 
                    Account.Potential_SCorp_Savings__c, Account.Potential_QBI_Savings__c, Account.Potential_Business_Mile_Savings__c, 
                    Account.Potential_Startup_Savings__c, Account.Industry, Account.Total_Startup_Costs__c, Account.Expected_1st_year_revenue__c,
                    Account.Potential_Home_Office_Savings__c, Account.Personal_Income__c, Account.Current_Year_Profit_Projection__c, 
                    Account.Personal_Return_Filing_Status__c, Account.Expected_Number_of_Employees__c, Account.Number_of_owners__c, 
                    Account.Estimated_Business_Mileage__c, Account.Home_Office_Square_Feet__c, Owner.Name, Account.Primary_Contact__r.FirstName
                    FROM Opportunity
                    WHERE Id =:oppId
                ];
                //And the products
                List<OpportunityLineItem> getProductNames = ([
                    SELECT Id, Name, Product2.Name
                    FROM OpportunityLineItem
                    WHERE OpportunityId = :oppId
                ]);

                for(OpportunityLineItem junction : getProductNames){
                    if(null == numberOfProducts){
                        numberOfProducts = 0;
                    }
                    //Count the number of products for display purposes
                    numberOfProducts ++;
                    if(numberOfProducts > 6){
                        if(null == productsPastSix){
                            productsPastSix = new List<Integer>();
                        }
                        //Add the products past 6 that there are because the full coverage box holds 6
                        productsPastSix.add(numberOfProducts);
                    }
                    if(null == productNames){
                        productNames = new List<String>();
                    }
                    //Add the product names to display
                    productNames.add(junction.Product2.Name);
                }

                //Make the URL for the scheduler from the primary contact id
                List<AccountContactRelation> accountContact = new List<AccountContactRelation>([
                    SELECT Id, AccountId, ContactId, IsDirect
                    FROM AccountContactRelation
                    WHERE AccountId = :opportunity.AccountId
                    AND IsDirect = true
                ]);
                //There should only be one primary contact per account
                schedulerURL = (null != accountContact[0]) ? 'https://1800accountant.com/sfapi/schedule/index.php?WID='+accountContact[0].ContactId+'&TID=1on1&EmailCampaignID=PostTSAPage1' : '';
                fullServiceSchedulerURL = (null != accountContact[0]) ? 'https://1800accountant.com/sfapi/schedule/index.php?WID='+accountContact[0].ContactId+'&TID=1on1FC&EmailCampaignID=PostTSAPageCustom' : '';
                whatBoxClass = (opportunity.Amount < 3999 && pageHasEvent) ? 'whiteMainBox' : 'centerBox';
                firstName = opportunity.Account.Primary_Contact__r.FirstName;


                if(pageHasEvent){
                    /* These currency variables are coming in a variety of ways - some as strings, picklist fields with currency formatting and others without so to try and 
                    simplify the process, I am converting all currency variables to decimals stripped of $ and commas so that the formatting can be done on the front end appropriately */
                    
                    //Savings numbers
                    potentialSavings = (null != opportunity.Account.Potential_Total_Savings__c) ? currencyStringToDecimal(opportunity.Account.Potential_Total_Savings__c) : 0;
                    sSavings = (null != opportunity.Account.Potential_SCorp_Savings__c) ? currencyStringToDecimal(opportunity.Account.Potential_SCorp_Savings__c) : 0;
                    homeOfficeSavings = (null != opportunity.Account.Potential_Home_Office_Savings__c) ? currencyStringToDecimal(opportunity.Account.Potential_Home_Office_Savings__c) : 0;
                    businessMileageSavings = (null != opportunity.Account.Potential_Business_Mile_Savings__c) ? currencyStringToDecimal(opportunity.Account.Potential_Business_Mile_Savings__c) : 0;
                    qbiSavings = (null != opportunity.Account.Potential_QBI_Savings__c) ? currencyStringToDecimal(opportunity.Account.Potential_QBI_Savings__c) : 0;
                    startupSavings = (null != opportunity.Account.Potential_Startup_Savings__c) ? currencyStringToDecimal(opportunity.Account.Potential_Startup_Savings__c) : 0;

                    //Account Information
                    totalStartupCosts = (null != opportunity.Account.Total_Startup_Costs__c) ? currencyStringToDecimal(opportunity.Account.Total_Startup_Costs__c) : 0;
                    projectedProfit = (null != opportunity.Account.Current_Year_Profit_Projection__c) ? currencyStringToDecimal(opportunity.Account.Current_Year_Profit_Projection__c) : 0;
                    personalIncome = (null != opportunity.Account.Personal_Income__c) ? currencyStringToDecimal(opportunity.Account.Personal_Income__c) : 0;
                    homeOfficeSqFt = (null != opportunity.Account.Home_Office_Square_Feet__c && '--' != opportunity.Account.Home_Office_Square_Feet__c) ? currencyStringToDecimal(opportunity.Account.Home_Office_Square_Feet__c) : 0;
                    businessMileage = (null != opportunity.Account.Estimated_Business_Mileage__c && '--' != opportunity.Account.Estimated_Business_Mileage__c) ? currencyStringToDecimal(opportunity.Account.Estimated_Business_Mileage__c) : 0;
                    //CSS display for showing only the personalized plan and showing both
                    //Had to add some custom field mapping for Expected_1st_year_revenue__c on Account because the scheduler was still using ranges 
                    projectedRevenue = 0;
                    if(null != opportunity.Account.Expected_1st_year_revenue__c){
                        switch on opportunity.Account.Expected_1st_year_revenue__c {
                            when '0 - $10,000' {
                                projectedRevenue = 10000;
                            }
                            when '$10,000 - $50,000' {
                                projectedRevenue = 50000;
                            }
                            when '$50,000 - $100,000' {
                                projectedRevenue = 100000;
                            }
                            when '$100,000+' {
                                projectedRevenue = 100000;
                            }
                            when '> $100,000' {
                                projectedRevenue = 100000;
                            }
                            when else {
                                projectedRevenue = currencyStringToDecimal(opportunity.Account.Expected_1st_year_revenue__c);
                            }
                        }
                    }
                }
            }
        }
    }

    public boolean displayPopup {get; set;}     
    
    public void closePopup() {        
        displayPopup = false;    
    }     
    public void showPopup() {        
        displayPopup = true;    
    }

    public static Decimal currencyStringToDecimal(String currencyString) {
        String editedString = currencyString.removeStart('$').replace(',', '');

        return Decimal.valueOf(editedString);
    }
}