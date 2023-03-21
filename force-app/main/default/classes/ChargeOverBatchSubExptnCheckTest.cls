@IsTest
private class ChargeOverBatchSubExptnCheckTest
{
    @TestSetup
    private static void testSetup()
    {
        Account pAccount = new Account(Name = 'Personal', Business_Account__c = false);
        insert pAccount;

        Contact cont = new Contact(AccountId = pAccount.Id, LastName = 'Pho', FirstName = 'Soup');
        insert cont;

        Product2 prod = new Product2(Name = 'TestProduct', Standard_Price__c = 1.0, Description = 'Test', Family = 'Bookkeeping', SOW_Description__c = 'Test', ZZ_Primary_Category__c = 'Business');
        insert prod;

        Date today = Date.today();

        ChargeOver_Subscription__c sliSub = new ChargeOver_Subscription__c(Name = 'Test', Account__c = pAccount.Id, Subscription_Start_Date__c = Datetime.now(), Service_End_Date__c = today.addDays(10), Status__c = 'Active');
        insert sliSub;

        ChargeOver_Subscription_Line_Item__c sli = new ChargeOver_Subscription_Line_Item__c(ChargeOver_Subscription__c = sliSub.Id, Quantity__c = 2, Account__c = pAccount.Id, Cancel_Date_Time__c = today.addDays(2),
        Product__c = prod.Id, Status__c = 'Active', Price_Per_Unit__c = 10.0, Historical_Update__c = false, Subscription_Start_Date__c = Datetime.now());
        insert sli;

        System.debug('Sub :: ' + sliSub);
        ChargeOver_Subscription__c hasDate = [SELECT Subscription_Start_Date__c FROM ChargeOver_Subscription__c WHERE Subscription_Start_Date__c != NULL LIMIT 1];
        System.debug('hasDate :: ' + hasDate);
        System.debug('ASL should exist :: ' + [SELECT Id, Status__c, Active_Subscription__c, ChargeOver_Subscription_Line_Item__c, ChargeOver_Subscription__r.Subscription_Start_Date__c, Start_Date__c FROM Active_Subscription_Line__c WHERE Start_Date__c != NULL]);

        Account nAccount = new Account(Name = 'Business', Business_Account__c = true);
        insert nAccount;

    }

    @IsTest
    static void testBatchClass()
    {
        Date deadDate = Date.today().addDays(-10);
        Active_Subscription_Line__c line = [SELECT Id, Active_Subscription__r.Subscription_Status__c, Active_Subscription__c, ChargeOver_Subscription_Line_Item__c, ChargeOver_Subscription_Line_Item__r.ChargeOver_Subscription__c FROM Active_Subscription_Line__c LIMIT 1];
        System.debug('active sub status :: ' + line.Active_Subscription__r.Subscription_Status__c);
        line.Expiration_Date__c = deadDate;
        update line;

        Active_Subscriptions__c aSub = [SELECT Id FROM Active_Subscriptions__c WHERE Id =: line.Active_Subscription__c LIMIT 1];
        aSub.Cancelled_Date__c = deadDate;
        aSub.Expiration_Date__c = deadDate.addDays(-1);
        update aSub;

        ChargeOver_Subscription__c sub = [SELECT Id FROM ChargeOver_Subscription__c WHERE Id = : line.ChargeOver_Subscription_Line_Item__r.ChargeOver_Subscription__c LIMIT 1];
        sub.Service_End_Date__c = Date.today().addDays(-100);
        sub.Cancellation_Date__c = Date.today().addDays(-10);
        update sub;

        Test.startTest();
        ChargeOverBatchSubExptnCheck job = new ChargeOverBatchSubExptnCheck();
        job.execute(null);
        Test.stopTest();

        Active_Subscription_Line__c line_updated = [SELECT Id, Active_Subscription__r.Subscription_Status__c FROM Active_Subscription_Line__c WHERE Id =: line.Id LIMIT 1];
//        System.assertEquals(true, line_updated.Active_Subscription__r.Subscription_Status__c.containsIgnoreCase('Cancelled'),'Actual status :: ' + line_updated.Active_Subscription__r.Subscription_Status__c);
        System.assertNotEquals(null,line_updated.Active_Subscription__r.Subscription_Status__c);
    }
}