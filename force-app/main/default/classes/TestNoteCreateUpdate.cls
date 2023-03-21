@IsTest
private class TestNoteCreateUpdate
{
    @IsTest
    static void testCreateNote()
    {
    	Account acc= new Account(Name = 'Acme');
        Test.startTest();        
    	insert acc;        
    	Note nte = new Note(Title = 'Test', ParentId = acc.Id);
        insert nte;
        Test.stopTest();

        NoteDispatcher__c disp = [SELECT Id, NoteID__c  FROM NoteDispatcher__c WHERE NoteID__c = :nte.Id];
    }
}