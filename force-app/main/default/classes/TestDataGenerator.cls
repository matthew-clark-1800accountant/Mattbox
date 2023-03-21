global class TestDataGenerator {
    public static User createTestUser(Id profileId) {
        String uniqueName = UserInfo.getOrganizationId() + String.valueof(Datetime.now()).deleteWhitespace().replace(':','').replace('-','') + Crypto.getRandomInteger();
        User testUser = new User(  
            FirstName = Fake.firstName(),                      
            LastName = Fake.lastName(),
            ProfileId = profileId,
            Email = uniqueName + '@1800accountant.com',
            Username = uniqueName + '@1800accountant.com',
            EmailEncodingKey = 'ISO-8859-1',
            Alias = uniqueName.substring(18, 23),
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US'
        );
        return testUser;
    }

    public static Lead createTestLead(Id OwnerId) {
        Lead testLead = new Lead(
            OwnerId = OwnerId,
            FirstName = Fake.firstName(),
            LastName = Fake.lastName(),
            Company = Fake.companyName(),
            Distribute_Date__c = Date.today().addDays(-15),
            Date_For_Reassignment__c = Date.today()
        );
        return testLead;
    }

    public static Account createTestAccount(Id OwnerId) {
        Account testAccount = new Account(
            OwnerId = OwnerId,
            Name = Fake.firstName() + ' ' + Fake.lastName(),
            Distribute_Date__c = Date.today().addDays(-15),
            Pitched_Date__c = Date.today().addDays(-15),
            Date_For_Reassignment__c = Date.today()
        );
        return testAccount;
    }

    public static Account createTestAccountWithoutOwner() {
        Account testAccount = new Account(
            Name = Fake.firstName() + ' ' + Fake.lastName(),
            Distribute_Date__c = Date.today().addDays(-15),
            Pitched_Date__c = Date.today().addDays(-15),
            Date_For_Reassignment__c = Date.today()
        );
        return testAccount;
    }

    public static Opportunity createTestOpportunity(Account account) {
        Opportunity testOpportunity = new Opportunity(
            Name = Fake.firstName() + ' ' + Fake.lastName(),
            Amount = 100,
            CloseDate = Date.today(),
            StageName = 'New',
            AccountId = account.Id
        );
        return testOpportunity;
    }

    public static Contact createTestContact(Account account) {
        Contact testContact = new Contact(
            FirstName = Fake.firstName(),
            LastName = Fake.lastName(),
            AccountId = account.Id

        );
        return testContact;
    }

    public static Product2 createTestProduct() {
        Product2 testProduct = new Product2(
            Name = Fake.productName(),
            zqu__SKU__c = String.valueOf(Crypto.getRandomInteger()),
            IsActive = true
        );
        return testProduct;
    }

    public static Pricebook2 createTestPriceBook() {
        Pricebook2 testPriceBook = new Pricebook2(
            Name = 'Standard Price Book',
            IsActive = true
        );
        return testPriceBook;
    }

    public static PricebookEntry createTestPriceBookEntry(Product2 product) {
        PricebookEntry testPriceBook = new PricebookEntry(
            UnitPrice = 123,
            Product2Id = product.Id,
            //Using the standard price book here, may need another method for custom in the future
            Pricebook2Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        return testPriceBook;
    }

    public static OpportunityLineItem createTestOpportunityProduct(Product2 product, PricebookEntry priceBookEntry, Opportunity opportunity) {
        OpportunityLineItem testOli = new OpportunityLineItem(
            Product2Id = product.Id,
    		OpportunityId = opportunity.Id,
            PricebookEntryId = priceBookEntry.Id,
    		Quantity = 1,
    		TotalPrice = 123
        );
        return testOli;
    }

    public static Event createTestEvent() {
        Event event = new Event(
            DurationInMinutes = 30,
            ActivityDateTime = Date.today(),
            Subject = 'Tax Consultation'
        );
        return event;
    }
}