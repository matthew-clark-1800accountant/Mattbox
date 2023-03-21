trigger zQuoteRatePlanChargeTrigger on zqu__QuoteRatePlanCharge__c (before insert) {
	zQuoteRatePlanChargeTriggerhandler.updateCharges(Trigger.new);
}