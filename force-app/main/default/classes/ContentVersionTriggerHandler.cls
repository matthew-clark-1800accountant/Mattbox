/**
 * Created by SReyes on 7/30/2020.
 */

public with sharing class ContentVersionTriggerHandler
{

    private static Boolean OUTBOUND_SENT_THIS_CONTEXT_INSERT = false;
    private static Boolean OUTBOUND_SENT_THIS_CONTEXT_UPDATE = false;

    private class ContentLink
    {
        Id primaryId {get;set;}
        Boolean hasOpportunity {get;set;}
        Boolean hasAccount {get;set;}
        Boolean hasContact {get;set;}

        public ContentLink(Id keyId, Boolean hasAcct, Boolean hasOpp, Boolean hasCont)
        {
            this.hasAccount = hasAcct;
            this.hasContact = hasCont;
            this.hasOpportunity = hasOpp;
            this.primaryId = keyId;
        }
    }


    public static void doBeforeTrigger(ContentVersion[] triggerNew, Map<Id, ContentVersion> oldMap, Boolean isInsert, Boolean isUpdate)
    {
        //Fire once at insert and once on update in a single context.
        //Generally this shouldn't be an issue.
        if(!OUTBOUND_SENT_THIS_CONTEXT_INSERT || !OUTBOUND_SENT_THIS_CONTEXT_UPDATE)
        {
            if(isInsert)
            {
//                noteDispatcherForOutboundMessage(triggerNew);
//                OUTBOUND_SENT_THIS_CONTEXT_INSERT = true;
            }
            if(isUpdate)
            {
//                noteDispatcherForOutboundMessage(triggerNew);
//                OUTBOUND_SENT_THIS_CONTEXT_UPDATE = true;
            }
        }
    }

    public static void doAfterTrigger(ContentVersion[] triggerNew, Map<Id, ContentVersion> oldMap, Boolean isInsert, Boolean isUpdate, Boolean isDelete)
    {
        if(isInsert || isUpdate)
        {
            System.debug('in CV doAfter');
            relateAccountIfMissing(triggerNew);
        }
    }

    private static void relateAccountIfMissing(ContentVersion[] records)
    {
        Set<Id> recordIds = new Set<Id>();
        Set<Id> oppIds = new Set<Id>();
        Set<Id> contIds = new Set<Id>();
        for(ContentVersion ver : records){ recordIds.add(ver.ContentDocumentId); }

        System.debug(LoggingLevel.FINE, 'recordIds :: ' + recordIds);

        ContentDocumentLink[] links = new ContentDocumentLink[0];
        Map<Id, ContentLink> linkMap = new Map<Id, ContentLink>();
        for(ContentDocumentLink cdl : [SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink WHERE ContentDocumentId IN :recordIds])
        {
            System.debug('linksMap current :: ' + linkMap);
            ContentLink contLink;

            System.debug(LoggingLevel.FINE, 'populating contLink.... using cdl :: ' + cdl);

            //If the map has a key fetch record, otherwise instantiate new contLink with default values.
            if(linkMap.containsKey(cdl.ContentDocumentId))
            {
                System.debug('key found for ContentLink');
                contLink = linkMap.get(cdl.ContentDocumentId);
            }
            else
            {
                System.debug('creating new ContentLink');
                contLink = new ContentLink(cdl.ContentDocumentId, false, false, false);
            }

            System.debug(LoggingLevel.FINE, 'contLink :: ' + contLink);

            //Intentional use of else if blocks because each cdl iteration will only relate to a single SObjectType.
            //For each SObjectType a separate cdl will exist.
            SObjectType objectType = cdl.LinkedEntityId.getSobjectType();
            System.debug(LoggingLevel.FINE, 'objectType :: ' + objectType);

            if(Account.SObjectType == objectType){ contLink.hasAccount = true; }
            else if(Opportunity.SObjectType == objectType)
            {
                contLink.hasOpportunity = true;
                oppIds.add(cdl.LinkedEntityId);
            }
            else if(Contact.SObjectType == objectType)
            {
                contLink.hasContact = true;
                contIds.add(cdl.LinkedEntityId);
            }

            //Update the map entry.
            linkMap.put(cdl.ContentDocumentId, contLink);
            links.add(cdl);
        }

        System.debug(LoggingLevel.FINE, 'linkMap :: ' + linkMap);

        Opportunity[] relatedOpportunities = new Opportunity[0];
        for(Opportunity opp : [SELECT Id, AccountId FROM Opportunity WHERE Id IN : oppIds]){ relatedOpportunities.add(opp); }

        Contact[] relatedContacts = new Contact[0];
        for(Contact cont : [SELECT Id, AccountId FROM Contact WHERE Id IN : contIds]){ relatedContacts.add(cont); }

        System.debug(LoggingLevel.FINE, 'relatedOpportunities :: ' + relatedOpportunities);
        System.debug(LoggingLevel.FINE, 'relatedContacts :: ' + relatedContacts);

        ContentDocumentLink[] toInsert = new ContentDocumentLink[0];
        for(ContentDocumentLink cdl : links)
        {
            if(linkMap.containsKey(cdl.ContentDocumentId))
            {
                ContentLink contLink = linkMap.get(cdl.ContentDocumentId);

                //If it already has an account we won't bother with it.
                //We only care about ones that aren't related to an account.
                if(!contLink.hasAccount)
                {
                    Id accountId;
                    for(Opportunity opp : relatedOpportunities)
                    {
                        if(null != opp.AccountId && cdl.LinkedEntityId == opp.Id)
                        {
                            accountId = opp.AccountId;
                            break;
                        }
                    }
                    if(null == accountId)
                    {
                        for(Contact cont : relatedContacts)
                        {
                            if(null != cont.AccountId && cdl.LinkedEntityId == cont.Id)
                            {
                                accountId = cont.AccountId;
                                break;
                            }
                        }
                    }
                    //End accountId variable setting.

                    //Create new ContentDocumentLink record for relating to an account if required and criteria is valid.
                    if(null != accountId)
                    {
                        //Set temp variable to true so it won't try to create this again.
                        contLink.hasAccount = true;
                        linkMap.put(contLink.primaryId, contLink);

                        //We have to set Visibility and ShareType so that NoteDispatcherBatch can find them to send to ChargeOver to create a new NoteDispatcher__c record.
                        toInsert.add(new ContentDocumentLink(ContentDocumentId=cdl.ContentDocumentId,LinkedEntityId=accountId,Visibility='AllUsers',ShareType='I'));
                    }
                }
                //outside of !contLink.hasAccount check
            }
        }
        System.debug(LoggingLevel.FINE, 'toInsert :: ' + toInsert);
        new DMLUtility(toInsert, DMLUtility.DMLType.INSERTS, 'ContentVersionTriggerHandler.relateAccountIfMissing - toInsert of new ContentDocumentLinks').execute(null);

    }

}