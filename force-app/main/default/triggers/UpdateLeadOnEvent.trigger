trigger UpdateLeadOnEvent on Event (after insert, after update) {
    
    Set<String> ApptSubjects = new Set<String>{'Salesforce Webinar'};
    map<Id,Event> leadIDs = new map<Id,Event>(); 
    map<Id,Event> leadIDs2 = new map<Id,Event>();    
    List<Lead> leadstoupdate = new List<Lead>();
    List<Lead> leadstoupdate2 = new List<Lead>();
    
    for(Event e :Trigger.new)  {
        if(e.whoid<>null && ((String)e.WhoId).startsWith(Schema.SObjectType.Lead.getKeyPrefix()) && ApptSubjects.contains(e.Subject)) {
            leadIDs.put(e.whoid,e);
        } else {
            leadIDs2.put(e.whoid,e);
        }
    }   
    
    if(!leadIDs.keyset().isEmpty())  {
        Set<Lead> leads = new Set<Lead>([Select Id,Name,Recent_Appointment_Date__c, Recent_Appointment_Setter__c from Lead WHERE Id IN :leadIDs.keyset()]);
        for(Lead l: leads)  {
            Event e = leadIDs.get(l.id);
            if(l.Recent_Appointment_Date__c == null || e.activitydate.daysbetween(l.Recent_Appointment_Date__c)<0)  {
                l.Recent_Appointment_Date__c = e.activitydate;
                l.Recent_Appointment_Setter__c = e.Appointment_Setter__c;
                l.EventIDNum__c = e.id;
                leadstoupdate.add(l);
            }           
        }
        if(!leadsToUpdate.isEmpty()) update leadsToUpdate;
    }
    if(!leadIDs2.keyset().isEmpty())  {
        Set<Lead> leads = new Set<Lead>([Select Id,Name,Recent_Appointment_Date__c, Recent_Appointment_Setter__c from Lead WHERE Id IN :leadIDs2.keyset()]);
        for(Lead l: leads)  {
            Event e = leadIDs2.get(l.id);
            l.EventIDNum__c = e.id;
            leadstoupdate2.add(l);
           
        }
        if(!leadsToUpdate2.isEmpty()) update leadsToUpdate2;
    }   
}