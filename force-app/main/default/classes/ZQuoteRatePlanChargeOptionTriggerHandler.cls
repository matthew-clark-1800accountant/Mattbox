public class ZQuoteRatePlanChargeOptionTriggerHandler {
	public static void updateCharges(List<zqu__QuoteRatePlanChargeOption__c> options){
        List<zqu__QuoteRatePlanCharge__c> charges = new List<zqu__QuoteRatePlanCharge__c>();
        for (zqu__QuoteRatePlanChargeOption__c option : options){
            zqu__QuoteRatePlanCharge__c charge = new zqu__QuoteRatePlanCharge__c(
                Id=option.zqu__QuoteRatePlanCharge__c,
                GroupId__c=option.InvoiceName__c,
                InvoiceName__c=option.InvoiceName__c,
                Price_Description__c=option.Price_Description__c,
                ProductDescription__c=option.ProductDescription__c.left(255)
            );
            charges.add(charge);
        }
        if (!charges.isEmpty()){
            update charges;
        }
    }
}

/*
list<contact>  theContacts = [select id, accountid, name from contact limit 5];
list<account> updateAccounts = new list<account>();
for(contact con : theContacts)
{
    account thisContactsAccount = new account(Id=con.accountid);
    thisContactsAccount.name = 'blah blah blah';
    updateAccounts.add(thisContactsAccount);
}
update updateAccounts;
*/