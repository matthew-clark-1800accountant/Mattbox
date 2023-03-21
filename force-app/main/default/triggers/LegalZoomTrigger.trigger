trigger LegalZoomTrigger on Legal_Zoom__c (before insert, before update) {
    
    for (Legal_Zoom__c l : Trigger.new){
        if (l.Status__c == 'Processed' && l.Processed_Date__c == null){
            l.Processed_Date__c = System.now();
        }
    }
    
}