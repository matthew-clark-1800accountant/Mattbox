// Authored by BJ Jones - bj@binarycloudconsulting.com

trigger UpdateCalls on Task (after delete, after insert, after undelete, after update) {
	/*
	// Declare the variables
	set<Id> WhoIDs = new Set<Id>();
	boolean hasLeads=false;
	list<Lead> LeadsToUpdate = new List<Lead>();
	
	// Build the list of Leads to update
	if(Trigger.isInsert || Trigger.isUnDelete || Trigger.isUpdate){
		for(Task t: Trigger.new){
			if(t.WhoID != null  && t.isClosed && t.type == 'Call')  {
				 WhoIDs.add(t.WhoId);
				 if(((String)t.WhoId).startsWith(Schema.SObjectType.Lead.getKeyPrefix())) hasLeads = true;
			}
		}
	}
	if(Trigger.isDelete || Trigger.isUpdate){
		for(Task t: Trigger.old){
			if(t.WhoID != null && t.isClosed && t.type == 'Call')  {
				WhoIDs.add(t.WhoId);
				if(((String)t.WhoId).startsWith(Schema.SObjectType.Lead.getKeyPrefix())) hasLeads = true;	
			}
		}
	}
	List<Task> tasks = new List<Task>([select whoID,type from Task where WhoID IN :WhoIDs AND isClosed = TRUE ]);
	  
	//Process Touch count on Leads
	if(hasLeads)  {
		for(Lead l : [Select Id, Calls__c from Lead where Id IN :WhoIDs]){
	  		Double Calls = 0;  		
	  		for (Task t : tasks)  {
	  			if(t.whoid == l.id && t.type == 'Call') Calls++;  				
	  		}
	  		if(l.Calls__c<>Calls)  {
	  			l.Calls__c = Calls;
	    		LeadsToUpdate.add(l);
	  		}
	  	}
	}
	if(LeadsToUpdate.size()<>0) update LeadsToUpdate;
	*/

}