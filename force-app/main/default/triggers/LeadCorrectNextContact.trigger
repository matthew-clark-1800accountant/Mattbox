/**    
* Author: Koby Campbell
* Date: November 2021
* Test: LeadAccountCorrectNextContactTest
* Description: Corrects an incorrect default NVMConnect__NextContactTime__c value to 12 hours ahead
*               when the NVMConnect__NextContactTime__c is set to the year 4000.
*/
trigger LeadCorrectNextContact on Lead (before insert, before update) {
    User sdrQueue = [SELECT Id FROM User WHERE Name = 'SDR Queue' LIMIT 1];
    for(Lead l : Trigger.new){
        if(null != l.NVMConnect__NextContactTime__c && 4000 == l.NVMConnect__NextContactTime__c.year()){
            if(l.Status == 'Attempted' && l.OwnerId == sdrQueue.Id && l.Distribute_Date__c == Date.today()){
                l.NVMConnect__NextContactTime__c = Datetime.now().addHours(4);
            } else {
                l.NVMConnect__NextContactTime__c = Datetime.now().addHours(12);
            }            
        }
    }
}