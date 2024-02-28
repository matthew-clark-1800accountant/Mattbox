@IsTest
public with sharing class NVMCallSummaryTriggerHandlerTest {
    @TestSetup
    static void makeData(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        User u = new User(Username = 'testguy@test.com', LastName='Beebop', Email='testguy@test.com', Alias = 'newUser', 
        EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles');
        insert u;

        NVMStatsSF__NVM_Agent_Summary__c agentSummary1 = new NVMStatsSF__NVM_Agent_Summary__c(
            NVMStatsSF__AgentID__c = '1234', //text field
            NVMStatsSF__Agent__c = u.Id, //user lookup
            NVMStatsSF__Date__c = Date.today(), //date field,
            NVMStatsSF__dateAgentId__c = '202311021234'
        );

        NVMStatsSF__NVM_Agent_Summary__c agentSummary2 = new NVMStatsSF__NVM_Agent_Summary__c(
            NVMStatsSF__AgentID__c = '5678', //text field
            NVMStatsSF__Agent__c = u.Id, //user lookup
            NVMStatsSF__Date__c = Date.today(), //date field,
            NVMStatsSF__dateAgentId__c = '202311025678'
        );

        insert new List<NVMStatsSF__NVM_Agent_Summary__c>{agentSummary1, agentSummary2};
    }

    @isTest 
    static void testInsert(){
        Test.startTest();
        //Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        //User u = [SELECT Id FROM User WHERE IsActive = true AND Profile.Id = :p.Id LIMIT 1];
        //System.runAs(u) {
            NVMStatsSF__NVM_Call_Summary__c callSummary = new NVMStatsSF__NVM_Call_Summary__c(
                NVMStatsSF__Ring_List__c = '1234:15, 5678:5',
                NVMStatsSF__Agent_List__c = '1234-0, 5678-224',
                NVMStatsSF__NVM_AgentID__c = '1234',
                NVMStatsSF__Agent2_ID__c = '5678',
                NVMStatsSF__dateAgentId__c = '202311021160',
                NVMStatsSF__Queue_Name__c = 'Good queue',
                NVMStatsSF__Queue_Agent_Queue_List__c = 'Live Transfer'
            );
            insert callSummary;
        //}
        
        Test.stopTest();
    }
}