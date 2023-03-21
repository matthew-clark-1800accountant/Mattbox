trigger RHX_ChargeOver_Invoice_Line_Item on ChargeOver_Invoice_Line_Item__c
    (after delete, after insert, after undelete, after update, before delete) {
		System.debug('RHX_ChargeOver_Invoice_Line_Item');
		if(Trigger.isInsert && Trigger.isAfter){
			ChargeoverInvoiceLineTriggerHandler.afterInsert(trigger.new);
		} else if (Trigger.isUpdate && Trigger.isAfter){
			ChargeoverInvoiceLineTriggerHandler.afterUpdate(Trigger.oldMap, Trigger.new);
		}
		Type rollClass = System.Type.forName('rh2', 'ParentUtil');
	 if(rollClass != null) {
		rh2.ParentUtil pu = (rh2.ParentUtil) rollClass.newInstance();
		if (trigger.isAfter) {
			
			pu.performTriggerRollups(trigger.oldMap, trigger.newMap, new String[]{'ChargeOver_Invoice_Line_Item__c'}, null);
    	}
    }
}