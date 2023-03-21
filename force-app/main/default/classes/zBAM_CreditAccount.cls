public class zBAM_CreditAccount {
    public String creditAmount {get;set;}
    private String billId;
    private String zId;
    private String accId;
    public zqu.NotificationOptions notificationOptions {get;set;}
    public BillingAccountManagerSettings__c userSettings {get;set;}
    public Zuora__CustomerAccount__c zuoraAccount {get;set;}
    private zqu__ProductRatePlanCharge__c charge;
    private Zuora__Subscription__c subscription;
    
    public String maxCredit {get;set;}
    
    private Zuora.zApi zapi;
    
    public zBAM_CreditAccount(){
        this.billId = System.currentPageReference().getParameters().get('billId');
        this.zId = System.currentPageReference().getParameters().get('zId');
        this.accId = System.currentPageReference().getParameters().get('accId');
        
        userSettings = BillingAccountManagerSettings__c.getInstance(UserInfo.getProfileId());
        
        //Generate notification object and fills in information
        notificationOptions = new zqu.NotificationOptions();
        notificationOptions.isPopup = true;
        notificationOptions.continueAction = 'continueToNextPage();';
        notificationOptions.backLabel = 'Remain';
        notificationOptions.successTitle = 'SUCCESS! Payment method created!';
        notificationOptions.failureTitle = 'AN ERROR OCCURRED!';
        
        if (userSettings.MaximumCreditAllowed__c == 0){
            maxCredit = 'NO LIMIT';
        } else {
            maxCredit = '$' + String.valueOf(userSettings.MaximumCreditAllowed__c);
        }
        
        zapi = new Zuora.zApi();
        
        zuoraAccount = queryAccount();
        subscription = querySubscription();
        charge = [Select Id, zqu__ProductRatePlan__r.zqu__ZuoraId__c, zqu__ZuoraId__c from zqu__ProductRatePlanCharge__c where zqu__ZuoraId__c = :userSettings.CreditCharge__c LIMIT 1];
        
    }
    
    /**
        Queries Zuora for the current Billing Account
    */
    public Zuora__CustomerAccount__c queryAccount(){
        List<Zuora.zObject> accounts;
        if (!Test.isRunningTest()){
            //Login to Zuora
            zapi.zlogin();
        }

        //Create ZOQL query
        String zoql =
            'SELECT Name, Balance, CreditBalance FROM Account WHERE Id = \'' + zId + '\'';
        if (!Test.isRunningTest()){
            //Query for payments from Zuora
            accounts = zapi.zquery(zoql);
        } else {
            //Create test data for testing if needed
            accounts = new List<Zuora.zObject>();
            Zuora.zObject testAccount = new Zuora.zObject('Account');
            testAccount.setValue('Name', 'Name');
            testAccount.setValue('AccountNumber', 'AccountNumber');
            testAccount.setValue('Id', 'Id');
            testAccount.setValue('DefaultPaymentMethodId', 'pmId');
            accounts = new List<Zuora.zObject>();
            accounts.add(testAccount);
        }       
        
        //Create the sObject and fills it with data from the zObject
        Zuora__CustomerAccount__c acc = new Zuora__CustomerAccount__c();
        acc.put(Zuora__CustomerAccount__c.Name, accounts.get(0).getValue('Name'));
        acc.put(Zuora__CustomerAccount__c.Zuora__Balance__c, accounts.get(0).getValue('Balance'));
        acc.put(Zuora__CustomerAccount__c.Zuora__Zuora_Id__c, accounts.get(0).getValue('Id'));
        acc.put(Zuora__CustomerAccount__c.Zuora__CreditBalance__c, accounts.get(0).getValue('CreditBalance'));
    
        return acc;
    }
    
    public Zuora__Subscription__c querySubscription(){
        List<Zuora.zObject> subscriptions;
        if (!Test.isRunningTest()){
            //Login to Zuora
            zapi.zlogin();
        }

        //Create ZOQL query
        String zoql =
            'SELECT Id FROM Subscription WHERE AccountId = \'' + zId + '\' AND Status = \'Active\'';
        if (!Test.isRunningTest()){
            //Query for payments from Zuora
            subscriptions = zapi.zquery(zoql);
        } else {
            //Create test data for testing if needed
            subscriptions = new List<Zuora.zObject>();
            Zuora.zObject testsubscription = new Zuora.zObject('Subscription');
            testsubscription.setValue('Id', 'Id');
            subscriptions = new List<Zuora.zObject>();
            subscriptions.add(testsubscription);
        }       
        
        //Create the sObject and fills it with data from the zObject
        Zuora__Subscription__c sub = new Zuora__Subscription__c();
        sub.put(Zuora__Subscription__c.Zuora__Zuora_Id__c, subscriptions.get(0).getValue('Id'));
    
        return sub;
    }
    
    public PageReference creditAccount(){
        Decimal creditValue;
        try{
            creditValue = Decimal.valueOf(creditAmount);
            if (creditValue == 0){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'A credit of amount [' + creditAmount + '] cannot be created! Please enter a credit amount greater than 0.');
                ApexPages.addMessage(myMsg);
                return null;
            } else if (creditValue < 0){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'A credit of amount [' + creditAmount + '] cannot be created! Please enter a positive credit amount.');
                ApexPages.addMessage(myMsg);
                return null;
            }
        } catch (Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'A credit of amount [' + creditAmount + '] cannot be created! Please enter a valid amount.');
            ApexPages.addMessage(myMsg);
            return null;
        }
        
        if (!Test.isRunningTest()){
            zapi.zlogin();
        }
        List<Zuora.zApi.AmendRequest> amendRequests = new List<Zuora.zApi.AmendRequest>();
        Zuora.zApi.AmendRequest amendRequest = new Zuora.zApi.AmendRequest();
        Zuora.zApi.AmendOptions amendOptions = new Zuora.zApi.AmendOptions();
        amendOptions.generateInvoice = true;
        amendOptions.processPayments = false;
        amendRequest.amendOptions = amendOptions;
        List<Zuora.zObject> amendments =  new List<Zuora.zObject>();
        Zuora.zObject amendment =  new Zuora.zObject('Amendment');
        amendment.setValue('ContractEffectiveDate', Zuora.zUtil.getZuoraDate(Date.Today()));
        amendment.setValue('ServiceActivationDate', Zuora.zUtil.getZuoraDate(Date.Today()));
        amendment.setValue('CustomerAcceptanceDate', Zuora.zUtil.getZuoraDate(Date.Today()));
        amendment.setValue('Name', 'Crediting Account for the amount of ' + creditAmount);
        amendment.setValue('Status', 'Completed');
        amendment.setValue('SubscriptionId', subscription.Zuora__Zuora_Id__c);
        amendment.setValue('Type', 'NewProduct');
        Zuora.zObject ratePlanData = new Zuora.zObject('RatePlanData');
        Zuora.zObject ratePlan = new Zuora.zObject('RatePlan');
        ratePlan.setValue('ProductRatePlanId', charge.zqu__ProductRatePlan__r.zqu__ZuoraId__c);
        ratePlanData.setValue('RatePlan', ratePlan);
        List<Zuora.zObject> ratePlanChargeDataList = new List<Zuora.zObject>();
        Zuora.zObject ratePlanChargeData = new Zuora.zObject('RatePlanChargeData');
        Zuora.zObject ratePlanCharge = new Zuora.zObject('RatePlanCharge');
        ratePlanCharge.setValue('ProductRatePlanChargeId', charge.zqu__ZuoraId__c);
        ratePlanCharge.setValue('Price', Math.abs(creditValue) * -1);
        ratePlanChargeData.setValue('RatePlanCharge', ratePlanCharge);
        ratePlanChargeDataList.add(ratePlanChargeData);
        ratePlanData.setValue('RatePlanChargeData', ratePlanChargeDataList);
        amendment.setValue('RatePlanData', ratePlanData);
        amendments.add(amendment);
        amendRequest.amendments = amendments;
        
        Zuora.zApi.PreviewOptions previewOptions = new Zuora.zApi.PreviewOptions();
        previewOptions.EnablePreviewMode = false;
        
        amendRequest.PreviewOptions = previewOptions;
        
        amendRequests.add(amendRequest);

        Zuora.zApi.AmendResult amendResult;
        try{
        amendResult = zapi.zAmend(amendRequests);  
        } catch (Exception e){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage() + e.getStackTraceString());
            ApexPages.addMessage(myMsg);
            return null;
        }
        
        if (!amendResult.success){
            //Throw Error & Undo Amendment/Invoice
            for (Zuora.zObject error: amendResult.errors){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: Could not create Amendment! [' + error.getValue('ErrorCode') + '] ' + error.getValue('Message'));
                ApexPages.addMessage(myMsg);
            }
            return null;
        }
        String invoiceId = amendResult.InvoiceId;
        if (invoiceId == null){
            //Throw Error & Undo Amendment/Invoice
        }
        
        List<Zuora.zObject> invoices;
        String zoql =
            'SELECT Id, Balance FROM Invoice WHERE Id = \'' + invoiceId + '\'';
        if (!Test.isRunningTest()){
            //Query for payments from Zuora
            invoices = zapi.zquery(zoql);
        } else {
            //Create test data for testing if needed
            invoices = new List<Zuora.zObject>();
            Zuora.zObject testinvoice = new Zuora.zObject('Invoice');
            testinvoice.setValue('Id', 'Id');
            testinvoice.setValue('Balance', -100);
            invoices.add(testinvoice);
        }
        
        Zuora.zObject invoice = invoices[0];
        
        Decimal invoiceBalance = (Decimal)invoice.getValue('Balance');
        
        if (invoiceBalance < 0){
            //Throw Notification
        } 
        
        List<Zuora.zObject> CBAs = new List<Zuora.zObject>();
        Zuora.zObject cba = new Zuora.zObject('CreditBalanceAdjustment');
        cba.setValue('Amount', invoiceBalance*-1);
        cba.setValue('SourceTransactionId', invoiceId);
        cba.setValue('Type', 'Increase');
        CBAs.add(cba);
        
        List<Zuora.zapi.SaveResult> cbaResults = zapi.zCreate(CBAs);
        
        for (Zuora.zapi.SaveResult result : cbaResults){
            if (!result.success){
                for (Zuora.zObject error: result.errors){
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, '[' + error.getValue('ErrorCode') + '] ' + error.getValue('Message'));
                    ApexPages.addMessage(myMsg);
                }
                return null;
            }
        }
        
        
        String displayMessage = 'A credit of [' + (invoiceBalance*-1) + '] was applied to the account, ' + zuoraAccount.Name + '.';
        String headerMessage = 'SUCCESS!  A Credit has been applied!';
        return new PageReference('/apex/Manage_Billing_Account?Id=' + billId + '&displayMessage=' + displayMessage + '&headerMessage=' + headerMessage);
    }
    
    public PageReference cancel(){
        return new PageReference('/apex/Manage_Billing_Account?Id=' + billId);
    }
    
    public void verifyAmount(){
        try{
            Decimal creditValue = Decimal.valueOf(creditAmount);
            If (creditValue > userSettings.MaximumCreditAllowed__c && userSettings.MaximumCreditAllowed__c != 0){
                creditAmount = String.valueOf(userSettings.MaximumCreditAllowed__c);
            }
            creditAmount = String.valueOf(creditValue.setScale(2));
        } catch (Exception e){
            creditAmount = '0.00';
        }
    }
    
    /**
        Confirm error and clears error messages.
    */
    public void confirmError(){
        ApexPages.getMessages().clear();
    }
}