public with sharing class ReassignNoShowLeadsBatchable implements Database.Batchable<sObject>, Schedulable {
    public class CustomException extends Exception {}
    public string queryString = 'SELECT Id, WhoId, Account__c FROM Event WHERE Lead_Source__c = \'1-800Accountant\' '
    +'AND Appointment_Disposition__c = \'No Show\' AND Type_of_Appointment__c =\'Tax Savings Analysis\' AND StartDateTime IN :timeslots';
    public boolean isWeekend = false;
    public ReassignNoShowLeadsBatchable() {

    }

    //execute method for schedulable interface
    public void execute(SchedulableContext context) {
        ReassignNoShowLeadsBatchable updateLeads = new ReassignNoShowLeadsBatchable();
        Database.executeBatch(updateLeads, 10);
    }

    public Database.QueryLocator start(Database.BatchableContext context) {   
        System.debug('start(): '+queryString);
        List<Datetime> timeslots = lastBusinessDays;
        System.debug(timeslots);
        System.debug(Database.query(queryString));
        return Database.getQueryLocator(queryString);
    }

    public Datetime currentTime{
        get {return roundToHalfHourTime(Datetime.now());} 
        set;
    }

    public List<Datetime> lastBusinessDays{
        get {
            Datetime today = roundToHalfHourTime(Datetime.now());
            List<Datetime> timeslots = new List<Datetime>();
            String day = today.format('EEEE');
            if(day == 'Monday'){
                timeslots.add(today.addDays(-3));
                timeslots.add(today.addDays(-2));
            } else if (day == 'Sunday' || day == 'Saturday'){
                timeslots.add(today); //just to avoid errors
                System.debug('isWeekend');
                isWeekend = true;
            } else {
                timeslots.add(today.addDays(-1));
            }
            return timeslots;
        }
        set;
    }

    //execute method for batchable interface
    public void execute(Database.BatchableContext context, List<Event> eventList) {
        //don't run on the weekend 
        if(isWeekend){
            return;
        }
        List<Id> whoIds = new List<Id>();
        List<Id> whatIds = new List<Id>();
        System.debug('execute');
        System.debug(eventList);
        for(Event ev : eventList){
            if(ev.Account__c == null){
                whoIds.add(ev.WhoId);
            } else {
                whatIds.add(ev.Account__c);
            }
        }

        system.debug(whoIds);
        system.debug(whatIds);

        //ignore records with upcoming 1on1 appointments
        List<Lead> leads = [SELECT Id FROM Lead WHERE Id IN :whoIds AND (X1_1_Scheduled__c < :currentTime OR X1_1_Scheduled__c = null )];
        //Set<Id> leadIds = new Map<Id, Lead>(leads).keySet();
        System.debug(leads);

        List<Account> accounts = [SELECT Id FROM Account WHERE Id IN :whatIds AND (X1_1_Scheduled__c < :currentTime OR X1_1_Scheduled__c = null )];
        //Set<Id> accountIds = new Map<Id, Lead>(accounts).keySet();
        System.debug(accounts);

        List<User> generalLeadQueue = [SELECT Id FROM User WHERE Name = 'General Lead Queue' LIMIT 1];
        if(generalLeadQueue.size() == 0){
            throw new CustomException('General Lead Queue not found');
        } else {
            for(Lead l : leads){
                l.OwnerId = generalLeadQueue[0].Id;
                l.Date_For_Reassignment__c = null;
                System.debug(l);
            } 
            for(Account a : accounts){
                a.OwnerId = generalLeadQueue[0].Id;
                a.Date_For_Reassignment__c = null;
                System.debug(a);
            }

            System.Savepoint sp = Database.setSavepoint();
            try{
                update leads;
                update accounts;
            } catch (Exception ex){
                Database.rollback(sp);
                throw new CustomException('Error while updating records: '+ex.getMessage());
            }            
        } 
    }

    public void finish(Database.BatchableContext context) {
        System.debug('finish');
    }

    public static Datetime roundToHalfHourTime(Datetime dt){
        if(dt.minute() < 30){
            dt = dt.addMinutes(-dt.minute());
        } else {
            dt = dt.addMinutes(30-dt.minute());
        }
        //round to 0 seconds
        return Datetime.newInstance(dt.getTime()/100000*100000);
    }
}