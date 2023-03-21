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
global class Z_PaymentMethodCaptureControllerTest {

    private static final String DEBUG_STR = 'Z_PaymentMethodCaptureControllerTest: ';
    private static final String TEST_ACC_ID = '11111111111111111111111111111111';
   
    @isTest
    private static void testSetupWithQuote() {
        final String FUNC_STR = DEBUG_STR + 'testSetupWithQuote: ';
        System.debug(FUNC_STR+'Starting test method');
      Z_PaymentMethodCaptureUtilTest.setupTestEnv();

      //Account acc = createTestAccount(null, true);
      //Contact con = createTestContact(acc, true);
      //Opportunity opp = createTestOpportunity(acc, true);
      //zqu__Quote__c quote = createTestQuote(acc, opp, con, con, true);

      //Insert HPM 2.0 custom setting
      //setupHpmConfig_ACH();

      //ApexPages.StandardController standardController;
      //Z_PaymentMethodCaptureController controller = new Z_PaymentMethodCaptureController(standardController);

      Test.startTest();

        //System.assert(controller.hasQuote == false);
        //System.assert(controller.displayChargeInfo == false);
        //System.assert(controller.displayQuoteInfo == false);
        //System.assert(controller.hasQuoteCharges == false); 
        //System.assert(controller.hasAccountInSFDC == false); 
        //System.assert(controller.hasAccountInZuora == false);  
         
        //Setup test page with parameters "accId" and "type"
        //PageReference testPage = setupPage(quote.Id);
        //System.Test.setCurrentPage(testPage);
        //controller = new Z_PaymentMethodCaptureController(standardController);

        //System.assert(controller.renderHPM == false);
        //controller.onload();
        //System.assert(controller.renderHPM == true);
        //System.assert(controller.hasQuote == true);
        //System.assert(controller.pageIdMap.size() > 0);
        //System.assert(controller.displayChargeInfo == true);
        //System.assert(controller.displayQuoteInfo == true);
        //System.assert(controller.hasAccountInSFDC == false); 
        //System.assert(controller.hasAccountInZuora == false);

        //TODO: to implement this, need to insert charge group to test quote
        //System.assert(controller.hasQuoteCharges == true); 
      
      Test.stopTest();
    }

    @isTest
    private static void testSetupWithAccountInSfdc() {
      final String FUNC_STR = DEBUG_STR + 'testSetupWithAccountInSfdc: ';
      System.debug(FUNC_STR+'Starting test method');
      Z_PaymentMethodCaptureUtilTest.setupTestEnv();

      Account acc = createTestAccount(null, true);
      Zuora__CustomerAccount__c billAcc = Z_PaymentMethodCaptureUtilTest.createBillingAccount(acc, true);

      //Insert HPM 2.0 custom setting
      setupHpmConfig();

      ApexPages.StandardController standardController;
      Z_PaymentMethodCaptureController controller = new Z_PaymentMethodCaptureController(standardController);

      Test.startTest();

        System.assert(controller.hasQuote == false);
        System.assert(controller.displayChargeInfo == false);
        System.assert(controller.displayQuoteInfo == false);
        System.assert(controller.hasQuoteCharges == false); 
        System.assert(controller.hasAccountInSFDC == false); 
        System.assert(controller.hasAccountInZuora == false);  
         
        //Setup test page with parameters "accId" and "type"
        PageReference testPage = setupPage(null);
        System.Test.setCurrentPage(testPage);
        controller = new Z_PaymentMethodCaptureController(standardController);

        System.assert(controller.renderHPM == false);
        controller.onload();
        System.assert(controller.renderHPM == true);
        System.assert(controller.hasQuote == false);
        System.assert(controller.pageIdMap.size() > 0);
        System.assert(controller.displayChargeInfo == false);
        System.assert(controller.displayQuoteInfo == false);
        System.assert(controller.hasQuoteCharges == false); 
        System.assert(controller.hasAccountInSFDC == true); 
        System.assert(controller.hasAccountInZuora == true);
      
      Test.stopTest();
    }

    @isTest
    private static void testSetupWithAccountInZuora() {
      final String FUNC_STR = DEBUG_STR + 'testSetupWithAccountInZuora: ';
      System.debug(FUNC_STR+'Starting test method');
      Z_PaymentMethodCaptureUtilTest.setupTestEnv();

      //Insert HPM 2.0 custom setting
      setupHpmConfig();

      ApexPages.StandardController standardController;
      Z_PaymentMethodCaptureController controller = new Z_PaymentMethodCaptureController(standardController);

      Test.startTest();

        System.assert(controller.hasQuote == false);
        System.assert(controller.displayChargeInfo == false);
        System.assert(controller.displayQuoteInfo == false);
        System.assert(controller.hasQuoteCharges == false); 
        System.assert(controller.hasAccountInSFDC == false); 
        System.assert(controller.hasAccountInZuora == false);  
         
        //Setup test page with parameters "accId" and "type"
        PageReference testPage = setupPage(null);
        System.Test.setCurrentPage(testPage);
        controller = new Z_PaymentMethodCaptureController(standardController);

        System.assert(controller.renderHPM == false);
        controller.onload();
        System.assert(controller.renderHPM == true);
        System.assert(controller.hasQuote == false);
        System.assert(controller.pageIdMap.size() > 0);
        System.assert(controller.displayChargeInfo == false);
        System.assert(controller.displayQuoteInfo == false);
        System.assert(controller.hasQuoteCharges == false); 
        System.assert(controller.hasAccountInSFDC == false); 
        System.assert(controller.hasAccountInZuora == true);
      
      Test.stopTest();
    }

    @isTest
    private static void testZApi() {
      final String FUNC_STR = DEBUG_STR + 'testZApi: ';
      System.debug(FUNC_STR+'Starting test method');
      Z_PaymentMethodCaptureUtilTest.setupTestEnv();

      ApexPages.StandardController standardController;
      Z_PaymentMethodCaptureController controller = new Z_PaymentMethodCaptureController(standardController);

      Zuora.ZApi zApi = controller.zApi;
      System.assert(zApi != null, 'zApi failed to instantiate');
    }

    @isTest
    private static void testAppendMessages() {
      final String FUNC_STR = DEBUG_STR + 'testSetupWithAccountInSfdc: ';
      System.debug(FUNC_STR+'Starting test method');
      Z_PaymentMethodCaptureUtilTest.setupTestEnv();

      Account acc = createTestAccount(null, true);
      Zuora__CustomerAccount__c billAcc = Z_PaymentMethodCaptureUtilTest.createBillingAccount(acc, true);

      //Insert HPM 2.0 custom setting
      setupHpmConfig();

      //Setup test page with parameters "accId" and "type"
      PageReference testPage = setupPage(null);
      System.Test.setCurrentPage(testPage);

      Z_PaymentMethodCaptureController.appendError('Test Error Message');
      Z_PaymentMethodCaptureController.appendSuccess('Test Success Message');
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

    private static void setupHpmConfig() {
        final String FUNC_STR = DEBUG_STR + 'setupHpmConfig: ';
        System.debug(FUNC_STR+'Starting method');

        String paymentMethodType = 'Credit Card';
        String paymentPageComponentName = 'Customer_Payment_Page';

        List < zqu__HostedPageLiteSetting__c > settingList = [SELECT zqu__PageId__c, zqu__PaymentMethodType__c, zqu__ComponentName__c FROM zqu__HostedPageLiteSetting__c WHERE zqu__PaymentMethodType__c = :paymentMethodType AND zqu__ComponentName__c = :paymentPageComponentName LIMIT 1];

        if (settingList == null || settingList.isEmpty()) {
            zqu__HostedPageLiteSetting__c testSetting = new zqu__HostedPageLiteSetting__c();
            testSetting.zqu__PageId__c = '1111111111';
            testSetting.zqu__PaymentMethodType__c = paymentMethodType;
            testSetting.zqu__ComponentName__c = paymentPageComponentName;
            System.debug(FUNC_STR+'Inserting new testSetting: '+testSetting);
            insert testSetting;
        } else {
            System.debug(FUNC_STR+'No need to insert testSetting');
        }
    }

    private static void setupHpmConfig_ACH() {
      final String FUNC_STR = DEBUG_STR + 'setupHpmConfig: ';
      System.debug(FUNC_STR+'Starting method');

      String paymentMethodType = 'ACH';
      String paymentPageComponentName = 'Customer_Payment_Page';

      List < zqu__HostedPageLiteSetting__c > settingList = [SELECT zqu__PageId__c, zqu__PaymentMethodType__c, zqu__ComponentName__c FROM zqu__HostedPageLiteSetting__c WHERE zqu__PaymentMethodType__c = :paymentMethodType AND zqu__ComponentName__c = :paymentPageComponentName LIMIT 1];

      if (settingList == null || settingList.isEmpty()) {
        zqu__HostedPageLiteSetting__c testSetting = new zqu__HostedPageLiteSetting__c();
        testSetting.zqu__PageId__c = '1111111111';
        testSetting.zqu__PaymentMethodType__c = paymentMethodType;
        testSetting.zqu__ComponentName__c = paymentPageComponentName;
        System.debug(FUNC_STR+'Inserting new testSetting: '+testSetting);
        insert testSetting;
      } else {
        System.debug(FUNC_STR+'No need to insert testSetting');
      }
    }

    public static List<Zuora.ZObject> retrieveTestAccount(Boolean accountExists) {
        Zuora.ZObject testAcc = new Zuora.ZObject('Account');
        testAcc.setValue('Id', TEST_ACC_ID);

        List<Zuora.ZObject> retrievedAccounts = (accountExists) ? new List<Zuora.ZObject>{testAcc} : new List<Zuora.ZObject>();
        return retrievedAccounts;
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
    
      if (doInsert) {
        insert quote;
      }
    
      return quote;
    }
}