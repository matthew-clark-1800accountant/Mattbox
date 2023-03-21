/**
 * Created by SReyes on 8/12/2020.
 */
@IsTest
private with sharing class OpportunityTriggerHandlerTest
{
    @TestSetup
    private static void testSetup()
    {
        Account act = new Account(Name='OppTriggerAct', Lead_Source__c='ZenBusiness');
        insert act;
        Contact con = new Contact(AccountId=act.Id,LastName='OppDude',FirstName='The',Email='opp@dude.com');
        insert con;
        Opportunity opp = new Opportunity(Name='TestOppTriggerSetup',StageName='New',AccountId=act.Id,CloseDate=Date.today().addDays(2));
        insert opp;

        //At this point Salesforce will recognize there is not a primary contact for the account and will
        //automatically relate them to one another. We can move on our test method.
    }

    @IsTest
    private static void relatePrimaryContactTest()
    {
        Id actId = [SELECT Id FROM Account LIMIT 1].Id;
        Opportunity opp = new Opportunity(Name='TestOppTrigger',StageName='New',AccountId=actId,CloseDate=Date.today().addDays(2));
        insert opp;

        OpportunityContactRole primaryRoleExists = [SELECT Id FROM OpportunityContactRole WHERE OpportunityId = :opp.Id AND IsPrimary = TRUE LIMIT 1];
        System.assertNotEquals(null,primaryRoleExists,'Should have returned a role that was created because it was missing at opp creation.');
    }

    @IsTest
    private static void populateLeadSourceTest()
    {
        Id actId = [SELECT Id FROM Account LIMIT 1].Id;
        Opportunity opp = new Opportunity(Name='TestOppTrigger',StageName='New',AccountId=actId,CloseDate=Date.today().addDays(2));
        insert opp;
        opp = [SELECT LeadSource FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals('ZenBusiness', opp.LeadSource);
    }
}