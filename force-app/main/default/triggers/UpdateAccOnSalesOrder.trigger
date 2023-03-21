trigger UpdateAccOnSalesOrder on Opportunity (after insert, after update) {

list<OpportunityLineItem> olis = new list<OpportunityLineItem>([SELECT ID,OpportunityID,Product2.Family FROM OpportunityLineItem WHERE OpportunityID IN :Trigger.newmap.keyset()]); 
	map<Id,Id> merchownermap = new map<Id,Id>();
	
	for(Opportunity opp :Trigger.new)  {
		for(OpportunityLineItem oli :olis)  {
			if(oli.OpportunityID == opp.id && oli.Product2.Family == 'Merchant Processing')  merchownermap.put(opp.accountid,opp.ownerid);
		}
	}
	
	if(!merchownermap.keyset().isEmpty())  {
		map<Id,Account> accs = new map<ID,Account>([SELECT ID,Merchant_Sales_Owner__c FROM Account WHERE ID IN :merchownermap.keyset()]);
		list<Account> acctstoUpdate = new list<Account>();
		for(ID accid : accs.keyset())  {
			Account a = accs.get(accid);
			if(a.Merchant_Sales_Owner__c == null)  {
				a.Merchant_Sales_Owner__c = merchownermap.get(a.id);
				acctstoUpdate.add(a);
			}		
		}
		if(!acctsToUpdate.isEmpty()) update acctsToUpdate;
	}
}