trigger ChargeoverSubLineAccountStatus on ChargeOver_Subscription_Line_Item__c (after insert, after update) {
    List<Id> changeStatusIds = new List<Id>();
    for(ChargeOver_Subscription_Line_Item__c cosli : Trigger.new){
        if(Trigger.isInsert){
            changeStatusIds.add(cosli.Account__c);   
        //Updates
        } else {
            ChargeOver_Subscription_Line_Item__c oldSubscriptionLine = Trigger.oldMap.get(cosli.Id);
            if(oldSubscriptionLine.Status__c != cosli.Status__c
            || cosli.Historical_Update__c != oldSubscriptionLine.Historical_Update__c){
                changeStatusIds.add(cosli.Account__c);
            }
        }
    }

    if(!changeStatusIds.isEmpty()){
        AccountStatusHandler.assignAccountStatus(changeStatusIds);
    }
}