/**
 * Created by Samuel Reyes on 3/23/2021.
 */

global with sharing class ChargeOverBatchSubExptnCheck implements Database.Batchable<SObject>, Schedulable
{
    global void execute(SchedulableContext context)
    {
        ChargeOverBatchSubExptnCheck ndb = new ChargeOverBatchSubExptnCheck();
        String cronStrHour = '0 0 * * * ?';
        String jobName = 'ActiveStatusExpirationCheck_Daily';

        //Schedule the next job for next day.
        try
        {
            System.schedule(jobName, cronStrHour, ndb);
            System.debug('ActiveStatusExpirationCheck_Daily scheduled....');
        } catch (Exception e)
        {
            System.debug('ActiveStatusExpirationCheck_Daily job already scheduled :: ' + e);
        }

        //Run actual batch job for this run.
        Database.executeBatch(ndb);
    }

    global Database.QueryLocator start(Database.BatchableContext context)
    {
        //Instantiating these dates in each method to avoid query limits.
        Date today = Date.today();
        return Database.getQueryLocator([SELECT Id, Expiration_Date__c, Subscription_Status__c, Cancelled_Date__c FROM Active_Subscriptions__c
        WHERE (Expiration_Date__c <= :today OR Expiration_Date__c = NULL)
        AND Cancelled_Date__c != NULL
        AND Subscription_Status__c IN ('Paused','Active','Active - Pending Cancel')]);
    }

    global void execute(Database.BatchableContext context, List<Active_Subscriptions__c> scope)
    {
        Date today = Date.today();

        Set<Id> sliIds = new Set<Id>();
        Set<Id> activeSubIds = new Set<Id>();
        for(Active_Subscriptions__c sub : scope)
        {
            if(null != sub.Cancelled_Date__c && (sub.Expiration_Date__c < sub.Cancelled_Date__c || sub.Cancelled_Date__c < Date.today() && null == sub.Expiration_Date__c))
            {
                activeSubIds.add(sub.Id);
            }
        }

        if(!activeSubIds.isEmpty())
        {
            ChargeOver_Subscription_Line_Item__c[] sliToTriggerUpdate = new ChargeOver_Subscription_Line_Item__c[0];
            for(Active_Subscription_Line__c line : [SELECT Id, ChargeOver_Subscription_Line_Item__c, ChargeOver_Subscription_Line_Item__r.Historical_Update__c,
                    Expiration_Date__c, Cancelled_Date__c
                FROM Active_Subscription_Line__c WHERE Active_Subscription__c IN :activeSubIds])
            {
                if(!sliIds.contains(line.ChargeOver_Subscription_Line_Item__c) && (line.Expiration_Date__c > line.Cancelled_Date__c || line.Expiration_Date__c < today || null == line.Expiration_Date__c))
                {
                    sliIds.add(line.ChargeOver_Subscription_Line_Item__c);
                    sliToTriggerUpdate.add(new ChargeOver_Subscription_Line_Item__c(Id=line.ChargeOver_Subscription_Line_Item__c,
                            Historical_Update__c=(line.ChargeOver_Subscription_Line_Item__r.Historical_Update__c) ? false : true));
                }
            }

            //Switch the historical update field on the records to force a status recalculation.
            if(!sliToTriggerUpdate.isEmpty())
            {
                update sliToTriggerUpdate;
            }
        }

    }

    global void finish(Database.BatchableContext context){}

}