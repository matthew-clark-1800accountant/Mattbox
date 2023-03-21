@isTest
private class TestDataClean {

    static testMethod void TestLeadDataClean() {
        Lead l = new Lead();
		l.firstname = 'Test';
		l.lastname =  'Lead';
		l.Company = 'Test Company';
		l.state = 'Arizona';
		l.Status = 'New';
		Test.startTest();
		insert l;
		Lead testlead = [SELECT ID,State,Calculated_timezone__c FROM Lead WHERE ID = :l.id];
		System.assert(testlead.State == 'AZ','State Abbreviation error');
		System.assert(testlead.Calculated_timezone__c == 'Pacific','Timezone error');
		Test.stopTest();
    }
    
//     static testMethod void TestContactDataClean() {
//        Account a = new Account();
//        a.name = 'Test Account';
//        Contact c = new Contact();
//		c.firstname = 'Test';
//		c.lastname = 'Contact';
//		c.MailingState = 'Arizona';
//		c.email = 'test@test.com';
//		Test.startTest();
//		insert a;
//		c.accountid = a.id;
//		insert c;
//		Contact testcontact = [SELECT ID,MailingState,Timezone__c FROM Contact WHERE ID = :c.id];
//		System.assert(testcontact.Mailingstate == 'AZ','State Abbreviation error');
//		System.assert(testcontact.timezone__c == 'Pacific','Timezone error');
//		Test.stopTest();
//    }
    
//     static testMethod void TestUpdateAccountOnEvent() {
//        Account a = new Account();
//        a.name = 'Test Account';
//       	Test.startTest();
//		insert a;
//		Event e1 = new Event();
//		e1.subject = 'Merchant Services 1-1';
//		e1.whatid = a.id;
//		DateTime dt = DateTime.newInstance(2100, 1, 31, 7, 8, 16);
//		e1.StartDateTime = dt;
//		e1.DurationInMinutes = 60;
//		insert e1;
//		Account testaccount = [SELECT ID,Merchant_Sales_1_1_Scheduled__c,Merchant_Sales_Status__c FROM Account WHERE ID = :a.id];
//		System.assert(testaccount.Merchant_Sales_Status__c == '1-1 Scheduled','Merchant Services 1-1 status error');
//		System.assert(testaccount.Merchant_Sales_1_1_Scheduled__c == dt,'Merchant Services 1-1 scheduling time error');
//		Test.stopTest();
//    }
			
    
//    static testMethod void TestUpdateCalls() {
//        Lead l = new Lead();
//		l.firstname = 'Test';
//		l.lastname =  'Lead';
//		l.Company = 'Test Company';
//		Test.startTest();
//		insert l;
//		Lead testlead = [SELECT ID,Calls__c FROM Lead WHERE ID = :l.id];
//		System.assert(testlead.Calls__c == 0,'Calls not initiated at 0');
//		Task t = new Task();
//		t.whoid = l.id;
//		t.type = 'Call';
//		t.Subject = 'Test Call';
//		t.status = 'Completed';
//		insert t;
//		testlead = [SELECT ID,Calls__c FROM Lead WHERE ID = :l.id];
//		System.assert(testlead.Calls__c == 1,'Calls not incrementing');
//		delete t;
//		testlead = [SELECT ID,Calls__c FROM Lead WHERE ID = :l.id];
//		System.assert(testlead.Calls__c == 0,'Calls not decrementing');
//		Test.stopTest();
//    }
    
     static testMethod void TestAppointmentReschedule() {
        Lead l = new Lead();
		l.firstname = 'Test';
		l.lastname =  'Lead';
		l.Company = 'Test Company';
		l.Status = 'New';
		Event e1 = new Event();
		e1.subject = 'Salesforce Webinar';
		e1.StartDateTime = System.now().adddays(1);
		e1.DurationInMinutes = 60;
		Test.startTest();
		insert l;
		e1.whoid = l.id;
		insert e1;
		Event e2 = new Event();
		e2.subject = 'Salesforce Webinar';
		e2.StartDateTime = System.now().adddays(2);
		e2.DurationInMinutes = 60;
		e2.whoid = l.id;
		insert e2;       
    }
    
    static testMethod void UpdateLeadonWebinarAttendance() {
    	Lead l = new Lead();
		l.firstname = 'Test';
		l.lastname =  'Lead';
		l.Company = 'Test Company';
		l.Status = 'New';
		l.email = 'test@test.com';
		l.Webinar_Request__c = System.now().adddays(-1);
		insert l;
		ON24_Webinar_Attendance__c wa = new ON24_Webinar_Attendance__c();
		wa.email__c = l.email;
		wa.minutes__c =  WebinarActions.MinThreshold-1;
		System.debug('MIN:'+wa.minutes__c);
		wa.ParentRecordID__c = l.id;
		Test.startTest();
		insert wa;
		Lead testlead = [SELECT ID,status FROM Lead WHERE ID = :l.id];
		System.assert(testlead.status == 'Webinar No Show','Webinar No Show import trigger not functioning correctly');
		ON24_Webinar_Attendance__c wa2 = new ON24_Webinar_Attendance__c();
		wa2.email__c = l.email;
		wa2.minutes__c =  WebinarActions.MinThreshold+1;
		wa2.ParentRecordID__c = l.id;
		insert wa2;
		testlead = [SELECT ID,status FROM Lead WHERE ID = :l.id];
		System.assert(testlead.status == 'Webinar Attended','Webinar Attendance import trigger not functioning correctly');
		Test.stopTest();
    	
    }
		
}