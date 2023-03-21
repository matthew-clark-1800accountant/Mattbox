@IsTest
private class ZuoraSubProdChargeTriggerHandlerTest {
    
    @TestSetup static void setupTestData() {
        Id myId = UserInfo.getUserId();
        Id userId = [SELECT Id FROM User WHERe Id != : myId LIMIT 1].Id;

        Account account = new Account(
            Name = 'Test Account',
            P2C_Customer_ID__c = '123',
            OwnerId = myId
        );
        insert account;


        Contact con = new Contact(
            FirstName = 'Zuora',
            LastName = 'Test Contact',
            OwnerId = userId,
            AccountId = account.Id
        );
        insert con;
        
        account.Primary_Contact__c = con.Id;
        update con;

	    Zuora__Product__c[] zProducts = new Zuora__Product__c[0];
	    for(Integer i = 0; i < 5; i++){
		    Zuora__Product__c zProduct = new Zuora__Product__c(
				    Zuora__External_Id__c = '1234' + i,
				    Name='Test Product'
		    );
		    zProducts.add(zProduct);

	    }

        insert zProducts;

        Zuora__Subscription__c zSubscription = new Zuora__Subscription__c(
            Zuora__Zuora_Id__c = '12345'
        );
        insert zSubscription;

	    Product2[] products = new Product2[0];
	    for(Integer i = 0; i < 5; i++){
		    Product2 product = new Product2(
				    Name = 'Test Product',
				    zqu__ZuoraId__c = '1234' + i,
				    Product_Category__c = 'Bookkeeping',
				    Description = 'Test Product',
				    Family = 'TestFamily',
				    SOW_Description__c = 'TestSOW'
		    );
		    products.add(product);

	    }
        insert products;

	    Zuora__SubscriptionProductCharge__c[] subs = new Zuora__SubscriptionProductCharge__c[0];
	    for(Integer i = 0; i < 3; i++){
		    Zuora__SubscriptionProductCharge__c subProdCharge = new Zuora__SubscriptionProductCharge__c(
				    Zuora__Account__c = account.Id,
				    Zuora__Price__c = 20,
				    Zuora__EffectiveStartDate__c = System.today(),
				    Zuora__EffectiveEndDate__c = null,
				    Zuora__BillingPeriod__c = 'Annual',
				    Zuora__Product__c = zProducts[i].Id,
				    Zuora__Subscription__c = zSubscription.Id,
				    Name = products[i].Name
		    );
		    subs.add(subProdCharge);
	    }

        insert subs;
        //Create ActiveSub because one doesn't exist yet.
        update subs;

        Zuora__Subscription__c[] zSubscriptionPost = [SELECT Id, Zuora__Status__c FROM Zuora__Subscription__c WHERE Id = :zSubscription.Id];
        System.debug(LoggingLevel.DEBUG, 'zSubscriptionPost ' + zSubscriptionPost);

    }

    @IsTest static void test_updateActiveSubscriptions () {
        System.debug(LoggingLevel.DEBUG, 'test_updateActiveSubscriptions started');

        Test.startTest();
        
        Zuora__SubscriptionProductCharge__c subProdCharge = [SELECT Id FROM Zuora__SubscriptionProductCharge__c LIMIT 1];
        update subProdCharge;

        Test.stopTest();

        Active_Subscriptions__c newSubscription = [
            SELECT Id, Subscription_Amount__c, Category__c, Subscription_Item__c, SOW_Description__c, Product__c FROM Active_Subscriptions__c WHERE Subscription_Amount__c = 20 LIMIT 1
        ];
	    System.assertNotEquals(null, newSubscription.Product__c);
        System.assertEquals(20, newSubscription.Subscription_Amount__c);

	    System.assertNotEquals(null, newSubscription.SOW_Description__c);
	    System.assertNotEquals(null, newSubscription.Subscription_Item__c);
	    System.assertNotEquals(null, newSubscription.Category__c);
    }

    @IsTest
    private static void testCancellation(){
        System.debug(LoggingLevel.DEBUG, 'testCancellation started');

        Zuora__SubscriptionProductCharge__c subProdCharge = [SELECT Id, Name, Zuora__Account__c, Zuora__Subscription__c FROM Zuora__SubscriptionProductCharge__c LIMIT 1];
        System.debug(LoggingLevel.DEBUG, 'returning active sub ' + [SELECT Id, Account__c FROM Active_Subscriptions__c]);

        Zuora__Subscription__c zSubscription = [SELECT Id, Zuora__Status__c FROM Zuora__Subscription__c WHERE Id = :subProdCharge.Zuora__Subscription__c LIMIT 1];
        System.debug(LoggingLevel.DEBUG, 'returning zSubscription ' + zSubscription);

        Account act = [SELECT Id FROM Account WHERE Id =: subProdCharge.Zuora__Account__c LIMIT 1];
        act.Cancelled_Date__c = Date.today();
        update act;


        Test.startTest();
        System.debug(LoggingLevel.DEBUG, 'testCancellation start test block');

        zSubscription.Zuora__Status__c = 'Cancelled';
        update zSubscription;

        System.debug(LoggingLevel.DEBUG, 'testCancellation end test block');
        Test.stopTest();

        
        Active_Subscriptions__c[] subExists = [ SELECT Id, Cancelled_Date__c FROM Active_Subscriptions__c];
        System.debug(LoggingLevel.DEBUG, 'subExists :: ' + subExists);
        
        Contact hasOwner = [SELECT Id FROM Contact WHERE OwnerId != null LIMIT 1];
        System.assertNotEquals(null, hasOwner);

    }

    @IsTest
    private static void testDeletion(){
        System.debug(LoggingLevel.DEBUG, 'testCancellation started');

        Zuora__SubscriptionProductCharge__c subProdCharge = [SELECT Id, Name, Zuora__Account__c, Zuora__Subscription__c FROM Zuora__SubscriptionProductCharge__c LIMIT 1];
        System.debug(LoggingLevel.DEBUG, 'returning active sub ' + [SELECT Id, Account__c FROM Active_Subscriptions__c]);

        Zuora__Subscription__c zSubscription = [SELECT Id, Zuora__Status__c FROM Zuora__Subscription__c WHERE Id = :subProdCharge.Zuora__Subscription__c LIMIT 1];
        System.debug(LoggingLevel.DEBUG, 'returning zSubscription ' + zSubscription);

        Account act = [SELECT Id FROM Account WHERE Id =: subProdCharge.Zuora__Account__c LIMIT 1];
        act.Cancelled_Date__c = Date.today();
        update act;

        zSubscription.Zuora__Status__c = 'Cancelled';
        update zSubscription;


        Test.startTest();
            System.debug(LoggingLevel.DEBUG, 'testDelete start test block');
            delete subProdCharge;
        Test.stopTest();

        System.debug(LoggingLevel.DEBUG, 'testDelete end test block');


        Active_Subscriptions__c[] subNotExists = [ SELECT Id FROM Active_Subscriptions__c WHERE IsDeleted = true ALL ROWS ];
        System.debug(LoggingLevel.DEBUG, 'subNotExists :: ' + subNotExists);

        System.assertNotEquals(null, subNotExists);


    }

}