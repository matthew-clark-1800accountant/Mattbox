public without sharing class FailureToCallBatchable implements Database.batchable<sObject>{

    public FailureToCallBatchable(){
        System.debug('FailureToCallBatchable.FailureToCallBatchable()');
    }

    public Database.QueryLocator start(Database.BatchableContext BC){
        Datetime startTime = Datetime.now().addHours(-25);
        Datetime endTime = Datetime.now().addHours(-1);
        List<String> appointmentTypes = new List<String>{'Tax Savings Analysis', 'Formation Consultation', 'BNA'};
        List<String> disposToIgnore = new List<String>{'Rescheduled', 'Cancelled', 'Bad Number'};
         String query = 'SELECT Id FROM Event WHERE StartDateTime >= :startTime AND StartDateTime < :endTime '
        +'AND Minute_Difference_for_Appt_Call__c = null AND Type_of_Appointment__c IN :appointmentTypes '
        +'AND Appointment_Disposition__c NOT IN :disposToIgnore AND (NOT Subject LIKE \'%Live%\')'
        +'AND (NOT (Appointment_Disposition__c = \'Consulted\' AND Secondary_Disposition_Details__c = \'Rescheduled\')) ';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<Event> scope){        
        System.debug(UserInfo.getName());
        System.debug(UserInfo.getProfileId());
        System.debug('FailureToCallBatchable.execute()');
        for(Event e : scope){
            System.debug(e);
            e.Appointment_Disposition__c = 'Failure to Call';
        }
        update scope;
    }

    public void finish(Database.BatchableContext BC){}
}