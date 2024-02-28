public class LaunchGuidedSellingInvocable {
    public class NoEmailTemplateFoundException extends Exception {}
    public class NoPrimaryContactException extends Exception {}
    public class ConvertedLeadException extends Exception {}
    public class WrongRecordIdException extends Exception {}
    public class WebSocketApiKeyException extends Exception {}
    public class WebSocketException extends Exception {}
    public class errorCreatingBusinessException extends Exception {}
    public class errorQuoteExistException extends Exception {}

    // public class NoTSAEventFoundException extends Exception {}
    public static String noEmailTemplateFound = 'No Classic Email Template found with the Name Guided Selling Client Link. Please check and try again';
    public static String wrongRecordId = 'Missing required Id of type Lead, Account, or Opportunity. Please make sure the Event is related to one of those.';
    public static String convertedLead = 'Error Converting Lead:';
    public static String noApiKeyError = 'Could not find metadata type with the label Web Socket API Key. Please check and try again.';
    public static String webSocketError = 'There was a problem generating your live web socket session. Please contact your administrator with these details: ';
    public static String errorCreatingBusiness = 'There was a problem creating a business and business owner for the client. ';
    public static String errorQuoteExist = 'There is a Quote already created for the Opportunity. Please, go to the calculator on Update Quote link. ';

    // public static String noTSAEventFound = 'There was no TSA Event scheduled for today related to this object. Please check and try again.';
    public String controllerToken;
    public String presentationToken;
    public String sessionId;

    public static String environmentName{
        get {
            String name = System.DomainParser.parse(URL.getOrgDomainUrl()).getSandboxName();
            if(name == null){
                return 'production';
            } else {
                return name;
            }
        }
    }

    public class SessionKeyApiResponse {
        public String session_id;
        public String controller_token;
        public String presentation_token;
        public String channel_id;
    }
    public LaunchGuidedSellingInvocable() {

    }
    public void getSessionTokens() {
        Web_Socket_API_Key__mdt getApiKeys;
        String mdtName;
        if(environmentName == 'production'){ mdtName = 'Web_Socket_API_Key_Prod'; } else if (environmentName == 'staging'){ mdtName = 'Web_Socket_API_Key_Staging'; } else { mdtName = 'Web_Socket_API_Key_UAT'; }
        try { getApiKeys = [SELECT Label, API_Key__c, Endpoint__c FROM Web_Socket_API_Key__mdt WHERE DeveloperName = :mdtName];
        } catch(Exception e) { throw new WebSocketApiKeyException(noApiKeyError); }

        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(getApiKeys.Endpoint__c);
        req.setHeader('Api-Key', getApiKeys.API_Key__c);
        Http http = new Http();
        HttpResponse resp = http.send(req);
        if(resp.getStatusCode() != 200) { throw new WebSocketException(webSocketError + resp.getStatus() + ' ' + resp.getBody()); }
        SessionKeyApiResponse keys = (SessionKeyApiResponse)JSON.deserialize(resp.getBody(), SessionKeyApiResponse.Class);
        this.controllerToken = keys.controller_token;
        this.presentationToken = keys.presentation_token;
        this.sessionId = keys.session_id;
    }  

    public static String schedulerURL{
        get {
            return GuidedSellingControllerExtension.getschedulerBaseUrl();
        }
    }

    @InvocableMethod(label='Launch Guided Selling' description='Launch Guided Selling')
    public static List<JobResponses> launchGuidedSelling (List<Requests> requestList) {
        
        List<JobResponses> responses = new List<JobResponses>();
        
        //Getting the email template needed to send the client their link
        EmailTemplate emailTemplate = new EmailTemplate();
        if('Send Email' == requestList[0].action) {
            try {
                emailTemplate = [SELECT Id, Subject, Description, HtmlValue, DeveloperName, Body FROM EmailTemplate WHERE Name = 'Guided Selling Client Link'];
            } catch (Exception e) {
                throw new NoEmailTemplateFoundException(noEmailTemplateFound);
            }
        }

        //Null check on recordId
        if('' == requestList[0].recordId || null == requestList[0].recordId) {
            throw new WrongRecordIdException('Missing record Id');
        }

        //Identifying the record Id coming in from the flow. The four Id types accepted: Event, Account, Lead, Opportunity
        String recordIdType = Id.valueOf(requestList[0].recordId).getSObjectType().getDescribe().getName(); 
        Id eventId = ('Event' == recordIdType) ? requestList[0].recordId : null;
        Id leadId = ('Lead' == recordIdType) ? requestList[0].recordId : null;
        Id accountId = ('Account' == recordIdType) ? requestList[0].recordId : null;
        Id opportunityId = ('Opportunity' == recordIdType) ? requestList[0].recordId : null;

        system.debug('recordIdType: ' + recordIdType);
        system.debug('eventId: ' + eventId);
        system.debug('leadId: ' + leadId);
        system.debug('accountId: ' + accountId);
        system.debug('opportunityId: ' + opportunityId);

        //They need to have a TSA Event to launch the process
        Event eventValidation;
        String userId = UserInfo.getUserId();
        String userNameUrl = UserInfo.getFirstName() + '+' + UserInfo.getLastName();

        //If the record Id is an Event, gather either an Account, Lead, or Opportunity Id
        if(null != eventId) {
            
            Event event = [SELECT Id, WhatId, WhoId FROM Event WHERE Id = :requestList[0].recordId];
            
            //Getting either a Lead, Account, or Opportunity from the Event
            if(null != event.WhoId && 'Lead' == event.WhoId.getSObjectType().getDescribe().getName()) {
                leadId = event.WhoId;
            }
            if(null != event.WhatId && 'Account' == event.WhatId.getSObjectType().getDescribe().getName()) {
                accountId = event.WhatId;
            }
            if(null != event.WhatId && 'Opportunity' == event.WhatId.getSObjectType().getDescribe().getName()) {
                opportunityId = event.WhatId;
            }
        }

        //If at this point I don't have a Lead, Account or Opportunity Id, throw an error
        if(null == leadId && null == accountId && null == opportunityId) {
            throw new WrongRecordIdException(wrongRecordId);
        }

        if('Create business and business owner' == requestList[0].action) {
            Id findAccountId;

            if(null != leadId) {
                Lead getlead = [SELECT Id, Name, ConvertedAccountId FROM Lead WHERE Id = :leadId];
                findAccountId = getlead.ConvertedAccountId;
            }

            if(null != accountId) {
                findAccountId = accountId;
            }

            if(null != opportunityId) {
                Opportunity getOpportunity = [SELECT Id, Name, AccountId FROM Opportunity WHERE Id = :opportunityId];
                findAccountId = getOpportunity.AccountId;
            }

            if(null == findAccountId) {
                throw new errorCreatingBusinessException(errorCreatingBusiness);
            }

            Account getAccount = ([
                SELECT Id, Name, Primary_Contact_First_Name__c, Primary_Contact_Last_Name__c, Primary_Contact__r.Phone, Primary_Contact__r.Email, Expected_1st_year_revenue__c,
                Industry, Entity_Tax_Classification__c, Number_of_Owners__c, Total_Startup_Costs__c, Owned_Business_Before_new__c, Interested_in_obtaining_funding__c
                FROM Account 
                WHERE Id = :findAccountId
            ]);

            List<Business__c> checkForBusiness = new List<Business__c>([ SELECT Id, Name FROM Business__c WHERE Account__c = :getAccount.Id]);

            if(checkForBusiness.isEmpty()) {
                Business__c toInsertBusiness = new Business__c(
                    Name = getAccount.Name,
                    Account__c = getAccount.Id,
                    Anticipated_Revenue__c = getAccount.Expected_1st_year_revenue__c,
                    Industry__c = getAccount.Industry,
                    Business_Type__c = getAccount.Entity_Tax_Classification__c,
                    Number_of_Owners__c = getAccount.Number_of_Owners__c,
                    Startup_Costs__c = getAccount.Total_Startup_Costs__c,
                    First_Business__c = (getAccount.Owned_Business_Before_new__c == 'Yes') ? true : false
                );

                insert toInsertBusiness;

                String fName = getAccount.Primary_Contact_First_Name__c; 
                String lName = getAccount.Primary_Contact_Last_Name__c; 
                String fiName = fName.replace('"','');
                String laName = lName.replace('"','');
                String firstName = fiName.replace('\'','');
                String lastName = laName.replace('\'','');

                List<Contact> checkForContacts = new List<Contact>();

                if(getAccount.Primary_Contact__r.Email != null && getAccount.Primary_Contact__r.Phone != null && getAccount.Primary_Contact__r.Email != '' && getAccount.Primary_Contact__r.Phone != '') {
                    checkForContacts = [
                        SELECT Id, Name, FirstName, LastName, Email, Phone FROM Contact WHERE Email = :getAccount.Primary_Contact__r.Email OR Phone = :getAccount.Primary_Contact__r.Phone
                    ];
                } else {
                    checkForContacts = [
                        SELECT Id, Name, FirstName, LastName, Email, Phone FROM Contact WHERE Email = :getAccount.Primary_Contact__r.Email
                    ];
                }

                Id existingContactId;
                if(!checkForContacts.isEmpty()) {
                    existingContactId = checkForContacts[0].Id;
                }

                Business_Owner__c toInsertBusinessContact = new Business_Owner__c(
                    Name = firstName + ' ' + lastName,
                    First_Name__c = firstName,
                    Last_Name__c = lastName,
                    Phone__c = getAccount.Primary_Contact__r.Phone,
                    Email__c = getAccount.Primary_Contact__r.Email,
                    Business__c = toInsertBusiness.Id,
                    Primary_Contact__c = true,
                    Partner_Role__c = 'Primary Contact',
                    Contact__c = existingContactId
                );
                
                insert toInsertBusinessContact;
            }
        } else {

            //Create the Session Id for the Web Socket if it is not created & passed through with the request
            String sessionId;
            String controllerToken;
            String presentationToken;

            if(null == requestList[0].sessionId) {
                LaunchGuidedSellingInvocable gsEx = new LaunchGuidedSellingInvocable();
                gsEx.getSessionTokens();
                controllerToken = gsEx.controllerToken;
                presentationToken = gsEx.presentationToken;
                sessionId = gsEx.sessionId;
            } else {
                sessionId = requestList[0].sessionId;
                controllerToken = requestList[0].controllerToken;
                presentationToken = requestList[0].presentationToken;
            }

            //If there is a lead id
            if(null != leadId) {
                Boolean hasEvent = true;
                if('Send Email' != requestList[0].action) { 
                    try{
                        if(eventId != null) {
                            eventValidation = [SELECT Id, StartDateTime FROM Event WHERE StartDateTime = TODAY AND Type_of_Appointment__c = 'Tax Savings Analysis' AND WhoId = :leadId AND Id = :eventId];
                        } else {
                            eventValidation = [SELECT Id, StartDateTime FROM Event WHERE StartDateTime = TODAY AND Type_of_Appointment__c = 'Tax Savings Analysis' AND WhoId = :leadId];
                        }
                    } catch(Exception e) {
                        hasEvent = false;
                    }
                }

                //Query the Lead
                Lead lead = [SELECT Id, Name, VR_Override__c, Entity_Type__c, Company, LeadSource, Email, Owner.Name, Owner.Email, Pitched__c FROM Lead WHERE Id = :leadId];
                lead.OwnerId = userId;
                lead.Pitched__c = UserInfo.getName();
                lead.VR_Override__c = !lead.VR_Override__c;
                update lead; 

                //Record the primary email address & session id
                JobResponses emailMessageResponse = new JobResponses();
                emailMessageResponse.primaryEmail = lead.Email;
                emailMessageResponse.sessionId = sessionId;
                emailMessageResponse.controllerToken = controllerToken;
                emailMessageResponse.presentationToken = presentationToken;
                
                //If this object does not have an appointment scheduled, add the scheduler url to the response
                System.debug('leadId: ' + hasEvent);
                if(!hasEvent) {
                    emailMessageResponse.schedulerUrl = schedulerURL+'?TID=1on1&WID=' +lead.Id+ '&Setter=' +userNameUrl+ '&SetterID='+userId;
                } else {
                    emailMessageResponse.schedulerUrl = 'None';
                }
                
                //If we are sending the email (in the second part of the flow)
                if('Send Email' == requestList[0].action) {
                    
                    //Create the message with the Guided Selling email template
                    Messaging.SingleEmailMessage message = Messaging.renderStoredEmailTemplate(emailTemplate.Id, lead.Id, null);
                    message.setTemplateId(emailTemplate.Id);
                    message.setTargetObjectId(lead.Id);
                    message.setSubject('Your Tax Savings Analysis Guided Presentation Link');
                    message.setSenderDisplayName(lead.Owner.Name);
                    message.setReplyTo(lead.Owner.Email);
                    
                    //Replace the link variable in the email with the session id
                    message.setHtmlBody(message.getHtmlBody().replace('sessionId', String.valueOf(requestList[0].sessionId)).replace('recordId', requestList[0].recordId).replace('finalToken', presentationToken));
                    
                    //If the user input additional email addresses, cc them in the message
                    if('' != requestList[0].emailAddresses) {
                        List<String> toAddresses = requestList[0].emailAddresses.split(',');
                        message.setCcAddresses(toAddresses);   
                    }
                    
                    //Sending the email message and recording the response
                    try {
                        if(!Test.isRunningTest()){
                            Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{message});
                        }                        
                        emailMessageResponse.sessionId = sessionId;
                        emailMessageResponse.response = 'An email message with the client link to the Tax Savings Analysis Presentation has been successfully sent to ' + lead.Email;
                        if('' != requestList[0].emailAddresses) {
                            emailMessageResponse.response += ', '+requestList[0].emailAddresses;
                        }
                    } catch(Exception e) {
                        emailMessageResponse.response = e.getMessage() + e.getStackTraceString();
                    }
                }

                if(hasEvent) {
                    //Converting the Lead before launching Guided Selling for security reasons - converting Leads is not allowed on public sites
                    try {
                        Database.LeadConvert lc = new Database.LeadConvert();
                        lc.setLeadId(leadId);
                        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
                        lc.setConvertedStatus(convertStatus.MasterLabel);
                        Database.LeadConvertResult lcr = Database.convertLead(lc);
                    } catch(Exception e) {
                        throw new ConvertedLeadException(convertedLead + e.getMessage() + e.getStackTraceString());
                    }
                }

                responses.add(emailMessageResponse);            
            }

            //If there is an account id
            if(null != accountId) {
                
                // toUpdateAccountId = accountId;
                Boolean hasEvent = true;
                if('Send Email' != requestList[0].action) { 
                    try {
                        if(eventId != null) {
                            eventValidation = [SELECT Id, StartDateTime FROM Event WHERE StartDateTime = TODAY AND Type_of_Appointment__c = 'Tax Savings Analysis' AND WhatId = :accountId AND Id = :eventId];
                        } else {
                            eventValidation = [SELECT Id, StartDateTime FROM Event WHERE StartDateTime = TODAY AND Type_of_Appointment__c = 'Tax Savings Analysis' AND WhatId = :accountId];
                        }
                    } catch(Exception e) {
                        hasEvent = false;
                    }
                }

                Account account = [
                    SELECT Id, Name, VR_Override__c, Entity_Type_After_Discovery_Call__c, Entity_Tax_Classification__c, Business_Name__c, Lead_Source__c, Primary_Contact__r.Email, Owner.Name, Owner.Email, Pitched__c
                    FROM Account
                    WHERE Id = :accountId
                ];

                //If the account does not have a primary contact relationship, throw an error
                if(null == account.Primary_Contact__r.Id) {
                    throw new NoPrimaryContactException('The Account does not have a Primary Contact associated. Please check and try again.');
                }

                account.OwnerId = userId;
                account.Pitched__c = UserInfo.getName();
                account.VR_Override__c = !account.VR_Override__c;
                update account;

                //Record the primary email address & session id
                JobResponses emailMessageResponse = new JobResponses();
                emailMessageResponse.primaryEmail = account.Primary_Contact__r.Email;
                emailMessageResponse.sessionId = sessionId;
                emailMessageResponse.controllerToken = controllerToken;
                emailMessageResponse.presentationToken = presentationToken;

                //If this object does not have an appointment scheduled, add the scheduler url to the response
                System.debug('accountId: ' + hasEvent);
                if(!hasEvent) {
                    emailMessageResponse.schedulerUrl = schedulerURL+'?TID=1on1&WID=' +account.Primary_Contact__r.Id+ '&Setter=' +userNameUrl+ '&SetterID='+userId;
                } else {
                    emailMessageResponse.schedulerUrl = 'None';
                }

                //If we are sending the email (in the second part of the flow)
                if('Send Email' == requestList[0].action) {
                    Messaging.SingleEmailMessage message = Messaging.renderStoredEmailTemplate(emailTemplate.Id, account.Primary_Contact__c, account.Id);
                    message.setTemplateId(emailTemplate.Id);
                    message.setTargetObjectId(account.Primary_Contact__r.Id);
                    message.setSubject('Your Tax Savings Analysis Guided Presentation Link');
                    message.setSenderDisplayName(account.Owner.Name);
                    message.setReplyTo(account.Owner.Email);

                    //Replace the link variable in the email with the session id
                    message.setHtmlBody(message.getHtmlBody().replace('sessionId', String.valueOf(sessionId)).replace('recordId', requestList[0].recordId).replace('finalToken', presentationToken));
                    
                    //If the user input additional email addresses, cc them in the message
                    if('' != requestList[0].emailAddresses) {
                        List<String> toAddresses = requestList[0].emailAddresses.split(',');
                        message.setCcAddresses(toAddresses);    
                    }

                    //Sending the email message and recording the response
                    try {
                        if(!Test.isRunningTest()){
                            Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{message});
                        }                          emailMessageResponse.response = 'An email message with the client link to the Tax Savings Analysis Presentation has been successfully sent to '+account.Primary_Contact__r.Email;
                        if('' != requestList[0].emailAddresses) {
                            emailMessageResponse.response += ', '+requestList[0].emailAddresses;
                        }
                    } catch(Exception e) {
                        emailMessageResponse.response = e.getMessage();
                    }
                }
                responses.add(emailMessageResponse);
            }

            //If there is an opportunity id
            if(null != opportunityId) {

                List<Quote> quoteList = new List<Quote>([SELECT Id, Name FROM Quote WHERE OpportunityId = :opportunityId]);
                if(quoteList.size() > 0 && !Test.isRunningTest()) {
                    throw new errorQuoteExistException(errorQuoteExist);
                }

                Boolean hasEvent = true;

                if('Send Email' != requestList[0].action) { 
                    try {
                        if(eventId != null) {
                            eventValidation = [SELECT Id, StartDateTime FROM Event WHERE StartDateTime = TODAY AND Type_of_Appointment__c = 'Tax Savings Analysis' AND WhatId = :opportunityId AND Id = :eventId];
                        } else {
                            eventValidation = [SELECT Id, StartDateTime FROM Event WHERE StartDateTime = TODAY AND Type_of_Appointment__c = 'Tax Savings Analysis' AND WhatId = :opportunityId];
                        }
                    } catch(Exception e) {
                        hasEvent = false;
                    }
                }

                Opportunity opportunity = [
                    SELECT Id, Name, Account.Primary_Contact_Email__c, Account.Primary_Contact__c, Account.Owner.Name, Account.Owner.Email, AccountId, OwnerId
                    FROM Opportunity
                    WHERE Id = :opportunityId
                ];

                //If the account does not have a primary contact relationship, throw an error
                if(null == opportunity.Account.Primary_Contact_Email__c) {
                    throw new NoPrimaryContactException('The Account does not have a Primary Contact associated. Please check and try again.');
                }

                opportunity.OwnerId = userId;
                update opportunity;

                Account updateTheAccount = [
                    SELECT Id, Name, Entity_Tax_Classification__c, Pitched__c, VR_Override__c
                    FROM Account WHERE Id = :opportunity.AccountId
                ];
                updateTheAccount.OwnerId = userId;
                updateTheAccount.Pitched__c = UserInfo.getName();
                updateTheAccount.VR_Override__c = !updateTheAccount.VR_Override__c;
                update updateTheAccount;

                //Record the primary email address & session id
                JobResponses emailMessageResponse = new JobResponses();
                emailMessageResponse.primaryEmail = opportunity.Account.Primary_Contact_Email__c;
                emailMessageResponse.sessionId = sessionId;
                emailMessageResponse.controllerToken = controllerToken;
                emailMessageResponse.presentationToken = presentationToken;
                System.debug('opportunityId: ' + hasEvent);

                //If this object does not have an appointment scheduled, add the scheduler url to the response
                if(!hasEvent) {
                    emailMessageResponse.schedulerUrl = schedulerURL+'?TID=1on1&WID=' +opportunity.Account.Primary_Contact__c+ '&Setter=' +userNameUrl+ '&SetterID='+userId;
                } else {
                    emailMessageResponse.schedulerUrl = 'None';
                }
                
                //If we are sending the email (in the second part of the flow)
                if('Send Email' == requestList[0].action) {
                    Messaging.SingleEmailMessage message = Messaging.renderStoredEmailTemplate(emailTemplate.Id, opportunity.Account.Primary_Contact__c, opportunity.AccountId);
                    message.setTemplateId(emailTemplate.Id);
                    message.setTargetObjectId(opportunity.Account.Primary_Contact__c);
                    message.setSubject('Your Tax Savings Analysis Guided Presentation Link');
                    message.setSenderDisplayName(opportunity.Account.Owner.Name);
                    message.setReplyTo(opportunity.Account.Owner.Email);

                    //Replace the variable in the email link
                    message.setHtmlBody(message.getHtmlBody().replace('sessionId', String.valueOf(sessionId)).replace('recordId', requestList[0].recordId).replace('finalToken', presentationToken));
                    
                    //If the user input additional email addresses, cc them in the message
                    if('' != requestList[0].emailAddresses) {
                        List<String> toAddresses = requestList[0].emailAddresses.split(',');
                        message.setCcAddresses(toAddresses);  
                    }

                    //Sending the email message and recording the response
                    try {
                        if(!Test.isRunningTest()){
                            Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{message});
                        }                          emailMessageResponse.response = 'An email message with the client link to the Tax Savings Analysis Presentation has been successfully sent to '+opportunity.Account.Primary_Contact_Email__c;
                        if('' != requestList[0].emailAddresses) {
                            emailMessageResponse.response += ', '+requestList[0].emailAddresses;
                        }
                        emailMessageResponse.primaryEmail = opportunity.Account.Primary_Contact_Email__c;
                    } catch(Exception e) {
                        emailMessageResponse.response = e.getMessage();
                    }
                }
                responses.add(emailMessageResponse);
            } 
        }
        return responses;   
    }

    
    public class Requests {
        //The Id from the record from which the flow was launched
        @InvocableVariable(required=true)
        public String recordId;
        //Additional email addresses to send the link to
        @InvocableVariable
        public String emailAddresses;
        //Indicator of the first time through to get the email address and the second time to send the email
        @InvocableVariable
        public String action;
        //Session id for the web socket
        @InvocableVariable
        public String sessionId;
        @InvocableVariable
        public String controllerToken;
        @InvocableVariable
        public String presentationToken;
    }

    
    public class JobResponses {
        //Email response message
        @InvocableVariable
        public String response;
        @InvocableVariable
        public String primaryEmail;
        @InvocableVariable
        public String sessionId;
        @InvocableVariable
        public String controllerToken;
        @InvocableVariable
        public String presentationToken;
        @InvocableVariable
        public String schedulerUrl;
    }
}