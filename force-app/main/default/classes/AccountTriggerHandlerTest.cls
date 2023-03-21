@IsTest
private class AccountTriggerHandlerTest
{
    private static final User PORTAL_USER = [SELECT Id FROM User WHERE Alias = 'drepl'];

    @TestSetup
    private static void createTestData()
    {

        System.runAs(PORTAL_USER)
        {
            Account pAccount = new Account(Name='Personal', Business_Account__c=false);
            insert pAccount;

            Contact cont = new Contact(AccountId=pAccount.Id, LastName='Pho', FirstName='Soup');
            insert cont;

            Product2 prod = new Product2(Name='TestProduct',Standard_Price__c=1.0,Description='Test',Family='Bookkeeping',SOW_Description__c='Test',ZZ_Primary_Category__c='Business');
            insert prod;

            //There is a queueable job that relates the ActiveSub to the SLI record.
            //Insert these two here because in the deletion process it cannot otherwise keep track of the Queueable job order. -SReyes

            ChargeOver_Subscription__c sliSub = new ChargeOver_Subscription__c(Name='Test',Account__c=pAccount.Id);
            insert sliSub;

            ChargeOver_Subscription_Line_Item__c sli = new ChargeOver_Subscription_Line_Item__c(ChargeOver_Subscription__c=sliSub.Id, Quantity__c=2, Account__c=pAccount.Id, Product__c=prod.Id, Status__c='Active',Price_Per_Unit__c=10.0);
            insert sli;

            sli.Price_Per_Unit__c=10;
            update sli;

            System.debug(LoggingLevel.DEBUG, 'ASL should exist :: ' + [SELECT Id FROM Active_Subscription_Line__c WHERE Account__c = :pAccount.Id]);

            Account nAccount = new Account(
                    Name='Business',
                    Business_Account__c=true,
                    IS_FROM_CHARGEOVER__c=true,
                    Ready_for_sync_to_ChargeOver__c=true,
                    BillingState='TX',
                    BillingStreet='121 Birdseed Way',
                    BillingPostalCode='77584',
                    BillingCity='Pearland',
                    BillingCountry='USA',
                    ChargeOver_ID__c='123'
            );
            insert nAccount;

            insert new AccountContactRelation(AccountId=nAccount.Id,ContactId=cont.Id);
        }
    }
    @IsTest
    private static void testSetupResultsCheck()
    {
        Account act = [SELECT Id FROM Account WHERE Business_Account__c = TRUE LIMIT 1];
        Test.startTest();
            Active_Subscription_Line__c related = [SELECT Id FROM Active_Subscription_Line__c WHERE Applied_Account__c = :act.Id LIMIT 1];
        Test.stopTest();
        System.assertNotEquals(null, related, 'should have found related ASL for account :: ' + act);
        System.debug('testBehavior completed');
    }

    @IsTest
    private static void testAfterUpdateTriggerMethod()
    {
        Account[] accounts = [
                SELECT Id, IS_FROM_CHARGEOVER__c,LAST_SOURCE__c,Ready_for_sync_to_ChargeOver__c,Primary_Contact_Email__c,Primary_Contact_First_Name__c, Name,
                        Primary_Contact_Last_Name__c,Primary_Contact_Phone__c, BillingCity, BillingState, BillingStreet, BillingPostalCode, BillingCountry,ChargeOver_ID__c
                FROM Account];
        Boolean successfulRun = false;

        Integer counter = 0;
        for(Account act : accounts)
        {
            act.ChargeOver_ID__c = act.ChargeOver_ID__c + counter;
            counter++;
        }

        Test.startTest();
        try {
//            AccountTriggerHandler.chargeOverAfterUpdate(accounts);
            update accounts;

            successfulRun = true;
        }catch(Exception err){
            System.debug('test.chargeOverAfterUpdate() failed with err :: ' + err);
        }
        Test.stopTest();

        System.assertNotEquals(false, successfulRun, 'should be true from successful run of testAfterUpdateTriggerMethod() test class.');
    }

    @IsTest
    private static void testAfterUpdateTriggerMethod2()
    {
        Account[] accounts = [
                SELECT Id, IS_FROM_CHARGEOVER__c,LAST_SOURCE__c,Ready_for_sync_to_ChargeOver__c,Primary_Contact_Email__c,Primary_Contact_First_Name__c, Name,
                        Primary_Contact_Last_Name__c,Primary_Contact_Phone__c, BillingCity, BillingState, BillingStreet, BillingPostalCode, BillingCountry,ChargeOver_ID__c
                FROM Account];
        for(Account act : accounts){ act.ChargeOver_ID__c = null; }

        Boolean successfulRun = false;
        Test.startTest();
        try {
            update accounts;
//            AccountTriggerHandler.chargeOverAfterUpdate(accounts);
            successfulRun = true;
        }catch(Exception err){
            System.debug('test.chargeOverAfterUpdate2() failed with err :: ' + err);
        }
        Test.stopTest();

        System.assertNotEquals(false, successfulRun, 'should be true from successful run of testAfterUpdateTriggerMethod() test class.');
    }

    @IsTest
    private static void testAfterInsertTriggerMethod()
    {
        Account[] accounts = [
                SELECT Id, IS_FROM_CHARGEOVER__c,LAST_SOURCE__c,Ready_for_sync_to_ChargeOver__c,Primary_Contact_Email__c,Primary_Contact_First_Name__c, Name,
                        Primary_Contact_Last_Name__c,Primary_Contact_Phone__c, BillingCity, BillingState, BillingStreet, BillingPostalCode, BillingCountry,ChargeOver_ID__c
                FROM Account];
        Boolean successfulRun = false;
        Test.startTest();
        try {
            AccountTriggerHandler.chargerOverAfterInsert(accounts);
            successfulRun = true;
        }catch(Exception err){
            System.debug('test.chargerOverAfterInsert() failed with err :: ' + err);
        }
        Test.stopTest();

        System.assertNotEquals(false, successfulRun, 'should be true from successful run of testAfterInsertTriggerMethod() test class.');
    }
}