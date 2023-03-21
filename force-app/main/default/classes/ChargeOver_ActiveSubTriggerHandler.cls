public with sharing class ChargeOver_ActiveSubTriggerHandler
{
    public static void doBeforeTrigger(Active_Subscriptions__c[] triggerNew, Map<Id, Active_Subscriptions__c> oldMap, Boolean isInsert, Boolean isUpdate)
    {
        if(isUpdate){ updateTotalQuantity(triggerNew); }
    }

    public static void doAfterTrigger(Active_Subscriptions__c[] triggerNew, Map<Id, Active_Subscriptions__c> newMap, Boolean isInsert, Boolean isUpdate, Boolean isDelete)
    {
        if(isInsert)
        {
        }

    }

    public static void updateTotalQuantity(Active_Subscriptions__c[] triggerNew)
    {
        System.debug(LoggingLevel.FINER, 'updateTotalQuantity trigger entered :: ' + triggerNew);
        Set<Id> idsToQuery = new Set<Id>();
        for(Active_Subscriptions__c sub : triggerNew)
        {
            idsToQuery.add(sub.Id);
        }

        System.debug(LoggingLevel.FINE, 'idsToQuery :: ' + idsToQuery);
        Map<String,Decimal> counter = new Map<String,Decimal>();
        Map<String,Decimal> prices = new Map<String, Decimal>();
        Map<String,Decimal> applied = new Map<String, Decimal>();
        Active_Subscription_Line__c[] lines = new Active_Subscription_Line__c[0];
        for(Active_Subscription_Line__c line : [SELECT Id, Unique_Identifier__c, Created_by_Renewal__c, Subscription_Amount__c, Applied_Account__c FROM Active_Subscription_Line__c WHERE Active_Subscription__c IN: idsToQuery])
        {
            lines.add(line);

            //Count number of ASL records with specific unique identifier. This is based on the primary account.
            if(null != line.Unique_Identifier__c && counter.keySet().contains(line.Unique_Identifier__c))
            {
                Decimal currentCount = counter.get(line.Unique_Identifier__c);
                currentCount = currentCount + 1;
                counter.put(line.Unique_Identifier__c, currentCount);
            } else{ counter.put(line.Unique_Identifier__c, 1); }

            if(line.Created_by_Renewal__c){
                //SUM the amount for each related ASL and then put the total in the map.
                if(null != line.Subscription_Amount__c && prices.containsKey(line.Unique_Identifier__c))
                {
                    Decimal totalPriceSum = prices.get(line.Unique_Identifier__c);
                    totalPriceSum = totalPriceSum + line.Subscription_Amount__c;
                    prices.put(line.Unique_Identifier__c, totalPriceSum);
                } else{ prices.put(line.Unique_Identifier__c, (null == line.Subscription_Amount__c) ? 0 : line.Subscription_Amount__c); }
            }
            
            //Count the number of records that have had an account applied to them. Only count active ones towards total applied.
            if(null != line.Unique_Identifier__c && applied.containsKey(line.Unique_Identifier__c))
            {
	            System.debug('check line value :: ' + line);
                Decimal totalApplied = applied.get(line.Unique_Identifier__c);
                totalApplied = (null != line.Applied_Account__c) ? totalApplied  + 1 : totalApplied + 0;
//	            totalApplied = totalApplied + 1;
                applied.put(line.Unique_Identifier__c, totalApplied);
            }
            else
            {
	            Decimal startValue = (null != line.Applied_Account__c) ? 1 : 0;
	            applied.put(line.Unique_Identifier__c, startValue);
            }
        }

        System.debug(LoggingLevel.FINE, 'counterMap :: ' + counter);

        for(Active_Subscriptions__c sub : triggerNew)
        {
            if(counter.keySet().contains(sub.Unique_Identifier__c))
            {
                Decimal currentCount = counter.get(sub.Unique_Identifier__c);
                sub.Total_Purchased__c = currentCount;
            }

            if(prices.keySet().contains(sub.Unique_Identifier__c))
            {
                Decimal totalPrice = prices.get(sub.Unique_Identifier__c);
                sub.Subscription_Amount__c = totalPrice;
            }

            if(applied.keySet().contains(sub.Unique_Identifier__c))
            {
                Decimal totalApplied = applied.get(sub.Unique_Identifier__c);
                sub.Total_Applied__c = totalApplied;
            }
        }

    }
}