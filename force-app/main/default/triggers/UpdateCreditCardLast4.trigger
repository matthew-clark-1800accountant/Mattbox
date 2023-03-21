trigger UpdateCreditCardLast4 on Bill62__Payment_Method__c (before insert, before update) {

    for(Bill62__Payment_Method__c pm : Trigger.new){
        if(pm.Bill62__Card_Number__c != null && pm.Bill62__Card_Number__c.length() > 4){
            pm.Credit_Card_Last_4__c = pm.Bill62__Card_Number__c.right(4);
        }
    }
}