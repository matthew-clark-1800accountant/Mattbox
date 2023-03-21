//DEPRECATED 12-21
trigger AssignBlankEvents on Event (before insert, before update) {
	
	// Map<Id,Event> leadIDs = new Map<Id,Event>();
	// Map<Id,Event> contIDs = new Map<Id,Event>();
	// Map<Id,Event> acctIDs = new Map<Id,Event>();
	// Set<String> SetSetterTypes = new Set<String>{'Merchant Services 1-1'};
	
	// ID BJid = '005j000000BpFqy';
	
	// for(Event e :Trigger.new)  {
	// 	if((e.ownerid==null || e.ownerid==BJid || ((String)e.ownerId).startsWith(Schema.SObjectType.Group.getKeyPrefix())) && e.whoid<>null)  {
	// 		if(((String)e.WhoId).startsWith(Schema.SObjectType.Lead.getKeyPrefix())) leadIDs.put(e.whoid,e);
	// 		if(((String)e.WhoId).startsWith(Schema.SObjectType.Contact.getKeyPrefix())) contIDs.put(e.whoid,e);
	// 	}
	// 	if(e.subject == 'Merchant Services 1-1' && e.WhoId == null && ((String)e.WhatId).startsWith(Schema.SObjectType.Account.getKeyPrefix())) acctIDs.put(e.whatid,e);
	// }
	
	// if(!leadIDs.keyset().isEmpty())  {
	// 	Map<Id,Lead> leads = new Map<Id,Lead>([Select Id,Name,(Select Id,OwnerID,Subject,ActivityDate from Tasks ORDER BY ActivityDate DESC) from Lead WHERE Id IN :leadIDs.keyset()]);
	// 	for(ID id : leadIDs.keyset())  {
	// 		Event e = LeadIDs.get(id);
	// 		Lead l = leads.get(id);
	// 		for(Task t : l.Tasks)  {
	// 			if((e.ownerid==null || e.ownerid==BJid || ((String)e.ownerId).startsWith(Schema.SObjectType.Group.getKeyPrefix())) && t.ownerid<>null) e.ownerid = t.ownerid;
	// 			e.owner_updated_by_trigger__c = true;
	// 			//if(e.Subject<>null && SetSetterTypes.contains(e.Subject) && e.Appointment_Setter__c<>null) e.Appointment_Setter__c = UserInfo.getName();
	// 		}			
	// 	}			
	// }
	// if(!acctIDs.keyset().isEmpty())  {
	// 	List<Contact> conts = new List<Contact>([SELECT Id,AccountId FROM Contact WHERE AccountID IN :acctIDs.keyset()]);
	// 	for(Event e :acctIDs.values())  {
	// 		ID contid = null;
	// 		Double numConts = 0;
	// 		for(Contact c : conts)  {
	// 			if(c.accountid == e.whatid)  {
	// 				contid = c.id;
	// 				numConts++;
	// 			}
	// 		}
	// 		if(numConts == 1 && contid<>null) e.whoID = contid;			
	// 	}	
	// }
}