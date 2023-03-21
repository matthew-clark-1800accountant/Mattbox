trigger ContactTrigger on Contact (after insert, after update, before insert, before update)
{
    //TriggerControlPanels__mdt isActive = [SELECT Id, IsActive__c FROM TriggerControlPanels__mdt WHERE Label = 'ContactTrigger' LIMIT 1];
    //if (isActive.IsActive__c) {
        Boolean isInsert = (Trigger.isInsert);
        Boolean isUpdate = (Trigger.isUpdate);
        Boolean isDelete = (Trigger.isDelete);

        if (Trigger.isAfter) {
            ContactTriggerHandler.doAfterTrigger(Trigger.new, Trigger.newMap, Trigger.oldMap, isInsert, isUpdate, isDelete);
        }

    //}
}