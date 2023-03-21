public class Update_Account_Owner_Helper {
	
	public static boolean checkActiveProduct(Id accountId){
		
		boolean isActiveProduct = false;

		List<String> listProductCategories = new List<String>();
		Set<String> setActiveCategories = new Set<String>();

		// Get Product Categories list from schema
		Schema.sObjectType objType = Product2.getSObjectType(); 
		Schema.DescribeSObjectResult objDescribe = objType.getDescribe();       
		map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap(); 
		List<Schema.PicklistEntry> values = fieldMap.get('Product_Categories__c').getDescribe().getPickListValues();
		
		for(Schema.PicklistEntry v: values){
			listProductCategories.add(v.getValue());  
		}

		List<Bill62__Subscription__c> listActiveSubs = [Select Id
															, Bill62__Account__c
															, Bill62__Product__c
															, Bill62__Active__c 
															, Bill62__Suspended__c
															, Bill62__Termination_Date__c
															, Bill62__End_Date__c
															from Bill62__Subscription__c 
															where Bill62__Account__c = :accountId
															and Bill62__Active__c = true
															and Bill62__Suspended__c = false
															and (Bill62__Termination_Date__c > today or Bill62__Termination_Date__c = null)
															and (Bill62__End_Date__c > today or Bill62__End_Date__c = null)
														];


		if(listActiveSubs.size() > 0){

			Set<Id> setActiveProductIds = new Set<Id>();
			
			for(Bill62__Subscription__c s : listActiveSubs){
				setActiveProductIds.add(s.Bill62__Product__c);
			}

			//List<Product2> listActiveProducts = [Select Id, Name, Product_Categories__c from Product2 where Id IN :setActiveProductIds];

			for(Product2 p : [Select Id, Name, Product_Categories__c from Product2 where Id IN :setActiveProductIds]){
				if(p.Product_Categories__c == null){
					continue;
				}
				List<String> myCategories = p.Product_Categories__c.split(';');
				List<String> selectedCategories = new List<String>();               

				// Create list from all categories, flagging which ones are on product and which ones aren't
				for(String c : listProductCategories){  
					for(String m : myCategories){
						if(c == m){
							selectedCategories.add(m);
						}
					}
				}

			//setActiveCategories.addAll(selectedCategories);
			}

			if(setActiveCategories.size() > 0){
				isActiveProduct = Update_Account_Owner_Helper.sortCategories(setActiveCategories);
			} else {
				isActiveProduct = false;
			}

		}

		System.debug('isActiveProduct:-->' + isActiveProduct);
		
		return isActiveProduct;
	}

	public Static boolean sortCategories(Set<String> setCats){

		boolean isActive = false;
		String categories = '';

		List<Account_Product_Settings__c> customSettings = [SELECT Product_Category__c FROM Account_Product_Settings__c
		ORDER BY Sort_Order__c ASC];

		for(Account_Product_Settings__c aps: customSettings){
			if(setCats.contains(aps.Product_Category__c)){
				isActive = true;
				break;
			}
		}

		return isActive;
	}

	public static boolean checkPitchedAccount(Account acct){
		Integer taskCount = [Select count() from Task where WhatId =: acct.Id and Subject like '%Sales Follow Up%' and ActivityDate > TODAY];
		Integer eventCount = [Select count() from Event where WhatId =: acct.Id and Subject like '%Sales Follow Up%' and ActivityDate > TODAY];

		if(taskCount > 0 || eventCount > 0) {

			List<AccountHistory> lstAccountHistory = [SELECT AccountId, Field, Id, NewValue, OldValue, CreatedDate FROM AccountHistory Where Field='Lead_Status__c' and AccountId =: acct.Id and CreatedDate < N_DAYS_AGO:28 Order By CreatedDate desc Limit 1];

			if(lstAccountHistory.size() > 0) {
				if(lstAccountHistory[0].NewValue == acct.Lead_Status__c)
					return true;
			}

		} else {

			List<AccountHistory> lstAccountHistory = [SELECT AccountId, Field, Id, NewValue, OldValue, CreatedDate FROM AccountHistory Where Field='Lead_Status__c' and AccountId =: acct.Id and CreatedDate < N_DAYS_AGO:14 Order By CreatedDate desc Limit 1];			

			if(lstAccountHistory.size() > 0) {
				if(lstAccountHistory[0].NewValue == acct.Lead_Status__c)
					return true;
			}

		}
		return false;
	}
}