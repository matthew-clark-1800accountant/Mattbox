@isTest
global class eventNotifier_scheduler_TC {
    
   public static testMethod void testschedule() {
    Test.StartTest();
    //System.schedule('eventNotifier Schedule Job  11',  '0 55 * * * ?', new eventNotifier_scheduler());
    Test.stopTest();
   }
}