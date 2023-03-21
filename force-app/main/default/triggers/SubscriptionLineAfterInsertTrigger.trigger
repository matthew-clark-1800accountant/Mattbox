trigger SubscriptionLineAfterInsertTrigger on ChargeOver_Subscription_Line_Item__c (after insert) 
{
//    List<sObject> objs = new List<sObject>();
//
//	if (Trigger.isInsert && Trigger.isAfter)
//	{
//		for (sObject o : Trigger.new)
//		{
//			objs.add(o);
//		}
//	}
//
//    ChargeOver_Subscription__c sub = null;
//	for (integer i = 0; i < objs.size(); i++)
//	{
//        // Find the related subscription
//        List<ChargeOver_Subscription__c> subs = [ SELECT Id FROM ChargeOver_Subscription__c WHERE Id = :(String) objs[i].get('ChargeOver_Subscription__c') ];
//
//        sub = subs[i];
//        sub.put('TriggerUpdateFlag__c', String.valueOf(Math.random()));
//        update sub;
//    }
}