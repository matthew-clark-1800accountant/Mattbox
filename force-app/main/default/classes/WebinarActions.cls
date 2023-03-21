// Authored by BJ Jones - bj@binarycloudconsulting.com

	global class WebinarActions implements Schedulable {
	
	global void execute(SchedulableContext SC) {
      SetWebinarNoShowsandAttends(); 
   }
   
    public static set<String> WebinarNoShowStatuses = new set<String>{
   		'Webinar No Show',
   		'Pitched',
		'Qualified'};
		
    public static set<String> WebinarAttendedStatuses = new set<String>{
   		'Webinar Attended',		
		'Pitched',
		'Qualified'};
		
	public static Double MinThreshold = 0;		
		 
   
    public static void SetWebinarNoShowsAndAttends()  {  
    	//Query all leads with webinars today and attended webinar = false
    	List<Lead> leads = new List<Lead>([SELECT ID,Name,Attended_Webinar__c,Webinar_Request__c,Status FROM Lead WHERE Webinar_Request__c<>null AND Webinar_Request__c = TODAY AND isConverted = False]);
   		List<Lead> leadsToUpdate = new List<Lead>();
   			
   		for(Lead l : leads)  {
   			//If scheduled webinar has occured mark as no show
   			if(l.Webinar_Request__c < System.now()) {
   				if(!l.Attended_Webinar__c && !WebinarNoShowStatuses.contains(l.Status))  {
   					l.Status = 'Webinar No Show';
   					leadsToUpdate.add(l);
   				}
   				if(l.Attended_Webinar__c && !WebinarAttendedStatuses.contains(l.Status))  {
   					l.Status = 'Webinar Attended';
   					leadsToUpdate.add(l);
   				}
   			}
   		}
   		if(!leadsToUpdate.IsEmpty()) update leadsToUpdate;
    }
}