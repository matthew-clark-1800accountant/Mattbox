@IsTest
public with sharing class TaskTriggerHandlerTest {
    @TestSetup
    private static void testDataSetup() {
        Account acc = new Account(Name='test account',
        Distribute_Date__c=Date.today(), Pitched_Date__c = Date.today().addDays(2),
        ChargeOver_Initial_Payment_Date__c=Date.today().addDays(4));
        insert acc;
        Contact con = new Contact(FirstName='Test', LastName='contact', AccountId=acc.Id);
        insert con;

        Lead l = new Lead(Distribute_Date__c=Date.today(), Pitched_Date__c = Date.today().addDays(2),
        LeadSource='LegalZoom', Status='New', Lead_Type_New__c='Buyer Tax Opt In', FirstName='first',
        LastName='last', Company='company');
        insert l;
    }

    @IsTest
    public static void insertLeadCalls(){
        Lead l = [SELECT Id, Distribute_Date__c, Pitched_Date__c FROM Lead LIMIT 1];
        Integer count = 5;
        List<Task> newTasks = new List<Task>();
        User owner = [SELECT Id FROM User WHERE Name='Matthew Clark' LIMIT 1];
        for(Integer i=0; i<count; i++){
            newTasks.add(new Task(
                Subject='test task',
                OwnerId=owner.Id,
                ActivityDate=Date.today(),
                NVMContactWorld__CW_Call_Start_Time__c = Datetime.now(),
                WhoId = l.Id,
                CallType='Outbound',
                CallDurationInSeconds=5
            ));
        }
        System.debug(newTasks);
        Test.startTest();
        insert newTasks;
        Test.stopTest();
        l = [SELECT Id, of_Pre_TSA_Calls__c FROM Lead LIMIT 1];
        System.debug(l.of_Pre_TSA_Calls__c);
        System.assert(l.of_Pre_TSA_Calls__c == count);
    }

    @IsTest
    public static void insertContactCalls(){
        Contact con = [SELECT Id FROM Contact LIMIT 1];
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Integer preCount = 3;
        Integer postCount = 4;
        List<Task> newTasks = new List<Task>();
        User owner = [SELECT Id FROM User WHERE Name='Matthew Clark' LIMIT 1];
        for(Integer i=0; i<preCount; i++){
            newTasks.add(new Task(
                Subject='test task',
                OwnerId=owner.Id,
                ActivityDate=Date.today(),
                NVMContactWorld__CW_Call_Start_Time__c = Datetime.now(),
                WhoId = con.Id,
                WhatId = acc.Id,
                CallType='Outbound',
                CallDurationInSeconds=5
            ));
        }
        for(Integer i=0; i<postCount; i++){
            newTasks.add(new Task(
                Subject='test task',
                OwnerId=owner.Id,
                ActivityDate=Date.today().addDays(3),
                NVMContactWorld__CW_Call_Start_Time__c = Datetime.now().addDays(3),
                WhoId = con.Id,
                WhatId = acc.Id,
                CallType='Outbound',
                CallDurationInSeconds=5
            ));
        }
        System.debug(newTasks);
        Test.startTest();
        insert newTasks;
        Test.stopTest();
        con = [SELECT Id, of_Pre_TSA_Calls__c, of_TSA_Follow_Up_Calls__c FROM Contact LIMIT 1];
        acc = [SELECT Id, of_Pre_TSA_Calls__c, of_TSA_Follow_Up_Calls__c FROM Account LIMIT 1];
        System.debug(con);
        System.debug(acc);
        System.assertEquals(con.of_Pre_TSA_Calls__c, preCount);
        System.assertEquals(acc.of_Pre_TSA_Calls__c, preCount);
        //System.assertEquals(con.of_TSA_Follow_Up_Calls__c, postCount);
        //System.assertEquals(acc.of_TSA_Follow_Up_Calls__c, postCount);
    }

}