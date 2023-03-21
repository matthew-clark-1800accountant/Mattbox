trigger Accounting_Process_Trigger on Accounting_Process__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
/*
	if (Trigger.isAfter && Trigger.isUpdate) {
		Accounting_Process_Trigger_Helper.afterUpdate(trigger.newMap, trigger.oldMap);
	} else if(Trigger.isBefore && Trigger.isDelete){
		Accounting_Process_Trigger_Helper.beforeDelete(trigger.oldMap);
	}
*/
}