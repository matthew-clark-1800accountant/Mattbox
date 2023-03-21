// Authored by BJ Jones - bj@binarycloudconsulting.com

global class TransferActions implements Schedulable {
	
	global void execute(SchedulableContext SC) {
      SetTransferEligibilityonLeads();     
   }
   
    public static Set<String> NonTransferStatuses = new Set<String>{
    	'Qualified','Bad Number','Not Interested','Dupe','Dialer Call Back'};
    	
    public static void SetTransferEligibilityonLeads()  {
    	Map<Id,Group> queueMap = new map<Id,Group>([SELECT id,Name from Group WHERE type='Queue']);
    	Map<String,Id> queueNameMap = new map<String,Id>{};
    	for(Group g : queueMap.values())  {
    		queueNameMap.put(g.Name,g.Id);    	
   		 }	
   		ID leadgenque = queueNameMap.get('X4_Week_Transfer_Q');
   		
   		List<Lead> leads = new List<Lead>([SELECT ID,Name,Ownerid,LastTransferDate,LastActivityDate,Transfer_Eligible__c FROM Lead WHERE isConverted = FALSE AND Status NOT IN :NonTransferStatuses AND Owner.Name <> 'X4_Week_Transfer_Q' AND Owner.Name <> '4 Week Transfer Q' LIMIT 50000]);
    	List<Lead> leadsToUpdate = new List<Lead>(); 
    	for (Lead l : leads)  {
    		if(l.LastTransferDate.daysbetween(System.Today()) > 30 && (l.LastActivityDate == null || l.LastActivityDate.daysbetween(System.Today()) > 0))  {
    			l.Transfer_Eligible__c = TRUE;
    			l.ownerid = leadgenque;
    			leadsToUpdate.add(l);    			
    		}
    		
    	}
    	if(!leadsToUpdate.IsEmpty()) update leadsToUpdate;
    }   
}