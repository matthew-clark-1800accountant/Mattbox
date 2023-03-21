@IsTest
private class TestActivityDelete {

    @IsTest static void testEventDelete() {

        

        //profile name == insidesalesuser - zoura
        Profile p = [SELECT Id FROM Profile WHERE Name = 'InsideSalesUser - Zuora'];
        User u = new User(Alias = 'Test', Email = 'test@example.com', EmailEncodingKey = 'UTF-8', ProfileId = p.Id,
                        TimeZoneSidKey = 'America/Los_Angeles', UserName = 'testusername123454321@example.com', LastName='Tester', LocaleSidKey='es_BO', LanguageLocaleKey='en_US');
        insert u;
        
        //insert event
        Datetime startTime = Datetime.now();
        Event e = new Event(OwnerId=u.Id,
                            StartDateTime=startTime,
                            EndDateTime=startTime.addHours(1),
                            Subject='Testing');
        insert e;

        Boolean deleted = true;

        System.runAs(u)
        {

            //delete event
            Test.startTest();
            try {
                delete e;
            } catch (DmlException ex) {
                deleted = false;
            }
            Test.stopTest();
        }

        //should not delete
        System.assertEquals(false,deleted);
    }

    @IsTest
    static void testTaskDelete(){

        
        //profile name == insidesalesuser - zoura
        Profile p = [SELECT Id FROM Profile WHERE Name = 'InsideSalesUser - Zuora'];
        User u = new User(Alias = 'Test', Email = 'test@example.com', EmailEncodingKey = 'UTF-8', ProfileId = p.Id,
                        TimeZoneSidKey = 'America/Los_Angeles', Username = 'testusername123454321@example.com', LastName='Tester', LocaleSidKey='es_BO', LanguageLocaleKey='en_US');
        insert u;
        
        //insert task
        Task t = new Task(OwnerId=u.Id,
                            Subject='Testing',
                            Status='Other',
                            Priority='Normal');
        insert t;    

        Boolean deleted = true;

        System.runAs(u)
        {
            try{
                //delete task
                Test.startTest();
                    delete t;
                Test.stopTest();
            } catch(Exception err)
            {
                System.debug(LoggingLevel.DEBUG, 'record failed to delete. Expected behavior.');
                deleted = false;
            }
        }
        System.assertEquals(false,deleted);
        
    }
}