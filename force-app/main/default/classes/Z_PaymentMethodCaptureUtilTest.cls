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
public class Z_PaymentMethodCaptureUtilTest {

    //Used for debugging
    private static final String DEBUG_STR = 'Z_PaymentMethodCaptureUtilTest: ';

    //Test variables
    private static final String TEST_ACC_ID = '11111111111111111111111111111111';
    private static final String TEST_BILL_TO_ID = '22222222222222222222222222222222';
    private static final String TEST_SOLD_TO_ID = '33333333333333333333333333333333';
    
    
    @isTest static void testSearchForQuoteFail() {
        setupTestEnv();
        zqu__Quote__c testQuote = Z_PaymentMethodCaptureUtil.searchForQuote(null);
        System.assert(testQuote == null);
    }

    @isTest static void testSearchForQuoteSuccess() {
        setupTestEnv();
        Account acc = createTestAccount(null, true);
        //Contact con = createTestContact(acc, true);
        //Opportunity opp = createTestOpportunity(acc, true);
        //zqu__Quote__c quote = createTestQuote(acc, opp, con, con, true);

        //zqu__Quote__c testQuote = Z_PaymentMethodCaptureUtil.searchForQuote(quote.Id);
        //System.assert(testQuote != null);
    }
    
    @isTest static void testSearchForSFDCBillingAccountFail() {
        //setupTestEnv();
        //Zuora__CustomerAccount__c testBillAcc = Z_PaymentMethodCaptureUtil.searchForSFDCBillingAccount(null);
        //System.assert(testBillAcc == null);
    }

    @isTest static void testSearchForSFDCBillingAccountSuccess() {
        setupTestEnv();
        Account acc = createTestAccount(null, true);
        Zuora__CustomerAccount__c billAcc = createBillingAccount(acc, true);

        Zuora__CustomerAccount__c testBillAcc = Z_PaymentMethodCaptureUtil.searchForSFDCBillingAccount(billAcc.Id);
        System.assert(testBillAcc != null);
    }

    @isTest static void testSearchForZuoraAccountFail() {
        setupTestEnv();
        Zuora.ZObject testZAccount = Z_PaymentMethodCaptureUtil.searchForZuoraAccount(TEST_ACC_ID, false);
        System.assert(testZAccount == null);
    }

    @isTest static void testSearchForZuoraAccountSuccess() {
        setupTestEnv();
        Zuora.ZObject testZAccount = Z_PaymentMethodCaptureUtil.searchForZuoraAccount(TEST_ACC_ID, true);
        System.assert(testZAccount != null);
    }

    @isTest static void testZApi() {
        setupTestEnv();
        Zuora.ZApi zApi = Z_PaymentMethodCaptureUtil.zApi;
        System.assert(zApi != null); 
    }

    @isTest static void testSearchForZuoraContactsSuccess() {
        setupTestEnv();
        List<Zuora.ZObject> zuoraContacts = Z_PaymentMethodCaptureUtil.searchForZuoraContacts(TEST_BILL_TO_ID, TEST_SOLD_TO_ID, true);
        System.assert(zuoraContacts != null, 'List of returned Zuora contacts is null');
        System.assert(zuoraContacts.size() > 0, 'List of returned Zuora contacts is empty');
    }

    @isTest static void testSearchForZuoraContactsFail() {
        setupTestEnv();
        List<Zuora.ZObject> zuoraContacts = Z_PaymentMethodCaptureUtil.searchForZuoraContacts(null, null, true);
        System.assert(zuoraContacts != null, 'List of returned Zuora contacts is null');
        System.assert(zuoraContacts.size() == 0, 'Erroneously returned Zuora contacts from null Ids');

        zuoraContacts = Z_PaymentMethodCaptureUtil.searchForZuoraContacts(TEST_BILL_TO_ID, TEST_SOLD_TO_ID, false);
        System.assert(zuoraContacts != null, 'List of returned Zuora contacts is null');
        System.assert(zuoraContacts.size() == 0, 'Erroneously returned Zuora contacts with "find" flag set to false');
    }

    public static void setupTestEnv() {
        //Insert Country, State, and HPM Setting
        Z_PaymentMethodCaptureUtil.performCustomizationSetup();

        //Insert Quote display field Settings
        createQuoteCustomSettings();

        //Insert Charge display field Settings
        createQuoteChargeCustomSettings();
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

    public static List<Zuora.ZObject> retrieveTestAccount(Boolean accountExists) {
        Zuora.ZObject testAcc = new Zuora.ZObject('Account');
        testAcc.setValue('Id', TEST_ACC_ID);
        testAcc.setValue('BillToId', TEST_BILL_TO_ID);
        testAcc.setValue('SoldToId', TEST_SOLD_TO_ID);

        List<Zuora.ZObject> retrievedAccounts = (accountExists) ? new List<Zuora.ZObject>{testAcc} : new List<Zuora.ZObject>();
        return retrievedAccounts;
    }

    public static List<Zuora.ZObject> retrieveTestContacts(Boolean contactExists) {
        Zuora.ZObject testBillTo = new Zuora.ZObject('Contact');
        Zuora.ZObject testSoldTo = new Zuora.ZObject('Contact');

        testBillTo.setValue('Id',TEST_BILL_TO_ID);
        testSoldTo.setValue('Id',TEST_SOLD_TO_ID);
        testBillTo.setValue('Address1','123 Main St');
        testSoldTo.setValue('Address1','321 Other St');
        testBillTo.setValue('City','Atlanta');
        testSoldTo.setValue('City','Roswell');
        testBillTo.setValue('Country','United States');
        testSoldTo.setValue('Country','United States');
        testBillTo.setValue('FirstName','John');
        testSoldTo.setValue('FirstName','Jane');
        testBillTo.setValue('LastName','Smith');
        testSoldTo.setValue('LastName','Doe');
        testBillTo.setValue('PostalCode','12345');
        testSoldTo.setValue('PostalCode','54321');
        testBillTo.setValue('State','Georgia');
        testSoldTo.setValue('State','Georgia');
        testBillTo.setValue('WorkEmail','test1@test.com');
        testSoldTo.setValue('WorkEmail','test2@test.com');
        testBillTo.setValue('WorkPhone','1234567890');
        testSoldTo.setValue('WorkPhone','0987654321');

        List<Zuora.ZObject> retrievedContacts = (contactExists) ? new List<Zuora.ZObject>{testBillTo, testSoldTo} : new List<Zuora.ZObject>();
        return retrievedContacts;
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

    public static void createQuoteCustomSettings() {
        final String FUNC_STR = DEBUG_STR + 'createQuoteCustomSettings: ';

        String testSettingName = 'Test Quote Setting';

        Zuora_Customer_HPM_Quote_Field__c testSetting = Zuora_Customer_HPM_Quote_Field__c.getall().get(testSettingName);
        
        if (testSetting == null) {
            System.debug(FUNC_STR+'Creating test Zuora_Customer_HPM_Quote_Field__c setting');

            testSetting = new Zuora_Customer_HPM_Quote_Field__c();
            testSetting.Name = testSettingName;
            testSetting.Active__c = true;
            testSetting.Display_Order__c = 1;
            testSetting.Enable_for_Amendments__c = true;
            testSetting.Enable_For_New_Subscriptions__c = true;
            testSetting.Enable_for_Renewals__c = true;
            testSetting.Quote_Field_API_Name__c = 'Id';
            testSetting.Quote_Field_Display_Label__c = 'Id';

            insert testSetting;
        } else {
            System.debug(FUNC_STR+'Test Zuora_Customer_HPM_Quote_Field__c already exists. Will not create');        
        }   
    }

    public static void createQuoteChargeCustomSettings() {
        final String FUNC_STR = DEBUG_STR + 'createQuoteChargeCustomSettings: ';

        String testSettingName = 'Test Quote Charge Setting';

        Zuora_Customer_HPM_Charge_Field__c testSetting = Zuora_Customer_HPM_Charge_Field__c.getall().get(testSettingName);
        
        if (testSetting == null) {
            System.debug(FUNC_STR+'Creating test Zuora_Customer_HPM_Charge_Field__c setting');

            testSetting = new Zuora_Customer_HPM_Charge_Field__c();
            testSetting.Name = testSettingName;
            testSetting.Active__c = true;
            testSetting.Display_Order__c = 1;
            testSetting.Enable_For_New_Subscriptions__c = true;
            testSetting.Charge_Field_API_Name__c = 'Id';
            testSetting.Charge_Field_Display_Label__c = 'Id';

            insert testSetting;
        } else {
            System.debug(FUNC_STR+'Test Zuora_Customer_HPM_Charge_Field__c already exists. Will not create');       
        }   
    }

    
}