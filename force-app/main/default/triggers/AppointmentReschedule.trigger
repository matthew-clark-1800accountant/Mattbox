trigger AppointmentReschedule on Event (after insert) {/*
	
	Set<String> AppointmentSubjects = new Set<String> {
		'Salesforce Webinar',
		'1on1 Appointment'};
	Set<String> ApiNames = new Set<String> {
		'Do Not Reply',
		'Kayla Boles',
		'BJ Jones'};
	map<ID,User> UserMap = new map<Id,User> ([SELECT ID,Name FROM User WHERE IsActive=True]);
	
	set<Id> whoids = new set<ID>();
	for(Event e : Trigger.new)  whoids.add(e.whoid);
	List<Event> allEvents = new List<Event>([SELECT ID,ownerid,type,whatid,whoid,Subject,StartDateTime,DurationInMinutes,createdDate,createdByID FROM Event WHERE whoid IN :whoids AND Subject IN :AppointmentSubjects AND StartDateTime > :System.now()]);	
	List<Event> EventsToUpdate = new List<Event>();
	List<Event> EventsToPurge = new List<Event>();
	
	for(String ApptType : AppointmentSubjects)  {
		map<ID,Event> primeEvents = new Map<Id,Event>();
		for(Event e : allEvents)  {
			if(e.Subject == ApptType && (!primeEvents.keyset().contains(e.whoid) || primeEvents.get(e.whoid).createdDate > e.createdDate)) primeEvents.put(e.whoid,e);
		}
		
		for(Event e : allEvents)  {
			if(e.whoid<>null && e.Subject == ApptType && primeEvents.get(e.whoid).ID <> e.id /*&& APINames.contains(Usermap.get(e.createdByID).Name) && e.ownerid == primeEvents.get(e.whoid).ownerID)  {
				Event mergedev = primeEvents.get(e.whoid);
				mergedev.StartDateTime = e.StartDateTime;
				mergedev.DurationInMinutes = e.DurationInMinutes;
				if(mergedev.Description<>null) mergedev.Description += ' RESCHEDULED BY CUSTOMER '+System.Now();	
				else mergedev.Description = ' RESCHEDULED BY CUSTOMER '+System.Now();			
				EventsToUpdate.add(mergedev);
				EventsToPurge.add(e);
			}
		}
	}
	if(!EventsToUpdate.isEmpty()) update EventsToUpdate;
	if(!EventsToPurge.isEmpty()) delete EventsToPurge;
*/}