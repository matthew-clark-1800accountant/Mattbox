public class PreTSAControllerExtension {
    //Default picklist values
    public String defaultEntity {get; set;}
    public String defaultProfits {get; set;}
    public String defaultStartup {get; set;}
    public String defaultMileage {get; set;}
    public String defaultOffice {get; set;}
    public String defaultFilingStatus {get; set;}
    public String defaultIncome {get; set;}

    public String schedulerURL {get; set;}
    public static List<String> disqualifiers = new List<String>{'C Corporation', 'Non-Profit'};
    public Boolean disableFields {get; set;}

    public string getBaseUrl(){
        if(System.DomainParser.parse(URL.getOrgDomainUrl()).getSandboxName() == null){
            return 'https://1800accountant.com';
        } else {
            return 'https://staging.1800accountant.com';
        }
    }

    public PreTSAControllerExtension(ApexPages.StandardController stdController) {
        //Before doing anything, I am going to set the default values for the page
        defaultEntity = 'LLC';
        defaultProfits = '50000';
        defaultStartup = '5000';
        defaultMileage = '15000';
        defaultOffice = '150';
        defaultFilingStatus = 'Single';
        defaultIncome = '50000';
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
            defaultProfits = (lead.Estimated_First_Year_Profits__c != null) ? lead.Estimated_First_Year_Profits__c : '50000';
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
            defaultProfits = (account.Current_Year_Profit_Projection__c != null) ? account.Current_Year_Profit_Projection__c : '50000';
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
    //For the popup
    public void hideSectionOnChange()
    {
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
}