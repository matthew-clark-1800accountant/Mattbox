/**
 * DefaultValuesTest is a test class that populates all the required objects
 * necessary for running through as many of the lines of code as possible
 * for the DefaultValues plugin. Because it is testing a class that extends
 * a managed package class whose getters and setters are private, we are not
 * able to assert any values being set. This class is strictly for code 
 * coverage
 *
 * @author Tan Pham (tan.pham@zuora.com)
 */
@isTest
global class Z_DefaultValuesTest extends zqu.CreateQuoteController.PopulateDefaultFieldValuePlugin {

  @isTest
  private static void testDefaultValues() {
    Account acc = createTestAccount();
    Opportunity opp = createTestOpportunity(acc);
    Contact c = createTestContact(acc);
    acc.Primary_Contact__c = c.Id;
    OpportunityContactRole ocr = createTestContactRole(c,opp);
    zqu__Quote__c quote = createTestQuote(acc, opp);
    
    Z_DefaultValues controller = new Z_DefaultValues();
    PageReference createQuote = Page.zqu__CreateQuote;
    createQuote.getParameters().put('oppId', opp.Id);
    createQuote.getParameters().put('quoteType', 'Subscription');
    createQuote.getParameters().put('stepNumber', '2');
    createQuote.getParameters().put('crmAccountId', acc.Id);
    Test.setCurrentPage(Page.zqu__CreateQuote);

    Test.startTest();

    controller.populateDefaultFieldValue(quote,
      new zqu.PropertyComponentController.ParentController());
      
    Account acc2 = createTestAccount();
    controller.populateDefaultFieldValue(quote,
      new zqu.PropertyComponentController.ParentController());

    Test.stopTest();
  }

  /** 
   * Create a test Contact
   */
  public static Contact createTestContact(Account a) {
    Contact c = new Contact();
    c.MailingCountry = 'US';
    c.MailingCity = 'CA';
    c.AccountId = a.Id;
    c.FirstName = 'John';
    c.LastName = 'Smith';
    insert c;
    return c;
  }
    
  /**
   * Create a test Contact Role
   */
  public static OpportunityContactRole createTestContactRole(
    Contact contact, Opportunity o) {
    OpportunityContactRole ocr = new OpportunityContactRole();
    ocr.ContactId = contact.Id;
    ocr.OpportunityId = o.Id;
    ocr.Role = 'Billing Contact';
    insert ocr;
    return ocr;
  }
    
  /**
   * Create a test quote
   */
  public static zqu__Quote__c createTestQuote(Account acc,
      Opportunity opp) {
    zqu__Quote__c quote = new zqu__Quote__c();
    quote.Name = 'Test Quote';
    quote.zqu__StartDate__c = System.today();
    quote.zqu__ValidUntil__c = System.today();
    quote.zqu__Subscription_Term_Type__c = 'Termed';
    quote.zqu__InitialTerm__c = 12;
    quote.zqu__RenewalTerm__c = 12;
    quote.zqu__Account__c = acc.Id;
    quote.zqu__Opportunity__c = opp.Id;
    insert quote;
    return quote;
  }

  /**
   * Create a test account
   */
  public static Account createTestAccount() {
    Account testAcc = new Account();
    testAcc.Name = 'Test Account';
    testAcc.BillingCity = 'Atlanta';
    testAcc.BillingState = 'GA';
    testAcc.BillingCountry = 'USA';
    testAcc.BillingPostalCode = '12345';
    testAcc.BillingStreet = '123 Main St';
    insert testAcc;
    return testAcc;
  }

  /**
   * Create a test Opportunity
   */
  public static Opportunity createTestOpportunity(Account acc) {                
    Opportunity opp = new Opportunity();    
    opp.CloseDate = System.today().addMonths(1);           
    opp.StageName = 'Closed Won';
    opp.Payment_Method__c = 'Credit Card';
    opp.Type = 'New Business';          
    opp.Name = 'Test Opportunity';
    opp.AccountId = acc.Id;
    insert opp;
    return opp;
  }
}