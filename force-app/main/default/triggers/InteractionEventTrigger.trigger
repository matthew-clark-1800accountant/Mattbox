trigger InteractionEventTrigger on NVMContactWorld__InteractionEvent__c (after update) {
    // InteractionEventTriggerHandler.afterInsert(Trigger.new);
    InteractionEventTriggerHandler.afterUpdate(Trigger.oldMap, Trigger.new);
}