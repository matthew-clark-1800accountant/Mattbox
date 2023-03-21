/**
* Overview: If the number of connected calls on a Lead with Lead Source of ZenBusiness
*           is greater than or equal to 3, then the Lead Status will be updated to 
*           'Do Not Call'.
*
* Author: Koby Campbell
* Date: June 2021
* Test: LeadDoNotCallTest
*/


//Deprecated on 2-9-23 by Matt Clark
trigger LeadDoNotCall on Lead (before insert, after update){
    // List<Lead> toUpdateLeads = new List<Lead>();
    // for(Lead l : Trigger.new){
    //     //If this is a Zenbusiness Lead...
    //     if('ZenBusiness' == l.leadSource){
    //         //Being Inserted...
    //         if(Trigger.isInsert){
    //             if((null != l.X1_1_Scheduled__c && 'Not Interested' != l.Status) && l.of_Connected_Calls__c >= 5){
    //                 l.Status = 'Do Not Call';
    //             } else if((null == l.X1_1_Scheduled__c || 'Not Interested' == l.Status) && l.of_Connected_Calls__c >= 3){
    //                 l.Status = 'Do Not Call';
    //             }
    //         }
    //         //Being Updated...
    //         if(Trigger.isUpdate){
    //             //If the status is not already Do Not Call
    //             if('Do Not Call' != l.Status){
    //                 Lead oldLead = Trigger.oldMap.get(l.Id);
    //                 if(oldLead.of_Connected_Calls__c != l.of_Connected_Calls__c){
    //                     if((null != l.X1_1_Scheduled__c && 'Not Interested' != l.Status) &&
    //                     l.of_Connected_Calls__c >= 5){
    //                         toUpdateLeads.add(new Lead(Id = l.Id, Status = 'Do Not Call'));
    //                     } else if((null == l.X1_1_Scheduled__c || 'Not Interested' == l.Status) &&
    //                     l.of_Connected_Calls__c >= 3){
    //                         toUpdateLeads.add(new Lead(Id = l.Id, Status = 'Do Not Call'));
    //                     }
    //                 }
    //             }
    //         }
    //     }
    // }
    // if(!toUpdateLeads.isEmpty()){
    //     System.debug(toUpdateLeads);
    //     update toUpdateLeads; 
    // }
}