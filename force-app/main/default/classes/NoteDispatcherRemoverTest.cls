/**
 * Created by SReyes on 8/3/2020.
 */
@IsTest
public with sharing class NoteDispatcherRemoverTest
{

    @TestSetup
    private static void createData()
    {
        Account act = new Account(Name='Test');
        insert act;

        Note nt = new Note(Title='Test',Body='TestBody',ParentId=act.Id);
        insert nt;

        NoteDispatcher__c ndc = [SELECT Id FROM NoteDispatcher__c LIMIT 1];
        Test.setCreatedDate(ndc.Id,System.now().addDays(-10));
        update ndc;
    }

    @IsTest
    private static void testBatch()
    {
        NoteDispatcher__c toDelete = [SELECT Id FROM NoteDispatcher__c LIMIT 1];
        System.debug('toDelete :: ' + toDelete);

        Test.startTest();
            NoteDispatcherRemoverBatch.execute(null);
        Test.stopTest();

        NoteDispatcher__c gone;
        for(NoteDispatcher__c nd : [SELECT Id FROM NoteDispatcher__c WHERE Id = :toDelete.Id])
        {
            gone = nd;
        }
        System.assertEquals(null, gone);

    }
}