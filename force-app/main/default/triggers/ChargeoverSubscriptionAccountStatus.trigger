trigger ChargeoverSubscriptionAccountStatus on ChargeOver_Subscription__c (after insert, after update) {
    List<Id> changeStatusIds = new List<Id>();
    for(ChargeOver_Subscription__c cos : Trigger.new){
        if(Trigger.isInsert){
            changeStatusIds.add(cos.Account__c);
        //Updates
        } else {
            ChargeOver_Subscription__c oldSubscription = Trigger.oldMap.get(cos.Id);
            if(oldSubscription.Status__c != cos.Status__c){
                changeStatusIds.add(cos.Account__c);
            }
            if(oldSubscription.Initial_Refund_Percentage__c != cos.Initial_Refund_Percentage__c){
                changeStatusIds.add(cos.Account__c);
            }
        }
    }
    if(!changeStatusIds.isEmpty()){
        AccountStatusHandler.assignAccountStatus(changeStatusIds);
    }
}