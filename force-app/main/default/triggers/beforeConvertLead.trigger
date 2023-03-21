trigger beforeConvertLead on Lead (before update) {
    Map<String, String> mapAccLead = new Map<String, String>();
    Map<String, String> mapConLead = new Map<String, String>();
    for(Lead l: Trigger.New)
    {   
        if(l.isConverted == true && (l.LeadSource == 'Company.com' || l.LeadSource == 'Office Depot'))
        {
            mapAccLead.put(l.ConvertedAccountId,l.Id);
            mapConLead.put(l.ConvertedContactId,l.Id);       
        } 
    }
    
    map<String,String> mapLocalRemoteLeadId = new map<String,String>();
    for(PartnerNetworkRecordConnection pnr : [select Id,LocalRecordId, PartnerRecordId from PartnerNetworkRecordConnection where LocalRecordId IN : mapAccLead.values()]){
        mapLocalRemoteLeadId.put(pnr.LocalRecordId,pnr.PartnerRecordId);
    }
    
    List<Account> lstAcntToUpdate = new List<Account>();
    for(String s : mapAccLead.keyset()){
        if(mapLocalRemoteLeadId.containsKey(mapAccLead.get(s))){
            Account acc = new Account();
            acc.Original_Lead_Id__c = mapLocalRemoteLeadId.get(mapAccLead.get(s));
            acc.Id = s;
            lstAcntToUpdate.add(acc);
        }
    }
    List<Contact> lstConToUpdate = new List<Contact>();
    for(String s : mapConLead.keySet()){
        if(mapLocalRemoteLeadId.containsKey(mapConLead.get(s))){
            Contact c = new Contact();
            c.Original_Lead_Id__c = mapLocalRemoteLeadId.get(mapConLead.get(s));
            c.Id = s;
            lstConToUpdate.add(c);      
        }
     }
     
     if(lstAcntToUpdate.size()>0) update lstAcntToUpdate;
     if(lstConToUpdate.size()>0) update lstConToUpdate;
     // PartnerNetworkConnection pnc = [select id from PartnerNetworkConnection where ConnectionName = 'Infoglen Admin' and ConnectionStatus ='Accepted' limit 1];    
     if(lstAcntToUpdate.size()>0) SendPartnerRecords2.actualSendPartnerRecord('04Pf10000004CC2',lstAcntToUpdate[0].Id,lstConToUpdate[0].Id);
     
}