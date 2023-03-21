@isTest
private class TestWebinarActions {
	
	static testMethod void TestSetWebinarNoShows() {
		Lead l = new Lead();
		l.firstname = 'Test';
		l.lastname =  'Lead';
		l.Company = 'Test Company';
		l.Webinar_Request__c = System.now();
		l.attended_Webinar__c = FALSE;
		l.Status = 'New';
		Test.startTest();
		insert l;
		WebinarActions.SetWebinarNoShowsAndAttends();
		Lead testlead = [SELECT ID,Status FROM Lead WHERE ID = :l.id];
		System.assert(testlead.Status == 'Webinar No Show','Lead not set to Webinar No Show');
		l.attended_Webinar__c = TRUE;
		update l;
		WebinarActions.SetWebinarNoShowsAndAttends();	
		testlead = [SELECT ID,Status FROM Lead WHERE ID = :l.id];			
		System.assert(testlead.Status == 'Webinar Attended','Lead not set to Webinar Attended');
		Test.stopTest();
	}
}