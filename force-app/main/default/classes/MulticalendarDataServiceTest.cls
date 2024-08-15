@IsTest
public with sharing class MulticalendarDataServiceTest {
    @TestSetup
    static void makeData(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Contact con = new Contact(FirstName='Test', LastName='Contact', AccountId=acc.Id, Phone='(234) 567-8901');
        insert con;

        Opportunity opp = new Opportunity(StageName='New', Name='Test Opp', AccountId=acc.Id, CloseDate=Date.today());
        insert opp;

        Portal_Team_Member__c portalRep = new Portal_Team_Member__c(Name='test rep', Timezone__c = 'Central', Portal_Accountant_Id__c='1212', Status__c='Active', Presence__c='Ready', Accounting_Skills__c='Multicalendar;Crypto;Trucking;Real Estate;Non Profit;E-Commerce', Team_Role__c='Tax Advisor I');
        insert portalRep;
        Portal_Team_Member__c portalCurrentUser = new Portal_Team_Member__c(Name='test rep', Timezone__c = 'Central', Portal_Accountant_Id__c='1234', Status__c='Active', Presence__c='Team Meeting', Accounting_Skills__c='Multicalendar;Crypto;Trucking;Real Estate;Non Profit;E-Commerce', Team_Role__c='Manager', User__c = UserInfo.getUserId());
        insert portalCurrentUser;

        User u = [SELECT Id FROM User WHERE Name = 'Matthew Clark'];
        Datetime startTime = MulticalendarDataService.roundToHalfHourTime(Datetime.now());
        Datetime endTime = startTime.addMinutes(30);
        Event ev = new Event(Subject='Tax Consultation', Type_of_Appointment__c='Tax Savings Analysis', 
        WhatId=opp.Id, WhoId=con.Id, StartDateTime=startTime, EndDateTime=endTime, OwnerId=u.Id, Lead_Type_New__c='Buyer-DUNS Creator', Lead_Source__c='1-800Accountant', Portal_Team_Member__c=portalRep.Id);
        insert ev;

        

        
    }

    @IsTest 
    static void testMakeTestData(){
        // User u = [SELECT Id FROM User WHERE Name = 'Matthew Clark'];
        // Contact c = [SELECT Id FROM Contact LIMIT 1];
        Integer startCount = [SELECT COUNT() FROM Event];
        Test.startTest();
        MulticalendarDataService.makeDataForReps(new List<String>{'Sales_Team__c = \'BNA Team\''});
        Test.stopTest();
        System.assert([SELECT COUNT() FROM Event] > startCount);
    }

    @IsTest
    static void testGetTimeslotLabels(){
        List<String> results = MulticalendarDataService.getTimeslotLabels();
        System.assert(!results.isEmpty());
    }

    public class CustomException extends Exception{}
    //1686846600000L 12:30
    //1686848400000L 1:00
    //1686848234696L 12:56
    //1686848834696L 1:16
    @IsTest 
    static void testHelperMethods(){
        Datetime rounded1 = MulticalendarDataService.roundToHalfHourTime(Datetime.newInstance(1686848234696L));
        Datetime rounded2 = MulticalendarDataService.roundToHalfHourTime(Datetime.newInstance(1686848834696L));
        System.assertEquals(1686846600000L, rounded1.getTime());
        System.assertEquals(1686848400000L, rounded2.getTime());

        String phoneNum = MulticalendarDataService.formatPhone('(765) 123-4567');
        System.assertEquals('+17651234567', phoneNum);

        String environment = MulticalendarDataService.getEnvironmentName();
        System.assertNotEquals(null, environment);

        MulticalendarDataService.sendEmail('body');
        CustomException ce = new CustomException();
        ce.setMessage('body');
        MulticalendarDataService.logError(ce);
        MulticalendarDataService.createNote('body');

        Boolean showScreen = MulticalendarDataService.showMaintenanceScreen();
        System.assertNotEquals(null, showScreen);
    }

    @IsTest 
    static void testGetRepRejections(){
        Event ev = [SELECT Id FROM Event LIMIT 1];
        Integer startCount = MulticalendarDataService.getRepRejections(ev.Id).size();
        User u = [SELECT Id FROM User WHERE Name = 'Matthew Clark'];
        ev.Initial_Rejected_By__c = u.Id;
        Test.startTest();
        update ev;
        Test.stopTest();
        System.assertEquals(startCount+1, MulticalendarDataService.getRepRejections(ev.Id).size());
    }

    @IsTest 
    static void testMoveAppointment(){
        Event ev = [SELECT Id FROM Event LIMIT 1];
        User u = [SELECT Id FROM User WHERE Name = 'Drew Troutner'];
        MulticalendarDataService.moveAppointment(ev.Id, u.Id);
        ev = [SELECT OwnerId FROM Event LIMIT 1];
        System.assertEquals(u.Id, ev.OwnerId);        
    }

    @IsTest 
    static void testGetReps(){
        List<MulticalendarDataService.Rep> results = MulticalendarDataService.getReps(new List<String>{'Sales_Team__c = \'BNA Team\''}, '');
        System.assertNotEquals(0, results.size());
    }

    @IsTest 
    static void testGetFulfillmentReps(){
        System.debug(UserInfo.getUserId());
        List<MulticalendarDataService.Rep> results = MulticalendarDataService.getReps(new List<String>{'Timezone__c = \'Central\''},'Advisory');
        System.debug(results);
        System.assertNotEquals(0, results.size());
    }

    @IsTest 
    static void testGetCalendarViews(){
        List<MulticalendarDataService.CalendarView> results = MulticalendarDataService.getCalendarViews(UserInfo.getUserId());
        System.assertNotEquals(0, results.size());
    }

    @IsTest 
    static void testGetRepPresence(){
        String results = MulticalendarDataService.getRepPresence(UserInfo.getUserId());
        User u = [SELECT Presence__c FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        String expected = 'no presence found';
        if(u.Presence__c != null){
            expected = u.Presence__c;
        }
        System.assertEquals(expected, results);

        Portal_Team_Member__c rep = [SELECT Id, Presence__c FROM Portal_Team_Member__c LIMIT 1];
        results = MulticalendarDataService.getRepPresence(rep.Id);
        expected = 'no presence found';
        if(rep.Presence__c != null){
            expected = rep.Presence__c;
        }
        System.assertEquals(expected, results);
    }

    @IsTest 
    static void testNumberOfEndedCalls(){
        NVMStatsSF__NVM_Call_Summary__c summary = new NVMStatsSF__NVM_Call_Summary__c(NVMStatsSF__CLID__c='+12345678901', NVMStatsSF__CallEndTime__c=Datetime.now());
        insert summary;

        Event ev = [SELECT Id FROM Event];
        System.assertEquals(1, MulticalendarDataService.numberOfEndedCalls(ev.Id));
    }

    @IsTest 
    static void testGetRepTimeslots(){
        Datetime todayDate = Datetime.now();
        //String dateString = '2023-06-15T00:00:00.000-04:00';
        String dateString = todayDate.format('yyyy-MM-dd')+'T00:00:00.000-05:00';
        User u = [SELECT Id FROM User WHERE Name = 'Matthew Clark'];

        Event ev = new Event(Subject='BLOCK', Type_of_Appointment__c='Calendar Block', StartDateTime=Datetime.now(), EndDateTime=Datetime.now().addMinutes(60), OwnerId=u.Id);
        //Event ev2 = new Event(Subject='BLOCK', StartDateTime=Datetime.now(), EndDateTime=Datetime.now().addMinutes(30), OwnerId=u.Id);
        insert ev;

        List<MulticalendarDataService.Timeslot> results =  MulticalendarDataService.getRepTimeslots(u.Id, dateString);
        System.assertNotEquals(0, results.size());

        List<MulticalendarDataService.Timeslot> results2 =  MulticalendarDataService.getRepTimeslots('0', dateString);
        System.assertNotEquals(0, results2.size());
    }

    @IsTest 
    static void testGetFulfillmentRepTimeslots(){
        Datetime todayDate = Datetime.now();
        //String dateString = '2023-06-15T00:00:00.000-04:00';
        String dateString = todayDate.format('yyyy-MM-dd')+'T00:00:00.000-05:00';
        User u = [SELECT Id FROM User WHERE Name = 'Matthew Clark'];
        Portal_Team_Member__c rep = [SELECT Id FROM Portal_Team_Member__c WHERE User__c = :UserInfo.getUserId() LIMIT 1];
        Event ev = new Event(Subject='BLOCK', Type_of_Appointment__c='Calendar Block', StartDateTime=Datetime.now(), EndDateTime=Datetime.now().addMinutes(60), OwnerId=u.Id, Portal_Team_Member__c=rep.Id);
        //Event ev2 = new Event(Subject='BLOCK', StartDateTime=Datetime.now(), EndDateTime=Datetime.now().addMinutes(30), OwnerId=u.Id);
        insert ev;

        List<MulticalendarDataService.Timeslot> results =  MulticalendarDataService.getRepTimeslots(rep.Id, dateString);
        System.assertNotEquals(0, results.size());
    }

    @IsTest
    static void testGetCurrentUserData(){
        MulticalendarDataService.Rep currentUser = MulticalendarDataService.getCurrentUserData('');
        System.debug(currentUser);
        System.assertNotEquals(null, currentUser);
    }

    @IsTest
    static void testGetCurrentUserDataAdvisory(){
        MulticalendarDataService.Rep currentUser = MulticalendarDataService.getCurrentUserData('Advisory');
        System.debug(currentUser);
        System.assertNotEquals(null, currentUser);
    }


}