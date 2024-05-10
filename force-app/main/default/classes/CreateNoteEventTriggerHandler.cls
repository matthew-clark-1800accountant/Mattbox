public with sharing class CreateNoteEventTriggerHandler {
    public static void afterInsert(List<Create_Note__e> creationEvents){
        for(Create_Note__e e : creationEvents){
            System.debug('createNote: '+e);
            createNote(e.AccountId__c, e.Description__c, e.Name__c, e.ContactOwnerId__c, e.ContactId__c);
            break; //todo: bulkify with future workaround
        }        
    }

    private static String convertLineBreaks(String input)
    {
        String returnStr = input;
        if (input.contains('\n'))
        {
            if(returnStr.startsWith('<p>')){
                returnStr = input.replaceAll('\n','</p><p>');
            } else {
                returnStr = '<p>' + input.replaceAll('\n','</p><p>') + '</p>';
            }
        }
        return returnStr;
    }

    //@future
    public static void createNote(String accountId, String description, String name, String conOwner, String contactId){
        
        // String accountId = Trigger.new[0].AccountId__c;
        // String description = Trigger.new[0].Description__c;
        // String name = Trigger.new[0].Name__c;
        // String conOwner = Trigger.new[0].ContactOwnerId__c;
        // String contactId = Trigger.new[0].ContactId__c;
        System.debug('createNote');
        List<String> relatedIds = new List<String>{contactId};

        List<ContentDocumentLink> existingNoteLinks = [SELECT Id, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :accountId];
        ContentNote cn;
        Id docId;
        System.debug('existingNoteLinks.size(): '+existingNoteLinks.size());
        if(!existingNoteLinks.isEmpty()){ //the contact already has an existing note
            cn = [SELECT Id, Content, Title FROM ContentNote WHERE Id = :existingNoteLinks[0].ContentDocumentId LIMIT 1];
            String updatedBody = description;
            System.debug(updatedBody);
            cn.Content = Blob.valueOf(convertLineBreaks(updatedBody));
            cn.Title = cn.Title; //idiot-proofing for salesforce
            update cn;
            docId = cn.Id;
        } else {
            // String body = '('+Datetime.now()+') \n\n'+description;
            // cn = new ContentNote();
            // cn.Content = Blob.valueof(convertLineBreaks(body));
            // cn.Title = name+' Sales Notes';
            // cn.ownerId = conOwner;
            // insert cn;
            ContentVersion cv = new ContentVersion();
            String title = description.substringBefore(':');
            cv.title = (title == null) ? name+' Sales Notes' : title;      
            cv.VersionData =Blob.valueOf(convertLineBreaks(description.substringAfter(':')));
            cv.PathOnClient= name+' '+contactId+' Sales Notes'+'.snote'; //<your file title>.snote 
            cv.OwnerId = conOwner;
            cv.FirstPublishLocationId = accountId;
            //cv.PublishStatus = 'P';
            //cv.NetworkId= networkid ;
            insert cv; 
            System.debug(cv);
            System.debug([SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id]);
            System.debug([SELECT Id,LatestPublishedVersionId FROM ContentNote]);
            //cn = [SELECT Id FROM ContentNote WHERE LatestPublishedVersionId  = :cv.Id];
            docId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id].ContentDocumentId;

            List<Account> relatedAccount = [SELECT Id, OwnerId, (SELECT Id, OwnerId, StageName FROM Opportunities) FROM Account WHERE Id = :accountId];
            if(!relatedAccount[0].Opportunities.isEmpty()){
                for(Opportunity opp : relatedAccount[0].Opportunities){
                    if(opp.OwnerId == relatedAccount[0].OwnerId && opp.StageName != 'Closed Lost'){
                        relatedIds.add(opp.Id);
                    }
                }
                //relatedIds.addAll(new Map<Id,Opportunity>(relatedAccount[0].Opportunities).keySet());
            } //add check for opportunity.owner == contact.owner, status != closed lost


            //fix to OR?
            List<Event> relatedEvents = [SELECT Id FROM Event WHERE (WhoId = :contactId OR WhatId = :accountId) AND Type_of_appointment__c IN ('Tax Savings Analysis', 'BNA', 'Formation Consultation') ];
            if(!relatedEvents.isEmpty()){
                relatedIds.addAll(new List<Id>(new Map<Id, Event>(relatedEvents).keySet()));
            }
            
            List<ContentDocumentLink> links = new List<ContentDocumentLink>();
            for(Id curId : relatedIds){
                ContentDocumentLink cdl = new ContentDocumentLink();
                cdl.ContentDocumentId = docId;
                cdl.LinkedEntityId = curId;
                cdl.ShareType = 'I'; //Changed from C
                cdl.Visibility = 'InternalUsers';    //changed from AllUsers
                links.add(cdl);   
                System.debug(cdl);         
            }
            insert links;
        }       
    }
}