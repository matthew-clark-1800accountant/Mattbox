@IsTest
public with sharing class CreateNoteEventTriggerHandlerTest {

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

    @isTest static void testNoteCreation(){
        User u = [SELECT Id FROM User WHERE Username = 'testguy@1800accountant.com' LIMIT 1];
        String testString = 'test title '+u.Id+': test contents';
        Contact con = [SELECT Id, FirstName, LastName, AccountId FROM Contact LIMIT 1];
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Test.startTest();
        EventBus.publish(new Create_Note__e(AccountId__c=con.accountId, ContactId__c=con.Id,
            Name__c=con.FirstName+' '+con.LastName, ContactOwnerId__c=u.Id, Description__c=testString));
        Test.stopTest();
        // con.description = testString;
        // update con;
        //CreateNoteEventTriggerHandler.createNote(acc.Id, testString, name, conOwner, contactId)
        ContentVersion cn = [SELECT Id, title, VersionData, ContentDocumentId FROM ContentVersion WHERE OwnerId = :u.Id LIMIT 1];
        System.debug(cn.VersionData.toString());
        System.assert(cn.VersionData.toString().contains(testString.substringAfter(':')));
        System.assert(cn.title.contains(testString.substringBefore(':')));
    }

    @isTest static void testNoteUpdate(){
        User u = [SELECT Id FROM User WHERE Username = 'testguy@1800accountant.com' LIMIT 1];
        String testString = 'test title '+u.Id+': test contents';
        Contact con = [SELECT Id, FirstName, LastName, AccountId FROM Contact LIMIT 1];
        Account acc = [SELECT Id FROM Account LIMIT 1];
        Test.startTest();
        EventBus.publish(new Create_Note__e(AccountId__c=con.accountId, ContactId__c=con.Id,
            Name__c=con.FirstName+' '+con.LastName, ContactOwnerId__c=u.Id, Description__c=testString));
        Test.getEventBus().deliver();
        System.debug('CV Count: '+[SELECT COUNT() FROM ContentVersion WHERE OwnerId = :u.Id]);
        System.debug('existingNoteLinks.size(): '+[SELECT COUNT() FROM ContentDocumentLink WHERE LinkedEntityId = :con.accountId]);
        EventBus.publish(new Create_Note__e(AccountId__c=con.accountId, ContactId__c=con.Id,
            Name__c=con.FirstName+' '+con.LastName, ContactOwnerId__c=u.Id, Description__c='test:update'));
        Test.getEventBus().deliver();
        Test.stopTest();
        // con.description = testString;
        // update con;
        //CreateNoteEventTriggerHandler.createNote(acc.Id, testString, name, conOwner, contactId)
        ContentVersion cn = [SELECT Id, VersionData, Title, ContentDocumentId FROM ContentVersion WHERE OwnerId = :u.Id LIMIT 1 OFFSET 1];
        System.debug(cn.VersionData.toString());
        System.debug('CV Count: '+[SELECT COUNT() FROM ContentVersion WHERE OwnerId = :u.Id]);
        // System.assert(cn.VersionData.toString().contains(testString.substringAfter(':')));
        System.assert(cn.VersionData.toString().contains('update'));
        System.assert(cn.title.contains(testString.substringBefore(':')));
    }
}