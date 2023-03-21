global class TransferAccts implements Schedulable {
	
	global void execute(SchedulableContext SC) {
       SetTransferEligibilityonAccounts();
   }
   
    public static Set<String> NonTransferStatuses = new Set<String>{
    	'Qualified','Bad Number','Not Interested','Dupe','Dialer Call Back'};
    	
    public static Set<String> TransferAcctStatuses = new Set<String>{
    	'New','No Sale','BTP'};	    	
      
   
    public static void SetTransferEligibilityonAccounts()  {
    	List <User> users = [SELECT Id,Name,IsActive,Skills_Sales__c FROM User WHERE IsActive = TRUE];
    	User acctowner;
    	Map<ID,User> salesusermap = new Map<Id,User>();
    	for(User u :users)  {
    		if(u.Skills_Sales__c<>null && u.Skills_Sales__c.contains('Closer')) salesusermap.put(u.id,u);
    		if(u.Name == 'Brooke Van Remoortere') acctowner = u;    	
    	}
    	
    	List<Account> accts = new List<Account>([SELECT ID,Name,Ownerid,CreatedDate,LastActivityDate,Transfer_Eligible__c,Lead_Status__c FROM Account WHERE Lead_Status__c NOT IN :NonTransferStatuses AND Account_Status__c IN :TransferAcctStatuses AND Ownerid IN :salesusermap.keyset() LIMIT 50000]);
   		List<Account> acctsToUpdate = new List<Account>(); 
   		for (Account a : accts)  {
   			Date CreatedDateOnly = date.newinstance(a.CreatedDate.year(), a.CreatedDate.month(), a.CreatedDate.day());
   			if(CreatedDateOnly.daysbetween(System.Today()) > 37 && (a.LastActivityDate == null || a.LastActivityDate.daysbetween(System.Today()) > 0))  {
    			a.Transfer_Eligible__c = TRUE;
    			a.ownerid = acctowner.id;
    			acctsToUpdate.add(a);    			
    		}
   		}
    	if(!acctsToUpdate.IsEmpty()) update acctsToUpdate;    	  
    }
}