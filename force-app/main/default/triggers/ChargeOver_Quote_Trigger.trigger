trigger ChargeOver_Quote_Trigger on ChargeOver_Quote__c (before insert, after insert, after update, after delete) {
    TriggerControlPanels__mdt isActive = [SELECT Id, IsActive__c FROM TriggerControlPanels__mdt WHERE Label = 'ChargeOverQuoteTriggerHandler' LIMIT 1];
    if (isActive.IsActive__c) {
        Boolean isInsert = (Trigger.isInsert);
        Boolean isUpdate = (Trigger.isUpdate);
        Boolean isDelete = (Trigger.isDelete);

        if (Trigger.isAfter) {
            ChargeOver_Quote_Trigger_Handler.doAfterTrigger(Trigger.new, Trigger.oldMap, isInsert, isUpdate, isDelete);
        }
        if (Trigger.isBefore) {
            ChargeOver_Quote_Trigger_Handler.doBeforeTrigger(Trigger.new, Trigger.oldMap, isInsert, isUpdate);
        }
    }

}