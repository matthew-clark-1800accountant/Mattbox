public with sharing class InteractionEventTriggerHandler {
    public static void afterUpdate(Map<Id, NVMContactWorld__InteractionEvent__c> oldInteractions, List<NVMContactWorld__InteractionEvent__c> newInteractions){
        System.debug('InteractionEventTriggerHandler.afterUpdate()');
        TriggerControlPanels__mdt afterTriggerIsActive = [SELECT IsActive__c FROM TriggerControlPanels__mdt WHERE Label='InteractionEventTriggerHandler'];
        System.debug(afterTriggerIsActive);
        // for(NVMContactWorld__InteractionEvent__c interaction : interactions){
        //     logCallDelay(interaction.Id);
        // }
        if(afterTriggerIsActive.isActive__c){
            for(NVMContactWorld__InteractionEvent__c interaction : newInteractions){
                if(oldInteractions?.get(interaction.Id).NVMContactWorld__Who__c == null && interaction.NVMContactWorld__Who__c != null){
                    logCallDelay(interaction.Id);
                } else {
                    System.debug('no delay logged: '+oldInteractions.get(interaction.Id).NVMContactWorld__Who__c == null+' '+interaction.NVMContactWorld__Who__c != null);
                }
            }
        }
    }

    @future
    public static void logCallDelay(Id interactionId){
        List<String> apptTypes = new List<String>{'BNA', 'Formation Consultation', 'Tax Savings Analysis'};
        List<String> disposToIgnore = new List<String>{'Rescheduled', 'Cancelled'};
        NVMContactWorld__InteractionEvent__c interaction = [SELECT Id, NVMContactWorld__Who__c, CreatedDate FROM NVMContactWorld__InteractionEvent__c WHERE Id = :interactionId LIMIT 1];
        
        List<Event> matchingEvents = [SELECT Id, StartDateTime, Minute_Difference_for_Appt_Call__c FROM Event WHERE WhoId = :interaction.NVMContactWorld__Who__c 
        AND StartDateTime >= :interaction.CreatedDate.addMinutes(-30) AND StartDateTime <= :interaction.CreatedDate.addMinutes(7) 
        AND Type_of_Appointment__c IN :apptTypes AND Appointment_Disposition__c NOT IN :disposToIgnore AND (NOT Subject LIKE '%Live%') LIMIT 1];
        if(!matchingEvents.isEmpty()){
            Event matchingEvent = matchingEvents[0];
            Integer timeDifference = (Integer)(interaction.CreatedDate.getTime() - matchingEvent.StartDateTime.getTime())/60000;
            if(matchingEvent.Minute_Difference_for_Appt_Call__c == null || Math.abs(timeDifference) < Math.abs(matchingEvent.Minute_Difference_for_Appt_Call__c)){
                matchingEvent.Minute_Difference_for_Appt_Call__c = timeDifference;
                update matchingEvent;
            }
            
        } else {
            System.debug('No matching events found for whoId '+interaction.NVMContactWorld__Who__c);
        }
    }
}