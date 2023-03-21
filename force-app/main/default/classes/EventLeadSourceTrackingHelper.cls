/**
* Overview: Adds the Lead Source and Distribute Date to the Event from the Lead or Account   
*
* Author: Koby Campbell
* Date: June 2021
* Test: EventLeadSourceTrackingHelperTest
*/
global class EventLeadSourceTrackingHelper implements Database.Batchable<sObject> {

    public class MissingQueryException extends Exception {}

    public EventLeadSourceTrackingHelper(Integer withinDays) {
        this.withinDays = withinDays;
        this.lastNdays = 'LAST_N_DAYS:'+String.valueOf(withinDays); 
        this.setEventQuery();
        this.setEvents();
    }

    public String eventQuery;
    public void setEventQuery() { 
        this.eventQuery = 
            'SELECT Id, WhoId ' 
            +'FROM Event ' 
            +'WHERE WhoId != NULL ' 
            +'AND CreatedDate = '+this.lastNdays+' '
            +'AND Distribute_Date__c = NULL '
            +'AND Lead_Source__c = NULL '
        ;
    }

    private List<Event> events;
    public void setEvents(List<Event> events) { this.events = events; }
    public void setEvents() {
        this.events = Database.query(this.eventQuery);
    }

    //Within the last number of days for Event query
    public Integer withinDays;

    public String lastNdays;

    public Database.QueryLocator start(Database.BatchableContext context) {   
        if(null == eventQuery) {
            throw new MissingQueryException('Batch job is missing Event query');
        }
        return Database.getQueryLocator(this.eventQuery);    
    }    

    public void manualExecution() {   
        List<Id> leadIds = new List<Id>();
        List<Id> contactIds = new List<Id>();
        //Gather WhoIds to query
        for(Event e : events) {
            if(e.WhoId.getSObjectType().getDescribe().getName() == 'Lead'){
                leadIds.add(e.WhoId);
            } else {
                contactIds.add(e.WhoId);
            }
        }
        //Get the Leads
        Map<Id, Lead> leads;
        if(!leadIds.isEmpty()){
            leads = new Map<Id, Lead>([
                SELECT Id, Name, Distribute_Date__c, LeadSource
                FROM Lead
                WHERE Id IN :leadIds
            ]);
        }
        //Get the Contacts
        Map<Id, Account> accounts;
        Map<Id, Id> contactIdToAccountId;
        if(!contactIds.isEmpty()){
            List<Contact> contacts = new List<Contact>([
                SELECT Id, Name, AccountId
                FROM Contact
                WHERE Id IN :contactIds
            ]);
            //Map the contact to the primary Account
            List<Id> accountIds = new List<Id>();
            contactIdToAccountId = new Map<Id, Id>();
            for(Contact c : contacts){
                if(null != c.AccountId){
                    accountIds.add(c.AccountId);
                    contactIdToAccountId.put(c.Id, c.AccountId);
                }
            }
            //Query for the primary Account
            accounts = new Map<Id, Account>([
                SELECT Id, Name, Primary_Contact__c, Distribute_Date__c, Lead_Source__c
                FROM Account
                WHERE Id IN :accountIds
            ]);
        }

        List<Event> toUpdateEvents = new List<Event>();
        for(Event e : events) {
            if(e.WhoId.getSObjectType().getDescribe().getName() == 'Lead'){
                if(null != leads){
                    //Assign the Events with Lead WhoIds the Distribute Date and Lead Source from the Lead
                    e.Distribute_Date__c = leads.get(e.WhoId).Distribute_Date__c;
                    e.Lead_Source__c = leads.get(e.WhoId).LeadSource;
                    toUpdateEvents.add(e);
                }
            } else {                
                if(null != accounts && null != contactIdToAccountId){
                    //Assign the Events with Contact WhoIds the Distribute Date and Lead Source from the Account
                    e.Distribute_Date__c = accounts.get(contactIdToAccountId.get(e.WhoId)).Distribute_Date__c;
                    e.Lead_Source__c = accounts.get(contactIdToAccountId.get(e.WhoId)).Lead_Source__c;  
                    toUpdateEvents.add(e);
                }
            }
        }
        update toUpdateEvents;
    }
    //Reassign the Lead Owner and update
    public void execute(Database.BatchableContext context, List<Event> events) {
        this.setEvents(events);
        this.manualExecution();
    }

    public void finish(Database.BatchableContext context) {
    } 
}