trigger ConvertLeadTrigger on Convert_Lead_Event__e (after insert) {
    ConvertLeadEventTriggerHandler.afterInsert(Trigger.new);
}