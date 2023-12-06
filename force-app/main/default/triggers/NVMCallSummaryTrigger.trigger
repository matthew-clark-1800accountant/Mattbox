trigger NVMCallSummaryTrigger on NVMStatsSF__NVM_Call_Summary__c (after insert, after update) {
    NVMCallSummaryTriggerHandler.updateTracking(Trigger.new);
}