trigger zQuoteRatePlanChargeOptionTrigger on zqu__QuoteRatePlanChargeOption__c (before insert, before update) {
	zQuoteRatePlanChargeOptionTriggerhandler.updateCharges(Trigger.new);
}