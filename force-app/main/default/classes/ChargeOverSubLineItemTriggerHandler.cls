/**
* Class created by Samuel Reyes on April 7 2020
* **/

public with sharing class ChargeOverSubLineItemTriggerHandler {
	/** Create as many as there is quantity in addition to 1 to 1 in future. **/
	/** For now just get the one to one going. **/
	private static TriggerControlPanels__mdt afterTriggerIsActive = [SELECT IsActive__c FROM TriggerControlPanels__mdt WHERE Label='CoSubLineItemTriggerHandler_After'];
	private static TriggerControlPanels__mdt beforeTriggerIsActive = [SELECT IsActive__c FROM TriggerControlPanels__mdt WHERE Label='CoSubLineItemTriggerHandler_Before'];
	private static Boolean haveInsertedActiveSubs = false;

	//Test visible because in the apex test class one test is processing the insert and update in the same context.
	//This should never happen in production as the CO Api will push the insert. SF should push back to CO. Then CO
	//should push back an update or such, triggering a second execution. For tests we need to set it ourselves.
	@TestVisible
	private static Boolean haveUpdatedActiveSubs = false;
	@TestVisible
	private static Boolean aslInsertsProcessed = false;
	@TestVisible
	private static Boolean aslUpdatesProcessed = false;
	@TestVisible
	private static Boolean testSwitchOff = false;

	public static void doAfterTrigger(ChargeOver_Subscription_Line_Item__c[] triggerNew, Map<Id, ChargeOver_Subscription_Line_Item__c> oldMap, Boolean isInsert, Boolean isUpdate, Boolean isDelete)
	{
		//Recursion & SOQL limits were happening here so I added the additional criteria -Koby
		if(afterTriggerIsActive.IsActive__c && Limits.getQueries() < 90)
		{
			if(isUpdate)
			{
				System.debug(LoggingLevel.FINE,'isUpdate trigger block AFTER');
				if(!haveUpdatedActiveSubs || (Test.isRunningTest() && !testSwitchOff))
				{
					//We're going to remove any items where the oldMap was an empty account as those would have been updated
					//in the context that triggered this. If it were to run through this again it would try to perform
					//the same operation. We only want the ones that either not had this done, or had it done in previous contexts.
					//-SReyes
					ChargeOver_Subscription_Line_Item__c[] modifiedTriggerList = new ChargeOver_Subscription_Line_Item__c[0];
					for(ChargeOver_Subscription_Line_Item__c record : triggerNew)
					{
						ChargeOver_Subscription_Line_Item__c oldRecord = oldMap.get(record.Id);
						if(oldRecord != record){ modifiedTriggerList.add(record); }
					}
					System.debug(LoggingLevel.FINE, 'modifiedTriggerList :: ' + modifiedTriggerList);
					activeSubscriptionProcessor(modifiedTriggerList, oldMap, true);
					haveUpdatedActiveSubs = true;
				}
			}
			if(isDelete)
			{
				System.debug(LoggingLevel.FINE,'isDelete trigger block AFTER');
//                deleteHandler(oldMap);
			}
			if(isInsert)
			{
				System.debug(LoggingLevel.FINE,'isInsert trigger block AFTER');
				System.debug(LoggingLevel.FINER,'AFTER INSERTION OF RECORDS :: ' + triggerNew);
				if(!haveInsertedActiveSubs){
					activeSubscriptionProcessor(triggerNew, new Map<Id, ChargeOver_Subscription_Line_Item__c>(), false);
				}
				haveInsertedActiveSubs = true;
				System.debug(LoggingLevel.FINER, 'haveInsertedActiveSubs :: ' + haveInsertedActiveSubs);
			}
		}
	}

	public static void doBeforeTrigger(ChargeOver_Subscription_Line_Item__c[] triggerNew, Map<Id, ChargeOver_Subscription_Line_Item__c> oldMap, Boolean isInsert, Boolean isUpdate)
	{
		if(beforeTriggerIsActive.IsActive__c)
		{
			if(isUpdate){}
			if(isInsert)
			{
				System.debug(LoggingLevel.FINE,'isInsert trigger block BEFORE');
				System.debug(LoggingLevel.FINER,'BEFORE INSERTION OF RECORDS :: ' + triggerNew);
				//Add accountId to this record to provide an additional query, and need less lookups.
				//If this works long term we should be able to consolidate the logic below to be more concise.
				setAccountIfAvailable(triggerNew);
			}
			if(isUpdate){ setAppliedAccountIfAvailable(triggerNew); }
		}
	}

	//This part sets default values only on personal accounts.
	//This method is specifically utilized on downgraded accounts. It looks backwards to the downgraded subscriptions SLI
	//records, and pulls the Applied Account value from that. This should only matter if not applied on creation for some reason.
	private static void setAppliedAccountIfAvailable(ChargeOver_Subscription_Line_Item__c[] triggerNew)
	{

		Set<Id> triggerIds = new Set<Id>();
		for(ChargeOver_Subscription_Line_Item__c sli : triggerNew)
		{
			if(null != sli.Converted_From_Subscription__c && null == sli.Applied_Account__c){ triggerIds.add(sli.Id); }
		}

		System.debug(LoggingLevel.FINE, 'triggerIds :: ' + triggerIds);
		for(ChargeOver_Subscription_Line_Item__c sli : [
				SELECT Id, Account__c, ChargeOver_Subscription__c, Product__r.ZZ_Primary_Category__c, Product__c
				FROM ChargeOver_Subscription_Line_Item__c WHERE ChargeOver_Subscription__c IN: triggerIds ])
		{
			if((Test.isRunningTest() && !testSwitchOff) || (null != sli.Product__c && 'Personal'.equalsIgnoreCase(sli.Product__r.ZZ_Primary_Category__c) && null != sli.Account__c))
			{ sli.Applied_Account__c = sli.Account__c; }


		}
	}

	private static void setAccountIfAvailable(ChargeOver_Subscription_Line_Item__c[] triggerNew)
	{
		//Having a relationship to the account on this record will help save time and be less 'expensive' because
		//we will need to use fewer queries to establish relationships and pull related field values.
		//As a general rule there should always be an account, so this should be an easy populate. -SReyes

		Set<Id> chargeOverSubIds = new Set<Id>();
		for(ChargeOver_Subscription_Line_Item__c sli : triggerNew)
		{ if(null != sli.ChargeOver_Subscription__c){ chargeOverSubIds.add(sli.ChargeOver_Subscription__c); } }

		//Map is of format <ChargeOver_Subscription__c Id, AccountId>
		Map<Id,Id> subToAccountMap = new Map<Id,Id>();
		for(ChargeOver_Subscription__c sub : [SELECT Id, Account__c FROM ChargeOver_Subscription__c WHERE Id IN :chargeOverSubIds])
		{
			//Only capture the map entry if an account relationship exists.
			if(null != sub.Account__c) subToAccountMap.put(sub.Id, sub.Account__c);
		}

		for(ChargeOver_Subscription_Line_Item__c sli : triggerNew)
		{
			if(subToAccountMap.containsKey(sli.ChargeOver_Subscription__c))
			{
				//This should work every time at this point because in the loop above we
				//automatically excluded any record that doesn't have a value to go with the key.
				sli.Account__c = subToAccountMap.get(sli.ChargeOver_Subscription__c);
			}
		}
	}

	private static Map<Id, ChargeOver_Subscription_Line_Item__c> getRecordsWithAdditionalFields(Set<Id> recordIds)
	{
		Map<Id, ChargeOver_Subscription_Line_Item__c> output = new Map<Id, ChargeOver_Subscription_Line_Item__c>();
		for(ChargeOver_Subscription_Line_Item__c sli : [
				SELECT Id, Account__c, Account__r.Name, Account__r.Customer_Number__c, ChargeOver_Subscription__c, Product__c, ChargeOver_Subscription__r.Active_Subscription__c, SystemModstamp, Paused_Date__c, ChargeOver_Subscription__r.Paused_Date__c,
						Product__r.Name, Product__r.Family, Product__r.SOW_Description__c ,CreatedDate, Price_Per_Unit__c, Cancel_Date_Time__c, Quantity__c, Historical_Update__c, ChargeOver_Subscription__r.Status__c, Converted_From_Subscription__c,
						Active_Subscription__c, Active_Subscription__r.Account__c, Subscription_Start_Date__c, Status__c, Applied_Account__c, Product__r.ZZ_Primary_Category__c, 
						Total_Paid_Amount__c, Total_Refund_Amount__c, Refund_Percentage__c, Service_End_Date__c, Oldest_Overdue_Due_Date__c, Write_Off_Paid_Amount__c, Write_Off_Paid_Percentage__c,
						of_Monthly_Bookkeeping_Transactions__c, of_Payroll_Employees__c
				FROM ChargeOver_Subscription_Line_Item__c
				WHERE Id IN :recordIds
		]){ output.put(sli.Id, sli); }
		return output;
	}

	private static void activeSubscriptionProcessor(ChargeOver_Subscription_Line_Item__c[] triggerNew, Map<Id, ChargeOver_Subscription_Line_Item__c> oldMap, Boolean isUpdate)
	{
		Map<Id, ChargeOver_Subscription_Line_Item__c> triggerNewMap = new Map<Id, ChargeOver_Subscription_Line_Item__c>();
		Map<String, Active_Subscriptions__c> recordsToPerformDmlOn = new Map<String, Active_Subscriptions__c>();
		Set<Id> recordIds = new Set<Id>();
		Set<String> subscriptionIds = new Set<String>();
		Date today = Date.today();

		//First we sort out records we don't need. "AND (NOT Name LIKE '%Renewal%') AND (NOT Name LIKE '%Discount%')".
		// By checking here we are just dumping them and excluding them from any further operations.
		// Second, we need to rebuild our TriggerNewMap because we modified our list previously. -SReyes
		for (ChargeOver_Subscription_Line_Item__c sli : triggerNew) {
			if (!sli.Name.containsIgnoreCase('renewal') && !sli.Name.containsIgnoreCase('discount')) {
				recordIds.add(sli.Id);
				subscriptionIds.add((String) sli.Product__c + (String) sli.Account__c);
				triggerNewMap.put(sli.Id,sli);
			}
		}

		//We need to re-query our trigger records with additional relationship values. This is an after trigger so this will work.
		//These will be used for sorting and assigning values further down. -SReyes
		Map<Id, ChargeOver_Subscription_Line_Item__c> triggerNewMapCustom = getRecordsWithAdditionalFields(recordIds);
		System.debug(LoggingLevel.FINE, 'triggerNewMapCustom :: ' + triggerNewMapCustom);

		//This is a map of our existing activeSubscriptions. Every record at this point should be making one I believe.
		//The Unique_Identifier__c field should be populated because it is done so on insertion.
		Set<Id> aslSubIds = new Set<Id>();
		Map<String, Active_Subscriptions__c> activeSubscriptions = new Map<String, Active_Subscriptions__c>();
		Set<String> alreadyCreatedSubscriptionsLineItems = new Set<String>();
		Map<String,Date> mostRecentExpirationDate = new Map<String,Date>();
		for (Active_Subscriptions__c subscription : [
				SELECT Id, Subscription_Status__c, SOW_Description__c, Subscription_Amount__c, Account__c, Unique_Identifier__c,
						Cancelled_Date__c, Total_Purchased__c, Payment_Status__c, Expiration_Date__c, Category__c, Start_Date__c, Oldest_Overdue_Due_Date__c,
						Account_Name__c, Customer_Number__c, Subscription_Item__c, Subscription_Term__c, Product__c,
				(SELECT Id, ChargeOver_Subscription_Line_Item__c, Converted_From_ASL__c, Converted_From_Subscription__c, Unique_Identifier__c, ChargeOver_Subscription_Line_Item__r.ChargeOver_Subscription__c,Cancelled_Date__c,Oldest_Overdue_Due_Date__c, of_Payroll_Employees__c, of_Monthly_Bookkeeping_Transactions__c,
						ChargeOver_Subscription_Line_Item__r.ChargeOver_Subscription__r.Status__c, Start_Date__c, Status__c, ChargeOver_Subscription__r.Status__c,ChargeOver_Subscription__c, Account__c, Applied_Account__c, Subscription_Amount__c, Expiration_Date__c FROM Active_Subscription_Lines__r)
				FROM Active_Subscriptions__c
				WHERE Unique_Identifier__c IN :subscriptionIds
		]) {
			activeSubscriptions.put(subscription.Unique_Identifier__c, subscription);
			alreadyCreatedSubscriptionsLineItems.add(subscription.Unique_Identifier__c);
			if(null != subscription.Active_Subscription_Lines__r)
			{
				for(Active_Subscription_Line__c asl : subscription.Active_Subscription_Lines__r)
				{
					if(null != asl.ChargeOver_Subscription__c)
					{
						aslSubIds.add(asl.ChargeOver_Subscription__c);
					}
					else if(null != asl.ChargeOver_Subscription_Line_Item__r.ChargeOver_Subscription__c)
					{
						aslSubIds.add(asl.ChargeOver_Subscription_Line_Item__r.ChargeOver_Subscription__c);
					}
				}
			}
		}
		System.debug(LoggingLevel.FINER, 'activeSubscriptions :: ' + activeSubscriptions);
		Map<Id,ChargeOver_Subscription__c> fullSubMap = new Map<Id,ChargeOver_Subscription__c>();
		for(ChargeOver_Subscription__c sub : [SELECT Id, Status__c FROM ChargeOver_Subscription__c WHERE Id IN :aslSubIds])
		{
			fullSubMap.put(sub.Id,sub);
		}

		Active_Subscription_Line__c[] aslToInsert = new Active_Subscription_Line__c[0];
		SObject[] aslToUpdate = new SObject[0];

		//Id of SLI as key.
		Map<Id,Set<Id>> usedItems = new Map<Id,Set<Id>>();
		Set<Id> usedSLI = new Set<Id>();
		Set<String> usedGUID = new Set<String>();
		Set<Id> isPausedASL = new Set<Id>();

		for(ChargeOver_Subscription_Line_Item__c sli : triggerNewMapCustom.values())
		{
//			System.debug('sli -- ' + sli.Id + ' - ' + sli.Converted_From_Subscription__c + ' - ' + sli);
			Boolean subPaused = ('Suspended'.equalsIgnoreCase(sli.ChargeOver_Subscription__r.Status__c));
			Boolean sliSubOverdue = ('Overdue'.equalsIgnoreCase(sli.ChargeOver_Subscription__r.Status__c));
			String uniqueId = (String) sli.Product__c + (String) sli.Account__c;
			Active_Subscriptions__c activeSubscription;
			Date startDate = Date.valueOf(sli.Subscription_Start_Date__c);
			Date cancelDate = (null != sli.Cancel_Date_Time__c) ? Date.valueOf(sli.Cancel_Date_Time__c) : null;
			Boolean historyChanged = (oldMap.containsKey(sli.Id) && oldMap.get(sli.Id).Historical_Update__c != sli.Historical_Update__c);
			if(null != sli.Service_End_Date__c)
			{
				if(!mostRecentExpirationDate.containsKey(uniqueId))
				{
					mostRecentExpirationDate.put(uniqueId,sli.Service_End_Date__c);
				}
				else if(mostRecentExpirationDate.containsKey(uniqueId) && mostRecentExpirationDate.get(uniqueId) < sli.Service_End_Date__c)
				{
					//Should overwrite the current map value with the most recent expiration date.
					mostRecentExpirationDate.put(uniqueId,sli.Service_End_Date__c);
				}
			}

			/**Check for cancellation status based on criteria.
			 * Active = No Cancel Date, CO Sub status not paused.
			 * Paused = No Cancel Date, CO Sub status paused.
			 * Active - Pending Cancel = Cancel Date Populated, Not passed Service End Date.
			 * Cancelled = Canceled Date Populated, Beyond Service End Date.
			 * **/
			Boolean paused = ('Suspended'.equalsIgnoreCase(sli.ChargeOver_Subscription__r.Status__c));
			System.debug(LoggingLevel.FINER, 'Suspended :: ' + paused);
			if(null != sli.Cancel_Date_Time__c || paused)
			{
				if(paused)
				{
					sli.Status__c = 'Suspended';
					subPaused = true;
					if(!isPausedASL.contains(sli.Id)){ isPausedASL.add(sli.Id); }
				}
				else if(null != sli.Refund_Percentage__c || null != sli.Write_Off_Paid_Percentage__c)
				{
					Boolean greaterThanThirty = (null != sli.Refund_Percentage__c && sli.Refund_Percentage__c >= 30);
					Boolean serviceEndDateNull = (null == sli.Service_End_Date__c);
					Boolean writeOffPaidPctGtrSvty = (null != sli.Write_Off_Paid_Percentage__c && sli.Write_Off_Paid_Percentage__c >= 70);
					if(greaterThanThirty || writeOffPaidPctGtrSvty){ sli.Status__c = 'Cancelled'; }
					else
					{
						if(serviceEndDateNull || sli.Service_End_Date__c < today) { sli.Status__c = 'Cancelled'; }
						else if(sli.Service_End_Date__c > today) { sli.Status__c = 'Active - Pending Cancel'; }
					}
				}
				else { sli.Status__c = 'Cancelled'; }
				
			}
			else if( sliSubOverdue ){ sli.Status__c = 'Overdue'; }
			else { sli.Status__c = 'Active'; }
			System.debug(LoggingLevel.FINE,'mostRecentExpirationDate Map :: ' + mostRecentExpirationDate);

			//Check if we have already created the active subscription.
			//If we have the modify or create the active sub lines accordingly.
			if(activeSubscriptions.containsKey(uniqueId))
			{
				//Active Sub found, check individual line items.
				//If we have previously touched the Active Sub, fetch out modified version.
				activeSubscription = (recordsToPerformDmlOn.containsKey(uniqueId)) ?
						recordsToPerformDmlOn.get(uniqueId) :
						activeSubscriptions.get(uniqueId);
				System.debug(LoggingLevel.FINE, 'activeSubscription found :: ' + activeSubscription);

				//Needed to add an if checking specifically for conversions because they won't create a new active sub.
				//So the insertion will directly fire this.
//				if(isUpdate || (!isUpdate && null != sli.Converted_From_Subscription__c))

				if(isUpdate)
				{
					System.debug(LoggingLevel.FINER, 'in asl creation block');
					//Check to make sure all of our line items are NOT cancelled, and keep the active sub
					//as active status if so.

					Decimal currentQuantityOfExistingASL = 0;
					if(null != activeSubscription.Active_Subscription_Lines__r)
					{
						for(Active_Subscription_Line__c asl : activeSubscription.Active_Subscription_Lines__r)
						{
							System.debug(LoggingLevel.FINE, 'asl record :: ' + asl);
							//If any SLI is active, match the related ASL records.
							//Make sure our quantity amount from the SLI aggregates properly.
							//The reason I am doing it this way instead of an activeSubscription.Active_Subscription_Lines__r.size()
							//check is because if SOQL doesn't return the related records it won't include the value, and it will throw a null error.
							//Additionally, each SLI should have a quantity on it. By checking against the SLI Id
							//we can check specifically to see if we have ASL for this SLI to match the quantity.
							//This means each sli should return it's own ASL count even though we are iterating through all of the SLI.
							//And if there are any ASL missing, we will find it as soon as we find an SLI record where they haven't been
							//created or because the number is less than an updated total. The count will fall short or remain zero. -SReyes
							if(sli.Id == asl.ChargeOver_Subscription_Line_Item__c)
							{
								//This block should fire retro-actively only for records where this field value is empty.
								//This field is only really used on insert going forward. Empty field values on existing ASL should be okay.
								
//								if(String.isEmpty(asl.ASL_Unique_Id__c))
//								{
//									asl.ASL_Unique_Id__c = sli.Id + '';
//								}

								if(sli.Oldest_Overdue_Due_Date__c != asl.Oldest_Overdue_Due_Date__c)
								{
									asl.Oldest_Overdue_Due_Date__c = sli.Oldest_Overdue_Due_Date__c;
								}
								if(sli.of_Monthly_Bookkeeping_Transactions__c != asl.of_Monthly_Bookkeeping_Transactions__c)
								{
									asl.of_Monthly_Bookkeeping_Transactions__c = sli.of_Monthly_Bookkeeping_Transactions__c;
								}
								if(sli.of_Payroll_Employees__c != asl.of_Payroll_Employees__c)
								{
									asl.of_Payroll_Employees__c = sli.of_Payroll_Employees__c;
								}

								System.debug(LoggingLevel.FINER, 'SLI Found :: ' + sli);

								Date subStartDate = (null != sli.Subscription_Start_Date__c) ? sli.Subscription_Start_Date__c.date() : null;
								if(null == asl.Start_Date__c && null != startDate)
								{
									asl.Start_Date__c = subStartDate;
								}

								//Redundancy to ensure ASL records are related to the corresponding SLI records Subscription as well.
								if(null == asl.ChargeOver_Subscription__c && null != sli.ChargeOver_Subscription__c)
								{
									System.debug('setting asl sub :: ' + sli.ChargeOver_Subscription__c);
									asl.ChargeOver_Subscription__c = sli.ChargeOver_Subscription__c;
								}

								if(null == asl.Converted_From_Subscription__c && null != sli.Converted_From_Subscription__c)
								{
									asl.Converted_From_Subscription__c = sli.Converted_From_Subscription__c;
								}

								if(subPaused && null != sli.Paused_Date__c)
								{
									asl.Paused_Date__c = sli.Paused_Date__c;
								}

								if(asl.Expiration_Date__c != sli.Service_End_Date__c)
								{
									asl.Expiration_Date__c = sli.Service_End_Date__c;
								}

								if(activeSubscription.Start_Date__c > subStartDate)
								{
									activeSubscription.Start_Date__c = subStartDate;
								}

								if(!asl.Status__c.equalsIgnoreCase(sli.Status__c) || historyChanged)
								{
									//Update the status of the ASL should it be changed. This should 'trigger' based on our status updates further up.
									asl.Status__c = sli.Status__c;
									if('Cancelled'.equalsIgnoreCase(sli.Status__c) && null != cancelDate)
									{
										asl.Cancelled_Date__c = cancelDate;
									}
								}
								aslToUpdate.add(asl);

								//Before this was being set to SLI quantity, but we are iterating through the ASL records.
								//Meaning we should be checking 1 by 1 against the ASL to SLI record Id lookup field. So there would be 1 SLI,
								//but if sli.Quantity is 4 we should have 4 asl and increment by one for each one.
								currentQuantityOfExistingASL = currentQuantityOfExistingASL + 1;
								System.debug(LoggingLevel.FINER, 'updating current quantity of existing too : ' + currentQuantityOfExistingASL);
							}
						}
					}

					//We are no longer iterating the individual ASL records, but are back at the ActiveSub level.
					//We have a total of all quantities for all SLI matching our unique identifier.
					//If total created is less, make the difference, and matches our current sli.
					//This is the expected amount, total.
					Decimal difference = 0;
					Boolean subHasAslRecords = aslSubIds.contains(sli.ChargeOver_Subscription__c);
					System.debug(LoggingLevel.FINE, 'subHasAslRecords :: ' + subHasAslRecords);
					if(subHasAslRecords && currentQuantityOfExistingASL < sli.Quantity__c)
					{
//						difference = sli.Quantity__c - currentQuantityOfExistingASL;
						while(difference < sli.Quantity__c){ difference++; }
					}
					else if(!subHasAslRecords || currentQuantityOfExistingASL == 0)
					{
						difference = sli.Quantity__c;
					}
					System.debug(LoggingLevel.FINE, 'difference exists of ' + difference);
					Boolean isPersonalProduct = 'Personal'.equalsIgnoreCase(sli.Product__r.ZZ_Primary_Category__c);
					Boolean isAppliedAccountAlreadyPopulated = (null != sli.Applied_Account__c);

					//We are storing the SLI Id on the ASL record for counting purposes. We're checking to see
					//if the number of ASL records with this ID on it matches the quantity on the SLI itself.
					for(Integer i = 0; i < difference; i++)
					{
						aslToInsert.add(new Active_Subscription_Line__c(
								Name=sli.Product__r.Name,
								Status__c=sli.Status__c,
								Product__c=sli.Product__c,
								Start_Date__c = startDate,
								Active_Subscription__c=activeSubscription.Id,
								Applied_Account__c = (isAppliedAccountAlreadyPopulated) ? sli.Applied_Account__c : (isPersonalProduct) ? sli.Account__c : null,
								Account__c=activeSubscription.Account__c,
								Unique_Identifier__c=activeSubscription.Unique_Identifier__c,
								ASL_Unique_Id__c = sli.Id + '000' + String.valueOf(i),
								ChargeOver_Subscription_Line_Item__c = sli.Id,
								Subscription_Amount__c = (null != sli.Price_Per_Unit__c) ? sli.Price_Per_Unit__c : 0,
								Customer_Number__c = sli.Account__r.Customer_Number__c,
								ChargeOver_Subscription__c=sli.ChargeOver_Subscription__c,
								Category__c=sli.Product__r.Family,
								Expiration_Date__c = (null != sli.Service_End_Date__c) ? sli.Service_End_Date__c : null,
								Converted_From_Subscription__c = (null != sli.Converted_From_Subscription__c) ? sli.Converted_From_Subscription__c : null
						));
					}
					System.debug(LoggingLevel.FINE, 'aslToInsert set as :: ' + aslToInsert);

					Boolean isActive = false;
					Boolean isPendingCancel = false;
					Boolean isPaused = false;
					Boolean isOverdue = false;
					Date oldestDueDate;
					for(Active_Subscription_Line__c asl : activeSubscription.Active_Subscription_Lines__r)
					{
						/** Check to see if anything is not marked as paused.
						 * Logic is:
						 * if isActive is true, and isPaused is false, active sub is active.
						 * if isActive is false, and isPaused is true, active sub is paused.
						 * if isActive is false, and isPaused is false, active sub is cancelled.
						 *
						 * These activeSubscription.Active_Subscription_Lines__r records were previously modified above
						 * and should be the most recent version of the record. Lin 233ish.
						 * -SReyes
						**/
						ChargeOver_Subscription__c parentSub = (fullSubMap.containsKey(asl.ChargeOver_Subscription__c)) ? fullSubMap.get(asl.ChargeOver_Subscription__c) : new ChargeOver_Subscription__c();
						System.debug(LoggingLevel.FINER, 'parentSub :: ' + parentSub);
						if('Active'.equalsIgnoreCase(asl.Status__c) && !isPausedASL.contains(asl.ChargeOver_Subscription_Line_Item__c)){ isActive = true; }
						if('Suspended'.equalsIgnoreCase(parentSub.Status__c)){ isPaused = true; }
						if('Active - Pending Cancel'.equalsIgnoreCase(asl.Status__c)){ isPendingCancel = true; }
						System.debug(LoggingLevel.FINE,'contains sli id :: ' + fullSubMap.containsKey(asl.ChargeOver_Subscription__c));
						if(isPendingCancel){ System.debug(LoggingLevel.FINE, 'isPendingCancel set to true, at least one ASL is pending cancel.'); }
						if(null != sli.Oldest_Overdue_Due_Date__c && (null == oldestDueDate || oldestDueDate > sli.Oldest_Overdue_Due_Date__c))
						{
							if('Overdue'.equalsIgnoreCase(sli.Status__c)){ isOverdue = true; }
							oldestDueDate = sli.Oldest_Overdue_Due_Date__c;
						}
					}

					if(isActive) { activeSubscription.Subscription_Status__c = 'Active';}
					else if(!isActive && isPaused && !isPendingCancel)
					{
						activeSubscription.Subscription_Status__c = 'Suspended';
						activeSubscription.Paused_Date__c = sli.ChargeOver_Subscription__r.Paused_Date__c;
					}
					else if( (!isActive && !isPaused && isPendingCancel)||(!isActive && isPaused && isPendingCancel) )
					{
						activeSubscription.Subscription_Status__c = 'Active - Pending Cancel';
					}
					else
					{
						activeSubscription.Subscription_Status__c = (isOverdue) ? 'Overdue' : 'Cancelled';
						activeSubscription.Cancelled_Date__c = ('Cancelled'.equalsIgnoreCase(activeSubscription.Subscription_Status__c)) ? cancelDate : null;
					}

					if(null != oldestDueDate){ activeSubscription.Oldest_Overdue_Due_Date__c = oldestDueDate; }

//					activeSubscription.Cancelled_Date__c = (isActive) ? null : cancelDate;
					System.debug(LoggingLevel.FINE, 'isActive :: ' + isActive + ' for record with ID :: ' + activeSubscription.Id);

					activeSubscription.Line_Items_Last_Modified__c = Datetime.now();

					System.debug(LoggingLevel.FINE, 'activeSubscription modified as :: ' + activeSubscription.Subscription_Status__c);
					recordsToPerformDmlOn.put(uniqueId, activeSubscription);
				}
			}
			else
			{
				//Create this, then update the related SLI records to have the account Id.
				//When the SLI records are created it will trigger the above block and create the related
				//ActiveSubscriptionLine records.
				Set<Id> used = (usedItems.containsKey(sli.Account__c)) ? usedItems.get(sli.Account__c) : new Set<Id>();

				if (
						!usedSLI.contains(sli.Id) &&
								!alreadyCreatedSubscriptionsLineItems.contains(sli.Id) &&
								!used.contains(sli.Product__c)
						) {
					if(null == sli.Product__c){ continue; }
					System.debug(LoggingLevel.FINER, 'now creating active subscription for SLI :: ' + sli.Id + ' :: ' + sli.Product__r.Name);

					activeSubscription = new Active_Subscriptions__c(Name = sli.Product__r.Name);
					activeSubscription.Unique_Identifier__c = (String) sli.Product__c + (String) sli.Account__c;
					usedGUID.add(activeSubscription.Unique_Identifier__c);

					activeSubscription.Account__c = sli.Account__c;
					activeSubscription.Subscription_Item__c = sli.Product__r.Name;
					activeSubscription.Customer_Number__c = sli.Account__r.Customer_Number__c;
					activeSubscription.SOW_Description__c = sli.Product__r.SOW_Description__c;
					activeSubscription.Subscription_Amount__c = sli.Price_Per_Unit__c;
					activeSubscription.Cancelled_Date__c = (null != sli.Cancel_Date_Time__c) ? sli.Cancel_Date_Time__c.date() : null ;
					activeSubscription.Total_Purchased__c = sli.Quantity__c;
					activeSubscription.Category__c = sli.Product__r.Family;
					activeSubscription.Product__c = sli.Product__c;
					activeSubscription.Subscription_Status__c = sli.Status__c;
					activeSubscription.Start_Date__c = startDate;
					activeSubscription.Subscription_Amount__c = sli.Price_Per_Unit__c;
					activeSubscription.Line_Items_Last_Modified__c = Datetime.now();

					System.debug(LoggingLevel.FINE, 'activeSubscription not found, creating.... ' + activeSubscription);
					recordsToPerformDmlOn.put(sli.Id, activeSubscription);

					used.add(sli.Product__c);
					usedItems.put(sli.Account__c, used);
					usedSLI.add(sli.Id);

				}
			}
		}

		System.debug(LoggingLevel.FINE,'recordsToPerformDmlOn :: ' + recordsToPerformDmlOn);
		if(null != recordsToPerformDmlOn && !recordsToPerformDmlOn.isEmpty())
		{
			//The purpose of this for loop is to check if we have collected expiration dates and then populate the field
			//on the active subscription if it exists.
			for(Active_Subscriptions__c sub : recordsToPerformDmlOn.values())
			{
				//This map, at this point, should only have the latest expiration date values.
				if(mostRecentExpirationDate.containsKey(sub.Unique_Identifier__c))
				{
					sub.Expiration_Date__c = mostRecentExpirationDate.get(sub.Unique_Identifier__c);
				}
			}
			upsert recordsToPerformDmlOn.values() Unique_Identifier__c; //need alternative upsert id?
		}

		Boolean subIdsModifiedForSLI = false;
		if(!aslUpdatesProcessed)
		{
			for(ChargeOver_Subscription_Line_Item__c sli : triggerNewMapCustom.values())
			{
				String uniqueId = (String) sli.Product__c + (String) sli.Account__c;
				for(Active_Subscriptions__c sub : recordsToPerformDmlOn.values())
				{
					if(null != sub.Unique_Identifier__c && uniqueId == sub.Unique_Identifier__c)
					{
						sli.Active_Subscription__c = sub.Id;
						aslToUpdate.add(sli);
						subIdsModifiedForSLI = true;
						System.debug(LoggingLevel.FINE, 'associating sli and active sub :: ' + sli.Id + ' - ' + sub.Id);
					}
				}
			}
		}

//        System.debug('sliToInsert :: ' + sliToInsert);

		//This SHOULD only be inserting new records. It should NOT be trying to recreate ones that already exist.
		System.debug(LoggingLevel.FINEST, 'aslToInsert triggering... ');
		if(!aslInsertsProcessed && !aslToInsert.isEmpty() && aslToInsert.size() > 0 )
		{
			aslInsertsProcessed = true;
			System.debug(LoggingLevel.FINEST, 'aslToInsert triggering... ' + aslToInsert);
			upsert aslToInsert ASL_Unique_Id__c;

			Active_Subscription_Line__c[] toRelateAccounts = new Active_Subscription_Line__c[0];
			for(Active_Subscription_Line__c asl : aslToInsert)
			{
				if(null != asl.Converted_From_Subscription__c && null == asl.Converted_From_ASL__c)
				{
					toRelateAccounts.add(asl);
				}
			}

			if(!toRelateAccounts.isEmpty())
			{
				setAppliedAccountAsPreviously(toRelateAccounts);
			}
		}
		//Update if the status was changed.
		System.debug(LoggingLevel.FINEST, 'aslToUpdate triggering... ');
		if((!aslUpdatesProcessed || (Test.isRunningTest() && !testSwitchOff) ) && !aslToUpdate.isEmpty() && aslToUpdate.size() > 0 )
		{
			aslUpdatesProcessed = true;
			System.debug(LoggingLevel.FINE, 'aslToUpdate triggering record :: ' + aslToUpdate);
			setAppliedAccountAsPreviously(aslToUpdate);
		}

	}

	//For the downgrade newly created ASL records. Set to match prior values. This will only work in an update context.
	//However it should run more or less immediately and feel like insertion to the end user.
	private static void setAppliedAccountAsPreviously(SObject[] aslToUpdate)
	{

		Map<Id,SObject> output = new Map<Id, SObject>();
		Set<String> identifierToSearch = new Set<String>();
		Map<Id,Id> aslConsumedMap = new Map<Id,Id>();

		//Map to preserve original records for outputting final updates.
		Map<Id, Active_Subscription_Line__c> aslToUpdateMap = new Map<Id, Active_Subscription_Line__c>();
		for(SObject aslr : aslToUpdate)
		{
			if('Active_Subscription_Line__c'.equalsIgnoreCase(aslr.Id.getSobjectType().getDescribe().getName()))
			{
				Active_Subscription_Line__c asl = (Active_Subscription_Line__c) aslr;
				System.debug('post set asl fetched :: ' + asl);
//				if(sliRecordsProcessed.contains(asl.ChargeOver_Subscription_Line_Item__c)){ continue; }
				aslToUpdateMap.put(asl.Id,asl);
				Boolean convASL = false;
				//Capture already related ASL records so we do not duplicate.
				if(null != asl.Converted_From_ASL__c)
				{
					convASL = true;
				}

				//This one is problem!
				Boolean convSUB = false;
				if(null != asl.Converted_From_Subscription__c)
				{
					convSUB = true;
				}

				Boolean hasApplied = true;
				if(null == asl.Applied_Account__c)
				{
					hasApplied = false;
				}

				//This SHOULD work okay because if they are switched back out of cancel it'll work for the other status.
				//Mostly trying to not keep the old ASL as active when a new, converted one is being created.
				if((convASL && convSUB && hasApplied)
						||
					(null == asl.Converted_From_Subscription__c &&
							'Cancelled'.equalsIgnoreCase(asl.Status__c) &&
							null != asl.Cancelled_Date__c
					)
				)
				{
					System.debug(LoggingLevel.FINER,' Record is already updated, or is cancelled :: adding to output:: ' + asl);
					output.put(aslr.Id,aslr);
				}
				else if (null == asl.Converted_From_Subscription__c && null == asl.Converted_From_ASL__c )
				{
					System.debug('checkpoint 1 else box');
					output.put(aslr.Id,aslr);
				}
				else
				{
					System.debug('checkpoint 2 else box');
					identifierToSearch.add(asl.Unique_Identifier__c);
				}
			}
			else
			{
				output.put((Id) aslr.get('Id'),aslr);
			}
		}

		//Sets to avoid duplication. Converted_From_ASL__c
		Set<Active_Subscription_Line__c> baseASL = new Set<Active_Subscription_Line__c>();
		for(Active_Subscription_Line__c asl : [SELECT Id, Applied_Account__c, Unique_Identifier__c, Converted_From_Subscription__c, Converted_From_ASL__c
		FROM Active_Subscription_Line__c
		WHERE Unique_Identifier__c IN : identifierToSearch])
		{
			//Only collect the ones with an Applied and without converted from sub. These will be the original ones.
			if(null == asl.Converted_From_Subscription__c)
			{
				baseASL.add(asl);
			}
		}

		System.debug('baseASL :: ' + baseASL);
		for(Active_Subscription_Line__c converted : aslToUpdateMap.values())
		{
			for(Active_Subscription_Line__c baseRecord : baseASL)
			{
				//Check to make sure we have not already set this value.
				if((converted.Unique_Identifier__c == baseRecord.Unique_Identifier__c) && (
						!output.containsKey(converted.Id) &&
						aslToUpdateMap.containsKey(converted.Id) &&
						!aslConsumedMap.containsKey(baseRecord.Id) &&
						null != converted.Converted_From_Subscription__c
						)
						)
				{
					if( baseRecord.Applied_Account__c != null ){ converted.Applied_Account__c = baseRecord.Applied_Account__c; }
					converted.Converted_From_ASL__c = baseRecord.Id;
					//Capture the new 1:1 relationship.
					System.debug(LoggingLevel.DEBUG, 'matching found :: ' + converted);
					aslConsumedMap.put(baseRecord.Id,converted.Id);

					//This will return an updated version of the original records we passed into this method,
					//But containing our new relationship as well as all of the fields we needed to update before.
					output.put(converted.Id, converted);
				}
			}
		}

		System.debug(LoggingLevel.DEBUG,'output...' + output);
		update output.values();
	}

}