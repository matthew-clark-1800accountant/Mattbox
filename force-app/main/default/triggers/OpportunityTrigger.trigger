/**
 * Created by SReyes on 8/12/2020.
 */
trigger OpportunityTrigger on Opportunity (before insert, after insert)
{
    TriggerControlPanels__mdt oppControl = [SELECT Id, IsActive__c FROM TriggerControlPanels__mdt WHERE Label = 'OpportunityTrigger' LIMIT 1];
    if(oppControl.IsActive__c){ 
        if(Trigger.isBefore){
            OpportunityTriggerHandler.doBeforeTrigger(Trigger.new,Trigger.oldMap,Trigger.isInsert,Trigger.isUpdate,Trigger.isDelete);
        } else if(Trigger.isAfter){
            OpportunityTriggerHandler.doAfterTrigger(Trigger.new,Trigger.oldMap,Trigger.isInsert,Trigger.isUpdate,Trigger.isDelete);
        }        
     }
}