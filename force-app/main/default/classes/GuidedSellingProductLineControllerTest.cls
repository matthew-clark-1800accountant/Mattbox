@IsTest
public with sharing class GuidedSellingProductLineControllerTest {
    @IsTest static void mainTest() {
        Product2 p = new Product2(Name = 'Loan Agreement', IsActive=true, Guided_Selling_Identifier__c='Personal Return',
        ChargeOver__c = true, Environment__c='Standard',Billing_Frequency__c = 'Annual',HTML_Description__c = 'test', Description = 'test', No_Split_Allowed__c = true, sort_Order__c = 2);
        insert p;

        GuidedSellingProductLineController cont = new GuidedSellingProductLineController();
        cont.productValue = new GuidedSellingProduct(p);
        cont.setUnitPrice(cont.getUnitPrice());
        cont.setProdSubtotal(cont.getProdSubtotal());

        cont.productValue.adjustedPrice = null;
        cont.productValue.subtotal = 123;
        cont.setUnitPrice(cont.getUnitPrice());
        cont.setProdSubtotal(cont.getProdSubtotal());
        
        cont.setdisableQuantity(cont.getdisableQuantity());
        cont.setdisplayRow(cont.getdisplayRow());
        
        
    }
}