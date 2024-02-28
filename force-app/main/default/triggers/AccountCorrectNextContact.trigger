/**    
* Author: Koby Campbell
* Date: November 2021
* Test: LeadAccountCorrectNextContactTest
* Description: Corrects an incorrect default NextContactTime__c value to 12 hours ahead
*               when the NextContactTime__c is set to the year 4000.
*/
trigger AccountCorrectNextContact on Account (before insert, before update) {
    User sdrQueue = [SELECT Id FROM User WHERE Name = 'SDR Queue' LIMIT 1];
    for(Account a : Trigger.new){
        if(null != a.NextContactTime__c && 4000 == a.NextContactTime__c.year()){
            if(a.OwnerId == sdrQueue.Id && a.Distribute_Date__c == Date.today() && a.Dialer_Tier__c == 'Tier 1'){
                a.NextContactTime__c = datetime.now().addHours(4);
            } else {
                a.NextContactTime__c = datetime.now().addHours(12);
            }            
        }
    }
}