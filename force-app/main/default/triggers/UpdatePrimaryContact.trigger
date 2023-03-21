trigger UpdatePrimaryContact on Contact (after insert) {
    
    Map<Id, Id> mapAccountContactIds = new Map<Id, Id>();
    List<Contact> listContacts = [Select Id, AccountId from Contact where Id IN :Trigger.newMap.keySet()];
    for(Contact c : listContacts){
        mapAccountContactIds.put(c.AccountId, c.Id);
    }
    
    List<Account> listAccounts = [Select Id, Primary_Contact__c from Account where Primary_Contact__c = null and Id IN :mapAccountContactIds.keySet()];
    for(Account a : listAccounts){
		a.Primary_Contact__c = mapAccountContactIds.get(a.Id);
    }
    
    update listAccounts;
}