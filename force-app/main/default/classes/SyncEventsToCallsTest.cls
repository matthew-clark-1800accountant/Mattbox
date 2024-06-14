@IsTest
public with sharing class SyncEventsToCallsTest {
    @TestSetup
    static void makeData(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Contact con = new Contact(FirstName='Test', LastName='Contact', AccountId=acc.Id, Phone='(234) 567-8901');
        Contact con2 = new Contact(FirstName='Test', LastName='Contact', AccountId=acc.Id, Phone='(234) 567-8902');
        insert new List<Contact>{con, con2};

        Opportunity opp = new Opportunity(StageName='New', Name='Test Opp', AccountId=acc.Id, CloseDate=Date.today());
        insert opp;

        User u = [SELECT Id FROM User WHERE Name = 'Matthew Clark'];
        Datetime startTime = MulticalendarDataService.roundToHalfHourTime(Datetime.now());
        Datetime endTime = startTime.addMinutes(30);
        List<Event> evList = new List<Event>{
            new Event(Subject='Tax Consultation 1', Type_of_Appointment__c='Tax Savings Analysis', Appointment_Disposition__c = 'Cancelled',
                WhatId=opp.Id, WhoId=con.Id, StartDateTime=startTime, EndDateTime=endTime, OwnerId=u.Id),
            new Event(Subject='Tax Consultation 2', Type_of_Appointment__c='', 
                WhatId=opp.Id, WhoId=con.Id, StartDateTime=startTime, EndDateTime=endTime, OwnerId=u.Id),
            new Event(Subject='Tax Consultation 3', Type_of_Appointment__c='Tax Savings Analysis', 
                WhatId=opp.Id, WhoId=con.Id, StartDateTime=startTime, EndDateTime=endTime, OwnerId=u.Id),
            new Event(Subject='Tax Consultation 4', Type_of_Appointment__c='Tax Savings Analysis', 
                WhatId=opp.Id, WhoId=con.Id, StartDateTime=startTime, EndDateTime=endTime, OwnerId=u.Id),

            new Event(Subject='Tax Consultation 5', Type_of_Appointment__c='Tax Savings Analysis', 
                WhatId=opp.Id, WhoId=con2.Id, StartDateTime=startTime, EndDateTime=endTime, OwnerId=u.Id)
        };
        insert evList;
        Test.setCreatedDate(evList[0].Id, Datetime.now().addMinutes(-5));
        Test.setCreatedDate(evList[3].Id, Datetime.now().addMinutes(5));

        NVMStatsSF__NVM_Call_Summary__c summary = new NVMStatsSF__NVM_Call_Summary__c(NVMStatsSF__CLID__c='+12345678901', NVMStatsSF__CallTime__c=startTime, NVMStatsSF__CallEndTime__c=endTime);
        NVMStatsSF__NVM_Call_Summary__c summary2 = new NVMStatsSF__NVM_Call_Summary__c(NVMStatsSF__CLID__c='+12345678902', NVMStatsSF__CallTime__c=startTime, NVMStatsSF__CallEndTime__c=endTime);

        insert new List<NVMStatsSF__NVM_Call_Summary__c>{summary, summary2};
    }

    @IsTest 
    static void testSync(){
        List<Id> eventIds = new List<Id>(new Map<Id, Event>([SELECT Id FROM Event]).keySet());

        Test.startTest();
        SyncEventsToCalls.syncEvents(eventIds);
        Test.stopTest();

        NVMStatsSF__NVM_Call_Summary__c summary = [SELECT Event_Subject__c FROM NVMStatsSF__NVM_Call_Summary__c WHERE NVMStatsSF__CLID__c='+12345678901'];
        System.assertEquals('Tax Consultation 3', summary.Event_Subject__c);

        NVMStatsSF__NVM_Call_Summary__c summary2 = [SELECT Event_Subject__c FROM NVMStatsSF__NVM_Call_Summary__c WHERE NVMStatsSF__CLID__c='+12345678902'];
        System.assertEquals('Tax Consultation 5', summary2.Event_Subject__c);
    }
}