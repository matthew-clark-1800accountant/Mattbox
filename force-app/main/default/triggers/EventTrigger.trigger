/**
 *  About
 *  -----
 *  Author: Appluent
 *  Create date: 02nd Oct 2017
 *  
 *  Details
 *  -----
 *  Trigger on Event
 *  
 *  Update History
 *  -----
 *  
 *  Issues / TODOs
 *  ----- 
 *
**/


trigger EventTrigger on Event (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    if(trigger.isInsert && trigger.isAfter){
        EventTriggerHandler.afterInsert(trigger.new);
    }
    else if(trigger.isDelete && trigger.isAfter){
        EventTriggerHandler.afterDelete(Trigger.oldMap);
    }
    else if(trigger.isUpdate && trigger.isAfter){
        EventTriggerHandler.afterUpdate(Trigger.new,Trigger.oldMap);
    }
    else if(Trigger.isBefore && Trigger.isInsert){
        EventTriggerHandler.beforeInsert(Trigger.new);
    }

}