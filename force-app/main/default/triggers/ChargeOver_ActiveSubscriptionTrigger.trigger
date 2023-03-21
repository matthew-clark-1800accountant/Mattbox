trigger ChargeOver_ActiveSubscriptionTrigger on Active_Subscriptions__c (after update, after insert, before update)
{
    TriggerControlPanels__mdt isActive = [SELECT Id, IsActive__c FROM TriggerControlPanels__mdt WHERE Label = 'ActiveSubscriptionTriggerHandler' LIMIT 1];
    if (isActive.IsActive__c) {
        Boolean isInsert = (Trigger.isInsert);
        Boolean isUpdate = (Trigger.isUpdate);
        Boolean isDelete = (Trigger.isDelete);

        if (Trigger.isAfter) {
            ChargeOver_ActiveSubTriggerHandler.doAfterTrigger(Trigger.new, Trigger.newMap, isInsert, isUpdate, isDelete);
        }
        if (Trigger.isBefore) {
            ChargeOver_ActiveSubTriggerHandler.doBeforeTrigger(Trigger.new, Trigger.oldMap, isInsert, isUpdate);
        }
    }
}