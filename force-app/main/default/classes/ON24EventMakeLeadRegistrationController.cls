public without sharing class ON24EventMakeLeadRegistrationController {
    public Lead theLead {get;set;}
    public Contact theContact {get;set;}
    public Account theAccount {get;set;}
    public List<selectOption> lstSO {get;set;}
    public String selEvent {get;set;}
    public Map<ID, ON24_Event__c> eventMap {get;set;}
    public Boolean showRegister {get;set;}
    
    public String FirstName {get;set;}
    public String LastName {get;set;}
    public String Email {get;set;}
    public String Phone {get;set;}
    
    public ON24EventMakeLeadRegistrationController(){
        showRegister = true;
        
        Id theId = ApexPages.currentPage().getParameters().get('id');
        
        if(theId != null){
            if(theId.getSObjectType() == Lead.getSObjectType()){
                            
                theLead = [SELECT Id, FirstName, LastName, Email, Phone, Webinar_Request__c, Status, Company, OwnerId FROM Lead WHERE Id=:theId];    
                FirstName = theLead.FirstName;
                LastName = theLead.LastName;
                Phone = theLead.Phone;
                Email = theLead.Email;
            } else if(theId.getSObjectType() == Account.getSObjectType()){
                //find account and get the contact
                theAccount = [select Id,OwnerId from Account where Id = :theId];
                List<Contact> conts = [select Id,AccountId,FirstName,LastName,Email,Phone from Contact where Id in (select Primary_Contact__c from Account where Id = :theId)];
                
                if(conts.size() > 0){
                    theContact = conts[0];
                    
                    FirstName = theContact.FirstName;
                    LastName = theContact.LastName;
                    Phone = theContact.Phone;
                    Email = theContact.Email;
                    
                    
                } else {
                    theContact = new Contact();
                }
                
            }
        } else {
            theLead = null;
        }
        
        
        lstSO = new List<SelectOption>();

        
        //if we send in an eventname, use it, otherwise grab everything. should use a dynamic query but not enough time
        String eventName = ApexPages.currentPage().getParameters().get('EventName');
        if(eventName == null){
            eventMap = new Map<ID, ON24_Event__c>([SELECT Id, Event_Time__c,Key__c,Event_ID__c FROM ON24_Event__c WHERE Event_Time__c != null 
                                               and Day_Only(Event_Time__c) <= :Date.today().addDays(7) and Event_Time__c > :DateTime.now() order by Event_Time__c asc ]);    
        } else {
            eventMap = new Map<ID, ON24_Event__c>([SELECT Id, Event_Time__c,Key__c,Event_ID__c FROM ON24_Event__c WHERE Event_Time__c != null 
                                               and Day_Only(Event_Time__c) <= :Date.today().addDays(7) and Event_Time__c > :DateTime.now() and Event_Name__c = :eventName
                                                   order by Event_Time__c asc ]);
        }
        
        for(String q: eventMap.keySet()){
            //put the day of the week
            if(eventMap.get(q).Event_Time__c != null) lstSO.add(new SelectOption(q, eventMap.get(q).Event_Time__c.format('E, MMMM d h:mm a') + ' ET'));
        }
    }
    
    public String encode(String s){
        return EncodingUtil.urlEncode(s, 'UTF-8');
    }
    
    public PageReference insertLead(){
        if(theLead == null){
            String ownerId = UserInfo.getUserId();
            List<User> users = [select Id from User where Name = 'Kayla Boles'];
            if(users.size() > 0){
                ownerId = users[0].Id;
            }
        
                theLead = new Lead(
                    FirstName = FirstName,
                    LastName = LastName,
                    Phone = Phone,
                    Email = Email,
                    Company = 'Not Provided',
                    Lead_Type__c = 'Kabbage Webinar Registration',
                    OwnerId = ownerId
                );
                
                insert theLead;
            }
            
        return null;
    }
    
    public PageReference eventRegister(){
        
        Id myUserId;
        
        List<User> uList = [select Id from user where Name = 'Do Not Reply'];
        if(uList.size() > 0 ){
            myUserId = uList[0].Id;
        }
        
        //contact on24's api upon registration

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        
        ON24_Event__c myEvent = eventMap.get(selEvent);
        
        if(myEvent == null){
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Invalid selection'));
            return null;
        }
        
        String eventId = myEvent.Event_Id__c;
        String eventKey = myEvent.Key__c;
        String leadEmail = EncodingUtil.urlEncode(Email,'UTF-8');
        String leadFirstName =FirstName;
        String leadLastName = LastName;
        
        if (leadFirstName == '') {
            leadFirstName = 'first';
        }
        
        
        String myEndpoint;
        
        
        
        if(theLead != null){
            myEndpoint = 'http://event.on24.com/utilApp/r?eventid='
            + eventId +'&sessionid=1&key=' + eventKey + '&email='+ leadEmail
            + '&firstname=' + leadFirstName + '&lastname=' + leadLastName 
            +  '&work_phone=' + theLead.Id + '&zip=' + theLead.OwnerId;
        } else if(theAccount != null){
            myEndpoint = 'http://event.on24.com/utilApp/r?eventid='
            + eventId +'&sessionid=1&key=' + eventKey + '&email='+ leadEmail
            + '&firstname=' + leadFirstName + '&lastname=' + leadLastName 
            +  '&work_phone=' + theAccount.Id + '&zip=' + theAccount.OwnerId;
        } 
        
        req.setEndpoint(myEndpoint);
        req.setHeader('Content-Length','0');
        h.send(req);

        String thisSetter;
        
        if(theLead != null){
            theLead.Webinar_Request__c = eventMap.get(selEvent).Event_Time__c;
            theLead.Status = 'Webinar Requested';
            try{
                
                theLead.FirstName = FirstName;
                theLead.LastName = LastName;
                theLead.Email = Email;
                theLead.Phone = Phone;
                theLead.Webinar_Link__c = 'http://event.on24.com/wcc/r/' + eventId + '/' + eventKey;
                
                update theLead;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Successfully registered'));
                showRegister = false;
                
                
                String setterId = ApexPages.currentPage().getParameters().get('Setter');
                List<User> setters = new List<User>();
                if(setterId != null){
                    setters = [select Name from user where Id = :setterId];
                }
                                
                if(setters.size() > 0){
                    thisSetter = setters[0].Name;
                }
                
                
                Event e = new Event(
                    Subject = 'Salesforce Webinar',
                    Description = 'sf1 Webinar',
                    WhoId = theLead.Id,
                    OwnerId = myUserId,
                    StartDateTime = eventMap.get(selEvent).Event_Time__c,
                    EndDateTime = eventMap.get(selEvent).Event_Time__c.addMinutes(30),
                    Appointment_Setter__c = thisSetter,
                    Email_Campaign_ID__c = ApexPages.currentPage().getParameters().get('Email_Campaign_ID__c')
                );
                
                insert e;
                
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()+' '+e.getStackTraceString()));
            }
        } else if(theAccount != null){
            
            theAccount.Webinar_Request__c = eventMap.get(selEvent).Event_Time__c;
            theAccount.Lead_Status__c = 'Webinar Requested';
            try{
                
                theContact.FirstName = FirstName;
                theContact.LastName = LastName;
                theContact.Email = Email;
                theContact.Phone = Phone;
                theAccount.Webinar_Link__c = 'http://event.on24.com/wcc/r/' + eventId + '/' + eventKey;
                
                update theAccount;
                update theContact;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Successfully registered'));
                showRegister = false;
                
                
                String setterId = ApexPages.currentPage().getParameters().get('Setter');
                List<User> setters = new List<User>();
                if(setterId != null){
                    setters = [select Name from user where Id = :setterId];
                }
                
                
                
                if(setters.size() > 0){
                    thisSetter = setters[0].Name;
                }
                
                
                Event e = new Event(
                    Subject = 'Salesforce Webinar',
                    Description = 'sf1 Webinar',
                    WhatId = theAccount.Id,
                    OwnerId = myUserId,
                    StartDateTime = eventMap.get(selEvent).Event_Time__c,
                    EndDateTime = eventMap.get(selEvent).Event_Time__c.addMinutes(30),
                    Appointment_Setter__c = thisSetter,
                    Email_Campaign_ID__c = ApexPages.currentPage().getParameters().get('Email_Campaign_ID__c')
                );
                
                insert e;
                
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()+' '+e.getStackTraceString()));
            }
            
            
        }
        
        
        PageReference myP = Page.OneonOneRegistration;
            
        if(eventMap.get(selEvent) != null){
            if(theAccount != null){
                String ownId = string.valueof(theAccount.OwnerId);
                
                myP.getParameters().put('id', theAccount.Id);
                myP.getParameters().put('OwnerId', ownId);
                myP.getParameters().put('Setter', thisSetter);
                myP.getParameters().put('tzoffset', ApexPages.currentPage().getParameters().get('tzoffset'));
                myP.getParameters().put('Email_Campaign_ID__c', ApexPages.currentPage().getParameters().get('Email_Campaign_ID__c'));
            } else if(theLead != null) {
                String ownId = string.valueof(theLead.OwnerId);
                myP.getParameters().put('id', theLead.Id);
                myP.getParameters().put('OwnerId', ownId);
                myP.getParameters().put('Setter', thisSetter);
                myP.getParameters().put('tzoffset', ApexPages.currentPage().getParameters().get('tzoffset'));
                myP.getParameters().put('Email_Campaign_ID__c', ApexPages.currentPage().getParameters().get('Email_Campaign_ID__c'));
            }
        }
        /*
        PageReference myP = Page.RegistrationComplete;
        if(eventMap.get(selEvent) != null){
            myP.getParameters().put('Date',eventMap.get(selEvent).Event_Time__c.format('EEE, MMM d, yyyy'));
            myP.getParameters().put('Time',eventMap.get(selEvent).Event_Time__c.format('h:mm a'));
            
        }
        */
        return myP;
    }
    
    public pageReference cancel(){
        //return new PageReference('/'+theLead.Id);
        return null;
    }
}