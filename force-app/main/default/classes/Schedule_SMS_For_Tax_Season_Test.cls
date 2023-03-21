@isTest
public class Schedule_SMS_For_Tax_Season_Test {
	//deprecated 12/5/22 by Matt Clark
	// private static testMethod void runSchedule() {
	// 	String CRON_EXP = '0 0 0 '+Date.today().addDays(3).day()+' '+Date.today().addMonths(1).month()+' ? '+Date.today().year();
		
	// 	Test.startTest();

	// 		String jobId = System.schedule('Schedule_SMS_For_Tax_Season_Test',
	// 										CRON_EXP, 
	// 										new Schedule_SMS_For_Tax_Season()
	// 									);

	// 		CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
	// 							FROM CronTrigger 
	// 							WHERE id = :jobId
	// 						];

	// 		System.assertEquals(CRON_EXP, ct.CronExpression);
	// 		System.assertEquals(0, ct.TimesTriggered);
			

	// 	Test.stopTest();
	// }

}