trigger UpdateContactOwners on Account (after insert, after update) {
	
	  List<Contact> contacts = [Select Id,ownerid,AccountID from Contact where accountId IN :Trigger.newmap.keyset()];
      
      Map<String, List<Contact>> accountToContactMap = new Map<String, List<Contact>>();

	  for(Contact sobj: contacts){
		if(accountToContactMap.containsKey(sobj.AccountID)){
			List<Contact> temp = accountToContactMap.get(sobj.AccountID);
			temp.add(sobj);
			accountToContactMap.put(sobj.AccountID, temp);
		}else{
			List<Contact> temp = new List<Contact>();
			temp.add(sobj);
			accountToContactMap.put(sobj.AccountID, temp);
		}
	}
	  
	  List<Contact> contsToUpdate = new List<Contact>();
	  
	  Map<ID,User> userList = new Map<ID,User>([SELECT ID FROM User WHERE isActive = TRUE]);
	  
	  for(Account a : Trigger.new)  {
		if(!accountToContactMap.containsKey(a.Id)) continue;
	  	for(Contact c : accountToContactMap.get(a.Id)){
	  		if(a.ownerid != null && c.ownerid != a.ownerid && userList.keySet().contains(a.ownerId))  {
	  			c.ownerid = a.ownerid;
	  			contsToUpdate.add(c);
	  		}
	  	}
	  }
      
      if(!contsToUpdate.isEmpty()) update contsToUpdate;
}