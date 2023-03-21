trigger TaskTrigger on Task (after insert) {
    TriggerControlPanels__mdt isActive = [SELECT Id, IsActive__c FROM TriggerControlPanels__mdt WHERE Label = 'TaskTrigger' LIMIT 1];
    if (isActive.IsActive__c) {
        TaskTriggerHandler.afterInsert(Trigger.new);
    }
}