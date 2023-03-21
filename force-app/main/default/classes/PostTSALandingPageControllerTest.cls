@isTest()
public class PostTSALandingPageControllerTest {
@isTest()
    public static void testPostTSAGeneration() {
        Opportunity testOpportunity = [SELECT Id, Name FROM Opportunity LIMIT 1];
        Event testEvent = new Event(
            whatId = testOpportunity.Id,
            DurationInMinutes = 30,
            ActivityDateTime = Date.today()
        );
        insert testEvent;

        ApexPages.currentPage().getParameters().put('Id', testEvent.Id);
        ApexPages.StandardController postTSA = new ApexPages.StandardController(testEvent);
        PostTSALandingPageController controller = new PostTSALandingPageController(postTSA);
        
        //Variable roll call
        Boolean pageHasEvent = controller.pageHasEvent;
        System.assertEquals(true, pageHasEvent);
        //Event has an Opportunity
        Boolean eventHasOpportunity = controller.eventHasOpportunity;
        System.assertEquals(true, eventHasOpportunity);
        //Expecting 10 products
        Integer numberOfProducts = controller.numberOfProducts;
        System.assertEquals(10, numberOfProducts);
        //With 10 products there should be 4 products past 6
        List<Integer> productsPastSix = new List<Integer>(controller.productsPastSix);
        System.assertEquals(4, productsPastSix.size());
        //Under 3999 should be whiteMainBox
        String whatBoxClass = controller.whatBoxClass;
        System.assertEquals('whiteMainBox', whatBoxClass);
        //Check that the right opportunity was pulled
        Opportunity opportunity = controller.opportunity;
        System.assertEquals(testOpportunity.Id, opportunity.Id);
        //Check that currency formatted correctly
        Decimal potentialSavings = controller.potentialSavings;
        System.assertEquals(12956.85, potentialSavings);

    }
    @TestSetup
    static void makeData(){
        Account testAccount = TestDataGenerator.createTestAccountWithoutOwner();
        testAccount.Potential_Total_Savings__c = '$12,956.85';
        insert testAccount;

        Pricebook2 testPriceBook = TestDataGenerator.createTestPriceBook();
        insert testPriceBook;

        Opportunity testOpportunity = TestDataGenerator.createTestOpportunity(testAccount);
        insert testOpportunity;

        Contact testContact = TestDataGenerator.createTestContact(testAccount);
        insert testContact;

        Product2 testProduct = TestDataGenerator.createTestProduct();
        insert testProduct;

        PricebookEntry testPriceBookEntry = TestDataGenerator.createTestPriceBookEntry(testProduct);
        insert testPriceBookEntry;
        //Making 10 Opportunity Lines/Opportunity Product Junctions
        List<OpportunityLineItem> opportunityLines = new List<OpportunityLineItem>();
        for(Integer x = 0; x < 10; x++) {
            OpportunityLineItem testOli = TestDataGenerator.createTestOpportunityProduct(testProduct, testPriceBookEntry, testOpportunity);
            opportunityLines.add(testOli);
        }
        insert opportunityLines;

    }
}