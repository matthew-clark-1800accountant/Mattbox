trigger AccountTrigger on Account (after insert, after update, before insert, before update)
{
    TriggerControlPanels__mdt isActive = [SELECT Id, IsActive__c FROM TriggerControlPanels__mdt WHERE Label = 'AccountTrigger' LIMIT 1];
    //Recursion & SOQL limits were happening here in the test so I added the additional criteria -Koby
    if (isActive.IsActive__c && Limits.getQueries() < 50) {
        Boolean isInsert = (Trigger.isInsert);
        Boolean isUpdate = (Trigger.isUpdate);
        Boolean isDelete = (Trigger.isDelete);
        
        if (Trigger.isAfter) {
            AccountTriggerHandler.doAfterTrigger(Trigger.new, Trigger.newMap, Trigger.oldMap, isInsert, isUpdate, isDelete);
        }
        if (Trigger.isBefore) {
            AccountTriggerHandler.doBeforeTrigger(Trigger.new, Trigger.oldMap, isInsert, isUpdate);
        }
    }
}