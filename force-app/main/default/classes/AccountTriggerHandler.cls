global with sharing class AccountTriggerHandler
{
    public static void doBeforeTrigger(Account[] triggerNew, Map<Id, Account> oldMap, Boolean isInsert, Boolean isUpdate)
    {
        if (isInsert)
        {
            chargeOverBeforeOperations(triggerNew);
        }
        
        if (isUpdate)
        {
            chargeOverBeforeOperations(triggerNew);
        }
    }

    public static void doAfterTrigger(Account[] triggerNew, Map<Id, Account> newMap, Map<Id, Account> oldMap, Boolean isInsert, Boolean isUpdate, Boolean isDelete)
    {
        if (isInsert)
        {
            System.debug(LoggingLevel.DEBUG,'AccountTriggerHandler.doAfterTrigger.isInsert block...');
            chargerOverAfterInsert(triggerNew);
        }
        
        if (isUpdate)
        {
            chargeOverAfterUpdate(triggerNew, oldMap);
        }
        
        if (isDelete) 
        {
            
        }
    }

    private static List<User> getRelatedUsers(Account[] accounts)
    {
        List<Id> userIds = new List<Id>();
        for (Account o : accounts)
        {
            userIds.add(o.Collections_Rep__c);
        }
        
        return [
            SELECT 
        		Id,
            	Name
            FROM 
            	User
            WHERE
            	Id IN :userIds ];
    }
    
    private static User findRelatedUser(List<User> users, Id findUserId)
    {
        for (User o : users)
        {
            if (o.Id == findUserId)
            {
                return o;
            }
        }
        
        return null;
    }
    
    private static void chargeOverAfterUpdate(Account[] triggerNew, Map<Id, Account> oldMap)
    {
        System.debug(LoggingLevel.FINE, 'chargeOverAfterUpdate trigger fired with records :: ' + triggerNew);
        List<SObject> objs = new List<SObject>();

        for (SObject o : triggerNew)
        {
            System.debug('after update trigger fired with object');
            objs.add(o);
        }

        List<User> relatedUsers = getRelatedUsers(triggerNew);
        
        for (Integer i = 0; i < objs.size(); i++)
        {
            Id account_id = (Id) objs[i].get('Id');
            Account old = oldMap.get(account_id);
            
            String old_company = old.Name;
            String old_bill_addr1 = old.BillingStreet;
            String old_bill_city = old.BillingCity;
            String old_bill_state = old.BillingState;
            String old_bill_postcode = old.BillingPostalCode;
            String old_bill_country = old.BillingCountry;
            String old_collections_rep = old.Collections_Rep__c;
            String old_customer_number = old.Customer_Number__c;
            Boolean old_blacklist = old.Blacklisted__c;
            
            String new_company = (String) objs[i].get('Name');
            String new_bill_addr1 = (String) objs[i].get('BillingStreet');
            String new_bill_city = (String) objs[i].get('BillingCity');
            String new_bill_state = (String) objs[i].get('BillingState');
			String new_bill_postcode = (String) objs[i].get('BillingPostalCode');
			String new_bill_country = (String) objs[i].get('BillingCountry');
            String new_collections_rep = (String) objs[i].get('Collections_Rep__c');
            String new_customer_number = (String) objs[i].get('Customer_Number__c');
            Boolean new_blacklist = (Boolean) objs[i].get('Blacklisted__c');
            
            System.debug('source is ' + objs[i].get('LAST_SOURCE__c'));
            if (objs[i].get('LAST_SOURCE__c') == 'ChargeOver') 
            {
                // Do not sync; this is just processing an update _from ChargeOver_ 
                //   e.g. ChargeOver was the one who _triggered_ this update, so 
                //   you do not need to sync this back to ChargeOver again. 
                //   Doing so would create an infinite loop because then ChargeOver
                //   would trigger _another_ update back to SF. 
            }
            else if (old_company != new_company || 
                    old_bill_addr1 != new_bill_addr1 || 
                    old_bill_city != new_bill_city || 
                    old_bill_state != new_bill_state || 
                    old_bill_postcode != new_bill_postcode || 
                    old_bill_country != new_bill_country || 
                    old_collections_rep != new_collections_rep || 
                    old_customer_number != new_customer_number)
            {
                Map<String, String> v = new Map<String, String>();
                
                v.put('company', new_company);
                v.put('bill_addr1', new_bill_addr1);
                v.put('bill_city', new_bill_city);
                v.put('bill_state', new_bill_state);
                v.put('bill_postcode', new_bill_postcode);
                v.put('bill_country', new_bill_country);
                v.put('custom_1', (String) objs[i].get('Customer_Number__c'));
                
                User collections_rep = findRelatedUser(relatedUsers, (Id) objs[i].get('Collections_Rep__c'));
                if (collections_rep != null)
                {
                    v.put('custom_2', collections_rep.Name);
                }

                if (objs[i].get('ChargeOver_ID__c') != null &&
                        ((String) objs[i].get('ChargeOver_ID__c')).length() > 0)
                { 
                    ChargeOver.updateCustomer(String.valueOf(objs[i].get('ChargeOver_ID__c')), JSON.serialize(v)); 
                }
                
            }
            
            if (old_blacklist == false &&
				new_blacklist == true)
            {
                if (objs[i].get('ChargeOver_ID__c') != null &&
					((String) objs[i].get('ChargeOver_ID__c')).length() > 0)
                {
                	ChargeOver.blockCustomer(String.valueOf(objs[i].get('ChargeOver_ID__c')));
                }
            }
        }
    }

    //DO NOTE USE TestVisible without just cause. If it can be covered using ONLY trigger execution, it should be.
    //Doing it this way should be a last effort result when coverage has failed all other methods.
    //Using it here because there was some issues with collecting insertion code test coverage, and this allowed
    //checking of some final points. -SReyes
    @TestVisible
    private static void chargerOverAfterInsert(Account[] triggerNew)
    {

    }

    private static void chargeOverBeforeOperations(Account[] triggerNew)
    {
        for (Account act : triggerNew)
        {
            //This field won't be null as Salesforce always populates boolean fields with default values of false, unless designated default should be true.
            if (act.IS_FROM_CHARGEOVER__c)
            {
                act.IS_FROM_CHARGEOVER__c = false;
                act.LAST_SOURCE__c = 'ChargeOver';
            } 
            else 
            {
                act.LAST_SOURCE__c = 'Salesforce'; 
            }
        }
    }
}