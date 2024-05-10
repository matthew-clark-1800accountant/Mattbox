@IsTest
public with sharing class UpdateOpportunityEventTriggerHandlerTest {

    @TestSetup
    static void makeData(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        User u = new User(Username = 'testguy@1800accountant.com', LastName='Beebop', Email='testguy@1800accountant.com', Alias = 'newUser', 
        EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles');
        insert u;

        Account act = new Account(Name='Test', OwnerId=u.id);
        insert act;

        Opportunity opp = new Opportunity(Name='TestOpp',AccountId=act.Id, StageName='New', CloseDate=Date.today().addDays(1), OwnerId=u.id);
        insert opp;

        Contact con = new Contact(FirstName='Test', LastName='Contact', AccountId = act.Id, OwnerId=u.Id);
        insert con;
    }

    @isTest
    static void testUpdate(){
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];

        Test.startTest();
        String oppString = JSON.serialize(new Opportunity(
            Id = opp.Id,
            StageName = 'Quote Sent'
        ));

        EventBus.publish(new Update_Opportunity__e(Opportunity_JSON__c = oppString));
        Test.stopTest();
    }
}