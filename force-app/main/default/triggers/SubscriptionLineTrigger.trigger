trigger SubscriptionLineTrigger on Bill62__Subscription_Line__c (after delete) {
	if (Trigger.isAfter && Trigger.isDelete){
		Set<Id> subLineSet = new Set<Id>();
		for (Bill62__Subscription_Line__c s : Trigger.old){
			subLineSet.add(s.Id);
		}
		
		List<Bill62__Payment__c> delPayment = [SELECT ID FROM Bill62__Payment__c
			WHERE Bill62__Subscription_Line__c IN: subLineSet];
		Database.delete(delPayment, false);
	}
}