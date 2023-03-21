public class ZuoraSubProdChargeTriggerHandler {
    private static Boolean disabled = false;

    public static Boolean isDisabled () {
        return disabled;
    }

    public static void disableTrigger () {
        disabled = true;
    }

    public static void enableTrigger () {
        disabled = false;
    }

    public static void doAfterTrigger(List<Zuora__SubscriptionProductCharge__c> triggerNew, Map<Id, Zuora__SubscriptionProductCharge__c> oldMap, Boolean isInsert, Boolean isUpdate, Boolean isDelete){
        if(isUpdate){
            updateActiveSubscriptions(triggerNew);
//			deletionProcess(oldMap);
        }
		if(isDelete){
			System.debug('isDelete doAfter');
			deletionProcess(oldMap);
		}
        if(isInsert){}
    }

    public static void doBeforeTrigger(List<Zuora__SubscriptionProductCharge__c> triggerNew, Map<Id, Zuora__SubscriptionProductCharge__c> oldMap, Boolean isInsert, Boolean isUpdate){
        if(isUpdate){}
        if(isInsert){}
    }

	private static void deletionProcess(Map<Id,Zuora__SubscriptionProductCharge__c> oldMap){
//		System.debug(LoggingLevel.DEBUG, 'deletionProcess running...' + oldMap);
//		// Get parent Accounts
//		Set<Id> accountIds = new Set<Id>();
//		for (Zuora__SubscriptionProductCharge__c product : oldMap.values()) {
//			if (product.Zuora__Account__c != null) {
//				accountIds.add(product.Zuora__Account__c);
//			}
//		}
//
//		// Get relevant information for parent Accounts
//		Map <Id, Account> accountMap = new Map<Id, Account>([
//				SELECT Id, Customer_Number__c,
//				(SELECT Id, Subscription_Item__c, Start_Date__c, Expiration_Date__c, Product__c
//				FROM Active_Subscriptions__r ORDER BY CreatedDate DESC)
//				FROM Account
//				WHERE Id IN :accountIds
//		]);
//
//		System.debug(LoggingLevel.FINE, 'fetched accounts :: accountMap ' + accountMap);
//
//		// Get all other Product & Charge objects related to parent Accounts
//		Map<Id, List<Zuora__SubscriptionProductCharge__c>> accountProductMap = new Map<Id, List<Zuora__SubscriptionProductCharge__c>>();
//		Set<String> productZuoraIds = new Set<String>();
//		for (Zuora__SubscriptionProductCharge__c product: [
//				SELECT Id, Zuora__Account__c, Zuora__Product__r.Zuora__External_Id__c, Zuora__Price__c,Cancelled_Date__c,Date_of_Cancellation__c,
//						Zuora__EffectiveStartDate__c, Zuora__EffectiveEndDate__c, Zuora__BillingPeriod__c, Subscription_Status__c, Zuora__Subscription__c,
//						Zuora__Subscription__r.Zuora__SubscriptionStartDate__c
//				FROM Zuora__SubscriptionProductCharge__c
//				WHERE Zuora__Account__c IN :accountIds
//				AND Zuora__Product__c != null
//				AND (NOT Name LIKE '%Renewal%') AND (NOT Name LIKE '%Discount%')
//		]) {
//			if (!accountProductMap.containsKey(product.Zuora__Account__c)) {
//				accountProductMap.put(product.Zuora__Account__c, new List<Zuora__SubscriptionProductCharge__c>());
//			}
//			accountProductMap.get(product.Zuora__Account__c).add(product);
//
//			if (product.Zuora__Product__r.Zuora__External_Id__c != null) {
//				productZuoraIds.add(product.Zuora__Product__r.Zuora__External_Id__c);
//			}
//		}
//
//		System.debug(LoggingLevel.FINE, 'built accountProductMap :: ' + accountProductMap);
//		System.debug(LoggingLevel.FINE, 'built productZuoraIds :: ' + productZuoraIds);
//
//		// Get all Products associated with the Zuora Ids
//		Map<String, Product2> productsByZuoraId = new Map<String, Product2>();
//		for (Product2 product : [
//				SELECT Id, zqu__ZuoraId__c, Family, SOW_Description__c, Description, Name
//				FROM Product2
//				WHERE zqu__ZuoraId__c IN :productZuoraIds
//		]) {
//			if (!productsByZuoraId.containsKey(product.zqu__ZuoraId__c)) {
//				productsByZuoraId.put(product.zqu__ZuoraId__c, product);
//			}
//		}
//
//		System.debug(LoggingLevel.FINE, 'built productsByZuoraId :: ' + productsByZuoraId);
//
//		// Loop through Product & Charge objects for each Account
//		List <Active_Subscriptions__c> toDelete = new List <Active_Subscriptions__c>();
//
//		for (Id accountId : accountProductMap.keySet()) {
//			// Collect P&Cs by Zuora Id
//			Map <String, List<Zuora__SubscriptionProductCharge__c>> subscriptionByZid = new Map <String, List<Zuora__SubscriptionProductCharge__c>>();
//			for (Zuora__SubscriptionProductCharge__c subscription : accountProductMap.get(accountId)) {
//				if (!subscriptionByZid.containsKey(subscription.Zuora__Product__r.Zuora__External_Id__c)) {
//					subscriptionByZid.put(subscription.Zuora__Product__r.Zuora__External_Id__c, new List<Zuora__SubscriptionProductCharge__c>());
//				}
//				subscriptionByZid.get(subscription.Zuora__Product__r.Zuora__External_Id__c).add(subscription);
//			}
//			// Loop through each collection to gather necessary info for new Active Subscription
//			for (String zId : subscriptionByZid.keySet()) {
//				// Before continuing, make sure that we found an appropriate Product2 object
//				if (!productsByZuoraId.containsKey(zId)) {
//					continue;
//				}
//
//				Active_Subscriptions__c subToDelete = new Active_Subscriptions__c();
//
//				// Find Active Subscription with same Subscription_Item__c
//				Boolean subscriptionFound = false;
//				for (Active_Subscriptions__c subscriptionToCheck : accountMap.get(accountId).Active_Subscriptions__r) {
//					//if (subscriptionToCheck.Subscription_Item__c == productsByZuoraId.get(zId).Name) {
//					if (subscriptionToCheck.Product__c == productsByZuoraId.get(zId).Id) {
//						subToDelete = subscriptionToCheck;
//						subscriptionFound = true;
//						break;
//					}
//				}
//
//				if(subscriptionFound){
//					toDelete.add(subToDelete);
//				}
//			}
//		}


		Active_Subscriptions__c[] toDelete = new Active_Subscriptions__c[0];
		Set<Id> accountIds = new Set<Id>();
		for(Zuora__SubscriptionProductCharge__c spc : oldMap.values())
		{
			accountIds.add(spc.Zuora__Account__c);
		}

		Map <Id, Account> accountMap = new Map<Id, Account>([
				SELECT Id, Customer_Number__c,
				(SELECT Id, Subscription_Item__c, Start_Date__c, Expiration_Date__c, Product__c, Product__r.Name, Product__r.ExternalId
				FROM Active_Subscriptions__r ORDER BY CreatedDate DESC)
				FROM Account
				WHERE Id IN :accountIds
		]);

		for(Zuora__SubscriptionProductCharge__c spc : oldMap.values())
		{
			Account act = accountMap.get(spc.Zuora__Account__c);
			if(null != act.Active_Subscriptions__r && !act.Active_Subscriptions__r.isEmpty())
			{
				for(Active_Subscriptions__c aSub : act.Active_Subscriptions__r)
				{
					if(spc.Deprecated_Zuora_Id__c == aSub.Product__r.ExternalId)
					{
						toDelete.add(aSub);
					}
				}
			}
		}



		System.debug(LoggingLevel.FINE, 'built toDelete :: ' + toDelete);
		if(!toDelete.isEmpty()){
			delete toDelete;
		}

	}

	public static void updateActiveSubscriptions (List<Zuora__SubscriptionProductCharge__c> newObjects) {
		// Get parent Accounts
		Set<Id> accountIds = new Set<Id>();
		for (Zuora__SubscriptionProductCharge__c product : newObjects) {
			if (product.Zuora__Account__c != null) {
				accountIds.add(product.Zuora__Account__c);
			}
		}

		// Get relevant information for parent Accounts
		Map <Id, Account> accountMap = new Map<Id, Account>([
				SELECT Id, Customer_Number__c,
				(SELECT Id, Subscription_Item__c, Start_Date__c, Expiration_Date__c, Product__c, ChargeOverSubLineItemId__c
						FROM Active_Subscriptions__r ORDER BY CreatedDate DESC)
						FROM Account
						WHERE Id IN :accountIds
		]);

		// Get all other Product & Charge objects related to parent Accounts
		Map<Id, List<Zuora__SubscriptionProductCharge__c>> accountProductMap = new Map<Id, List<Zuora__SubscriptionProductCharge__c>>();
		Set<String> productZuoraIds = new Set<String>();
		for (Zuora__SubscriptionProductCharge__c product: [
				SELECT Id, Zuora__Account__c, Zuora__Product__r.Zuora__External_Id__c, Zuora__Price__c,Cancelled_Date__c,Date_of_Cancellation__c,
						Zuora__EffectiveStartDate__c, Zuora__EffectiveEndDate__c, Zuora__BillingPeriod__c, Subscription_Status__c, Zuora__Subscription__r.Zuora__SubscriptionStartDate__c
						FROM Zuora__SubscriptionProductCharge__c
						WHERE Zuora__Account__c IN :accountIds
						AND Zuora__Product__c != null
						AND (NOT Name LIKE '%Renewal%') AND (NOT Name LIKE '%Discount%')
		]) {
			if (!accountProductMap.containsKey(product.Zuora__Account__c)) {
				accountProductMap.put(product.Zuora__Account__c, new List<Zuora__SubscriptionProductCharge__c>());
			}
			accountProductMap.get(product.Zuora__Account__c).add(product);

			if (product.Zuora__Product__r.Zuora__External_Id__c != null) {
				productZuoraIds.add(product.Zuora__Product__r.Zuora__External_Id__c);
			}
		}

		// Get all Products associated with the Zuora Ids
		Map<String, Product2> productsByZuoraId = new Map<String, Product2>();
		for (Product2 product : [
				SELECT Id, zqu__ZuoraId__c, Family, SOW_Description__c, Description, Name
						FROM Product2
						WHERE zqu__ZuoraId__c IN :productZuoraIds
		]) {
			if (!productsByZuoraId.containsKey(product.zqu__ZuoraId__c)) {
				productsByZuoraId.put(product.zqu__ZuoraId__c, product);
			}
		}

		// Loop through Product & Charge objects for each Account
		List <Active_Subscriptions__c> activeSubscriptionsToInsert = new List <Active_Subscriptions__c>();
		Map<Id, Active_Subscriptions__c> existingRecords = new Map<Id, Active_Subscriptions__c>();

		for (Id accountId : accountProductMap.keySet()) {
			// Collect P&Cs by Zuora Id
			Map <String, List<Zuora__SubscriptionProductCharge__c>> subscriptionByZid = new Map <String, List<Zuora__SubscriptionProductCharge__c>>();
			for (Zuora__SubscriptionProductCharge__c subscription : accountProductMap.get(accountId)) {
				if (!subscriptionByZid.containsKey(subscription.Zuora__Product__r.Zuora__External_Id__c)) {
					subscriptionByZid.put(subscription.Zuora__Product__r.Zuora__External_Id__c, new List<Zuora__SubscriptionProductCharge__c>());
				}
				subscriptionByZid.get(subscription.Zuora__Product__r.Zuora__External_Id__c).add(subscription);
			}
			// Loop through each collection to gather necessary info for new Active Subscription
			for (String zId : subscriptionByZid.keySet()) {
				// Before continuing, make sure that we found an appropriate Product2 object
				if (!productsByZuoraId.containsKey(zId)) {
					continue;
				}

				Active_Subscriptions__c newActiveSubscription = new Active_Subscriptions__c();

				// Find Active Subscription with same Subscription_Item__c
				Boolean subscriptionFound = false;
				for (Active_Subscriptions__c subscriptionToCheck : accountMap.get(accountId).Active_Subscriptions__r) {
					//if (subscriptionToCheck.Subscription_Item__c == productsByZuoraId.get(zId).Name) {
					if (subscriptionToCheck.Product__c == productsByZuoraId.get(zId).Id) {
						newActiveSubscription = subscriptionToCheck;
						subscriptionFound = true;
						break;
					}
				}



				// If no existing Active Subscription exists, create a new one
				newActiveSubscription.Account__c = accountId;
				newActiveSubscription.Customer_Number__c = accountMap.get(accountId).Customer_Number__c;
				newActiveSubscription.Category__c = productsByZuoraId.get(zId).Family;
				newActiveSubscription.Subscription_Item__c = productsByZuoraId.get(zId).Name;
				newActiveSubscription.Product__c = productsByZuoraId.get(zId).Id;
				newActiveSubscription.SOW_Description__c = productsByZuoraId.get(zId).SOW_Description__c;
				newActiveSubscription.Subscription_Amount__c = 0;
				for (Zuora__SubscriptionProductCharge__c subscription : subscriptionByZid.get(zId)) {
					if(null == newActiveSubscription.ChargeOverSubLineItemId__c){ newActiveSubscription.ChargeOverSubLineItemId__c = subscription.Id; }

					newActiveSubscription.Subscription_Status__c = subscription.Subscription_Status__c;
					newActiveSubscription.Subscription_Start_Date__c = subscription.Zuora__Subscription__r.Zuora__SubscriptionStartDate__c;

					newActiveSubscription.Subscription_Amount__c += subscription.Zuora__Price__c;
					if (subscription.Zuora__EffectiveStartDate__c < newActiveSubscription.Start_Date__c
							|| newActiveSubscription.Start_Date__c == null
							) {
						newActiveSubscription.Start_Date__c = subscription.Zuora__EffectiveStartDate__c;
					}
					if (subscription.Zuora__EffectiveEndDate__c > newActiveSubscription.Expiration_Date__c
							|| newActiveSubscription.Expiration_Date__c == null
							) {
						newActiveSubscription.Expiration_Date__c = subscription.Zuora__EffectiveEndDate__c;
						newActiveSubscription.Subscription_Term__c = subscription.Zuora__BillingPeriod__c;

					}
				}
				activeSubscriptionsToInsert.add(newActiveSubscription);
			}
		}

		// Insert all newly organized Active Subscriptions
		if (!activeSubscriptionsToInsert.isEmpty()) {
			System.debug('activeSubscriptionsToInsert :: ' + activeSubscriptionsToInsert);
			upsert activeSubscriptionsToInsert;
		}
		if (!existingRecords.isEmpty()) {
			System.debug('existingRecords :: ' + existingRecords);
			update existingRecords.values();
		}
	}
}