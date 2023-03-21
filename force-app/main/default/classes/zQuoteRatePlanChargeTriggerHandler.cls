public class zQuoteRatePlanChargeTriggerHandler {
	public static void updateCharges(List<zqu__QuoteRatePlanCharge__c> charges){
        for (zqu__QuoteRatePlanCharge__c charge : charges){
            if (charge.ProductType__c == 'Bundle'){
                charge.GroupId__c = charge.zqu__ProductName__c;
                charge.InvoiceName__c = charge.zqu__ProductName__c;
                charge.Price_Description__c = charge.PriceDescriptionFormula__c;
                charge.ProductDescription__c = charge.ProductDescriptionFormula__c.left(255);
            } else {
                charge.GroupId__c = charge.zqu__ProductName__c + ' ' + charge.Name;
                charge.Price_Description__c = charge.PriceDescriptionFormula__c;
                charge.ProductDescription__c = charge.ProductDescriptionFormula__c.left(255);
            }
        }
    }
}