@isTest
public without sharing class FailureToCallBatchableTest {
    public static Integer numberOfRecords = 10;

    @TestSetup
    static void makeData(){
        Contact whoContact = new Contact(LastName='last', FirstName='first');
        insert whoContact;
        
        List<Event> events = new List<Event>();
        for(integer i = 0; i < numberOfRecords; i++){
           events.add(new Event(
                StartDateTime = Datetime.now().addHours(-i),
                EndDateTIme = Datetime.now().addHours(-i).addMinutes(30),
                Subject = 'Tax Consultation',
                WhoId = whoContact.Id,
                Type_of_Appointment__c = 'BNA'
            ));
            System.debug(events[i]);
        }
        insert events;

        NVMContactWorld__InteractionEvent__c interaction = new NVMContactWorld__InteractionEvent__c(
            NVMContactWorld__Who__c = whoContact.Id,
            NVMContactWorld__Type__c = 'Deliver',
            NVMContactWorld__TimeStamp__c = Datetime.now(),
            NVMContactWorld__IndexedCallObjectIdentifier__c = '12345'
        );
        insert interaction;
        Test.setCreatedDate(interaction.Id, DateTime.now().addHours(-5));
        InteractionEventTriggerHandler.afterUpdate(null, new List<NVMContactWorld__InteractionEvent__c>{interaction});
    }

    @isTest
    public static void testBatch(){
        Test.startTest();
        FailureToCallBatchable batch = new FailureToCallBatchable();
        Database.executeBatch(batch);
        Test.stopTest();
        Integer failures = [SELECT COUNT() FROM Event WHERE Appointment_Disposition__c = 'Failure to Call'];
        //two records should be outside the timerange, and one record should match the interaction event
        System.assertEquals(numberOfRecords-2, failures);
    }

    @isTest
    public static void testScheduled(){
        System.debug('testScheduled()');
        Datetime curTime = Datetime.now();
        String CRON_EXP = '0 0 0 3 9 ? 2042';
        //String CRON_EXP = '0 {0} {1} {2} {3} ? {4}';
        //CRON_EXP = String.format(CRON_EXP, new List<String>{String.valueOf(curTime.addMinutes(5).minute()), String.valueOf(curTime.addHours(-5).hour()), String.valueOf(curTime.day()), String.valueOf(curTime.month()), String.valueOf(curTime.year())});
        System.debug(CRON_EXP);
        Test.startTest();
        String jobId = System.schedule('testFailureToCallScheduled', CRON_EXP, new FailureToCallScheduled());
        // Get the information from the CronTrigger API object
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
        NextFireTime
        FROM CronTrigger WHERE id = :jobId];

        // Verify the expressions are the same
        System.assertEquals(CRON_EXP, 
            ct.CronExpression);

        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered);

        // Verify the next time the job will run
        System.assert(ct.NextFireTime != null);
        System.debug(ct);
        Test.stopTest();
    }
}