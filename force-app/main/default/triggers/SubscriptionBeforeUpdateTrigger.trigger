trigger SubscriptionBeforeUpdateTrigger on ChargeOver_Subscription__c (before update) 
{
//	List<ChargeOver_Subscription__c> objs = new List<ChargeOver_Subscription__c>();
//
//	if (Trigger.isUpdate && Trigger.isBefore)
//	{
//		for (ChargeOver_Subscription__c o : Trigger.new)
//		{
//			objs.add(o);
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
//
//	}
}