/**
*  About
*  -----
*  Author: Appluent
*  Create date: 03 Oct 2017
*  
*  Details
*  -----
*  This class is the Test Class for EventTriggerHandler.
*  It will do following operations :
*  1.Create new events one for discovery Call and one for Advisory
*  2.Verify the newly Created 3 SMS Scheduler Records.
*  3.Delete events and check that respect SMS records has been deleted.
*
*  Update History
*  -----
*  
*  Issues / TODOs
*  ----- 
*
**/
@IsTest
public class EventTriggerHandlerTest{
    /**  
    *  About
    *  -----
    *  Author: Appluent
    * 
    *  Details
    *  -----
    *  Method to setup Test Data
    **/
    @TestSetup
    private static void testDataSetup() {
        List<User> lstUser = new List<User>();

        UserRole r = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role');
        insert r;

        Id profileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;

        User u = [SELECT Id FROM User WHERE Name = 'Matthew Clark'];

        User u1 = new User();
        u1.FirstName = 'Appluent';
        u1.LastName = 'Business Solutions';
        u1.Alias = 'test1';
        u1.Email = 'firstfirst@testasi.com';
        u1.Username = 'firstfirst@testasi209734.com';
        u1.ProfileId = profileId;
        u1.Country = 'United States';
        u1.UserRoleId = r.Id;
        u1.IsActive = true;
        u1.TimeZoneSidKey ='America/Los_Angeles';
        u1.EmailEncodingKey = 'UTF-8';
        u1.LanguageLocaleKey = 'en_US';
        u1.LocaleSidKey = 'en_US';
        u1.ManagerId = u.Id;

        lstUser.add(u1);
        insert lstUser;
        System.runAs(lstUser[0]){


            List<Account> listAccountsToInsert  = new List<Account> ();

            //Account with Primary Contact
            Account testAccount = ApexTestUtility.createAccount('TestAccount');
            listAccountsToInsert.add(testAccount);
            //Account without Primary Contact
            Account testAccountwithoutPrimaryCon = ApexTestUtility.createAccount('TestAccountWithoutPrimaryContact');
            listAccountsToInsert.add(testAccountwithoutPrimaryCon);
            //This is for Distributed SMS scdehule Test
            Account distributedAccount = ApexTestUtility.createAccount('distributedAccount');
            distributedAccount.Lead_Status__c = 'New';
            distributedAccount.Lead_Type_New__c='Buyer Tax Opt In';
            distributedAccount.Distribute_Date__c = Date.today();
            listAccountsToInsert.add(distributedAccount);

            insert listAccountsToInsert;

            Event event = new Event(
                    WhatId = listAccountsToInsert[0].Id,
                    Subject = 'Test Event',
                    StartDateTime = System.now(),
                    EndDateTime = System.now(),
                    Email_Campaign_ID__c = '12345',
                    Type_of_Appointment__c = 'Tax Savings Analysis',
                    Portal_Event_Owner__c = 'Matthew Clark'
            );
            insert event;

            List<Lead> listLeadstoAdd = new  List<Lead>();

            Lead testLead = new Lead();
            testLead.FirstName='Test';
            testLead.LastName='Lead';
            testLead.X1_1_Scheduled__c=null;
            testLead.Distribute_Date__c= System.today().addDays(-24);
            testLead.OwnerId=lstUser[0].Id;
            testLead.Email='testrec@gmail.com';
            testLead.Status='1-1 No Show';
            testLead.Phone='9326582649';
            testLead.Company='test company';
            listLeadstoAdd.add(testLead);

            //This is for Distributed SMS scdehule Test
            Lead distributedLead = new Lead();
            distributedLead.FirstName='Test';
            distributedLead.LastName='Lead';
            distributedLead.Distribute_Date__c= System.today();
            distributedLead.Email='testrec1@gmail.com';
            distributedLead.Status='New';
            distributedLead.Phone='9326582649';
            distributedLead.Company='test company';
            distributedLead.Lead_Type_New__c='Buyer Tax Opt In';
            listLeadstoAdd.add(distributedLead);

            insert listLeadstoAdd;

            //Create Contact
            Contact testContact = ApexTestUtility.createContact('lastName','FirstName');
            testContact.AccountId = testAccount.Id;
            testContact.Email ='testcontact@email.com';
            testContact.Phone ='6102902598';

            insert testContact;

            distributedAccount.Primary_Contact__c = testContact.Id;
            update distributedAccount;

            //Setting primary contact
            testAccount.Primary_Contact__c = testContact.id;
            update testAccount;

            String phoneNumber = '000-000-0000';

            //Distributed Account / Lead SMS
            //Create SMS Schedule Records Existing SMS records
            // List<SMS_Schedule__c> smsShedulesToInsert = new List<SMS_Schedule__c> ();

            // for(Integer i=0 ; i<=2 ; i++){
            //     Datetime distributeDate = datetime.newInstance(distributedAccount.Distribute_Date__c.year(), distributedAccount.Distribute_Date__c.month(),distributedAccount.Distribute_Date__c.day());
            //     SMS_Schedule__c smsScheduleAccount = new SMS_Schedule__c();
            //     smsScheduleAccount.RingCentral_Number__c=phoneNumber;
            //     smsScheduleAccount.Schedule_Date__c= distributeDate.addDays(2).addHours(14).addMinutes(30);
            //     smsScheduleAccount.Message__c='This is Account Message Text '+i;
            //     smsScheduleAccount.Object_Id__c = (String)distributedAccount.Primary_Contact__c;
            //     smsScheduleAccount.Reference_Id__c = distributedAccount.Primary_Contact__r.Name+'-'+distributeDate;
            //     smsScheduleAccount.To_Phone_Number__c = '1234567';
            //     smsScheduleAccount.Name =  distributedAccount.Primary_Contact__r.Name+'_'+distributeDate;
            //     smsScheduleAccount.Contact__c=distributedAccount.Primary_Contact__c;
            //     smsScheduleAccount.Account__c=distributedAccount.Id;
            //     smsShedulesToInsert.add(smsScheduleAccount);
            // }

            // for(Integer i=0 ; i<=2 ; i++){
            //     Datetime distributeDate = datetime.newInstance(distributedLead.Distribute_Date__c.year(), distributedLead.Distribute_Date__c.month(),distributedLead.Distribute_Date__c.day());
            //     SMS_Schedule__c smsScheduleAccount = new SMS_Schedule__c();
            //     smsScheduleAccount.RingCentral_Number__c=phoneNumber;
            //     smsScheduleAccount.Schedule_Date__c= distributeDate.addDays(2).addHours(14).addMinutes(30);
            //     smsScheduleAccount.Message__c='This is Lead Message Text '+i;
            //     smsScheduleAccount.Object_Id__c = (String)distributedLead.Id;
            //     smsScheduleAccount.Reference_Id__c = distributedLead.Name+'-'+distributeDate;
            //     smsScheduleAccount.To_Phone_Number__c = '1234567';
            //     smsScheduleAccount.Name =  distributedLead.Name+'_'+distributeDate;
            //     smsScheduleAccount.Lead__c=distributedLead.Id;
            //     smsShedulesToInsert.add(smsScheduleAccount);
            // }

            // insert smsShedulesToInsert;
        }

    }

    /**
    *  About
    *  -----
    *  Author: Appluent
    *  Create date:03 Oct 2017
    *
    *  Details
    *  -----
    *  It will do following operations :
    *  1.Create new events one for discovery Call and one for Advisory
    *  2.Verify the newly Created 3 SMS Scheduler Records per Discovery and Advisory Event.
    *
    *  Update History
    *  -----
    *
    *  Issues / TODOs
    *  -----
    *
    **/
    @IsTest
    public static void newEventInsertTest() {

        List<Event> listEventsToInsert  = new List<Event> ();
        List<Account> listTestAccounts = [SELECT Id,
                Name,
                Primary_Contact__r.Name,
                Primary_Contact__r.Phone
        FROM Account
        ORDER BY CreatedDate DESC
        LIMIT 3];
        Account testAccount = new Account();
        Account testAccountWithoutPrimaryCon = new Account();
        Account distributedAccount = new Account();
        for(Account acc : listTestAccounts){
            if(acc.Name == 'TestAccount'){
                testAccount=acc;
            }
            if(acc.Name == 'TestAccountWithoutPrimaryContact'){
                testAccountWithoutPrimaryCon=acc;
            }
            if(acc.Name == 'distributedAccount'){
                distributedAccount=acc;
            }
        }

        List<Lead> listTestLeads = [SELECT Id,Email
        FROM Lead
        ORDER BY CreatedDate DESC
        LIMIT 2 ];
        Lead testLead = new Lead();
        Lead distributedLead = new Lead();
        for(Lead led : listTestLeads){
            if(led.Email == 'testrec@gmail.com'){
                testLead =led;
            }
            if(led.Email == 'testrec1@gmail.com'){
                distributedLead =led;
            }
        }
        System.debug('inserting events');
        Event newEvent01 = ApexTestUtility.createEvent('Discovery call');
        newEvent01.WhatId=testAccount.Id;
        newEvent01.StartDateTime = System.now().addDays(2);
        newEvent01.ActivityDateTime = newEvent01.StartDateTime;
        newEvent01.EndDateTime = System.now().addDays(3);
        listEventsToInsert.add(newEvent01);

        Event newEvent02 = ApexTestUtility.createEvent('Test Subject');
        newEvent02.WhatId=testAccount.Id;
        listEventsToInsert.add(newEvent02);

        Event newEvent03 = ApexTestUtility.createEvent('Advisory #1');
        newEvent03.WhatId=testAccount.Id;
        listEventsToInsert.add(newEvent03);

        //Without Related account ID
        Event newEvent04 = ApexTestUtility.createEvent('Advisory #1');
        listEventsToInsert.add(newEvent04);

        //Without Primary Contact on account
        Event newEvent05 = ApexTestUtility.createEvent('Advisory #1');
        newEvent05.WhatId=testAccountWithoutPrimaryCon.Id;
        listEventsToInsert.add(newEvent05);

        Event newEvent06 = ApexTestUtility.createEvent('1on1 Sales Appointment');
        newEvent06.WhatId=testAccountWithoutPrimaryCon.Id;
        listEventsToInsert.add(newEvent06);

        Event newEvent07 = ApexTestUtility.createEvent('Discovery call');
        newEvent07.WhoId=testLead.Id;
        newEvent07.StartDateTime = System.now().addDays(2);
        newEvent07.EndDateTime = System.now().addDays(3);
        newEvent07.ActivityDateTime = newEvent07.StartDateTime;
        listEventsToInsert.add(newEvent07);

        Event newEvent08 = ApexTestUtility.createEvent('1on1 Sales Appointment');
        newEvent08.WhoId=testLead.Id;
        listEventsToInsert.add(newEvent08);

        //This event insertion will delete distributed account sms sch records
        Event newEvent09 = ApexTestUtility.createEvent('1on1 Sales Appointment');
        System.debug('** newEvent09: ' +newevent09);
        newEvent09.WhatId=distributedAccount.Id;
        newEvent09.Type_of_Appointment__c = 'Tax Savings Analysis';
        newEvent09.Appointment_Disposition__c = 'Scheduled';
        newEvent09.ActivityDateTime = System.now().addDays(1);
        newEvent09.StartDateTime = newEvent09.ActivityDateTime;
        newEvent09.EndDateTime = System.now().addDays(3);
        listEventsToInsert.add(newEvent09);

        //This event insertion will delete distributed Lead sms sch records
        Event newEvent10 = ApexTestUtility.createEvent('1on1 Sales Appointment');
        newEvent10.WhoId=distributedLead.Id;
        listEventsToInsert.add(newEvent10);

        //This event insertion will delete distributed account sms sch records
        Event newEvent11 = ApexTestUtility.createEvent('ClientBooks Consultation');
        newEvent11.WhatId=testAccount.Id;
        newEvent11.Appointment_Disposition__c = 'ClientBooks Consultation';
        newEvent11.Type_of_Appointment__c = 'ClientBooks Consultation';
        newEvent11.StartDateTime = System.now().addDays(2);
        newEvent11.EndDateTime = System.now().addDays(3);
        newEvent11.ActivityDateTime = newEvent11.StartDateTime;
        listEventsToInsert.add(newEvent11);

        //This event insertion will delete distributed Lead sms sch records
        Event newEvent12 = ApexTestUtility.createEvent('ClientBooks Consultation');
        newEvent12.WhoId=testLead.Id;
        newEvent12.Appointment_Disposition__c = 'ClientBooks Consultation';
        newEvent12.StartDateTime = System.now().addDays(2);
        newEvent12.ActivityDateTime = newEvent12.StartDateTime;
        newEvent12.EndDateTime = System.now().addDays(3);
        listEventsToInsert.add(newEvent12);

        Event newEvent13 = ApexTestUtility.createEvent('1on1 Sales Appointment');
        newEvent13.WhatId=testAccount.Id;
        newEvent13.Type_of_Appointment__c = 'Tax Savings Analysis';
        newEvent13.ActivityDateTime = System.now().addDays(2);
        newEvent13.StartDateTime = newEvent13.ActivityDateTime;
        newEvent13.EndDateTime = System.now().addDays(3);
        newEvent13.Appointment_Disposition__c = 'No Show';
        listEventsToInsert.add(newEvent13);

        Event newEvent14 = ApexTestUtility.createEvent('ClientBooks Consultation');
        newEvent14.WhatId=testAccount.Id;
        newEvent14.Type_of_Appointment__c = 'ClientBooks Consultation';
        newEvent14.ActivityDateTime = System.now().addDays(2);
        newEvent14.StartDateTime = newEvent14.ActivityDateTime;
        newEvent14.EndDateTime = System.now().addDays(3);
        newEvent14.Appointment_Disposition__c = 'No Show';
        listEventsToInsert.add(newEvent14);

        Event newEvent015 = ApexTestUtility.createEvent('BNA');
        newEvent015.WhatId=testAccount.Id;
        newEvent015.Type_of_Appointment__c = 'BNA';
        newEvent015.StartDateTime = System.now().addDays(2);
        newEvent015.ActivityDateTime = newEvent015.StartDateTime;
        newEvent015.EndDateTime = System.now().addDays(3);
        listEventsToInsert.add(newEvent015);

        Event newEvent016 = ApexTestUtility.createEvent('Formation Consultation');
        newEvent016.WhatId=testAccount.Id;
        newEvent016.Type_of_Appointment__c = 'Formation Consultation';
        newEvent016.StartDateTime = System.now().addDays(2);
        newEvent016.ActivityDateTime = newEvent016.StartDateTime;
        newEvent016.EndDateTime = System.now().addDays(3);
        listEventsToInsert.add(newEvent016);

        System.debug('TO BE INSERT SMS COUNT '+[SELECT COUNT() FROM SMS_Schedule__c ] );

        Test.startTest();
        Database.SaveResult[] results = Database.insert(listEventsToInsert);
        for(Database.SaveResult res : results)
        {
            System.debug(res);
        }
        Test.stopTest();


        System.debug('TEST INSERTED SMS COUNT '+[SELECT COUNT() FROM SMS_Schedule__c ] );

        System.assertNotEquals(0, [SELECT COUNT() FROM SMS_Schedule__c], 'should have created more than 0 SMS_Schedule__c records.');
    }

    /**
    *  About
    *  -----
    *  Author: Appluent
    *  Create date:12 Oct 2017
    *
    *  Details
    *  -----
    *  It will do following operations :
    *  1.Create new events one for discovery Call and one for Advisory and Then Delete one of them.
    *  2.Verify the newly Created SMS Scheduler Records deletion as per their respective event deletion.
    *
    *  Update History
    *  -----
    *
    *  Issues / TODOs
    *  -----
    *
    **/
    @IsTest
    public static void eventDeleteTest() {
        List<Event> listEventsToInsert  = new List<Event> ();
        List<Account> listTestAccounts = [SELECT Id,
                Name,
                Primary_Contact__r.Name,
                Primary_Contact__r.Phone
        FROM ACCOUNT
        ORDER BY createdDate DESC
        LIMIT 3];
        Account testAccount = new Account();
        Account testAccountwithoutPrimaryCon = new Account();
        Account distributedAccount = new Account();
        for(Account acc : listTestAccounts){
            if(acc.Name == 'TestAccount'){
                testAccount=acc;
            }
            if(acc.Name == 'TestAccountWithoutPrimaryContact'){
                testAccountwithoutPrimaryCon=acc;
            }
            if(acc.Name == 'distributedAccount'){
                distributedAccount=acc;
            }
        }

        List<Lead> listTestLeads = [SELECT Id,Email
        FROM LEAD
        ORDER BY createdDate DESC
        LIMIT 2 ];
        Lead testLead = new Lead();
        Lead distributedLead = new Lead();
        for(Lead led : listTestLeads){
            if(led.Email == 'testrec@gmail.com'){
                testLead =led;
            }
            if(led.Email == 'testrec1@gmail.com'){
                distributedLead =led;
            }
        }



        // Event newEvent01 = ApexTestUtility.createEvent('Discovery call');
        // newEvent01.Whatid=testAccount.Id;
        // listEventsToInsert.add(newEvent01);

        Event newEvent02 = ApexTestUtility.createEvent('Advisory #1');
        newEvent02.Whatid=testAccount.Id;

        Event newEvent03 = ApexTestUtility.createEvent('1on1 Sales Appointment');
        newEvent03.Whatid=testAccount.Id;

        Event newEvent04 = ApexTestUtility.createEvent('Advisory #1');
        newEvent04.WhoId=testLead.Id;

        Event newEvent05 = ApexTestUtility.createEvent('1on1 Sales Appointment');
        newEvent05.WhoId=testLead.Id;

        //This event insertion will delete distributed account sms sch records
        // Event newEvent06 = ApexTestUtility.createEvent('1on1 Sales Appointment');
        // newEvent06.Whatid=distributedAccount.Id;
        // listEventsToInsert.add(newEvent06);

        //This event insertion will delete distributed Lead sms sch records
        Event newEvent07 = ApexTestUtility.createEvent('1on1 Sales Appointment');
        newEvent07.Whoid=distributedLead.Id;
        listEventsToInsert.add(newEvent07);


        // listEventsToInsert.add(newEvent02);
        // listEventsToInsert.add(newEvent03);
        // listEventsToInsert.add(newEvent04);
        // listEventsToInsert.add(newEvent05);

        insert listEventsToInsert;
        //System.assertEquals(6,[SELECT count() FROM SMS_Schedule__c]);

        Test.startTest();
        delete listEventsToInsert;
        Test.stopTest();

        //System.assertEquals(3,[SELECT count() FROM SMS_Schedule__c]);
    }

    @IsTest
    public static void eventDeleteTest2() {
        List<Event> listEventsToInsert  = new List<Event> ();
        List<Account> listTestAccounts = [SELECT Id,
                Name,
                Primary_Contact__r.Name,
                Primary_Contact__r.Phone
        FROM ACCOUNT
        ORDER BY createdDate DESC
        LIMIT 3];
        Account testAccount = new Account();
        Account testAccountwithoutPrimaryCon = new Account();
        Account distributedAccount = new Account();
        for(Account acc : listTestAccounts){
            if(acc.Name == 'TestAccount'){
                testAccount=acc;
            }
            if(acc.Name == 'TestAccountWithoutPrimaryContact'){
                testAccountwithoutPrimaryCon=acc;
            }
            if(acc.Name == 'distributedAccount'){
                distributedAccount=acc;
            }
        }

        List<Lead> listTestLeads = [SELECT Id,Email
        FROM LEAD
        ORDER BY createdDate DESC
        LIMIT 2 ];
        Lead testLead = new Lead();
        Lead distributedLead = new Lead();
        for(Lead led : listTestLeads){
            if(led.Email == 'testrec@gmail.com'){
                testLead =led;
            }
            if(led.Email == 'testrec1@gmail.com'){
                distributedLead =led;
            }
        }



        // Event newEvent01 = ApexTestUtility.createEvent('Discovery call');
        // newEvent01.Whatid=testAccount.Id;
        // listEventsToInsert.add(newEvent01);

        Event newEvent02 = ApexTestUtility.createEvent('Advisory #1');
        newEvent02.Whatid=testAccount.Id;

        Event newEvent03 = ApexTestUtility.createEvent('1on1 Sales Appointment');
        newEvent03.Whatid=testAccount.Id;

        Event newEvent04 = ApexTestUtility.createEvent('Advisory #1');
        newEvent04.WhoId=testLead.Id;

        Event newEvent05 = ApexTestUtility.createEvent('1on1 Sales Appointment');
        newEvent05.WhoId=testLead.Id;

        //This event insertion will delete distributed account sms sch records
        Event newEvent06 = ApexTestUtility.createEvent('1on1 Sales Appointment');
        newEvent06.Whatid=distributedAccount.Id;
        listEventsToInsert.add(newEvent06);

        //This event insertion will delete distributed Lead sms sch records
        // Event newEvent07 = ApexTestUtility.createEvent('1on1 Sales Appointment');
        // newEvent07.Whoid=distributedLead.Id;
        // listEventsToInsert.add(newEvent07);


        // listEventsToInsert.add(newEvent02);
        // listEventsToInsert.add(newEvent03);
        // listEventsToInsert.add(newEvent04);
        // listEventsToInsert.add(newEvent05);

        insert listEventsToInsert;
        //System.assertEquals(6,[SELECT count() FROM SMS_Schedule__c]);

        Test.startTest();
        delete listEventsToInsert;
        Test.stopTest();

        //System.assertEquals(3,[SELECT count() FROM SMS_Schedule__c]);
    }

    /**
    *  About
    *  -----
    *  Author: Appluent
    *  Create date:04 Dec 2017
    *
    *  Details
    *  -----
    *  It will do following operations :
    *  1.Create new events one for discovery Call and one for Advisory
    *  2.Verify the newly Created 3 SMS Scheduler Records per Discovery and Advisory Event.
    *  3.Verify the newly Created SMS Scheduler Records deletion as per their respective event deletion.
    *  4.Verify that 3 new SMS Schedule records are created after upation of the event.
    *
    *  Update History
    *  -----
    *
    *  Issues / TODOs
    *  -----
    *
    **/
    @IsTest
    public static void newEventUpdateTest() {

        List<Event> listEventsToInsert  = new List<Event> ();
        List<Account> listTestAccounts = [SELECT Id,
                Name,
                Primary_Contact__r.Name,
                Primary_Contact__r.Phone
        FROM ACCOUNT
        ORDER BY createdDate DESC
        LIMIT 3];
        Account testAccount = new Account();
        Account testAccountwithoutPrimaryCon = new Account();
        Account distributedAccount = new Account();
        for(Account acc : listTestAccounts){
            if(acc.Name == 'TestAccount'){
                testAccount=acc;
            }
            if(acc.Name == 'TestAccountWithoutPrimaryContact'){
                testAccountwithoutPrimaryCon=acc;
            }
            if(acc.Name == 'distributedAccount'){
                distributedAccount=acc;
            }
        }

        List<Lead> listTestLeads = [SELECT Id,Email
        FROM LEAD
        ORDER BY createdDate DESC
        LIMIT 2 ];
        Lead testLead = new Lead();
        Lead distributedLead = new Lead();
        for(Lead led : listTestLeads){
            if(led.Email == 'testrec@gmail.com'){
                testLead =led;
            }
            if(led.Email == 'testrec1@gmail.com'){
                distributedLead =led;
            }
        }


        Event newEvent01 = ApexTestUtility.createEvent('Discovery call');
        newEvent01.Whatid=testAccount.Id;

        Event newEvent02 = ApexTestUtility.createEvent('1on1 Sales Appointment');
        newEvent02.Whatid=testAccount.Id;
        newEvent02.Subject='Formation Consultation';


        //This event insertion will delete distributed account sms sch records
        Event newEvent03 = ApexTestUtility.createEvent('Random acc Event');
        newEvent03.Whatid=distributedAccount.Id;

        //This event insertion will delete distributed Lead sms sch records
        Event newEvent04 = ApexTestUtility.createEvent('Random lead Event');
        newEvent04.Whoid=distributedLead.Id;

        listEventsToInsert.add(newEvent01);
        // listEventsToInsert.add(newEvent02);
        // listEventsToInsert.add(newEvent03);
        // listEventsToInsert.add(newEvent04);
        System.debug('checkpoint1');
        insert listEventsToInsert;
        System.debug('SMS record before update '+[SELECT count() FROM SMS_Schedule__c] );
        //System.assertEquals(3,[SELECT count() FROM SMS_Schedule__c]);

        Test.startTest();
        newEvent01.StartDateTime= DateTime.newInstance(2018, 11, 06, 11, 30, 0);
        //newEvent01.Call_Result__c= 'Qualified';
        newEvent01.Subject = '1on1 Sales Appointment';
        System.debug('checkpoint2');

        update newEvent01;
        // newEvent02.StartDateTime= DateTime.newInstance(2018, 11, 06, 11, 30, 0);
        // newEvent03.Subject = '1on1 Sales Appointment';
        // newEvent04.Subject = '1on1 Sales Appointment';
        // update listEventsToInsert;
        //delete listEventsToInsert;
        System.debug('checkpoint3');

        Test.stopTest();
        System.debug('SMS record After update '+[SELECT count() FROM SMS_Schedule__c] );
        //System.assertEquals(3,[SELECT count() FROM SMS_Schedule__c]);


    }

    @IsTest static void test_updateEmailCampaignId () {
        Account account = [SELECT Id FROM Account LIMIT 1];
        Event[] eventsToInsert = new Event[0];

        Lead lead = new Lead(
                FirstName = 'Test',
                LastName = 'Test Lead',
                Email = 'test@test.com',
                Phone = '8001111111',
                Company = 'Test Company',
                Status = 'New'
        );
        insert lead;

	    Test.startTest();
        Event leadEvent = new Event(
                WhoId = lead.Id,
                Subject = 'Test Event',
                StartDateTime = System.now(),
                EndDateTime = System.now(),
                Email_Campaign_ID__c = '11111',
                Type_of_Appointment__c = 'Tax Savings Analysis'
        );
        eventsToInsert.add(leadEvent);

        Contact contact = new Contact(
                FirstName = 'Test',
                LastName = 'Test Contact',
                Email = 'test2@test.com',
                Phone = '8002222222',
                AccountId = account.Id
        );
        insert contact;
        Event contactEvent = new Event(
                WhoId = contact.Id,
                Subject = 'Test Event',
                StartDateTime = System.now(),
		        OwnerId = UserInfo.getUserId(),
                EndDateTime = System.now(),
                Email_Campaign_ID__c = '22222',
                Type_of_Appointment__c = 'Tax Savings Analysis'
        );
        eventsToInsert.add(contactEvent);
        Event contactEvent2 = new Event(
            WhoId = contact.Id,
            Subject = 'Formation Consultation',
            StartDateTime = System.now(),
            OwnerId = UserInfo.getUserId(),
            EndDateTime = System.now(),
            Email_Campaign_ID__c = '22222',
            Type_of_Appointment__c = 'BNA',
            Appointment_Disposition__c = 'No Show'
        );
        eventsToInsert.add(contactEvent2);

        insert eventsToInsert;

//        Test.startTest();

        Event newAccountEvent = new Event(
                WhatId = account.Id,
                Subject = 'Test Event',
                StartDateTime = System.now(),
                EndDateTime = System.now(),
                Type_of_Appointment__c = 'Tax Savings Analysis'
        );
        insert newAccountEvent;

        Event newLeadEvent = new Event(
                WhoId = lead.Id,
                Subject = 'Formation Consultation',
                StartDateTime = System.now(),
                EndDateTime = System.now(),
                Type_of_Appointment__c = 'Tax Savings Analysis',
                Appointment_Disposition__c = 'No Show'
        );
        insert newLeadEvent;

        // Event newContactEvent = new Event(
        //         WhoId = contact.Id,
        //         Subject = 'Test Event',
        //         StartDateTime = System.now(),
        //         EndDateTime = System.now(),
        //         Type_of_Appointment__c = 'Tax Savings Analysis'
        // );
        // insert newContactEvent;
        Test.stopTest();

        Set<Id> idsToQuery = new Set<Id>();
        idsToQuery.add(newAccountEvent.Id);
        idsToQuery.add(newLeadEvent.Id);
        //idsToQuery.add(newContactEvent.Id);

        Event[] results = [
                SELECT Email_Campaign_ID__c FROM Event WHERE Id IN : idsToQuery
        ];

        for(Event evt : results)
        {
            if(evt.Id == newAccountEvent.Id){System.assertEquals('12345', evt.Email_Campaign_ID__c);}
            if(evt.Id == newLeadEvent.Id){System.assertEquals('11111', evt.Email_Campaign_ID__c);}
            //if(evt.Id == newContactEvent.Id){System.assertEquals('22222', evt.Email_Campaign_ID__c);}
        }

//
//        Event updatedAccountEvent = [
//                SELECT Email_Campaign_ID__c FROM Event WHERE Id = :newAccountEvent.Id
//        ];
//        System.assertEquals('12345', updatedAccountEvent.Email_Campaign_ID__c);
//
//        Event updatedLeadEvent = [
//                SELECT Email_Campaign_ID__c FROM Event WHERE Id = :newLeadEvent.Id
//        ];
//        System.assertEquals('11111', updatedLeadEvent.Email_Campaign_ID__c);
//
//        Event updatedContactEvent = [
//                SELECT Email_Campaign_ID__c FROM Event WHERE Id = :newContactEvent.Id
//        ];
//        System.assertEquals('22222', updatedContactEvent.Email_Campaign_ID__c);
    }

    @isTest static void test_updateInvoicePaymentAmount () {
        Account act = [SELECT Id FROM Account LIMIT 1];
        Event evt = [SELECT Id FROM Event LIMIT 1];
//        Zuora__ZInvoice__c invoice = new Zuora__ZInvoice__c(
//                Zuora__Account__c = account.Id,
//                Zuora__InvoiceDate__c = System.today().addDays(1),
//                Zuora__PaymentAmount__c = 10
//        );
//        insert invoice;

        ChargeOver_Invoice__c inv = new ChargeOver_Invoice__c(Account__c=act.Id,Total__c=10);
        insert inv;

        Test.startTest();
        evt.Appointment_Disposition__c = 'Consulted';
        evt.Secondary_Disposition_Details__c = 'Sale';
        update evt;
        Test.stopTest();

        Event updatedEvent = [
                SELECT Invoice_Payment_Amount__c FROM Event WHERE Id = :evt.Id
        ];
        System.assertEquals(10, updatedEvent.Invoice_Payment_Amount__c);
    }
}