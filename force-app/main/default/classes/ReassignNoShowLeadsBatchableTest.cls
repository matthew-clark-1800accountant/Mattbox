@IsTest
public with sharing class ReassignNoShowLeadsBatchableTest {
    @TestSetup
    static void makeData(){
        List<Account> testAccounts = new List<Account>{
            new Account(Name='testacc'),
            new Account(Name='testacc', X1_1_Scheduled__c=Datetime.now().addDays(-1)),
            new Account(Name='testacc', X1_1_Scheduled__c=Datetime.now().addDays(1)) //this one should be excluded
        };
        insert testAccounts;

        List<Lead> testLeads = new List<Lead>{
            new Lead(FirstName='first', LastName='last', Company='company'),
            new Lead(FirstName='first', LastName='last', Company='company', X1_1_Scheduled__c=Datetime.now().addDays(-1)),
            new Lead(FirstName='first', LastName='last', Company='company', X1_1_Scheduled__c=Datetime.now().addDays(1))            
        };
        insert testLeads;
        
        Datetime curTime = ReassignNoShowLeadsBatchable.roundToHalfHourTime(Datetime.now()).addDays(-1);
        System.debug('curTime: '+curTime);
        List<Event> testEvents = new List<Event>{
            //weekday events
            new Event(Lead_Source__c = '1-800Accountant', StartDateTime=curTime, Type_of_Appointment__c ='Tax Savings Analysis', 
            Subject='Test', DurationInMinutes=5, Appointment_Disposition__c = 'No Show', Account__c = testAccounts[0].Id),
            new Event(Lead_Source__c = '1-800Accountant', StartDateTime=curTime, Type_of_Appointment__c ='Tax Savings Analysis', 
            Subject='Test', DurationInMinutes=5, Appointment_Disposition__c = 'No Show', Account__c = testAccounts[1].Id),
            new Event(Lead_Source__c = '1-800Accountant', StartDateTime=curTime, Type_of_Appointment__c ='Tax Savings Analysis', 
            Subject='Test', DurationInMinutes=5, Appointment_Disposition__c = 'No Show', Account__c = testAccounts[2].Id),

            new Event(Lead_Source__c = '1-800Accountant', StartDateTime=curTime, Type_of_Appointment__c ='Tax Savings Analysis', 
            Subject='Test', DurationInMinutes=5, Appointment_Disposition__c = 'No Show', WhoId = testLeads[0].Id),
            new Event(Lead_Source__c = '1-800Accountant', StartDateTime=curTime, Type_of_Appointment__c ='Tax Savings Analysis', 
            Subject='Test', DurationInMinutes=5, Appointment_Disposition__c = 'No Show', WhoId = testLeads[1].Id),
            new Event(Lead_Source__c = '1-800Accountant', StartDateTime=curTime, Type_of_Appointment__c ='Tax Savings Analysis', 
            Subject='Test', DurationInMinutes=5, Appointment_Disposition__c = 'No Show', WhoId = testLeads[2].Id),

            //events for Monday tests
            new Event(Lead_Source__c = '1-800Accountant', StartDateTime=curTime.addDays(-1), Type_of_Appointment__c ='Tax Savings Analysis', 
            Subject='Test', DurationInMinutes=5, Appointment_Disposition__c = 'No Show', Account__c = testAccounts[0].Id),
            new Event(Lead_Source__c = '1-800Accountant', StartDateTime=curTime.addDays(-1), Type_of_Appointment__c ='Tax Savings Analysis', 
            Subject='Test', DurationInMinutes=5, Appointment_Disposition__c = 'No Show', Account__c = testAccounts[1].Id),
            new Event(Lead_Source__c = '1-800Accountant', StartDateTime=curTime.addDays(-2), Type_of_Appointment__c ='Tax Savings Analysis', 
            Subject='Test', DurationInMinutes=5, Appointment_Disposition__c = 'No Show', Account__c = testAccounts[2].Id),

            new Event(Lead_Source__c = '1-800Accountant', StartDateTime=curTime.addDays(-1), Type_of_Appointment__c ='Tax Savings Analysis', 
            Subject='Test', DurationInMinutes=5, Appointment_Disposition__c = 'No Show', WhoId = testLeads[0].Id),
            new Event(Lead_Source__c = '1-800Accountant', StartDateTime=curTime.addDays(-1), Type_of_Appointment__c ='Tax Savings Analysis', 
            Subject='Test', DurationInMinutes=5, Appointment_Disposition__c = 'No Show', WhoId = testLeads[1].Id),
            new Event(Lead_Source__c = '1-800Accountant', StartDateTime=curTime.addDays(-2), Type_of_Appointment__c ='Tax Savings Analysis', 
            Subject='Test', DurationInMinutes=5, Appointment_Disposition__c = 'No Show', WhoId = testLeads[2].Id),

            //events to ignore:
            new Event(Lead_Source__c = '1-800Accountant', StartDateTime=curTime, Type_of_Appointment__c ='BNA', 
            Subject='Test', DurationInMinutes=5, Appointment_Disposition__c = 'No Show', WhoId = testLeads[0].Id),
            new Event(Lead_Source__c = '1-800Accountant', StartDateTime=curTime, Type_of_Appointment__c ='Tax Savings Analysis', 
            Subject='Test', DurationInMinutes=5, WhatId = testAccounts[1].Id)
        };

        insert testEvents;
    }

    @IsTest 
    static void testBatch(){

        Test.startTest();
        Database.executeBatch(new ReassignNoShowLeadsBatchable(), 20);
        Test.stopTest();

        List<User> generalLeadQueue = [SELECT Id FROM User WHERE Name = 'General Lead Queue' LIMIT 1];
        System.assertEquals(2, [SELECT COUNT() FROM Account WHERE Date_For_Reassignment__c=null AND OwnerId=:generalLeadQueue[0].Id]);
        System.assertEquals(2, [SELECT COUNT() FROM Lead WHERE Date_For_Reassignment__c=null AND OwnerId=:generalLeadQueue[0].Id]);

    }

    @isTest
    public static void testScheduled(){
        System.debug('testScheduled()');
        String CRON_EXP = '0 0 0 3 9 ? 2042';
        Test.startTest();
        String jobId = System.schedule('ReassignNoShowLeadsBatchableTest', CRON_EXP, new ReassignNoShowLeadsBatchable());
        // Get the information from the CronTrigger API object
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
        NextFireTime
        FROM CronTrigger WHERE id = :jobId];

        // Verify the expressions are the same
        System.assertEquals(CRON_EXP, 
            ct.CronExpression);

        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered);

        // Verify the next time the job will run
        System.assert(ct.NextFireTime != null);
        System.debug(ct);
        Test.stopTest();
    }

    @isTest
    public static void testBusinessDays(){
        Assert.areNotEqual(null,  new ReassignNoShowLeadsBatchable().lastBusinessDays);
    }
}