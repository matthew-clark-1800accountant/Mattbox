/*    Copyright (c) 2014 Zuora, Inc.
 *
 *   Permission is hereby granted, free of charge, to any person obtaining a copy of 
 *   this software and associated documentation files (the "Software"), to use copy, 
 *   modify, merge, publish the Software and to distribute, and sublicense copies of 
 *   the Software, provided no fee is charged for the Software.  In addition the
 *   rights specified above are conditioned upon the following:
 *
 *   The above copyright notice and this permission notice shall be included in all
 *   copies or substantial portions of the Software.
 *
 *   Zuora, Inc. or any other trademarks of Zuora, Inc.  may not be used to endorse
 *   or promote products derived from this Software without specific prior written
 *   permission from Zuora, Inc.
 *
 *   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *   FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
 *   ZUORA, INC. BE LIABLE FOR ANY DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES
 *   (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *   LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 *   ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.  
 *
 *   IN THE EVENT YOU ARE AN EXISTING ZUORA CUSTOMER, USE OF THIS SOFTWARE IS GOVERNED
 *
 *   BY THIS AGREEMENT AND NOT YOUR MASTER SUBSCRIPTION AGREEMENT WITH ZUORA.
 */
public class Z_PaymentMethodCaptureController {

    //String used for debug messaging
    private final String DEBUG_STR = 'Z_PaymentMethodCaptureController: '; 
 
    //Error messages 
    //These have been converted to custom labels
    //private final String CONFIGURATION_ERROR_MESSAGE = 'A configuration error has occurred. Please contact customer support to resolve.';
    //private final String CUSTOMER_LOOKUP_ERROR_MESSAGE = 'An error occurred retrieving the customer record. Please contact customer support to resolve.';

    //List of error to display to page
    private List<String> errorMessages = new List< String >();

    //Booleans used for testing functionality
    public Boolean testFindAccount {get;set;}
    public Boolean testRemoteException {get;set;}

    //Denotes an error occurred and we should not render the IFrame
    public Boolean renderHPM {get;set;}

    //Zuora Page Ids Map of HPM 2.0 pages
    public Map<String, String> pageIdMap {get;set;}


    //Denotes error occurred setting up IFrame
    public Boolean hasConfigError {get;set;}

    //Controls displaying the charge table
    public Boolean displayChargeInfo {
        get {
            if (hasQuote && chargeFieldSettings != null && chargeFieldSettings.size() > 0) {
                return true;
            } else {
                return false;
            }
        }
    }

    //Controls displaying the quote table (if displayCharges is also true)
    public Boolean displayQuoteInfo {
        get {
            if (hasQuote && quoteFieldSettings != null && quoteFieldSettings.size() > 0) {
                return true;
            } else {
                return false;
            }
        }
    }

    //Holds connector to zuora apis
    public Zuora.ZApi zApi {
        get {
            if (zApi == null) {
                System.debug(DEBUG_STR+'Instantiating zApi and logging into Zuora');
                zApi = new Zuora.ZApi();
                if (!Test.isRunningTest()) {
                    zApi.zLogin();
                }
            }
            return zApi;
        } set;
    }

    //Settings used for rendering Quote fields
    public List<Zuora_Customer_HPM_Quote_Field__c> quoteFieldSettings {get;set;}
    
    //Settings used for rendering Charge fields
    public List<Zuora_Customer_HPM_Charge_Field__c> chargeFieldSettings {get;set;}

    //Custom setting related to this customization
    private Zuora_Customer_HPM_Setting__c hpmSetting;

    private String zuoraAccountId;
    private Id quoteId;
    private Id billingAccountId;
    public String paymentMethodType {get;set;}
    private List<String> paymentMethodTypeList;
    private List <zqu__HostedPageLiteSetting__c> settingList;

    public zqu__Quote__c quote {get;set;}

    public Boolean hasQuote {
        get {
            if (String.isNotBlank(quoteId)) {
                return true;
            } else {
                return false;
            }
        }
    }

    public List<zqu__QuoteCharge__c> quoteChargeObjects {get;set;}

    public Boolean hasQuoteCharges {
        get {
            if (quoteChargeObjects == null){
                quoteChargeObjects = new List<zqu__QuoteCharge__c>();
            }
            if (quoteChargeObjects.size() > 0) {
                return true;
            } else {
                return false;
            }
        }
    }

    public Boolean hasAccountInSFDC {
        get {
            if (String.isNotBlank(billingAccountId)) {
                return true;
            } else {
                return false;
            }
        }
    }

    public Boolean hasAccountInZuora {
        get {
            if (String.isNotBlank(zuoraAccountId)) {
                return true;
            } else {
                return false;
            }
        }
    }

    public Boolean showSuccessMessage {get;set;}

    public List<SelectOption> PaymentMethodList
    {
        get
        {
            PaymentMethodList = new List<SelectOption>();
            for(String pmType : paymentMethodTypeList)
            {
                PaymentMethodList.add(new SelectOption(pmType, pmType));
            }
            return PaymentMethodList;
        }
        set;
    }


    // Constructor, determines the Zuora page Id based on payment method
    public Z_PaymentMethodCaptureController(ApexPages.StandardController standardController) {
        final String FUNC_STR = DEBUG_STR + 'Constructor: ';
        System.debug(FUNC_STR+'Starting method');

        hasConfigError = false;
        testRemoteException = true;
        testFindAccount = true;
        showSuccessMessage = false;
        renderHPM = false;
        quoteFieldSettings = new List<Zuora_Customer_HPM_Quote_Field__c>();
        settingList = new List<zqu__HostedPageLiteSetting__c>();
        paymentMethodTypeList = new List<String>();
        pageIdMap = new Map<String, String>();

        //Default Payment Method Type
        this.paymentMethodType = zqu.PaymentPageController.PAYMENT_METHOD_TYPE_CREDIT_CARD;

        String successMsg = ApexPages.currentPage().getParameters().get('success');

        if (String.isNotBlank(successMsg) && successMsg.equalsIgnoreCase('true')) {
            showSuccessMessage = true;
        }

        this.hpmSetting = Zuora_Customer_HPM_Setting__c.getall().get(Z_PaymentMethodCaptureUtil.getHpmSettingName());

        if (hpmSetting == null) {
            System.debug(FUNC_STR+'HPM Setting is missing.');
            hasConfigError = true;
            //appendError(CONFIGURATION_ERROR_MESSAGE);
        } 
        /*else if (paymentMethodType == null)
        {
            System.debug(FUNC_STR+'Payment Method Type is missing.');
            hasConfigError = true;
        }*/
        else {
            // Name of Payment Page Setting object
            String paymentPageComponentName = hpmSetting.Payment_Page_Component_Name__c;

            System.debug(FUNC_STR+'Querying for hosted page lite setting for component: '+paymentPageComponentName);
            
            // Query for settings
            settingList = [SELECT zqu__PageId__c, zqu__PaymentMethodType__c, zqu__ComponentName__c FROM zqu__HostedPageLiteSetting__c WHERE zqu__ComponentName__c = :paymentPageComponentName];
              
            if(settingList != null && !settingList.isEmpty()) {
                for(zqu__HostedPageLiteSetting__c setting: settingList){
                    pageIdMap.put(setting.zqu__PaymentMethodType__c,setting.zqu__PageId__c);
                    paymentMethodTypeList.add(setting.zqu__PaymentMethodType__c);
                }
            } else {
                System.debug(FUNC_STR+'Failed to retrieve payment pages setting');
                hasConfigError = true;
                //appendError(CONFIGURATION_ERROR_MESSAGE);
            }
        }
    }

    public Boolean checkPaymentMethodSettings()
    {
        Boolean isValid = false;
        for(zqu__HostedPageLiteSetting__c setting: settingList){
            if(this.paymentMethodType == setting.zqu__PaymentMethodType__c){
                isValid = true;
            }
        }
        return isValid;
    }


    public void onload() {
        final String FUNC_STR = DEBUG_STR + 'onload: ';
        System.debug(FUNC_STR+'Starting onload method');

        renderHPM = false;
 
        if (!hasConfigError) {
            try {
                if ((searchForQuote() || searchForSFDCBillingAccount() || searchForZuoraAccount())) {

                    if(!checkPaymentMethodSettings())
                        return;

                    renderHPM = true;
        
                    if (hasQuote && hpmSetting.Display_Quote_Fields__c) {
                        this.quoteFieldSettings = new List<Zuora_Customer_HPM_Quote_Field__c>();

                        //List<Zuora_Customer_HPM_Quote_Field__c> quoteDisplayFields = Zuora_Customer_HPM_Quote_Field__c.getall().values();
                        List<Zuora_Customer_HPM_Quote_Field__c> quoteDisplayFields = [SELECT Id,Name,Active__c,Display_Order__c,Enable_for_Amendments__c,Enable_For_New_Subscriptions__c,
                            Enable_for_Renewals__c,Quote_Field_API_Name__c,Quote_Field_Display_Label__c  
                            FROM Zuora_Customer_HPM_Quote_Field__c ORDER BY Display_Order__c];

                        System.debug(FUNC_STR+'Retrieved '+quoteDisplayFields.size()+' Quote Display Field settings: '+quoteDisplayFields);

                        for (Zuora_Customer_HPM_Quote_Field__c quoteDisplayField : quoteDisplayFields) {
                            //Check Quote Subscription Type
                            if (quoteDisplayField.Active__c && 
                                ((quote.zqu__SubscriptionType__c == Z_PaymentMethodCaptureUtil.NEW_SUB_TEXT && quoteDisplayField.Enable_For_New_Subscriptions__c) ||
                                (quote.zqu__SubscriptionType__c == Z_PaymentMethodCaptureUtil.AMEND_SUB_TEXT && quoteDisplayField.Enable_for_Amendments__c) ||
                                (quote.zqu__SubscriptionType__c == Z_PaymentMethodCaptureUtil.RENEW_SUB_TEXT && quoteDisplayField.Enable_for_Renewals__c))) {

                                System.debug(FUNC_STR+'Zuora_Customer_HPM_Quote_Field__c "'+quoteDisplayField.Name+'" is enabled for this Quote Type. Will add to list of Quote Fields');
                                this.quoteFieldSettings.add(quoteDisplayField);
                            } else {
                                System.debug(FUNC_STR+'Zuora_Customer_HPM_Quote_Field__c "'+quoteDisplayField.Name+'" is not enabled for this Quote Type');
                            }
                            
                        }

                        //Gather charge fields
                        this.chargeFieldSettings = new List<Zuora_Customer_HPM_Charge_Field__c>();

                        List<Zuora_Customer_HPM_Charge_Field__c> chargeDisplayFields = [SELECT Id,Name,Active__c,Display_Order__c,Enable_For_New_Subscriptions__c,
                            Charge_Field_API_Name__c,Charge_Field_Display_Label__c
                            FROM Zuora_Customer_HPM_Charge_Field__c ORDER BY Display_Order__c];
                    
                        System.debug(FUNC_STR+'Retrieved '+chargeDisplayFields.size()+' Charge Display Field settings: '+chargeDisplayFields);

                        Set<String> quoteChargeFields = new Set<String>();

                        for (Zuora_Customer_HPM_Charge_Field__c chargeDisplayField : chargeDisplayFields) {
                            //Check Quote Subscription Type
                            if (chargeDisplayField.Active__c && 
                                (quote.zqu__SubscriptionType__c == Z_PaymentMethodCaptureUtil.NEW_SUB_TEXT && chargeDisplayField.Enable_For_New_Subscriptions__c)) {

                                System.debug(FUNC_STR+'Zuora_Customer_HPM_Charge_Field__c "'+chargeDisplayField.Name+'" is enabled for this Quote Type. Will add to list of Charge Fields');
                                this.chargeFieldSettings.add(chargeDisplayField);
                                quoteChargeFields.add(chargeDisplayField.Charge_Field_API_Name__c);
                            } else {
                                System.debug(FUNC_STR+'Zuora_Customer_HPM_Charge_Field__c "'+chargeDisplayField.Name+'" is not enabled for this Quote Type');
                            }
                        }

                        if (this.chargeFieldSettings.size() > 0) {
                            if (quoteChargeFields.contains('Id')) {
                                quoteChargeFields.remove('Id');
                            } 

                            String quoteChargeQuery = 'SELECT Id';

                            for (String chargeField : quoteChargeFields) {
                                quoteChargeQuery += ','+chargeField;
                            }

                            quoteChargeQuery += ' FROM zqu__QuoteCharge__c WHERE zqu__Quote__c = :quoteId';

                            this.quoteChargeObjects = new List<zqu__QuoteCharge__c>();
                            try {
                                this.quoteChargeObjects = (List<zqu__QuoteCharge__c>)Database.query(quoteChargeQuery);    
                            } catch (Exception ex) {
                                System.debug(FUNC_STR+'Error occurred querying for Quote Charges: '+ex.getMessage());
                            }
                            
                            System.debug(FUNC_STR+'Retrieved '+quoteChargeObjects.size()+' Quote Charges: '+quoteChargeObjects);
                        }
                    } else {
                        System.debug(FUNC_STR+'Quote does not exist or HPM Setting not configured to display Quote Fields');
                    }
                } 
            } catch (Exception ex) {
                System.debug(FUNC_STR+'Error occurred looking up customer record: '+ex.getMessage());
                renderHPM = false;
            }      
        } else {
            System.debug(FUNC_STR+'HPM has configuration error');
        }
    }

    /**
    * Searches for a Quote in SFDC based on 'id' param in URL. Returns true if it finds a Quote.
    **/
    private Boolean searchForQuote() {
        final String FUNC_STR = DEBUG_STR + 'searchForQuote: ';
        System.debug(FUNC_STR+'Starting searchForQuote');

        Boolean foundQuote = false;

        //Retrieve standard id field from url
        String tempQuoteId = ApexPages.currentPage().getParameters().get('id');
        System.debug(FUNC_STR+'tempQuoteId: '+tempQuoteId);

        this.quote = Z_PaymentMethodCaptureUtil.searchForQuote(tempQuoteId);

        if (this.quote != null) {
            System.debug(FUNC_STR+'Found a related Quote');
            foundQuote = true;
            this.quoteId = this.quote.Id;

            if (String.isNotBlank(this.quote.zqu__ZuoraAccountId__c)) {
                System.debug(FUNC_STR+'Retrieved Zuora Account Id "'+this.quote.zqu__ZuoraAccountId__c+'" from Quote');
                this.zuoraAccountId = this.quote.zqu__ZuoraAccountId__c;
            } else {
                System.debug(FUNC_STR+'Zuora Account id on Quote is blank');
            }

            //Retrieve Default Payment Method Type
            if (String.isNotBlank(this.quote.zqu__PaymentMethod__c)) {
                System.debug(FUNC_STR+'Retrieved Default Payment Method "'+this.quote.zqu__PaymentMethod__c+'" from Quote');
                this.paymentMethodType = this.quote.zqu__PaymentMethod__c;
            } else {
                System.debug(FUNC_STR+'Default Payment Method on Quote is blank');
            }

        } else {
            System.debug(FUNC_STR+'Failed to find a related Quote');
        }

        return foundQuote;
    }

    /**
    * Searches for a Billing Account in SFDC based on 'accid' param in URL. The 'accid' param can represent Id, Zuora Id, or AccountNumber of BillingAccount object in SFDC. Returns true if it finds a Billing Account.
    **/
    private Boolean searchForSFDCBillingAccount() {
        final String FUNC_STR = DEBUG_STR + 'searchForBillingAccount: ';
        System.debug(FUNC_STR+'Starting searchForBillingAccount');

        Boolean foundBillingAccount = false;

        //Retrieve accid field from url
        String tempBAId = ApexPages.currentPage().getParameters().get('accid');

        //Search for Quote if id is not blank
        if (String.isNotBlank(tempBAId)) {
            System.debug(FUNC_STR+'Searching for Billing Account related to accid param in URL: '+tempBAId);
            List<Zuora__CustomerAccount__c> billingAccounts = [SELECT Id, Zuora__Zuora_Id__c,Zuora__PaymentMethod_Type__c FROM Zuora__CustomerAccount__c WHERE Id = :tempBAId or Zuora__Zuora_Id__c = :tempBAId or Zuora__AccountNumber__c = :tempBAId LIMIT 1];

            if (billingAccounts != null && billingAccounts.size() > 0) {
                System.debug(FUNC_STR+'Found a related Billing Account');

                if (String.isNotBlank(billingAccounts[0].Zuora__Zuora_Id__c)) {
                    System.debug(FUNC_STR+'Retrieved Zuora Account Id "'+billingAccounts[0].Zuora__Zuora_Id__c+'" from Billing Account');
                    this.zuoraAccountId = billingAccounts[0].Zuora__Zuora_Id__c;
                    this.billingAccountId = billingAccounts[0].Id;
                    foundBillingAccount= true;
                } else {
                    System.debug(FUNC_STR+'Zuora Account id on Billing Account is blank');
                }


                //Retrieve Default Payment Method Type
                if (String.isNotBlank(billingAccounts[0].Zuora__PaymentMethod_Type__c)) {
                    System.debug(FUNC_STR+'Retrieved Default Payment Method "'+billingAccounts[0].Zuora__PaymentMethod_Type__c+'" from Billing Account');
                    this.paymentMethodType = billingAccounts[0].Zuora__PaymentMethod_Type__c;
                } else {
                    System.debug(FUNC_STR+'Default Payment Method on Billing Account is blank');
                }

            } else {
                System.debug(FUNC_STR+'Failed to find a related Billing Account in SFDC');
            }
        } else {
            System.debug(FUNC_STR+'accid param in URL is blank');
        }

        return foundBillingAccount;
    }
    
    /**
    * Searches for a Account in Zuora based on 'accid' param in URL. The 'accid' param can represent Id or AccountNumber field on Account. Returns true if an Account exists in Zuora.
    **/
    private Boolean searchForZuoraAccount() {
        final String FUNC_STR = DEBUG_STR + 'getZuoraAccount: ';
        System.debug(FUNC_STR+'Starting method');

        Boolean foundBillingAccount = false;

        //Retrieve accid field from url
        String tempBAId = ApexPages.currentPage().getParameters().get('accid');

        //Search for Quote if id is not blank
        if (String.isNotBlank(tempBAId)) { 
            System.debug(FUNC_STR+'Searching for Account in Zuora related to accid param in URL: '+tempBAId);
            //List<Zuora__CustomerAccount__c> billingAccounts = [SELECT Id, Zuora__Zuora_Id__c FROM Zuora__CustomerAccount__c WHERE Id = :tempBAId or Zuora__Zuora_Id__c = :tempBAId or Zuora__AccountNumber__c = :tempBAId LIMIT 1];

            String zoql = 'SELECT Id FROM Account WHERE Id = \'' + tempBAId + '\' or AccountNumber = \''+tempBAId+'\'';
            List <Zuora.zObject> billingAccounts = (!Test.isRunningTest()) ? zApi.zquery(zoql) : Z_PaymentMethodCaptureUtilTest.retrieveTestAccount(testFindAccount);  
            System.debug(FUNC_STR+'Retrieved Accounts from Zuora: '+billingAccounts);

            if (billingAccounts != null && billingAccounts.size() > 0) {
                System.debug(FUNC_STR+'Found a related Billing Account');

                if (String.isNotBlank((String)billingAccounts[0].getValue('Id'))) {
                    System.debug(FUNC_STR+'Retrieved Zuora Account Id "'+(String)billingAccounts[0].getValue('Id')+'" from Zuora Account');
                    this.zuoraAccountId = (String)billingAccounts[0].getValue('Id');
                    foundBillingAccount= true;
                } else {
                    System.debug(FUNC_STR+'Id on Zuora Account is blank');
                }

            } else {
                System.debug(FUNC_STR+'Failed to find a related Billing Account in SFDC');
            }
        } else {
            System.debug(FUNC_STR+'accid param in URL is blank');
        }

        return foundBillingAccount;      
    }

    /**
    * Helper method for posting error messages to the page
    **/
    static public void appendError(String message) {
        appendMessage(ApexPages.Severity.ERROR, message);
    }

    /**
    * Helper method for posting success messages to the page
    **/
    static public void appendSuccess(String message) {
        appendMessage(ApexPages.Severity.INFO, message);
    }

    /**
    * Helper method for posting messages to the page
    **/
    static public void appendMessage(ApexPages.Severity severity, String message) {
        System.debug('appendMessage, Severity: '+severity+', Message: '+message);
        ApexPages.addMessage(new ApexPages.Message(severity, message));
    }

}