public without sharing class C62PaymentReceiptController{
    public String purchased{get;set;}
    public Decimal monthlyCharge{get;set;}
    public Bill62__Payment__c thePayment{get;set;}
    public Date orderDate{get;set;}
    public ID paymentID{get;set;}
    public Integer debug{get;set;}

    public C62PaymentReceiptController(){

    }
    
    public Bill62__Payment__c getPayment(){
        system.debug('paymentID: '+paymentID);
        purchased = '';
        monthlyCharge = 0.0;
        debug = 0;
        thePayment = new Bill62__Payment__c();
        orderDate = System.Date.TODAY();
        List<Bill62__payment__c> payList = [SELECT ID,Name, Bill62__Subscription__c, Bill62__Subscription__r.Bill62__Order__c, Bill62__Amount__c,
            Bill62__Payment_Method__r.Name, Bill62__Subscription__r.Bill62__Billing_Schedule__c, Bill62__Processing_Message__c, Bill62__Amount_Used__c,
            Bill62__Subscription__r.Bill62__Start_Date__c,
            Bill62__Payment_Method__r.Bill62__Billing_Address__r.Bill62__Street_1__c,Bill62__Payment_Method__r.Bill62__Billing_Address__r.Bill62__Street_2__c,
            Bill62__Payment_Method__r.Bill62__Billing_Address__r.Bill62__City__c,Bill62__Payment_Method__r.Bill62__Billing_Address__r.Bill62__State_Province__c,
            Bill62__Payment_Method__r.Bill62__Billing_Address__r.Bill62__Country__c,Bill62__Payment_Method__r.Bill62__Billing_Address__r.Bill62__Zip_Postal_Code__c
            FROM Bill62__Payment__c WHERE ID = :paymentID];
        if(payList.size() > 0){
            thePayment = payList[0];
            system.debug('found a payment: '+thePayment);
            //thePayment.Bill62__Processing_Message__c = '';
            //thePayment.Bill62__Amount_Used__c = 0.0;
        }
        
        
        if(thePayment.Bill62__Subscription__r.Bill62__Order__c != null){
            //calculate for entire Order
            List<Bill62__Subscription__c> subList = [SELECT ID, Bill62__Product__c, Bill62__Product__r.Name,Bill62__Start_Date__c FROM Bill62__Subscription__c
                WHERE Bill62__Order__c = :thePayment.Bill62__Subscription__r.Bill62__order__c AND Bill62__Termination_Date__c = null AND Bill62__End_Date__c >= TODAY];
            Set<String> productIDs = new Set<String>();
            List<String> purchasedThings = new List<String>();
            for(Bill62__Subscription__c sub: subList){
                productIDs.add(sub.Bill62__Product__c);
                purchasedThings.add(sub.Bill62__Product__r.Name);
                //orderDate = sub.Bill62__Start_Date__c;
                system.debug('O adding product: '+sub.Bill62__Product__r.Name);
                List<Bill62__Billing_Schedule_Line__c> bslList = [SELECT ID, Bill62__Charge_Amount__c FROM Bill62__Billing_Schedule_Line__c
                WHERE Bill62__Charge_Month__c = 1.0 AND Bill62__Billing_Schedule__r.Bill62__Product__c = :sub.Bill62__Product__c
                AND Bill62__Type__c = 'Recurring'];
                for(Bill62__Billing_Schedule_Line__c bsl: bslList){
                    if(bsl.Bill62__Charge_Amount__c != null){ 
                        debug++;
                        monthlyCharge += bsl.Bill62__Charge_Amount__c;
                        system.debug('O adding to monthly charge, its now: '+monthlyCharge);
                    }
                }
            }
            purchased = String.join(purchasedThings,', ');

        }else{
            //if(thePayment.Id == null) return thePayment;
            //calculate for just that Subscription
            List<Bill62__Subscription__c> subList = [SELECT ID, Bill62__Product__c, Bill62__Product__r.Name FROM Bill62__Subscription__c
                WHERE ID = :thePayment.Bill62__Subscription__c];
            if(subList.size() > 0){
                Bill62__Subscription__c theSub = subList[0];
                purchased = theSub.Bill62__Product__r.Name;
                system.debug('adding product: '+theSub.Bill62__Product__r.Name);
                List<Bill62__Billing_Schedule_Line__c> bslList = [SELECT ID, Bill62__Charge_Amount__c FROM Bill62__Billing_Schedule_Line__c
                    WHERE Bill62__Charge_Month__c = 1 AND Bill62__Billing_Schedule__r.Bill62__Product__c = :theSub.Bill62__Product__c];
                    
                for(Bill62__Billing_Schedule_Line__c bsl: bslList){
                    if(bsl.Bill62__Charge_Amount__c != null){ 
                        monthlyCharge += bsl.Bill62__Charge_Amount__c;
                        system.debug('adding to monthly charge, its now: '+monthlyCharge);
                    }
                }
            }
        }
        return thePayment;//new List<Bill62__Payment__c>();
    }
}