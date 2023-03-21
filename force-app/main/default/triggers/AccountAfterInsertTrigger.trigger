trigger AccountAfterInsertTrigger on Account (after insert) {

//	List<sObject> objs = new List<sObject>();
//
//	if (Trigger.isInsert && Trigger.isAfter)
//	{
//		for (sObject o : Trigger.new)
//		{
//			System.debug('after insert trigger fired with object');
//			objs.add(o);
//		}
//	}
//
//	for (integer i = 0; i < objs.size(); i++)
//	{
//		System.debug('soure is ' + objs[i].get('LAST_SOURCE__c'));
//		if (objs[i].get('LAST_SOURCE__c') == 'ChargeOver')
//		{
//
//		}
//		else if (objs[i].get('Ready_for_sync_to_ChargeOver__c') != true)
//		{
//
//		}
//		else
//		{
//			Map<String, String> v = new Map<String, String>();
//			v.put('company', (String) objs[i].get('Name'));
//			v.put('external_key', (String) objs[i].get('Id'));
//			v.put('superuser_email', (String) objs[i].get('Primary_Contact_Email__c'));
//			v.put('superuser_first_name', (String) objs[i].get('Primary_Contact_First_Name__c'));
//			v.put('superuser_last_name', (String) objs[i].get('Primary_Contact_Last_Name__c'));
//			v.put('superuser_phone', (String) objs[i].get('Primary_Contact_Phone__c'));
//			v.put('bill_addr1', (String) objs[i].get('BillingStreet'));
//			v.put('bill_city', (String) objs[i].get('BillingCity'));
//			v.put('bill_state', (String) objs[i].get('BillingState'));
//			v.put('bill_postcode', (String) objs[i].get('BillingPostalCode'));
//			v.put('bill_country', (String) objs[i].get('BillingCountry'));
//
//			ChargeOver.createCustomer(JSON.serialize(v));
//		}
//	}

}