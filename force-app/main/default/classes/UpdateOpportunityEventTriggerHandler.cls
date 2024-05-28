public with sharing class UpdateOpportunityEventTriggerHandler {
    
    public static void updateOpportunities(List<Update_Opportunity__e> oppEvents){
        List<Opportunity> oppList = new List<Opportunity>();
        List<Opportunity> oppsToEmail = new List<Opportunity>();
        for(Update_Opportunity__e oppEvent : oppEvents){
            try {
                Opportunity opp = (Opportunity) JSON.deserialize(oppEvent.Opportunity_JSON__c, Opportunity.class);
                oppList.add(opp);
                if(opp.stageName == 'Quote Sent'){
                    oppsToEmail.add(opp);
                }
            } catch(Exception ex) {
                System.debug(ex.getMessage());
                continue;
            }
        }
        if(!oppsToEmail.isEmpty()){
            sendEmails(oppsToEmail);
        }
        if(!oppList.isEmpty()){
            update oppList;
        }
    }

    public static void sendEmails(List<Opportunity> oppList){
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        Set<Id> oppIds = new Map<Id, Opportunity>(oppList).keySet();
        Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>([SELECT Id, OwnerId, Owner.Email, Account.Primary_Contact__r.Email, Account.Primary_Contact__r.Id FROM Opportunity WHERE Id IN :oppIds]);
        EmailTemplate quoteTemplate = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'Quote_Sent' LIMIT 1];
        if(quoteTemplate == null) { System.debug('email template not found'); return;}
        for(Opportunity opp : oppList){
            Messaging.SingleEmailMessage mail = Messaging.renderStoredEmailTemplate(quoteTemplate.Id, opp.Id, opp.Id);
        
        
            //mail.setToAddresses(new List<String>{oppMap.get(opp.Id).Account.Primary_Contact__r.Email});
            mail.setReplyTo(oppMap.get(opp.Id).Owner.Email);
            //mail.setTemplateId(quoteTemplate.Id);
            mail.setTargetObjectId(oppMap.get(opp.Id).Account.Primary_Contact__r.Id);
            //mail.setTreatTargetObjectAsRecipient(false);
            //mail.setToAddresses(new List<String>{oppMap.get(opp.Id).Account.Primary_Contact__r.Email});
            System.debug(mail);
            emailList.add(mail);
            //mail.setSenderDisplayName('Salesforce Support');
            //mail.setSubject('Overdue Call on 1on1 Sales Appointment');
            //mail.setPlainTextBody('A TSA appointment for one of your team members was not called or rejected on time. Please reassign this appointment right away.\n Sales Specialist:'+agetsname+' \n'+'Name of Lead:  '+leadsname+'\n'+eventslink);
            
        }
        
        if(!Test.isRunningTest()){
            Messaging.SendEmailResult[] results = Messaging.sendEmail(emailList);
            for(Messaging.SendEmailResult result : results){System.debug(result);}
        }
        
    }
}