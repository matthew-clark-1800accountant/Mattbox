trigger SubscriptionAfterUpdateTrigger on ChargeOver_Subscription__c (after update) 
{
//	List<sObject> objs = new List<sObject>();
//
//	if (Trigger.isUpdate && Trigger.isAfter)
//	{
//		for (sObject o : Trigger.new)
//		{
//			objs.add(o);
//		}
//	}
//
//	for (integer i = 0; i < objs.size(); i++)
//	{
//		if (objs[i].get('LAST_SOURCE__c') == 'ChargeOver')
//		{
//
//		}
//		else
//		{
//			// Ensure the customer exists
//			List<Account> accts = [ SELECT Id, Name FROM Account WHERE Id = :(String) objs[i].get('Account__c') ];
//			Account a = accts[0];
//
//			Map<String, String> v = new Map<String, String>();
//			v.put('company', (String) a.get('Name'));
//			v.put('external_key', (String) a.get('Id'));
//			ChargeOver.createCustomer(JSON.serialize(v));
//
//			// Get the _line items_ for the subscription
//			List<ChargeOver_Subscription_Line_Item__c> lines = [
//				SELECT
//					Id,
//					Name,
//					Product__c,
//					Quantity__c,
//					Description__c,
//					Price_Per_Unit__c
//				FROM
//					ChargeOver_Subscription_Line_Item__c
//				WHERE
//					ChargeOver_Subscription__c = :(String) objs[i].get('Id')];
//			List<Map<String, String>> sub_lines = new List<Map<String, String>>();
//			List<Map<String, String>> single_sub_lines = new List<Map<String, String>>();
//			for (ChargeOver_Subscription_Line_Item__c l : lines)
//			{
//				single_sub_lines = new List<Map<String, String>>();
//				Map<String, String> m = new Map<String, String>();
//
//				m.put('external_key', (String) l.Id);
//				m.put('item_external_key', (String) l.Product__c);
//				m.put('line_quantity', String.valueOf(l.get('Quantity__c')));
//
//				if (NULL != l.get('Description__c'))
//				{
//					m.put('descrip', (String) l.get('Description__c'));
//				}
//
//				m.put('tierset.base', String.valueOf(l.get('Price_Per_Unit__c')));
//				m.put('on_sub_update', 'true');
//
//				single_sub_lines.add(m);
//				sub_lines.add(m);
//
//				if (((String) objs[i].get('Name')).length() > 0 &&
//					((String) objs[i].get('Name')).isNumeric())
//				{
//					// Exists and we have the ChargeOver ID
//					String su = ChargeOver.serializeSubscription(new Map<String, String>(), single_sub_lines);
//					ChargeOver.addLinesToSubscription((String) objs[i].get('Name'), su);
//				}
//			}
//
//			if (((String) objs[i].get('Name')).length() > 0 &&
//				((String) objs[i].get('Name')).isNumeric())
//			{
//				// Exists and we have the ChargeOver ID
//				String su = ChargeOver.serializeSubscription(new Map<String, String>(), sub_lines);
//				ChargeOver.addLinesToSubscription((String) objs[i].get('Name'), su);
//			}
//			else
//			{
//				Map<String, String> sub = new Map<String, String>();
//				sub.put('customer_external_key', (String) objs[i].get('Account__c'));
//				sub.put('paycycle', (String) objs[i].get('Payment_Cycle__c'));
//				sub.put('external_key', (String) objs[i].Id);
//
//				String sc = ChargeOver.serializeSubscription(sub, sub_lines);
//				ChargeOver.createSubscription(sc);
//			}
//		}
//	}
}