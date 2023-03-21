/**    
* Author: Koby Campbell
* Date: November 2021
* Test: LeadAccountCorrectNextContactTest
* Description: Corrects an incorrect default NVMConnect__NextContactTime__c value to 12 hours ahead
*               when the NVMConnect__NextContactTime__c is set to the year 4000.
*/
trigger LeadCorrectNextContact on Lead (before insert, before update) {
    for(Lead l : Trigger.new){
        if(null != l.NVMConnect__NextContactTime__c
        && 4000 == l.NVMConnect__NextContactTime__c.year()){
            l.NVMConnect__NextContactTime__c = datetime.now().addHours(12);
        }
    }
}