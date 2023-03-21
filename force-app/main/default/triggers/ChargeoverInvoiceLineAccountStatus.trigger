trigger ChargeoverInvoiceLineAccountStatus on ChargeOver_Invoice_Line_Item__c (after insert, after update) {
    List<Id> changeStatusIds = new List<Id>();
    for(ChargeOver_Invoice_Line_Item__c coili : Trigger.new){
        if(Trigger.isInsert){
            changeStatusIds.add(coili.Account__c);
            
        //Updates
        } else {
            ChargeOver_Invoice_Line_Item__c oldInvoiceLine = Trigger.oldMap.get(coili.Id);
            if(oldInvoiceLine.Payment_Type__c != coili.Payment_Type__c
            || oldInvoiceLine.Number_of_Recurs__c != coili.Number_of_Recurs__c){
                changeStatusIds.add(coili.Account__c);
            }
        }
    }
    if(!changeStatusIds.isEmpty()){
        System.debug('Triggering from line items');
        AccountStatusHandler.assignAccountStatus(changeStatusIds);
    }
}