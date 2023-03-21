trigger ZuoraSubProdChargeTrigger on Zuora__SubscriptionProductCharge__c (after update, before update, after delete ) {
    if (!ZuoraSubProdChargeTriggerHandler.isDisabled()) {
        Boolean isInsert = (Trigger.isInsert);
        Boolean isUpdate = (Trigger.isUpdate);
        Boolean isDelete = (Trigger.isDelete);

        if(Trigger.isAfter){
            ZuoraSubProdChargeTriggerHandler.doAfterTrigger(Trigger.new, Trigger.oldMap, isInsert, isUpdate, isDelete);
        }
        if(Trigger.isBefore){
            ZuoraSubProdChargeTriggerHandler.doBeforeTrigger(Trigger.new, Trigger.oldMap, isInsert, isUpdate);
        }
    }
}