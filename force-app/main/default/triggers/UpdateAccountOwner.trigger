trigger UpdateAccountOwner on Contact (after insert, after update) {

 	Map<Id,Contact> mapAccountContactIds = new Map<Id,Contact>();
    
 	for(Contact c : Trigger.new){
        mapAccountContactIds.put(c.AccountId,c);
    }
    Map<Id,User> users = X1800Utilities.userMap;
    List<Account> accounts = [Select Id,ownerid from Account where  Id IN :mapAccountContactIds.keySet()];
    List<Account> accsToUpdate = new List<Account>();
    for(Account a : accounts){
    	ID contownerid = null;    	
    	if(mapAccountContactIds.keyset().contains(a.Id)) contownerid = mapAccountContactIds.get(a.Id).ownerid;	
		if(contownerid<>null && a.ownerid<>contownerid && users.keyset().contains(contownerid))  {
			a.ownerid=contownerid;
			accsToUpdate.add(a);
		}			
	}    
    if(!accsToUpdate.isEmpty()) update accsToUpdate;
}