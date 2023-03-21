@IsTest
public with sharing class ChargeOver_Quote_Test
{

    @TestSetup
    private static void dataGenerator()
    {
        Account act = new Account(Name='I am an account');
        insert act;
        
        Product2 p = new Product2(
            Name='Test product',
            Setup_Fee__c='One-Time'
        	);
        insert p;
        
        Product2 p2 = new Product2(
            Name='Test product 2', 
            Price_Increase_Percent__c=7, 
            Months_Before_Effective_Price_Increase__c=12);
        insert p2;

        ChargeOver_Quote__c quote = new ChargeOver_Quote__c(Account__c=act.Id, Installment_Payment_Schedule__c=4, Quote_Number__c='1',Redirect_URL__c='http://blog.com');
        insert quote;

        ChargeOver_Quote_Line_Item__c sli1 = new ChargeOver_Quote_Line_Item__c(
            ChargeOver_Quote__c=quote.Id, 
            Product__c=p.Id, 
            HTML_Description__c='<b>test</b>', 
            of_Free_Trial_Cycles_Cycles_to_Skip__c=1, 
            Date_Time_Invoice_Being_Held_Until__c='2022-01-01'
        	);
        
		insert sli1;
        
        ChargeOver_Quote_Line_Item__c sli2 = new ChargeOver_Quote_Line_Item__c(
            ChargeOver_Quote__c=quote.Id, 
            Product__c=p.Id, 
			HTML_Description__c='<b>test</b>', 
            Product_Description__c='test', 
			of_times_this_should_recur__c=3,
			Applied_Account__c=act.Id,
            Contract_Amount__c=1000
        	);
        
		insert sli2;
        
        ChargeOver_Quote_Line_Item__c sli3 = new ChargeOver_Quote_Line_Item__c(
            ChargeOver_Quote__c=quote.Id, 
            Product__c=p.Id, 
            HTML_Description__c='<b>test</b>', 
            of_Free_Trial_Cycles_Cycles_to_Skip__c=1, 
            Date_Time_Invoice_Being_Held_Until__c='2022-01-01'
        	);
        
		insert sli3;
        
        ChargeOver_Quote_Line_Item__c sli4 = new ChargeOver_Quote_Line_Item__c(
            ChargeOver_Quote__c=quote.Id, 
            Product__c=p.Id, 
            HTML_Description__c='<b>test</b>', 
            Date_Time_Invoice_Being_Held_Until__c='2023-01-01'
        	);
        
		insert sli4;
    }

    @IsTest
    private static void testQuoteCreation()
    {
        ChargeOver_Quote__c quote = [SELECT Id FROM ChargeOver_Quote__c LIMIT 1];
        System.assertNotEquals(null, quote);
    }

    @IsTest
    private static void testQuoteUpdate()
    {
        ChargeOver_Quote__c quote = [SELECT Id, Account__c FROM ChargeOver_Quote__c LIMIT 1];
        System.assertNotEquals(null, quote);

        Test.startTest();

            quote.Status__c = 'Active';
            quote.Quote_Created__c = true;
            update quote;

        Test.stopTest();

        //Needs some kind of assertion.
    }

    @IsTest
    private static void testQuoteDelete()
    {
        ChargeOver_Quote__c quote = [SELECT Id, Account__c FROM ChargeOver_Quote__c LIMIT 1];
        System.assertNotEquals(null, quote);

        Test.startTest();

            delete quote;

        Test.stopTest();

        ChargeOver_Quote__c deleted = [SELECT Id FROM ChargeOver_Quote__c WHERE IsDeleted = TRUE LIMIT 1 ALL ROWS];
        System.assertNotEquals(null, deleted);
    }
}