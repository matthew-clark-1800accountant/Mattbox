public class MyCustomPageController {
     
    //Quote object
    zqu__Quote__c thisQuote {get; set;}
    
    public Boolean achoverride {get;set;}
    
    //Page Constructor
    public MyCustomPageController(ApexPages.StandardController StandardController) {
        thisQuote = (zqu__Quote__c)StandardController.getRecord();
        
        if (thisQuote.zqu__PaymentMethod__c == 'ACH') {
            achoverride = true;
        } else {
            achoverride = false;
        }
 
    }
     
    //Global method to retrieve back button text
    public String BackButtonText {
        get {
            if(BackButtonText == null) BackButtonText = zqu.QuoteWizardManager.getBackButtonText();
            return BackButtonText;
        }
        private set;
    }
 
    //Global method to retrieve next button text
    public String NextButtonText {
        get {
            if(NextButtonText == null) NextButtonText = zqu.QuoteWizardManager.getNextButtonText();
            return NextButtonText;
        }
        private set;
    }
 
    //Navigation methods
    public PageReference navigateNext() {
        upsert thisQuote;
        Map<String, String> customUrlParameters = new Map<String, String>{'Id' => thisQuote.Id};
        return zqu.QuoteWizardManager.navigateNext(customUrlParameters);
    }
 
    public PageReference navigateBack() {
        upsert thisQuote;
        Map<String, String> customUrlParameters = new Map<String, String>{'Id' => thisQuote.Id};
        return zqu.QuoteWizardManager.navigateBack(customUrlParameters);
    }
 
    //If the user clicks cancel, use global method to delete all quote information and navigate back to the Opportunity page
    public PageReference cancel() {
        String accIdValue = ApexPages.currentPage().getParameters().get('crmAccountId');
        return zqu.QuoteWizardManager.cancel('/' + accIdValue);
    }
 
}