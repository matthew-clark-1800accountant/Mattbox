/**
* Overview: This trigger will prevent any Profiles without Delete Event Permissions enabled
*           from deleting the Event unless the Type of Appointment is Calendar Block
*
* Author: Koby Campbell
* Date: March 2021
*/
trigger EventDelete on Event (before delete) {
    Boolean deleteEvent = FeatureManagement.checkPermission('Delete_Events');
    for(Event e : Trigger.old){
        if(e.Type_of_Appointment__c != 'Calendar Block' && !deleteEvent){
            e.addError('You do not have permission to delete Event records....');    
        }
    }
}