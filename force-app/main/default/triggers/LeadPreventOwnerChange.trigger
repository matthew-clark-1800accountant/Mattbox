/**
* Overview: This trigger will prevent any Profiles without Change Bark Lead Owner custom permission 
*           assigned to their profile from changing the owner of Bark Leads from a user to another 
*           user with the exception of the General & Dead Lead Queue
*
* Author: Koby Campbell
* Date: May 2021
* Test: LeadPreventOwnerChangeTest
*/
trigger LeadPreventOwnerChange on Lead (after update){
    Boolean changeOwner = FeatureManagement.checkPermission('Change_Bark_Lead_Owner');
    Id generalQueueId = Update_Lead_Owner_to_Queue.getQueue('General Lead Queue');
    Id deadQueueId = Update_Lead_Owner_to_Queue.getQueue('Dead Leads Queue');
    for(Lead l : Trigger.new){
        Lead oldLead = Trigger.oldMap.get(l.Id);
        if(l.CreatedDate.date() == Date.today()){
        //If they do not have the custom permission assigned to their profile....
            if(!changeOwner
                //and the owner is changing....
                && l.OwnerId != oldLead.OwnerId
                //and the Lead Source is Bark....
                && (l.LeadSource == 'Bark'
                || l.Campaign__c == 'MVF Global')
                //and the owner is changing from user to user....
                && l.OwnerId.getSObjectType() == User.SObjectType
                && oldLead.OwnerId.getSObjectType() == User.SObjectType
                //with the exception of the General Lead Queue 'User'....
                && l.OwnerId != generalQueueId
                && oldLead.OwnerId != generalQueueId
                //and the Dead Lead Queue 'User'....
                && l.OwnerId != deadQueueId
                && oldLead.OwnerId != deadQueueId){
                //STOP THEM!!!
                l.addError('You do not have permission to change the Bark Lead owner from a User to another User');
            }
        }
    }
}