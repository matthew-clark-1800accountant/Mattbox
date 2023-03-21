/**
 * Deprecated & combined into Update_Account_Owner_to_Lead_Queue_Test 4/21
 */
@isTest
private class Schedule_Update_Acct_Owner_Test {
	
	private static testMethod void runSchedule() {
		// String CRON_EXP = '0 0 0 15 3 ? 2022';
        // Test.startTest();
        
        // String jobId = System.schedule('Schedule_Update_Acct_Owner_Test',
        //                                     CRON_EXP, 
        //                                     new Schedule_Update_Acct_Owner_to_Lead_Queue());
        
        // CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
        //                     FROM CronTrigger 
        //                     WHERE id = :jobId];
        
        // System.assertEquals(CRON_EXP, ct.CronExpression);
        // System.assertEquals(0, ct.TimesTriggered);
        // System.assertEquals('2022-03-15 00:00:00',  String.valueOf(ct.NextFireTime));
        
        // Test.stopTest();
        
	}
	
}