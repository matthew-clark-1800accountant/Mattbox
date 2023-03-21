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
@isTest(SeeAllData=true)
global class Z_PaymentPage_IHostedPageLitePluginTest {
    
    private static final String TEST_ACC_ID = '11111111111111111111111111111111';

    @isTest 
    private static void testWithQuote() {
        Z_PaymentMethodCaptureUtilTest.setupTestEnv();

        Account acc = createTestAccount(null, true);
        //Contact con = createTestContact(acc, true);
        //Opportunity opp = createTestOpportunity(acc, true);
        //zqu__Quote__c quote = createTestQuote(acc, opp, con, con, true);
      //String paymentMethodType = zqu.PaymentPageController.PAYMENT_METHOD_TYPE_CREDIT_CARD;

      //Z_PaymentPage_IHostedPageLitePlugin controller = new Z_PaymentPage_IHostedPageLitePlugin();

      //Initial set page without any url params
      //PageReference testPage = Page.Z_PaymentMethodCapture;
      //System.Test.setCurrentPage(testPage);

      Test.startTest();

        //Map < String, String > defaultValues = controller.getAdditionalParameters(paymentMethodType);
        //System.assert(defaultValues != null);
        //System.assert(controller.hasQuote == false);
        //System.assert(controller.hasAccountInSFDC == false);
        //System.assert(controller.hasAccountInZuora == false);

        //testPage = setupPage(quote.Id);
        //System.Test.setCurrentPage(testPage);  

        //defaultValues = controller.getAdditionalParameters(paymentMethodType);
        //System.assert(defaultValues != null);
        //System.assert(controller.hasQuote == true);
        //System.assert(controller.hasAccountInSFDC == false);
        //System.assert(controller.hasAccountInZuora == false);
      
      Test.stopTest();
    }

    @isTest 
    private static void testWithBillingAccountInSfdc() {
        Z_PaymentMethodCaptureUtilTest.setupTestEnv();

        Account acc = createTestAccount(null, true);
      Zuora__CustomerAccount__c billAcc = createBillingAccount(acc, true);
      String paymentMethodType = zqu.PaymentPageController.PAYMENT_METHOD_TYPE_CREDIT_CARD;

      Z_PaymentPage_IHostedPageLitePlugin controller = new Z_PaymentPage_IHostedPageLitePlugin();

      //Initial set page without any url params
      PageReference testPage = Page.Z_PaymentMethodCapture;
      System.Test.setCurrentPage(testPage);

      Test.startTest();

        Map < String, String > defaultValues = controller.getAdditionalParameters(paymentMethodType);
        System.assert(defaultValues != null);
        System.assert(controller.hasQuote == false);
        System.assert(controller.hasAccountInSFDC == false);
        System.assert(controller.hasAccountInZuora == false);

        testPage = setupPage(null);
        System.Test.setCurrentPage(testPage); 

        defaultValues = controller.getAdditionalParameters(paymentMethodType);
        System.assert(defaultValues != null);
        System.assert(controller.hasQuote == false);
        System.assert(controller.hasAccountInSFDC == true);
        System.assert(controller.hasAccountInZuora == false);
      
      Test.stopTest();
    }

    @isTest 
    private static void testWithAccountInZuora() {
      Z_PaymentMethodCaptureUtilTest.setupTestEnv();

      Account acc = createTestAccount(null, true);
      String paymentMethodType = zqu.PaymentPageController.PAYMENT_METHOD_TYPE_CREDIT_CARD;

      Z_PaymentPage_IHostedPageLitePlugin controller = new Z_PaymentPage_IHostedPageLitePlugin();

      //Initial set page without any url params
      PageReference testPage = Page.Z_PaymentMethodCapture;
      System.Test.setCurrentPage(testPage);

      Test.startTest();

        Map < String, String > defaultValues = controller.getAdditionalParameters(paymentMethodType);
        System.assert(defaultValues != null);
        System.assert(controller.hasQuote == false);
        System.assert(controller.hasAccountInSFDC == false);
        System.assert(controller.hasAccountInZuora == false);
        System.assert(controller.hasBillToContact == false);
        System.assert(controller.hasSoldToContact == false);

        testPage = setupPage(null);
        System.Test.setCurrentPage(testPage); 

        defaultValues = controller.getAdditionalParameters(paymentMethodType);
        System.assert(defaultValues != null);
        System.assert(controller.hasQuote == false);
        System.assert(controller.hasAccountInSFDC == false);
        System.assert(controller.hasAccountInZuora == true);
        System.assert(controller.hasBillToContact == true);
        System.assert(controller.hasSoldToContact == true);
      
      Test.stopTest();
    }

    public static Zuora__CustomerAccount__c createBillingAccount(Account acc, Boolean doInsert) {
        Zuora__CustomerAccount__c billAcc = new Zuora__CustomerAccount__c();
        billAcc.Name = 'Test Billing Account';
        billAcc.Zuora__Account__c = acc.Id;
        billAcc.Zuora__AccountNumber__c = 'A-001';
        billAcc.Zuora__AutoPay__c = false;
        billAcc.Zuora__Batch__c = 'Batch1';
        billAcc.Zuora__BillCycleDay__c = '1';
        billAcc.Zuora__Balance__c = 0;
        billAcc.Zuora__BillToCity__c = 'Atlanta';
        billAcc.Zuora__BillToCountry__c = 'United States';
        billAcc.Zuora__BillToAddress1__c = '123 Main St';
        billAcc.Zuora__BillToState__c = 'Georgia';
        billAcc.Zuora__BillToPostalCode__c = '12345';
        billAcc.Zuora__BillToId__c = '1234567890';
        billAcc.Zuora__BillToName__c = 'Test Name';
        billAcc.Zuora__BillToWorkEmail__c = 'test@test.com';
      billAcc.Zuora__BillToWorkPhone__c = '1234567890';
        billAcc.Zuora__MRR__c = 100;
        billAcc.Zuora__Credit_Balance__c = 100;
        billAcc.Zuora__Currency__c = 'USD';
        billAcc.Zuora__External_Id__c = TEST_ACC_ID;
        billAcc.Zuora__PaymentTerm__c = 'Due Upon Receipt';
        billAcc.Zuora__Status__c = 'Active';
        billAcc.Zuora__Zuora_Id__c = TEST_ACC_ID;
    
        if (doInsert) {
            insert billAcc;
        }
        return billAcc;
    }

    private static PageReference setupPage(Id quoteId) {
        PageReference pageRef = Page.Z_PaymentMethodCapture;
        if (String.isNotBlank(quoteId)) {
            pageRef.getParameters().put('Id', quoteId);
        } else {
            pageRef.getParameters().put('accId', TEST_ACC_ID);
        }   
        pageRef.getParameters().put('type','CreditCard');
        return pageRef;
    }

    //Create a test Account
    public static Account createTestAccount(Account parent, Boolean doInsert) 
    {
        Account testAcc = new Account();
        testAcc.Name = 'Test Account';
        testAcc.BillingCity = 'Atlanta';
        testAcc.BillingState = 'GA';
        testAcc.BillingCountry = 'USA';
        testAcc.BillingPostalCode = '12345';
        testAcc.BillingStreet = '123 Main St';
        
        if (parent != null) {
            testAcc.ParentId = parent.Id;
        }
        if (doInsert) {
            insert testAcc;
        }
    
        return testAcc;
    }
    
    public static String generateRandomPhone(Integer len) {
        final String chars = '0123456789';
        String randStr = '';
        while (randStr.length() < len) {
           Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
           randStr += chars.substring(idx, idx+1);
        }
       
        return randStr; 
    }
    
    public static String generateRandomString(Integer len) {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < len) {
           Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
           randStr += chars.substring(idx, idx+1);
        }
        randStr += '@test.com';
        return randStr; 
    }

    //Create a test Contact
    public static Contact createTestContact(Account acc, Boolean doInsert)
    {
        String randEmail = generateRandomString(32);
        String randPhone = generateRandomPhone(21);
    
        Contact con = new Contact();
        con.FirstName = 'John';
        con.LastName = 'Smith';
        con.Phone = randPhone;
        con.Email = randEmail;
        con.MailingStreet = '123 Main St';
        con.MailingCity = 'Atlanta';
        con.MailingCountry = 'USA';
        con.MailingState = 'GA';
        con.MailingPostalCode = '12345';
    
        if (acc != null) {
            con.AccountId = acc.Id;
        }
        if (doInsert) {
            insert con;
        }
        
        return con;
    }

    //Create a test Opportunity
    public static Opportunity createTestOpportunity(Account acc, Boolean doInsert)
    {                
        Opportunity opp = new Opportunity();    
        opp.CloseDate = System.today().addMonths(1);           
        opp.StageName = 'Closed Won';
        opp.Type = 'New Business';          
        opp.Name = 'Test Opportunity';
        
        if (acc != null) {
            opp.AccountId = acc.Id;
        }        
        if (doInsert) {
            insert opp;
        }
    
        return opp;
    }

    //Create a test Quote
    public static zqu__Quote__c createTestQuote(Account acc, Opportunity opp, Contact billTo, Contact soldTo, Boolean doInsert) {
        zqu__Quote__c quote = new zqu__Quote__c();
        quote.Name = 'Test Quote';
        quote.zqu__SubscriptionType__c = 'New Subscription';
        quote.zqu__StartDate__c = System.today();
        quote.zqu__ValidUntil__c = System.today();
        quote.zqu__Subscription_Term_Type__c = 'Termed';
        quote.zqu__InitialTerm__c = 12;
        quote.zqu__RenewalTerm__c = 12;
        quote.zqu__Account__c = (acc != null) ? acc.Id : null;
        quote.zqu__Opportunity__c = (opp != null) ? opp.Id : null;
        quote.zqu__BillToContact__c = (billTo != null) ? billTo.Id : null;
        quote.zqu__SoldToContact__c = (soldTo != null) ? soldTo.Id : null;
        quote.zqu__Currency__c = 'USD';
        quote.zqu__ZuoraAccountId__c = TEST_ACC_ID;
    
        if (doInsert) {
            insert quote;
        }
    
        return quote;
    }
}