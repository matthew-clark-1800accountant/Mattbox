/**
* Author: Koby Campbell
* Date: July 2021
* Test: EventPostTsaEmailBatchTest
*/
global class EventPostTsaEmailBatch implements Database.Batchable<sObject>, Schedulable {
    
    public EventPostTsaEmailBatch() { 
        this.aTimeAgo = Date.Today().addDays(-2);
        setQueryString();
    }
    private Date aTimeAgo;
    private String eventQuery;
    private void setQueryString(){   
        this.eventQuery = 
            'SELECT Id, WhatId, Subject, Type_of_Appointment__c, Appointment_Disposition__c, Secondary_Disposition_Details__c,  ' 
            +'TYPEOF What ' 
            +'WHEN Opportunity '
            +'THEN ChargeOver_Quote_URL__c, Post_TSA_Link__c, AccountId, Account.Potential_Total_Savings__c, Account.Current_Year_Profit_Projection__c, Account.Primary_Contact__c, Account.Id, Account.Primary_Contact_Email__c, Account.Owner.Email, Account.Owner.Name ' 
            +'END ' 
            +'FROM Event ' 
            +'WHERE DAY_ONLY(StartDateTime) = :aTimeAgo '
            +'AND What.Type = \'Opportunity\' ' 
            +'AND Secondary_Disposition_Details__c != \'Sale\' '
            +'AND Secondary_Disposition_Details__c != \'Cancelled\' ' 
            +'AND Subject LIKE \'%1on1%\' ' 
            +'AND Type_of_Appointment__c = \'Tax Savings Analysis\' '
            +'AND Appointment_Disposition__c = \'Consulted\' ' 
        ;
    }
 
    private List<Event> events;
    public void setEvents(List<Event> events) { this.events = events; }
    public void setEvents() {
        this.events = Database.query(this.eventQuery);
    }

    //Execute with a batch size of 1
    public void execute(SchedulableContext context) {
        EventPostTsaEmailBatch sendPostTsaEmail = new EventPostTsaEmailBatch();
        Database.executeBatch(sendPostTsaEmail, 1);
    }

    public Database.QueryLocator start(Database.BatchableContext context) {   

        return Database.getQueryLocator(this.eventQuery);    
    }    

    public void execute(Database.BatchableContext context, List<Event> events) {
        this.setEvents(events);
        this.manualExecution();
    }

    public void manualExecution() {   
        EmailTemplate emailTemplate = [
            SELECT Id, Subject, Description, HtmlValue, DeveloperName, Body 
            FROM EmailTemplate 
            WHERE name = 'Tax savings breakdown'
        ];

        List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
        for(Event e : events){
            //Get the Opportunity associated to the Event
            Opportunity o = e.What;
            //As long as we have a quote, potential savings, and a profit projection, send the email
            if(null != o.ChargeOver_Quote_URL__c &&
            null != o.Account.Potential_Total_Savings__c &&
            '$0' != o.Account.Potential_Total_Savings__c &&
            null != o.Account.Current_Year_Profit_Projection__c &&
            '0' != o.Account.Current_Year_Profit_Projection__c &&
            null == o.Post_TSA_Link__c){
                //Related to the Event's Opportunity's Account's Contact
                Messaging.SingleEmailMessage message = Messaging.renderStoredEmailTemplate(emailTemplate.Id, o.Account.Primary_Contact__c, o.Account.Id);
                //Replace the part of the link with the Event Id
                message.setHtmlBody(message.getHtmlBody().replace('eventIdFromCustomer', e.Id));
                //Have to set the subject manually because the body is
                message.setSubject('Thanks again! Tax savings breakdown');
                message.toAddresses = new String[] { o.Account.Primary_Contact_Email__c};
                message.optOutPolicy = 'FILTER';
                //If owned by a queue or null, give default values
                if('General Lead Queue' == o.Account.Owner.Name
                || 'Dead Leads Queue' == o.Account.Owner.Name
                || null == o.Account.Owner.Name){
                    message.setSenderDisplayName('Taylor Covey');
                    message.setReplyTo('1on1@1800accountant.com');
                    message.setHtmlBody(message.getHtmlBody().replace('General Lead Queue', 'Taylor Covey'));
                } else {
                    message.setSenderDisplayName(o.Account.Owner.Name);
                    message.setReplyTo(o.Account.Owner.Email);
                }
                //Send email and save Link to the Opportunity
                if(!Test.isRunningTest()){
                    Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{message});
                }
                o.Post_TSA_Link__c = 'https://1800accountant.secure.force.com/PostTSA1/?id='+e.Id;
                opportunitiesToUpdate.add(o);
            }
        }
        if(!opportunitiesToUpdate.isEmpty()){
            update opportunitiesToUpdate;
        }
    }


    public void finish(Database.BatchableContext context) {

        
    } 
}