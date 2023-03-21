/**
 * Created by SReyes on 8/6/2020.
 */
trigger ChargeOverInvoiceTrigger on ChargeOver_Invoice__c (after insert, after update)
{
    TriggerControlPanels__mdt isActive = [SELECT Id, IsActive__c FROM TriggerControlPanels__mdt WHERE Label = 'ChargeOverInvoiceTriggerHandler' LIMIT 1];
    if (isActive.IsActive__c) {
        Boolean isInsert = (Trigger.isInsert);
        Boolean isUpdate = (Trigger.isUpdate);
        Boolean isDelete = (Trigger.isDelete);

        if (Trigger.isAfter) {
            ChargeOverInvoiceTriggerHandler.doAfterTrigger(Trigger.new, Trigger.oldMap, isInsert, isUpdate, isDelete);
        }
        if (Trigger.isBefore) {
            ChargeOverInvoiceTriggerHandler.doBeforeTrigger(Trigger.new, Trigger.oldMap, isInsert, isUpdate);
        }
    }
}