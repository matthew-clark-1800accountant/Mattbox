trigger SubscriptionBeforeInsertTrigger on ChargeOver_Subscription__c (before insert) 
{
//	List<ChargeOver_Subscription__c> objs = new List<ChargeOver_Subscription__c>();
//
//	if (Trigger.isInsert && Trigger.isBefore)
//	{
//		for (ChargeOver_Subscription__c s : Trigger.new)
//		{
//			objs.add(s);
//		}
//	}
//
//	for (integer i = 0; i < objs.size(); i++)
//	{
//		ChargeOver_Subscription__c this_obj = (ChargeOver_Subscription__c) objs[i];
//
//		if (this_obj.get('IS_FROM_CHARGEOVER__c') != null &&
//			(Boolean) this_obj.get('IS_FROM_CHARGEOVER__c'))
//		{
//			this_obj.IS_FROM_CHARGEOVER__c = False;
//			this_obj.LAST_SOURCE__c = 'ChargeOver';
//		}
//		else
//		{
//			this_obj.LAST_SOURCE__c = 'Salesforce';
//		}
//	}
}