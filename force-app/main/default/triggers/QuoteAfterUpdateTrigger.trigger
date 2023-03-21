trigger QuoteAfterUpdateTrigger on ChargeOver_Quote__c (after update) 
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
//		else if (objs[i].get('Quote_Created__c') != true)
//		{
//			// Do not send this yet; the flag isn't set
//		}
//		else
//		{
//			// Ensure the customer exists
//			List<Account> accts = [
//				SELECT
//					Id,
//					Name,
//					Primary_Contact_Email__c,
//					Primary_Contact_First_Name__c,
//					Primary_Contact_Last_Name__c,
//					Primary_Contact_Phone__c,
//					BillingStreet,
//					BillingCity,
//					BillingState,
//					BillingPostalCode,
//				    BillingCountry
//				FROM
//					Account
//				WHERE
//					Id = :(String) objs[i].get('Account__c') ];
//			Account a = accts[0];
//
//			Map<String, String> v = new Map<String, String>();
//			v.put('company', (String) a.get('Name'));
//			v.put('external_key', (String) a.get('Id'));
//			v.put('superuser_email', (String) a.get('Primary_Contact_Email__c'));
//			v.put('superuser_first_name', (String) a.get('Primary_Contact_First_Name__c'));
//			v.put('superuser_last_name', (String) a.get('Primary_Contact_Last_Name__c'));
//			v.put('superuser_phone', (String) a.get('Primary_Contact_Phone__c'));
//			v.put('bill_addr1', (String) a.get('BillingStreet'));
//			v.put('bill_city', (String) a.get('BillingCity'));
//			v.put('bill_state', (String) a.get('BillingState'));
//			v.put('bill_postcode', (String) a.get('BillingPostalCode'));
//			v.put('bill_country', (String) a.get('BillingCountry'));
//			String sc = JSON.serialize(v);
//
//			// Get the _line items_ for the quote
//			List<ChargeOver_Quote_Line_Item__c> lines = [
//				SELECT
//					Id,
//					Name,
//					Product__c,
//					Quantity__c,
//					Description__c,
//					Price_Per_Unit__c,
//					Contract_Amount__c,
//					Product_Description__c,
//					HTML_Description__c,
//					Applied_Account__c,
//					of_times_this_should_recur__c
//				FROM
//					ChargeOver_Quote_Line_Item__c
//				WHERE
//					ChargeOver_Quote__c = :(String) objs[i].get('Id')];
//			List<Map<String, String>> sub_lines = new List<Map<String, String>>();
//			List<Map<String, String>> single_sub_lines = new List<Map<String, String>>();
//			for (ChargeOver_Quote_Line_Item__c l : lines)
//			{
//				single_sub_lines = new List<Map<String, String>>();
//				Map<String, String> m = new Map<String, String>();
//
//				m.put('external_key', (String) l.Id);
//				m.put('item_external_key', (String) l.Product__c);
//				m.put('line_quantity', String.valueOf(l.get('Quantity__c')));
//				m.put('obligation.obligation_amount', String.valueOf(l.get('Contract_Amount__c')));
//
//				if (l.get('Product_Description__c') != null)
//				{
//					m.put('descrip', (String) l.get('Product_Description__c'));
//				}
//
//				if (l.get('Applied_Account__c') != null)
//				{
//					m.put('custom_1', (String) l.get('Applied_Account__c'));
//				}
//
//				if (l.get('of_times_this_should_recur__c') != null)
//				{
//					m.put('expire_recurs', String.valueOf(l.get('of_times_this_should_recur__c')));
//				}
//
//				m.put('custom_2', (String) l.get('HTML_Description__c'));
//
//				m.put('tierset.base', String.valueOf(l.get('Price_Per_Unit__c')));
//				m.put('on_sub_update', 'true');
//
//				single_sub_lines.add(m);
//				sub_lines.add(m);
//
//                /*
//				if (((String) objs[i].get('Name')).length() > 0 &&
//					((String) objs[i].get('Name')).isNumeric())
//				{
//					// Exists and we have the ChargeOver ID
//					String su = ChargeOver.serializeQuote(new Map<String, String>(), single_sub_lines);
//					ChargeOver.addLinesToQuote((String) objs[i].get('Name'), su);
//                }
//                */
//			}
//
//			if (((String) objs[i].get('Name')).length() > 0 &&
//				((String) objs[i].get('Name')).isNumeric())
//			{
//                /*
//				// Exists and we have the ChargeOver ID
//				String su = ChargeOver.serializeQuote(new Map<String, String>(), sub_lines);
//                ChargeOver.addLinesToQuote((String) objs[i].get('Name'), su);
//                */
//			}
//			else
//			{
//				Date valid = Date.today().addDays(60);
//				String validuntil = DateTime.newInstance(valid.year(), valid.month(), valid.day()).format('yyyy-MM-dd hh:mm:ss');
//
//				DateTime created = (DateTime) objs[i].get('CreatedDate');
//				String created_str = created.format('yyyy-MM-dd hh:mm:ss');
//
//				Map<String, String> sub = new Map<String, String>();
//				sub.put('customer_external_key', (String) objs[i].get('Account__c'));
//				sub.put('paycycle', (String) objs[i].get('Payment_Cycle__c'));
//				sub.put('external_key', (String) objs[i].Id);
//				sub.put('custom_1', (String) objs[i].get('ChargeOver_URL_Token__c'));
//				sub.put('custom_2', (String) objs[i].get('Opportunity__c'));
//
//				if (!String.isBlank((String) objs[i].get('Quote_Number__c')))
//				{
//					sub.put('custom_3', (String) objs[i].get('Quote_Number__c'));
//				}
//
//				if (!String.isBlank((String) objs[i].get('Redirect_URL__c')))
//				{
//					sub.put('url_acceptredirect', (String) objs[i].get('Redirect_URL__c'));
//				}
//
//				sub.put('validuntil_date', validuntil);
//
//				if (objs[i].get('Brand_Name__c') == 'Subscription Management Services')
//				{
//					sub.put('brand_id', '4');
//				}
//				else if (objs[i].get('Brand_Name__c') == 'ClientBooks')
//				{
//					sub.put('brand_id', '2');
//				}
//				else if (objs[i].get('Brand_Name__c') == 'EIN-Tax-Filing')
//				{
//					sub.put('brand_id', '3');
//				}
//				else if (objs[i].get('Brand_Name__c') == 'Bill62')
//				{
//					sub.put('brand_id', '5');
//				}
//				else if (objs[i].get('Brand_Name__c') == 'EzBizFile')
//				{
//					sub.put('brand_id', '6');
//				}
//				else
//				{
//					sub.put('brand_id', '1');
//				}
//
//				if (objs[i].get('Installment_Payment_Schedule__c') != null)
//				{
//					sub.put('first_invoice_schedule_template_id', String.valueOf(objs[i].get('Installment_Payment_Schedule__c')));
//				}
//
//				String sq = ChargeOver.serializeQuote(sub, sub_lines);
//				ChargeOver.createQuote(sc, sq, (String) objs[i].Id);
//			}
//		}
//	}
}