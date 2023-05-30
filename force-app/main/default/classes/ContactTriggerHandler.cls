global without sharing class ContactTriggerHandler
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
            syncContactNote(triggerNew, oldMap);
        } else if(isInsert){
            syncContactNote(triggerNew, oldMap);
        }
        
        if (isDelete) 
        {
            
        }
    }

    public static void syncContactNote(List<Contact> newContacts, Map<Id, Contact> oldContacts){
        List<Contact> contactsToSync = new List<Contact>();
        if(oldContacts == null){ //insert
            for(Contact con : newContacts){
                if(con.Description != null){
                    contactsToSync.add(con);
                }
            }
        } else { //update
            for(Contact con : newContacts){
                if(con.Description != null && con.Description != oldContacts.get(con.Id).Description){
                    contactsToSync.add(con);
                }
            }
        }

        Id currentUser = UserInfo.getUserId();
        for(Contact con : contactsToSync){
            //createContentNote(con.Id, con.FirstName+' '+con.LastName, con.Description, con.OwnerId, new List<Id>{con.AccountId});
            EventBus.publish(new Create_Note__e(AccountId__c=con.accountId, ContactId__c=con.Id,
             Name__c=con.FirstName+' '+con.LastName, ContactOwnerId__c=con.OwnerId, Description__c=con.Description));
        }
    }

    // @future
    // private static void createContentNote(Id contactId, String name, String description, Id conOwner, List<Id> relatedIds){
    //     Id accountId = relatedIds[0];
    //     List<ContentDocumentLink> existingNoteLinks = [SELECT Id, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :accountId];
    //     ContentNote cn;
    //     Id docId;
    //     if(!existingNoteLinks.isEmpty()){ //the contact already has an existing note
    //         cn = [SELECT Id, Content FROM ContentNote WHERE Id = :existingNoteLinks[0].ContentDocumentId LIMIT 1];
    //         //String updatedBody = cn.Content.toString().unescapeHTML4() + '\n\n\n(' + Datetime.now()+') \n\n'+description;
    //         String updatedBody = description;
    //         System.debug(updatedBody);
    //         cn.Content = Blob.valueOf(convertLineBreaks(updatedBody));
    //         update cn;
    //         docId = cn.Id;
    //     } else {
    //         // String body = '('+Datetime.now()+') \n\n'+description;
    //         // cn = new ContentNote();
    //         // cn.Content = Blob.valueof(convertLineBreaks(body));
    //         // cn.Title = name+' Sales Notes';
    //         // cn.ownerId = conOwner;
    //         // insert cn;
    //         ContentVersion cv = new ContentVersion();
    //         cv.title = name+' Sales Notes';      
    //         cv.VersionData =Blob.valueOf(convertLineBreaks(description));
    //         cv.PathOnClient= name+' '+contactId+' Sales Notes'+'.snote'; //<your file title>.snote 
    //         cv.OwnerId = conOwner;
    //         cv.FirstPublishLocationId = accountId;
    //         //cv.PublishStatus = 'P';
    //         //cv.NetworkId= networkid ;
    //         insert cv; 
    //         System.debug(cv);
    //         System.debug([SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id]);
    //         System.debug([SELECT Id,LatestPublishedVersionId FROM ContentNote]);
    //         //cn = [SELECT Id FROM ContentNote WHERE LatestPublishedVersionId  = :cv.Id];
    //         //docId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id].ContentDocumentId;

    //         // List<Account> relatedAccount = [SELECT Id, OwnerId, (SELECT Id, OwnerId, StageName FROM Opportunities) FROM Account WHERE Id = :relatedIds[0]];
    //         // if(!relatedAccount[0].Opportunities.isEmpty()){
    //         //     for(Opportunity opp : relatedAccount[0].Opportunities){
    //         //         if(opp.OwnerId == relatedAccount[0].OwnerId && opp.StageName != 'Closed Lost'){
    //         //             relatedIds.add(opp.Id);
    //         //         }
    //         //     }
    //         //     //relatedIds.addAll(new Map<Id,Opportunity>(relatedAccount[0].Opportunities).keySet());
    //         // } //add check for opportunity.owner == contact.owner, status != closed lost


    //         // //fix to OR?
    //         // List<Event> relatedEvents = [SELECT Id FROM Event WHERE (WhoId = :contactId OR WhatId = :relatedIds[0]) AND Type_of_appointment__c IN ('Tax Savings Analysis', 'BNA', 'Formation Consultation') ];
    //         // if(!relatedEvents.isEmpty()){
    //         //     relatedIds.addAll(new Map<Id, Event>(relatedEvents).keySet());
    //         // }
            
    //         // List<ContentDocumentLink> links = new List<ContentDocumentLink>();
    //         // for(Id curId : relatedIds){
    //         //     ContentDocumentLink cdl = new ContentDocumentLink();
    //         //     cdl.ContentDocumentId = docId;
    //         //     cdl.LinkedEntityId = curId;
    //         //     cdl.ShareType = 'I'; //Changed from C
    //         //     cdl.Visibility = 'InternalUsers';    //changed from AllUsers
    //         //     links.add(cdl);   
    //         //     System.debug(cdl);         
    //         // }
    //         // insert links;
    //     }        
    // }

    // private static String convertLineBreaks(String input)
    // {
    //     String returnStr = input;
    //     if (input.contains('\n'))
    //     {
    //         if(returnStr.startsWith('<p>')){
    //             returnStr = input.replaceAll('\n','</p><p>');
    //         } else {
    //             returnStr = '<p>' + input.replaceAll('\n','</p><p>') + '</p>';
    //         }
    //     }
    //     return returnStr;
    // }
    
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