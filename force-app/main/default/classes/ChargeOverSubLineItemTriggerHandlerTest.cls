@IsTest
private class ChargeOverSubLineItemTriggerHandlerTest
{
    private static final User PORTAL_USER = [SELECT Id FROM User WHERE Alias = 'drepl'];

    @TestSetup
    static void testSetup()
    {
        System.runAs(PORTAL_USER)
        {
            Account pAccount = new Account(Name='Personal', Business_Account__c=false);
            insert pAccount;

            Contact cont = new Contact(AccountId=pAccount.Id, LastName='Pho', FirstName='Soup');
            insert cont;

            Product2 prod = new Product2(Name='TestProduct',Standard_Price__c=1.0,Description='Test',Family='Bookkeeping',SOW_Description__c='Test',ZZ_Primary_Category__c='Business');
            insert prod;

	        Product2 prodP = new Product2(Name='TestProductP',Standard_Price__c=1.0,Description='Test',Family='Bookkeeping',SOW_Description__c='Test',ZZ_Primary_Category__c='Personal');
	        insert prodP;

            //There is a queueable job that relates the ActiveSub to the SLI record.
            //Insert these two here because in the deletion process it cannot otherwise keep track of the Queueable job order. -SReyes

//            String startDateTime = '2016-10-30T15:27:02.000Z';
            Date expDate = Date.today().addDays(5);

            ChargeOver_Subscription__c sliSub = new ChargeOver_Subscription__c(Name='Test',Account__c=pAccount.Id, Subscription_Start_Date__c=Datetime.now(),Service_End_Date__c=expDate,Status__c='Active');
            insert sliSub;

            ChargeOver_Subscription_Line_Item__c sli = new ChargeOver_Subscription_Line_Item__c(ChargeOver_Subscription__c=sliSub.Id, Quantity__c=2, Account__c=pAccount.Id,
                    Product__c=prod.Id, Status__c='Active',Price_Per_Unit__c=10,Historical_Update__c=false,Subscription_Start_Date__c = Datetime.now());
            insert sli;

            // sli.Price_Per_Unit__c=10;
            // sli.Subscription_Start_Date__c = Datetime.now();
            // update sli;

            System.debug('Sub :: ' + sliSub);
            ChargeOver_Subscription__c hasDate = [SELECT Subscription_Start_Date__c FROM ChargeOver_Subscription__c WHERE Subscription_Start_Date__c != NULL LIMIT 1];
            System.debug('hasDate :: ' + hasDate);
            System.debug('ASL should exist :: ' + [SELECT Id, Status__c, Active_Subscription__c, ChargeOver_Subscription_Line_Item__c, ChargeOver_Subscription__r.Subscription_Start_Date__c, Start_Date__c FROM Active_Subscription_Line__c WHERE Start_Date__c != NULL]);

            Account nAccount = new Account(Name='Business', Business_Account__c=true);
            insert nAccount;
        }
    }

    @IsTest
    static void sli_TriggerHandler_Tests(){

        System.runAs(PORTAL_USER)
        {
            Account act = [SELECT Id FROM Account LIMIT 1];
            Product2 prod = [SELECT Id FROM Product2 LIMIT 1];
            ChargeOver_Subscription__c sliSub = [SELECT Id FROM ChargeOver_Subscription__c LIMIT 1];
            Test.startTest();

                ChargeOver_Subscription_Line_Item__c sli = new ChargeOver_Subscription_Line_Item__c(ChargeOver_Subscription__c=sliSub.Id, Quantity__c=5, Account__c=act.Id, Product__c=prod.Id,
                        Status__c='Active',Price_Per_Unit__c=13.0);
                insert sli;

                sli.Description__c = 'Updated';
                update sli;

            Test.stopTest();

            String guid = (String) sli.Product__c + (String) sli.Account__c;
            Active_Subscriptions__c sub = [SELECT Id, Unique_Identifier__c, Total_Purchased__c, Total_Applied__c, Subscription_Amount__c FROM Active_Subscriptions__c WHERE Unique_Identifier__c = : guid];
            Active_Subscription_Line__c line = [SELECT Id, Start_Date__c FROM Active_Subscription_Line__c WHERE Active_Subscription__c = :sub.Id LIMIT 1];

            System.debug('sub record :: ' + sub);
            System.assertNotEquals(null, sub, 'sub should have populated with a related Id.');
            System.assertNotEquals(null, sub.Total_Purchased__c, 'sub should have populated with a total purchased.');
            System.assertNotEquals(null, sub.Subscription_Amount__c, 'sub should have populated with an amount.');

            System.assertNotEquals(null, line, 'sub should have crated a related active sub line with a related Id.');
           System.assertNotEquals(null, line.Start_Date__c, 'ASL should have copied start date.');
        }
    }

    @IsTest
    static void activeSubTriggerHandlerTest()
    {

        System.runAs(PORTAL_USER)
        {
            Active_Subscriptions__c sub = [SELECT Id, Unique_Identifier__c, Total_Purchased__c, Total_Applied__c, Subscription_Amount__c FROM Active_Subscriptions__c];
            System.debug('sub record :: ' + sub);

            Test.startTest();
                sub.Line_Items_Last_Modified__c = Datetime.now();
                update sub;
            Test.stopTest();

            Active_Subscriptions__c subUpdated = [SELECT Id, Total_Applied__c, Total_Purchased__c, Subscription_Amount__c FROM Active_Subscriptions__c WHERE Unique_Identifier__c = : sub.Unique_Identifier__c];

            System.debug('subUpdated record :: ' + subUpdated);
            System.assertNotEquals(null, subUpdated, 'sub should have populated with a related Id.');
        }
    }

    @IsTest
    static void testStatusChanging()
    {
        System.runAs(PORTAL_USER)
        {
	        Product2 personal = [SELECT Id FROM Product2 WHERE Name = 'TestProductP' LIMIT 1];
	        System.debug('personal product ' + personal );

            ChargeOver_Subscription__c sub = [SELECT Id, Subscription_Start_Date__c, Account__c FROM ChargeOver_Subscription__c];
            sub.Status__c = 'Suspended';
            update sub;

            ChargeOver_Subscription_Line_Item__c isSuspended = [SELECT Id FROM ChargeOver_Subscription_Line_Item__c WHERE ChargeOver_Subscription__c = :sub.Id LIMIT 1];
	        isSuspended.Historical_Update__c = true;
	        isSuspended.Product__c = personal.Id;
	        isSuspended.Cancel_Date_Time__c = Datetime.now();

            Test.startTest();
                update isSuspended;
            Test.stopTest();

	        ChargeOver_Subscription_Line_Item__c sli = [SELECT Id, Status__c, Product__c FROM ChargeOver_Subscription_Line_Item__c WHERE Id = : isSuspended.Id LIMIT 1];
	        System.debug('sli to match :: ' + sli);
            Active_Subscription_Line__c verifySuspend = [SELECT Status__c FROM Active_Subscription_Line__c WHERE ChargeOver_Subscription_Line_Item__c = : isSuspended.Id AND Status__c = 'Suspended' LIMIT 1];
            System.assertEquals(true,'Suspended'.equalsIgnoreCase(verifySuspend.Status__c), 'verify record :: ' + verifySuspend);
        }
    }

    @IsTest
    static void testExpDate()
    {
        System.runAs(PORTAL_USER)
        {
            ChargeOver_Subscription__c sub = [SELECT Id, Subscription_Start_Date__c FROM ChargeOver_Subscription__c];
            //This date needs to be in the future vs today.
            sub.Service_End_Date__c = Date.today().addDays(5);
            update sub;

            ChargeOver_Subscription_Line_Item__c sli = [SELECT Id, Status__c, Cancel_Date_Time__c, ChargeOver_Subscription__c, Subscription_Start_Date__c, Service_End_Date__c FROM ChargeOver_Subscription_Line_Item__c LIMIT 1];
            sli.Cancel_Date_Time__c = Date.today().addDays(-1);
            sli.ChargeOver_Subscription__c = sub.Id;
            //Have to manually se values for these fields because items that calculate it do not exist in UAT.
            sli.Total_Refund_Amount__c = -150.0;
            sli.Total_Paid_Amount__c = 151.0;

            Test.startTest();
                update sli;
            Test.stopTest();
            System.debug('sli test record :: ' + sli);

            Active_Subscription_Line__c verifyPause = [SELECT Status__c FROM Active_Subscription_Line__c WHERE ChargeOver_Subscription_Line_Item__c = : sli.Id LIMIT 1];
            System.assertEquals(true,'cancelled'.equalsIgnoreCase(verifyPause.Status__c),'status should be cancelled but is ' + verifyPause.Status__c);
        }
    }

	@IsTest
	static void testDowngrade()
	{
		System.runAs(PORTAL_USER)
		{
			ChargeOver_Subscription__c sub = [SELECT Id, Name, Subscription_Start_Date__c FROM ChargeOver_Subscription__c];
            System.debug(sub);
			//This date needs to be in the future vs today.
			sub.Service_End_Date__c = Date.today().addDays(-5);
			update sub;

			ChargeOver_Subscription_Line_Item__c sli = [SELECT Id, Status__c, Product__c, Cancel_Date_Time__c, ChargeOver_Subscription__c, Subscription_Start_Date__c, Service_End_Date__c FROM ChargeOver_Subscription_Line_Item__c LIMIT 1];
			sli.Cancel_Date_Time__c = Date.today().addDays(-1);
			sli.ChargeOver_Subscription__c = sub.Id;
			//Have to manually se values for these fields because items that calculate it do not exist in UAT.
			sli.Total_Refund_Amount__c = -150.0;
			sli.Total_Paid_Amount__c = 151.0;
			sli.Applied_Account__c = [SELECT Id FROM Account LIMIT 1].Id;
			sli.Status__c = 'Cancelled';
			update sli;

			ChargeOver_Subscription__c subNew = sub.clone(false);
			//This date needs to be in the future vs today.
			subNew.Service_End_Date__c = Date.today().addDays(5);
			subNew.Converted_From_Subscription__c = sub.Id;
            subNew.Account__c = sli.Applied_Account__c;
			insert subNew;

			ChargeOver_Subscription_Line_Item__c newSli = new ChargeOver_Subscription_Line_Item__c();
			newSli.ChargeOver_Subscription__c = subNew.Id;
			newSli.Account__c = sli.Applied_Account__c;
			newSli.Converted_From_Subscription__c = subNew.Converted_From_Subscription__c;
			newSli.Total_Refund_Amount__c = 0;
			newSli.Status__c = 'Active';
			newSli.Quantity__c = 1;
			newSli.Product__c = sli.Product__c;
			insert newSli;

			System.debug('insertion should be done, update next...');

			Test.startTest();

			//These should never fire in the same execution context. Insert and update that is.
			//So we will set variable back to normal to see it mimic proper behavior.
			//So we will set variable back to normal to see it mimic proper behavior.

			newSli.Description__c = 'Updated';
			update newSli;
			ChargeOverSubLineItemTriggerHandler.testSwitchOff = true;

			Test.stopTest();

			System.debug('sli test record :: ' + sli);

			Active_Subscription_Line__c verifyPause = [SELECT Status__c, Unique_Identifier__c FROM Active_Subscription_Line__c WHERE ChargeOver_Subscription_Line_Item__c = : sli.Id LIMIT 1];
			System.assertEquals(true,'cancelled'.equalsIgnoreCase(verifyPause.Status__c),'status should be cancelled but is ' + verifyPause.Status__c);

			Active_Subscription_Line__c[] verifyDowngrade = [SELECT Converted_From_Subscription__c, Status__c, Unique_Identifier__c, ChargeOver_Subscription_Line_Item__c, Converted_From_ASL__c FROM Active_Subscription_Line__c WHERE Converted_From_Subscription__c = :sub.Id];
			System.debug('downgrades :: ' + verifyDowngrade);

			System.assertEquals(sub.Id, verifyDowngrade[0].Converted_From_Subscription__c);
			System.assertNotEquals(null, verifyDowngrade[0].Converted_From_ASL__c, 'Should be the id of other original ASL.');

		}
	}

    //Note to self - may need to manually update the SLI after changing it.
    //It would automatically go through the trigger handler before the batch class has a chance to fire on it.
    //Need a way to test that without firing the trigger code first.
    //Thought - could use the trigger control panel and turn off the trigger from within the specific test.
    //Update the needed fields, then turn the trigger back on and run the batch job. -SReyes
}