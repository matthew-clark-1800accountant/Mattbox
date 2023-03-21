trigger AccountBeforeUpdateTrigger on Account (before update) 
{
//	List<Account> objs = new List<Account>();
//
//	if (Trigger.isUpdate && Trigger.isBefore)
//	{
//		for (Account o : Trigger.new)
//		{
//			objs.add(o);
//		}
//	}
//
//	for (integer i = 0; i < objs.size(); i++)
//	{
//		Account this_obj = (Account) objs[i];
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