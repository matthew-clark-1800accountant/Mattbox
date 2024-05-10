@IsTest
private class ContentTriggerTests {

    @TestSetup
    private static void createTestData()
    {
        Account act = new Account(Name='Test');
        insert act;

        Opportunity opp = new Opportunity(Name='TestOpp',AccountId=act.Id, StageName='New', CloseDate=Date.today().addDays(1));
        insert opp;

        Contact con = new Contact(FirstName='Test', LastName='Contact', AccountId = act.Id);
        insert con;
    }

    @IsTest
    private static void contentVersionTest()
    {
        Test.startTest();

        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        ContentVersion cd = new ContentVersion(FirstPublishLocationId=opp.Id,Title='TestContentVersion',PathOnClient='test.snote',IsMajorVersion=true,VersionData=Blob.valueOf('TestNote'));
        insert cd;
        System.debug('cd :: ' + cd);

        Account act = [SELECT Id FROM Account LIMIT 1];
        ContentDocumentLink[] cdl = [SELECT Id, Visibility, ShareType, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :opp.Id OR LinkedEntityId =: act.Id LIMIT 2];
        System.debug('cdl :: ' + cdl);

        Test.stopTest();

        System.assertEquals(2, cdl.size());
        System.assertEquals(cdl[0].Visibility,'AllUsers');
        //System.assertEquals(cdl[0].ShareType,'I');

    }

    @IsTest
    private static void contentVersionTestContact()
    {
        Account act = [SELECT Id FROM Account LIMIT 1];
        Contact cont = new Contact(FirstName='Test',LastName='Type',Email='test@test.com.do',AccountId=act.Id);
        insert cont;

        ContentVersion cd = new ContentVersion(FirstPublishLocationId=cont.Id,Title='TestContentVersion',PathOnClient='test.snote',IsMajorVersion=true,VersionData=Blob.valueOf('TestNote'));
        insert cd;
        System.debug('cd :: ' + cd);

        Test.startTest();
        System.debug('beginning update test');
            cd.Title = 'UpdatedTest';
            update cd;
        Test.stopTest();

        ContentDocumentLink[] cdl = [SELECT Id,ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :cont.Id OR LinkedEntityId =: act.Id LIMIT 2];
        System.debug('cdl :: ' + cdl);

        System.assertEquals(2, cdl.size());

    }

    @IsTest
    private static void testContactNote(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        User u = new User(Username = 'testguy@1800accountant.com', LastName='Beebop', Email='testguy@1800accountant.com', Alias = 'newUser', 
        EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US', LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles');
        insert u; //needed to filter since all content notes are visible to tests
        Test.startTest();
        Opportunity opp =[SELECT Id FROM Opportunity LIMIT 1];
        opp.OwnerId = u.Id;
        update opp;

        Contact con = [SELECT Id, OwnerId FROM Contact LIMIT 1];
        con.OwnerId = u.Id;
        update con;

        String testString = 'test description'+u.Id;
        System.runAs(u){            
            con.Description = testString;
            con.FirstName = 'New';
            update con;
        }        
        Test.stopTest();
        
        // ContentNote cn = [SELECT Id, Content FROM ContentNote WHERE OwnerId = :u.Id LIMIT 1];
        // System.debug(cn.Content.toString());
        // System.assert(cn.Content.toString().contains(testString));
        // ContentVersion cn = [SELECT Id, VersionData, ContentDocumentId FROM ContentVersion WHERE OwnerId = :con.OwnerId LIMIT 1];
        // System.debug(cn.VersionData.toString());
        // System.assert(cn.VersionData.toString().contains(testString));

        // for(ContentDocumentLink cdl : [select id, LinkedEntity.name, LinkedEntity.type from contentdocumentlink where contentdocumentid = :cn.id]){
        //     System.debug(cdl.LinkedEntity.type+' '+cdl.LinkedEntity.name);
        // }
        // Integer linkCount = [SELECT COUNT() FROM ContentDocumentLink WHERE ContentDocumentId = :cn.ContentDocumentId];
        // System.assertEquals(4, linkCount);
    }
}