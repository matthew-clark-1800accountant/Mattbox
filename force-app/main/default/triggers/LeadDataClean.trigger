trigger LeadDataClean on Lead (before insert, before update) {
    
    public static set<String> Confirmed1on1 = new set<String>{
        'Pitched',
        'Qualified'}; 
    
    for(Lead l : Trigger.new)  {        
        if(X1800Utilities.StateAbbrev.keyset().contains(l.State)) l.state = X1800Utilities.StateAbbrev.get(l.State);
        
        if(X1800Utilities.Timezones.keyset().contains(l.State)) {
        
            l.calculated_timezone__c = X1800Utilities.TimeZones.get(l.State);
            
        } else {
            
            if (l.calculated_timezone__c == 'Eastern') {
            
            } else if (l.calculated_timezone__c == 'Mountain') {
            
            } else if (l.calculated_timezone__c == 'Central') {
            
            } else if (l.calculated_timezone__c == 'Pacific') {
            
            } else {
            
                l.calculated_timezone__c ='';
                
            }
        
        } 
        
        if(Confirmed1on1.contains(l.status)) l.X1_1_Attended__c = true;
    }

}