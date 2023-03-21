/**
 * Created by SReyes on 8/12/2020.
 */

public with sharing class OpportunityTriggerHandler
{
    public static void doAfterTrigger(Opportunity[] triggerNew, Map<Id, Opportunity> oldMap, Boolean isInsert, Boolean isUpdate, Boolean isDelete)
    {
        if(isInsert)
        {
            System.debug(LoggingLevel.DEBUG, 'Opportunity Trigger AFTER_INSERT Context :: ' + triggerNew);
            relatePrimaryContactIfMissing(triggerNew);
            populateLeadSource(triggerNew);
        }
        if(isUpdate){System.debug(LoggingLevel.DEBUG, 'Opportunity Trigger AFTER_UPDATE Context');}
        if(isDelete){System.debug(LoggingLevel.DEBUG, 'Opportunity Trigger AFTER_DELETE Context');}
    }

    public static void doBeforeTrigger(Opportunity[] triggerNew, Map<Id, Opportunity> oldMap, Boolean isInsert, Boolean isUpdate, Boolean isDelete){
        if(isInsert){
            //populateLeadSource(triggerNew);
        }
    }

    private static void populateLeadSource(Opportunity[] triggerNew){
        //Set<Id> oppIds = newMap.keySet();
        List<Id> accIds = new List<Id>();
        for(Opportunity opp : triggerNew){
            if(opp.LeadSource == null){
                accIds.add(opp.AccountId);
            }
            System.debug(opp.AccountId);
        }
        Map<Id, String> accIdToLeadSource = new Map<Id, String>();
        for(Account acc : [SELECT Id, Lead_Source__c FROM Account WHERE Id IN :accIds]){
            accIdToLeadSource.put(acc.Id, acc.Lead_Source__c);
        }
        List<Opportunity> opps = new List<Opportunity>();
        for(Opportunity opp : triggerNew){
            //opp.LeadSource = accIdToLeadSource.get(opp.AccountId);
            if(opp.LeadSource == null){
                opps.add(new Opportunity(Id=opp.Id,LeadSource=accIdToLeadSource.get(opp.AccountId)));
            }
        }
        update opps;
    }

    private static void relatePrimaryContactIfMissing(Opportunity[] triggerNew)
    {
        Set<Id> ids = new Set<Id>();
        for(Opportunity opp : triggerNew){ ids.add(opp.Id); }

        Set<Id> isPrimaryIds = new Set<Id>();
        for(OpportunityContactRole role : [SELECT Id, OpportunityId, IsPrimary FROM OpportunityContactRole WHERE OpportunityId IN :ids AND IsPrimary = TRUE]){isPrimaryIds.add(role.OpportunityId);}

        Set<Id> needsPrimaryContact = new Set<Id>();
        for(Opportunity opp : triggerNew)
        {
            if(!isPrimaryIds.contains(opp.Id))
            {
                needsPrimaryContact.add(opp.AccountId);
            }
        }
        System.debug(LoggingLevel.FINER, 'OppTriggerHandler.relatePrimaryContactIfMissing().needsPrimaryContact :: ' + needsPrimaryContact);

        //Map is format of AccountId, ContactId.
        Map<Id,Id> accountToContactMap = new Map<Id,Id>();
        for(AccountContactRelation acr : [SELECT Id, ContactId, IsDirect, AccountId FROM AccountContactRelation WHERE AccountId IN : needsPrimaryContact])
        {
            if(acr.IsDirect){ accountToContactMap.put(acr.AccountId, acr.ContactId); }
        }
        System.debug(LoggingLevel.FINER, 'OppTriggerHandler.relatePrimaryContactIfMissing().accountToContactMap :: ' + accountToContactMap);

        Set<OpportunityContactRole> contactRolesToInsert = new Set<OpportunityContactRole>();
        for(Opportunity opp : triggerNew)
        {
            //Checking for LeadSource here in case there are multiple Opportunities related to the same account.
            if(accountToContactMap.containsKey(opp.AccountId) && null == opp.LeadSource)
            {
                contactRolesToInsert.add(new OpportunityContactRole(ContactId=accountToContactMap.get(opp.AccountId),OpportunityId=opp.Id,IsPrimary=true));
            }
        }

        System.debug(LoggingLevel.FINE, 'OppTriggerHandler.relatePrimaryContactIfMissing().contactRolesToInsert :: ' + contactRolesToInsert);

        if(!contactRolesToInsert.isEmpty() && contactRolesToInsert.size() > 0)
        {
            OpportunityContactRole[] roles = new OpportunityContactRole[0];
            roles.addAll(contactRolesToInsert);
            insert roles;
        }

    }

}