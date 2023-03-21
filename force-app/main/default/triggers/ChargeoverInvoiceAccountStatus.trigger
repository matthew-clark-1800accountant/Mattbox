trigger ChargeoverInvoiceAccountStatus on ChargeOver_Invoice__c (after insert, after update) {
    List<Id> changeStatusIds = new List<Id>();
    for(ChargeOver_Invoice__c coi : Trigger.new){
        if(Trigger.isInsert){
            changeStatusIds.add(coi.Account__c);
        } else {
            ChargeOver_Invoice__c oldInvoice = Trigger.oldMap.get(coi.Id);
            if(oldInvoice.ChargeOver_Invoice_Status__c != coi.ChargeOver_Invoice_Status__c){
                changeStatusIds.add(coi.Account__c);
            }
        }
    }
    if(!changeStatusIds.isEmpty()){
        AccountStatusHandler.assignAccountStatus(changeStatusIds);
    }
}