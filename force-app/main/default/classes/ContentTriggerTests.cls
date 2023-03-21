@IsTest
private class ContentTriggerTests {

    @TestSetup
    private static void createTestData()
    {
        Account act = new Account(Name='Test');
        insert act;

        Opportunity opp = new Opportunity(Name='TestOpp',AccountId=act.Id, StageName='New', CloseDate=Date.today().addDays(1));
        insert opp;
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
        System.assertEquals(cdl[0].ShareType,'I');

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
}