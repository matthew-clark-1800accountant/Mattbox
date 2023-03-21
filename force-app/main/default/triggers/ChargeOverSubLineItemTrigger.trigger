trigger ChargeOverSubLineItemTrigger on ChargeOver_Subscription_Line_Item__c (before insert, after insert, before update, after update, after delete) {
    TriggerControlPanels__mdt isActive = [SELECT Id, IsActive__c FROM TriggerControlPanels__mdt WHERE Label = 'ChargeOverSubLineItemTriggerHandler' LIMIT 1];
    if (isActive.IsActive__c) {
        Boolean isInsert = (Trigger.isInsert);
        Boolean isUpdate = (Trigger.isUpdate);
        Boolean isDelete = (Trigger.isDelete);

        if (Trigger.isAfter) {
            ChargeOverSubLineItemTriggerHandler.doAfterTrigger(Trigger.new, Trigger.oldMap, isInsert, isUpdate, isDelete);
        }
        if (Trigger.isBefore) {
            ChargeOverSubLineItemTriggerHandler.doBeforeTrigger(Trigger.new, Trigger.oldMap, isInsert, isUpdate);
        }
    }

}