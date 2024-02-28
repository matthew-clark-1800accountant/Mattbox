public with sharing class ManagerReassignmentsReport {
    public ManagerReassignmentsReport() {

    }

    public static void getData(){
        Map<Id, List<Event_Field_Update__c>> historyIdToUpdates = new Map<Id, List<Event_Field_Update__c>>();
        List<String> originalOwnerIds = new List<String>();
        List<Event> eventsToReport = new List<Event>();

        for(Event_Field_Update__c up : [
            SELECT Id, CreatedDate, Event_History__r.Id, Updated_By__r.Name, Updated_By__r.Profile.Name, Old_Value__c, New_Value__c
            FROM Event_Field_Update__c 
            WHERE CreatedDate = LAST_N_DAYS:90
            AND Updated_Field__c = 'Assigned To' 
            AND Update_made_in_change_window__c = false
            ORDER BY CreatedDate DESC
        ]){
            if(!historyIdToUpdates.containsKey(up.Event_History__r.Id)){
                historyIdToUpdates.put(up.Event_History__r.Id, new List<Event_Field_Update__c>{up});
            } else {
                historyIdToUpdates.get(up.Event_History__r.Id).add(up);
            }
        }

        List<Event> eventList = [
            SELECT Id, Event_History__r.Id, Initial_Rejected_By__r.Id, Original_Assigned_to__c
            FROM Event 
            WHERE Event_History__r.Id IN :historyIdToUpdates.keySet()
            AND Type_of_appointment__c = 'Tax Savings Analysis'
        ];
        
        //System.debug(eventList);
        for(Event ev : eventList){
            originalOwnerIds.add(ev.Original_Assigned_to__c);
        }

        Map<Id, User> userIdToUser = new Map<Id, User>([
            SELECT Id, Name, Profile.Name
            FROM User
            WHERE Id IN :originalOwnerIds
        ]);

        Map<String, Integer> userNameToReassignmentCount = new Map<String, Integer>();
        Map<String, Integer> userNameToMovedFromCount = new Map<String, Integer>();
        Map<String, Integer> userNameToMovedToCount = new Map<String, Integer>();

        for(Event ev : eventList){
            if(ev.Original_Assigned_to__c != ev.Initial_Rejected_By__r.Id
            && userIdToUser.get(ev.Original_Assigned_to__c).Profile.Name != 'Sales Manager'){
                for(Event_Field_Update__c up : historyIdToUpdates.get(ev.Event_History__r.Id)){
                    if(up.Updated_By__r.Profile.Name == 'Sales Manager'){
                        String printString = 'Event '+ev.Id+': '+up.Updated_By__r.Name + ' moved event from '+up.Old_Value__c+' to '+up.New_Value__c+' at '+up.CreatedDate;
                        System.debug(printString);
    
                        incrementCounter(userNameToReassignmentCount, up.Updated_By__r.Name);
                        incrementCounter(userNameToMovedFromCount, up.Old_Value__c);
                        incrementCounter(userNameToMovedToCount, up.New_Value__c);
                    }                    
                }                
            }
        }
        

        if(userNameToMovedFromCount.keySet().size() > 0){
            System.debug('---------------------');
            System.debug('Summary counts from the above data: ');
            for(String name : userNameToReassignmentCount.keySet()){
                System.debug('Manager '+name+' reassigned '+ userNameToReassignmentCount.get(name)+' appointments.');
            }
            for(String name : userNameToMovedFromCount.keySet()){
                System.debug('User '+name+' had '+ userNameToMovedFromCount.get(name)+' appointments moved out of their name.');
            }
            for(String name : userNameToMovedToCount.keySet()){
                System.debug('User '+name+' had '+ userNameToMovedToCount.get(name)+' appointments moved into their name.');
            }
        }
    }

    public static void incrementCounter(Map<String, Integer> counterMap, String valueString){
        if(counterMap.containsKey(valueString)){
            counterMap.put(valueString, counterMap.get(valueString)+1);
        } else {
            counterMap.put(valueString, 1);
        }
    }
}