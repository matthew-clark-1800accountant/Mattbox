trigger AccountContactRelationTrigger on AccountContactRelation (after insert)
{
    TriggerControlPanels__mdt isActive = [SELECT Id, IsActive__c FROM TriggerControlPanels__mdt WHERE Label = 'AccountContactRelationTrigger' LIMIT 1];
    if (isActive.IsActive__c) {
        Boolean isInsert = (Trigger.isInsert);
        Boolean isUpdate = (Trigger.isUpdate);
        Boolean isDelete = (Trigger.isDelete);

        if (Trigger.isAfter) {
            AccountContactRelationTriggerHandler.doAfterTrigger(Trigger.new, Trigger.newMap, isInsert, isUpdate, isDelete);
        }
        if (Trigger.isBefore) {
            //Uncomment next line if you need to implement a before trigger.
            //AccountContactRelationTriggerHandler.doBeforeTrigger(Trigger.new, Trigger.oldMap, isInsert, isUpdate);
        }
    }
}