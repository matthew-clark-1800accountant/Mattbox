@isTest
public class TestDataGeneratorTest {
@isTest
    public static void generateData() {
        Id profileId = UserInfo.getProfileId();
        User user = TestDataGenerator.createTestUser(profileId);
        insert user;
        System.assertNotEquals(null, user);

        Lead lead = TestDataGenerator.createTestLead(user.Id);
        insert lead;
        System.assertNotEquals(null, lead);

        Account account = TestDataGenerator.createTestAccount(user.Id);
        insert account;
        System.assertNotEquals(null, account);

        Account account2 = TestDataGenerator.createTestAccountWithoutOwner();
        insert account2;
        System.assertNotEquals(null, account2);

        Opportunity opportunity = TestDataGenerator.createTestOpportunity(account);
        insert opportunity;
        System.assertNotEquals(null, opportunity);

        Contact contact = TestDataGenerator.createTestContact(account);
        insert contact;
        System.assertNotEquals(null, contact);

        Product2 product = TestDataGenerator.createTestProduct();
        insert product;        
        System.assertNotEquals(null, product);

        PricebookEntry priceBookEntry = TestDataGenerator.createTestPriceBookEntry(product);
        insert priceBookEntry;
        System.assertNotEquals(null, opportunity);

        OpportunityLineItem oppLineItem = TestDataGenerator.createTestOpportunityProduct(product, priceBookEntry, opportunity);
        System.assertNotEquals(null, oppLineItem);
    }
}