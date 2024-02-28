public without sharing class ConvertLeadEventTriggerHandler {
    public static void afterInsert(List<Convert_Lead_Event__e> convertEvents){

        List<Database.LeadConvert> leadConvertList = new List<Database.LeadConvert>();
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        for(Convert_Lead_Event__e convertEvent : convertEvents){
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(convertEvent.LeadId__c);            
            lc.setConvertedStatus(convertStatus.MasterLabel);
            leadConvertList.add(lc);
        }
        
        List<Database.LeadConvertResult> lcr = Database.convertLead(leadConvertList);
        System.debug(lcr);
    }
}