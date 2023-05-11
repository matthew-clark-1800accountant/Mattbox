global with sharing class ContactTriggerHandler
{
//    public static void doBeforeTrigger(Contact[] triggerNew, Map<Id, Contact> oldMap, Boolean isInsert, Boolean isUpdate)
//    {
//        if (isInsert)
//        {
//            chargeOverBeforeOperations(triggerNew);
//        }
//        
//        if (isUpdate)
//        {
//            chargeOverBeforeOperations(triggerNew);
//        }
//    }

    private static List<Account> getRelatedAccounts(Contact[] contacts)
    {
        List<Id> accountIds = new List<Id>();
        for (Contact o : contacts)
        {
            accountIds.add(o.AccountId);
        }
        
        return [
            SELECT
              Id,
              ChargeOver_ID__c,
              Name,
              Primary_Contact_Email__c,
              Primary_Contact_First_Name__c,
              Primary_Contact_Last_Name__c,
              Primary_Contact_Phone__c,
              Primary_Contact_ID__c,
              BillingStreet,
              BillingCity,
              BillingState,
              BillingPostalCode,
              BillingCountry,
              Customer_Number__c
            FROM
              Account
            WHERE
              Id IN :accountIds ];
    } 
      
    private static Account findRelatedAccount(List<Account> accounts, Id findAccountId)
    {
        for (Account o : accounts)
        {
            if (o.Id == findAccountId)
            {
                return o;
            }
        }
        
        return null;
    }
    
    public static void doAfterTrigger(Contact[] triggerNew, Map<Id, Contact> newMap, Map<Id, Contact> oldMap, Boolean isInsert, Boolean isUpdate, Boolean isDelete)
    {
        //if (isInsert)
        //{
        //    System.debug(LoggingLevel.DEBUG,'ContactTriggerHandler.doAfterTrigger.isInsert block...');
        //    chargerOverAfterInsert(triggerNew);
        //}
        
        if (isUpdate)
        {
            chargeOverAfterUpdate(triggerNew, oldMap);
        }
        
        if (isDelete) 
        {
            
        }
    }
    
    private static void chargeOverAfterUpdate(Contact[] triggerNew, Map<Id, Contact> oldMap)
    {
        System.debug(LoggingLevel.FINE, 'chargeOverAfterUpdate trigger fired with records :: ' + triggerNew);
        
        Account[] accounts = getRelatedAccounts(triggerNew);
        
        List<SObject> objs = new List<SObject>();

        for (SObject o : triggerNew)
        {
            System.debug('after update trigger fired with object');
            objs.add(o);
        }
        
        for (Integer i = 0; i < objs.size(); i++)
        {
            Id contact_id = (Id) objs[i].get('Id');
            Contact old = oldMap.get(contact_id);
            
            String old_first_name = old.FirstName;
            String old_last_name = old.LastName;
            String old_email = old.Email;
            String old_phone = old.Phone;
            
            String new_first_name = (String) objs[i].get('FirstName');
            String new_last_name = (String) objs[i].get('LastName');
            String new_email = (String) objs[i].get('Email');
            String new_phone = (String) objs[i].get('Phone');
            
            if (old_first_name != new_first_name || 
               old_last_name != new_last_name || 
               old_email != new_email || 
               old_phone != new_phone)
            {
                Account a = findRelatedAccount(accounts, (Id) objs[i].get('AccountId'));
                
                if (a != null)
                {
                
                    Id primary_contact_id = a.Primary_Contact_ID__c;
                    
                    String superuser_email = (String) a.get('Primary_Contact_Email__c');
                    String superuser_fname = (String) a.get('Primary_Contact_First_Name__c');
                    String superuser_lname = (String) a.get('Primary_Contact_Last_Name__c');
                    
                    Map<String, String> v = new Map<String, String>();
                    
                    v.put('company', (String) a.get('Name'));
                    v.put('superuser_email', superuser_email);
                    v.put('superuser_first_name', superuser_fname);
                    v.put('superuser_last_name', superuser_lname);
                    v.put('superuser_phone', (String) a.get('Primary_Contact_Phone__c'));
                    v.put('superuser_external_key', (String) contact_id);
    
                    if (primary_contact_id == contact_id && 
                        a.ChargeOver_ID__c != null &&
                            ((String) a.ChargeOver_ID__c).length() > 0)
                    { 
                        ChargeOver.updateCustomer(String.valueOf(a.ChargeOver_ID__c), JSON.serialize(v)); 
                    }
                }
            }
        }
    }
    
    
}