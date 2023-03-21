trigger UpdateLeadonWebinarAttendance on ON24_Webinar_Attendance__c (before insert) {
	
	Set<ID> leadids = new set<Id>();
	Set<ID> accountids = new set<Id>();
	Double MinThreshold = 0;
	
	for(ON24_Webinar_Attendance__c row :Trigger.new)  {
		if(row.SetterID__c<>null && (row.SetterID__c).startsWith(Schema.SObjectType.User.getKeyPrefix()))  row.Appointment_Setter__c = row.SetterID__c;
		if(row.ParentRecordID__c<>null && (row.ParentRecordID__c).startsWith(Schema.SObjectType.Lead.getKeyPrefix()))  {
			row.lead__c = row.ParentRecordID__c;
			leadids.add(row.lead__c);
		}			
		else if (row.ParentRecordID__c<>null && (row.ParentRecordID__c).startsWith(Schema.SObjectType.Account.getKeyPrefix()))  {
			row.account__c = row.ParentRecordID__c;
			accountids.add(row.account__c);
		}			
	}
	
	Map<ID,Lead> leadmap = new Map<ID,Lead>([SELECT ID,Name,Attended_Webinar__c,Webinar_Request__c,Status FROM Lead WHERE ID IN :leadids]);
	Map<ID,Account> acctmap = new Map<ID,Account>([SELECT ID,Name,lead_status__c,Attended_Webinar__c FROM Account WHERE ID IN :accountids]);
	List<Lead> leadsToUpdate = new List<Lead>();
	List<Account> acctsToUpdate = new List<Account>();
	User Brooke = [SELECT Id,Name FROM User WHERE Name = 'Brooke Van Remoortere'];
		
	for(ON24_Webinar_Attendance__c owa :Trigger.new)  {
		//owa.ownerid = Brooke.id;
		if(leadmap.keyset().contains(owa.lead__c))  {
			Lead l = leadmap.get(owa.lead__c);
			if(owa.minutes__c > MinThreshold && !WebinarActions.WebinarAttendedStatuses.contains(l.status))  {
				l.status = 'Webinar Attended';
				l.Attended_Webinar__c = true;
				leadstoUpdate.add(l);
			}
			else if((owa.minutes__c==null || owa.minutes__c <= MinThreshold) && !WebinarActions.WebinarNoShowStatuses.contains(l.status) && l.Webinar_Request__c < System.Now())  {
				l.status = 'Webinar No Show';
				l.Attended_Webinar__c = false;
				leadstoUpdate.add(l);
			}				
		}
		else if(acctmap.keyset().contains(owa.account__c))  {
			Account a = acctmap.get(owa.account__c);
			if(owa.minutes__c > MinThreshold && !WebinarActions.WebinarAttendedStatuses.contains(a.lead_status__c))  {
				a.lead_status__c = 'Webinar Attended';
				a.Attended_Webinar__c = true;
				acctstoUpdate.add(a);
			}
			else if((owa.minutes__c==null || owa.minutes__c <= MinThreshold) && !WebinarActions.WebinarNoShowStatuses.contains(a.lead_status__c))  {
				a.lead_status__c = 'Webinar No Show';
				a.Attended_Webinar__c = false;
				acctstoUpdate.add(a);
			}				
		}
	}
	if(!leadstoupdate.isempty()) update leadstoupdate;
	if(!acctstoupdate.isempty()) update acctstoupdate;
	
}