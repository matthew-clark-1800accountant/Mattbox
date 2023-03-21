/**    
* Author: Koby Campbell
* Date: November 2021
* Test: LeadAccountCorrectNextContactTest
* Description: Corrects an incorrect default NextContactTime__c value to 12 hours ahead
*               when the NextContactTime__c is set to the year 4000.
*/
trigger AccountCorrectNextContact on Account (before insert, before update) {
    for(Account a : Trigger.new){
        if(null != a.NextContactTime__c 
        && 4000 == a.NextContactTime__c.year()){
            a.NextContactTime__c = datetime.now().addHours(12);
        }
    }
}