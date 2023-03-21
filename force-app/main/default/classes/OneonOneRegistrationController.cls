public class OneonOneRegistrationController {
    
    public final static String DO_NOT_REPLY_PROD_ID = '005j000000BODKS';
    public final static String DO_NOT_USE_GUEST_ID = '005j000000CQhxZ';
    
    public String myDate {get;set;}
    public String myTime {get;set;}
    public String output {get;set;}
    
    public Boolean situation {get;set;}
    public Boolean credit {get;set;}
    public Boolean payroll {get;set;}
    public Boolean bookkeeping {get;set;}
    public Boolean businessplan {get;set;}
    public Boolean formation {get;set;}
    public Boolean retirement {get;set;}
    
    public String getMultiSelect(){
        List<String> s = new List<String>();
        if(situation) s.add('Your Business and Personal Tax Situation');
        if(credit) s.add('Building Business Credit');
        if(payroll) s.add('Payroll');
        if(bookkeeping) s.add('Bookkeeping');
        if(businessplan) s.add('Formalizing your Business Plan');
        if(formation) s.add('Entity Formation');
        if(retirement) s.add('Retirement Plans');
        
        return String.join(s,';');
    }
    
    
    public String ownedBusinessBefore {get;set;}
    public String businessPartners {get;set;}
    public String fileReturn {get;set;}
    public String cpaOrAccountant {get;set;}
    public String taxApproach {get;set;}
    public String makingMoney {get;set;}
    public String howSoonMoney {get;set;}
    public String startUpCosts {get;set;}
    public String funding {get;set;}
    public String businessDescription {get;set;}
    public String experience {get;set;}
    public String expectedfirstyear {get;set;}
    public String industry {get;set;}
    public String entitytaxclass {get;set;}
    public String numberofowners {get;set;}
    public String partnername {get;set;}
    public String partnerphone {get;set;}
    public String areasneedhelp {get;set;}
    
    public OneonOneRegistrationController(ApexPages.StandardController sc){
        output = '';
        bookkeeping = false;
        situation = false;
        credit = false;
        payroll = false;
        businessplan = false;
        formation = false;
        retirement = false;
        
    }
    
    public OneonOneRegistrationController(){
        output = '';
        bookkeeping = false;
        situation = false;
        credit = false;
        payroll = false;
        businessplan = false;
        formation = false;
        retirement = false;
        
    }
    
    public Lead theLead {get;set;}
    public Account theAccount {get;set;}
    public Contact theContact {get;set;}
    
    public PageReference makeLead(){
        Map<String,String> params = ApexPages.currentPage().getParameters();
        String ownerId = UserInfo.getUserId();
        List<User> users = [select Id from User where X1_1_Default_Owner__c = True];
        if(users.size() > 0){
            ownerId = users[0].Id;
        }
        if(params.containsKey('firstname')){
            
            List<Lead> leadList = [Select Id from Lead where Email = :params.get('email') and isConverted = false order by createddate desc limit 1];
            if(leadList.size() > 0){
                theLead = leadList[0];
            }
            
            if(theLead == null){
                theLead = new Lead(
                    FirstName = params.get('firstname'),
                    LastName = params.get('lastname'),
                    Phone = params.get('phone'),
                    Email = params.get('email'),
                    State = params.get('state'),
                    Company = 'Not Provided',
                    LeadSource = 'LegalZoom',
                    Lead_Type__c = 'Webinar - How to Avoid an Audit',
                    OwnerId = ownerId
                );
                
                insert theLead;
            }
            
        }
        return null;
    }
    
    @RemoteAction
    public static List<String> getHolidayDates(){
        List<String> dates = new List<String>();
        
        for(Holiday h : [select activitydate from Holiday where isAllDay = true]){
            dates.add(h.activitydate.year() + '' + h.ActivityDate.month() + '' + h.ActivityDate.day());
        }
        
        return dates;
    }
    
    public PageReference toPage2(){
        try{
            Id leadId = ApexPages.currentPage().getParameters().get('id');
            String ownerId = ApexPages.currentPage().getParameters().get('OwnerId');
            system.debug('param map:');
            system.debug(json.serialize(ApexPages.currentPage().getParameters()));

            if(theLead != null){
                leadId = theLead.Id;
                ownerId = UserInfo.getUserId();
                List<User> users = [select Id from User where X1_1_Default_Owner__c = True];
                if(users.size() > 0){
                    ownerId = users[0].Id;
                }
                //TODO FIX
            }
            
            if(ownerId.startsWith('00G')){
            
            } else {
            
            User u2 = [SELECT FirstName, LastName FROM User WHERE Id = :ownerId];
            String uname2 = (u2.FirstName + ' ' + u2.LastName);
            
            if (uname2 == 'General Lead Queue' || uname2 == 'Do Not Reply') {
                
                // get the new owner id
                if(leadId.getSobjectType() == Lead.getSObjectType()){
                    
                    Lead l2 = [SELECT OwnerId FROM Lead WHERE Id = :leadId];
                    ownerId = l2.OwnerId;
                
                } else if(leadId.getSobjectType() == Account.getSObjectType()){
                    
                    Account a2 = [SELECT OwnerId FROM Account WHERE Id = :leadId];
                    ownerId = a2.OwnerId;
                    
                }
                
            }
            
            }
            
            
            if(myTime != null && myDate != null){
                System.debug(myDate);
                String myHour = myTime.split(':')[0];
                String myMinute = myTime.split(':')[1].split(' ')[0];
                
                system.debug(myHour);
                system.debug(myMinute);
                
                Boolean isAM = myTime.contains('AM');
                Integer hourInt = Integer.valueOf(myHour);
                
                Integer arizonaValue = 0;
                
                if(ApexPages.currentPage().getParameters().get('tzoffset') != null ){
                    arizonaValue = Integer.valueOf(ApexPages.currentPage().getParameters().get('tzoffset')) +2;
                }
                
                system.debug('arizona Value = ' + arizonaValue);
                
                hourInt += arizonaValue;
                if(!isAM && (hourInt-arizonaValue != 12)) hourInt += 12;
                system.debug(isAM);
                system.debug(hourInt);
                Time myT = Time.newInstance(hourInt, Integer.valueOf(myMinute), 0, 0);
                system.debug(myT);
                
                List<String> splitDate = myDate.split('/');
                Integer month = Integer.valueOf(splitDate[0]);
                Integer day = Integer.valueOf(splitDate[1]);
                Integer year = Integer.valueOf(splitDate[2]);
                
                DateTime myDT = DateTime.newInstance(Date.newInstance(year, month, day), myT);
                                
                if(leadId.getSobjectType() == Lead.getSObjectType()){
                    update new Lead(
                        Id = leadId, 
                        Status = '1-1 Request', 
                        X1_1_Scheduled__c = myDT
                    );

                    if(ownerId == null){
                        List<User> users = [select Id from User where X1_1_Default_Owner__c = True];
                        if(users.size() > 0){
                            ownerId = users[0].Id;
                        }
                        try{
                            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();         
                            String[] toAddresses = new String[] {'matt@cloud62.com'};         
                            mail.setToAddresses(toAddresses);         
                            mail.setSubject('OwnerId missing!');         
                            //String joined = String.join(log,'\r\n');
                            String mainBody = json.serialize(ApexPages.currentPage().getParameters());
                            
                            mail.setPlainTextBody(mainBody);         
                     
                            
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                        }catch(Exception e){}
                    }
                    Event e;
                    if(ownerId != null && ownerId.startsWith('005')){
                        e = new Event(
                            Subject = '1on1 Sales Appointment',
                            Description = '1on1 Appointment After Webinar',
                            WhoId = leadId,
                            OwnerId = ownerId,
                            StartDateTime = myDT,
                            EndDateTime = myDT.addMinutes(30),
                            Appointment_Setter__c = ApexPages.currentPage().getParameters().get('Setter'),
                            Email_Campaign_ID__c = ApexPages.currentPage().getParameters().get('Email_Campaign_ID__c'),
                            IsReminderSet = true,
                            ReminderDateTime  = myDT.addMinutes(-10)
                        );
                    } else {
                        // we need to look at the lead and find the most recent task or event and use that ownerid as this owner
                        // 
                        // 
                        // 
                        Id MostRecentTaskOwner;
                        Id fallbackOwner;
                        List<User> users = [select Id from User where Name = 'Do Not Reply'];
                        
                        if(users.size() > 0){
                            fallbackOwner = users[0].Id;
                        }
                        
                        List<Task> tasks = [select OwnerId,CreatedDate from Task where WhoId = :leadId and Owner.IsActive = true and OwnerId != :DO_NOT_REPLY_PROD_ID and ownerId != :DO_NOT_USE_GUEST_ID and ownerid not in (select id from user where isactive = true and Skills_Sales__c includes('Setter')) order by CreatedDate desc limit 1];
                        List<Event> events = [select OwnerId,CreatedDate from Event where WhoId = :leadId and Owner.IsActive = true and  OwnerId != :DO_NOT_REPLY_PROD_ID and ownerId != :DO_NOT_USE_GUEST_ID and ownerid not in (select id from user where isactive = true and Skills_Sales__c includes('Setter'))order by CreatedDate desc limit 1];
                        
                        if(tasks.size() == 1 && events.size() == 1){
                            if(tasks[0].CreatedDate > events[0].CreatedDate){
                                MostRecentTaskOwner = tasks[0].ownerId;
                            } else {
                                MostRecentTaskOwner = events[0].ownerId;
                            }
                        } else if(tasks.size() == 1 && events.size() == 0){
                            MostRecentTaskOwner = tasks[0].ownerId;
                        } else if(events.size() == 1 && tasks.size() == 0){
                            MostRecentTaskOwner = events[0].ownerId;
                        } else if(events.size() == 0 && tasks.size() == 0){
                            MostRecentTaskOwner = fallbackOwner;
                        }
                        
                        e = new Event(
                            Subject = '1on1 Sales Appointment',
                            Description = '1on1 Appointment After Webinar',
                            WhoId = leadId,
                            OwnerId = MostRecentTaskOwner,
                            StartDateTime = myDT,
                            EndDateTime = myDT.addMinutes(30),
                            Appointment_Setter__c = ApexPages.currentPage().getParameters().get('Setter'),
                            Email_Campaign_ID__c = ApexPages.currentPage().getParameters().get('Email_Campaign_ID__c'),
                            IsReminderSet = true,
                            ReminderDateTime  = myDT.addMinutes(-10)
                        );
                        
                        update new Lead(Id = leadId, OwnerId = MostRecentTaskOwner); // this should be cleaned up
                        
                    }
                    
                    
                    try{
                    
                        //disable old items
                        DateTime dt = datetime.now();
                        List<Event> oldev = [SELECT Id FROM Event WHERE whoId = :leadId AND subject = '1on1 Sales Appointment' AND StartDateTime > :dt];
                        delete oldev;
                        
                        
                        List<User> owner = [SELECT Id, Out_of_Office__c, ManagerId, LastName, FirstName FROM User WHERE id = :e.ownerId AND Manager.isActive = true LIMIT 1];
                        if(owner.size()>0){
                            if(owner[0].Out_of_Office__c == true && owner[0].ManagerId != null){
                                e.ownerId = owner[0].managerId;
                                List<Lead> leadName = [SELECT name FROM Lead WHERE id = :e.whoId LIMIT 1];
                                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();         
                                //String[] toAddresses = new String[] {'matt@cloud62.com'};         
                                mail.setTargetObjectId(owner[0].ManagerId);
                                //mail.setTargetObjectId('00Q17000006GBP7');
                                mail.setSubject('1-1 Appointment Reassigned');         
                                //String joined = String.join(log,'\r\n');
                                String mainBody = (owner[0].FirstName + ' ' + owner[0].LastName + ' is out of the office, and a new 1-1 Appointment has been assigned to you: ' +
                                                leadName[0].name + ' at ' + myTime + ' on ' + myDate + '.');
                                mail.saveAsActivity = false;

                                mail.setPlainTextBody(mainBody);         
                         
                                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                            }
                        }
                        
                        insert e;    
                        
                    }catch(Exception ex){
                         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();         
                            String[] toAddresses = new String[] {'ericyunker@gmail.com'};         
                            mail.setToAddresses(toAddresses);         
                            mail.setSubject('Exception with events');         
                            //String joined = String.join(log,'\r\n');
                            String mainBody = ex.getStackTraceString() + ' ' + ex.getMessage() + ' ;' + ApexPages.currentPage().getParameters();
                            
                            mail.setPlainTextBody(mainBody);         
                     
                            
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                    }
                    
                } else if(leadId.getSobjectType() == Account.getSObjectType()){
                    
                    update new Account(
                        Id = leadId,
                        Lead_Status__c = '1-1 Request',
                        X1_1_Scheduled__c = myDT
                    );
                    
                    Id fallbackOwner;
                    
                   
                    
                    Event e = new Event(
                        Subject = '1on1 Sales Appointment',
                        Description = '1on1 Appointment After Webinar',
                        WhatId = leadId,
                        OwnerId = ownerId,
                        StartDateTime = myDT,
                        EndDateTime = myDT.addMinutes(30),
                        Appointment_Setter__c = ApexPages.currentPage().getParameters().get('Setter'),
                        Email_Campaign_ID__c = ApexPages.currentPage().getParameters().get('Email_Campaign_ID__c'),
                        IsReminderSet = true,
                        ReminderDateTime  = myDT.addMinutes(-10)
                    );
                    
                    //cancel old events 
                    DateTime dt = datetime.now();
                    List<Event> oldev = [SELECT Id FROM Event WHERE WhatId = :leadId AND subject = '1on1 Sales Appointment' AND StartDateTime > :dt];
                    delete oldev;
                    
                    
                    List<User> owner = [SELECT Id, Out_of_Office__c, ManagerId, LastName, FirstName FROM User WHERE id = :e.ownerId AND manager.isactive = true LIMIT 1];
                    if(owner.size()>0){
                        if(owner[0].Out_of_Office__c == true && owner[0].ManagerId != null){
                            e.ownerId = owner[0].managerId;
                            List<Account> leadName = [SELECT Name FROM Account WHERE id = :e.whatId LIMIT 1];
                            
                            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();         
                            //String[] toAddresses = new String[] {'matt@cloud62.com'};         
                            mail.setTargetObjectId(owner[0].ManagerId);
                            //mail.setTargetObjectId('00Q17000006GBP7');
                            mail.setSubject('1-1 Appointment Reassigned');         
                            //String joined = String.join(log,'\r\n');
                            String mainBody = (owner[0].FirstName + ' ' + owner[0].LastName + ' is out of the office, and a new 1-1 Appointment has been assigned to you: ' +
                                                leadName[0].Name + ' at ' + myTime + ' on ' + myDate + '.');
                            mail.saveAsActivity = false;

                            mail.setPlainTextBody(mainBody);         
                     
                            
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                        }
                    }
                      
                    
                    insert e;
                    
                    
                }
                
                
                
                
            }
        }catch(exception e){}
        
        return Page.OneOnOneSurvey;
    }
    
    public PageReference doSubmit(){
        try{
            Id leadId = ApexPages.currentPage().getParameters().get('id');
            String ownerId = ApexPages.currentPage().getParameters().get('OwnerId');
            
            if(theLead != null){
                leadId = theLead.Id;
                ownerId = UserInfo.getUserId();
                List<User> users = [select Id from User where X1_1_Default_Owner__c = True];
                if(users.size() > 0){
                    ownerId = users[0].Id;
                }
                //TODO FIX
            }
            
            if(experience == null){
                experience = '';
            }
            
            experience = experience.left(255);
            
            if(businessDescription == null){
                businessDescription = '';
            }
            
            businessDescription = businessDescription.left(255);
            
            if(leadId.getSobjectType() == Lead.getSobjectType()){
                update new Lead(
                    Id = leadId,
                    Total_Startup_Costs__c = startUpCosts,
                    Expected_1st_year_revenue__c = expectedfirstyear,
                    Industry = industry,
                    Entity_Tax_Classification__c = entitytaxclass,
                    Number_of_Owners__c = numberofowners,
                    Partner_Name__c = partnername,
                    Partner_Phone__c = partnerphone,
                    Areas_needing_help__c = areasneedhelp
                    
                    
                );
            } else if(leadId.getSobjectType() == Account.getSObjectType()){
                update new Account(
                    Id = leadId,
                    Expected_1st_year_revenue__c = expectedfirstyear,
                    Industry = industry,
                    Entity_Tax_Classification__c = entitytaxclass,
                    Number_of_owners__c = numberofowners,
                    Partner_Name__c = partnername,
                    Partner_Phone__c = partnerphone,
                    X1_1_Discussion__c = getMultiSelect(),
                    Owned_Business_Before__c = ownedBusinessBefore == 'true',
                    Business_Partners__c = businessPartners == 'true',
                    Current_Tax_Approach__c = taxApproach,
                    How_Soon_Making_Money__c = howSoonMoney,
                    Married__c = fileReturn == 'true',
                    Need_Funding__c = funding == 'true',
                    Worked_with_CPA_Accountant__c = cpaOrAccountant == 'true',
                    Making_Money_Yet__c = makingMoney == 'true',
                    Total_Startup_Costs__c = startUpCosts,
                    Business_Description__c = businessDescription,
                    X1800_Experience__c = experience
                    
                    
                );
            }
            
            
        }catch(Exception e){
            system.debug(e);
        }
        
        return new PageReference('http://1800accountant.com/1on1nyc_1/thankyou.php?datetext='+myDate+'&timetext='+myTime);
    }
    
   @RemoteAction
    public static List<String> appointmentLimit(String chosenDay, String userId, String tmpId){

        List<String> limited = new List<String>();

        String month = chosenDay.split('/')[0];
        String day = chosenDay.split('/')[1];
        String year = chosenDay.split('/')[2];
        
        DateTime checkFriDate = datetime.newinstance(integer.valueof(year), integer.valueof(month), integer.valueof(day));
        
        
        Set<String> times = new Set<String>();
        
        Integer is_man = 0;
        
        Decimal tmpFoundCount = 0;
        
        AppSlotLimit__c ASL = AppSlotLimit__c.getOrgDefaults();
        
        String iHourCheck = '';
        String iDayCheck = '';
        Integer iStartHour = 0;
        Integer iStartMinute = 0;
        Integer iEndHour = 0;
        Integer iEndMinute = 0;
        
        Integer iTmpEndHour = 0;
        
        Integer iStartMid = 0;
        Integer iEndMid = 0;

        Decimal uLimitSize = ASL.Limit_Appointment_Slots__c;
        //limited.add(String.valueOf(uLimitSize));
        
        Map<String, Decimal> timeChecker = new Map<String, Decimal>();

        //exit if the user Id is a Group since there's nothing to do with that.
        if(userId != null && userId.startsWith('00G')){
            
              
           
                
            
        } else {
            
            User u2 = [SELECT FirstName, LastName FROM User WHERE Id = :userId];
            String uname2 = (u2.FirstName + ' ' + u2.LastName);
            
            if (uname2 == 'General Lead Queue' || uname2 == 'Do Not Reply') {
                
                String currentO2 = userId;
                
                Id leadId2 = tmpId;
                
                // get the new owner id
                if(leadId2.getSobjectType() == Lead.getSObjectType()){
                    
                    Lead l2 = [SELECT OwnerId FROM Lead WHERE Id = :leadId2];
                    currentO2 = l2.OwnerId;
                
                } else if(leadId2.getSobjectType() == Account.getSObjectType()){
                    
                    Account a2 = [SELECT OwnerId FROM Account WHERE Id = :leadId2];
                    currentO2 = a2.OwnerId;
                    
                }
                
                //currentO2 = userId;
                
                User u4 = [SELECT FirstName, LastName FROM User WHERE Id = :currentO2];
                String uname4 = (u4.FirstName + ' ' + u4.LastName);
                
                if (uname4 != 'General Lead Queue' && uname4 != 'Do Not Reply') {
                    userId = currentO2;
                } else {
                    // get team size for each manager
                    User m1 = [SELECT Team_Size__c FROM User WHERE FirstName = 'Shawna' AND LastName = 'Pendley'];
                    Decimal m1Size = m1.Team_Size__c;
                    
                    User m2 = [SELECT Team_Size__c FROM User WHERE FirstName = 'Floria' AND LastName = 'Royals'];
                    Decimal m2Size = m2.Team_Size__c;
                    
                    User m3 = [SELECT Team_Size__c FROM User WHERE FirstName = 'JT' AND LastName = 'Keenan'];
                    Decimal m3Size = m3.Team_Size__c;
                    
                    User m4 = [SELECT Team_Size__c FROM User WHERE FirstName = 'Michael' AND LastName = 'Cashman'];
                    Decimal m4Size = m4.Team_Size__c;

                    // array of managers
                    Set<String> managerExceptions2 = new Set<String>{'Shawna Pendley', 'Floria Royals', 'JT Keenan', 'Michael Cashman'};
                    
                    // load array based upon team size
                    for (integer i = 1; i < m1Size; i++) {
                        managerExceptions2.add('Shawna Pendley'+i);
                    }
                    for (integer i = 1; i < m2Size; i++) {
                        managerExceptions2.add('Floria Royals'+i);
                    }
                    for (integer i = 1; i < m3Size; i++) {
                        managerExceptions2.add('JT Keenan'+i);
                    }
                    for (integer i = 1; i < m4Size; i++) {
                        managerExceptions2.add('Michael Cashman'+i);
                    }
                
                    
                    // pick one randomly
                    List<String> lstArray = new List<String>(); 
                    lstArray.addAll(managerExceptions2); 
                    Double randomNumber = Math.random(); 
                    Integer arrayLength = lstArray.size(); 
                    Integer randomIndex = (randomNumber *(arrayLength-1)).intValue(); 
                    String chooseName = lstArray[randomIndex];
                    
                    
                    
                    // get their id
                    if (chooseName.contains('Shawna Pendley')) {
                        User u3 = [SELECT Id FROM User WHERE FirstName='Shawna' AND LastName='Pendley'];
                        userId = u3.Id;
                        if(leadId2.getSobjectType() == Lead.getSObjectType()){
                        
                            update new Lead(
                                                Id = leadId2, 
                                                OwnerId = userId
                                            );
                        
                        } else if(leadId2.getSobjectType() == Account.getSObjectType()){
                        
                            update new Account(
                                                Id = leadId2,
                                                OwnerId = userId
                                            );
                        
                        }
                    }
                    if (chooseName.contains('Floria Royals')) {
                        User u3 = [SELECT Id FROM User WHERE FirstName='Floria' AND LastName='Royals'];
                        userId = u3.Id;
                        if(leadId2.getSobjectType() == Lead.getSObjectType()){
                        
                            update new Lead(
                                                Id = leadId2, 
                                                OwnerId = userId
                                            );
                        
                        } else if(leadId2.getSobjectType() == Account.getSObjectType()){
                        
                            update new Account(
                                                Id = leadId2,
                                                OwnerId = userId
                                            );
                        
                        }
                    }
                    if (chooseName.contains('JT Keenan')) {
                        User u3 = [SELECT Id FROM User WHERE FirstName='JT' AND LastName='Keenan'];
                        userId = u3.Id;
                        if(leadId2.getSobjectType() == Lead.getSObjectType()){
                        
                            update new Lead(
                                                Id = leadId2, 
                                                OwnerId = userId
                                            );
                        
                        } else if(leadId2.getSobjectType() == Account.getSObjectType()){
                        
                            update new Account(
                                                Id = leadId2,
                                                OwnerId = userId
                                            );
                        
                        }
                    }
                    if (chooseName.contains('Michael Cashman')) {
                        User u3 = [SELECT Id FROM User WHERE FirstName='Michael' AND LastName='Cashman'];
                        userId = u3.Id;
                        if(leadId2.getSobjectType() == Lead.getSObjectType()){
                        
                            update new Lead(
                                                Id = leadId2, 
                                                OwnerId = userId
                                            );
                        
                        } else if(leadId2.getSobjectType() == Account.getSObjectType()){
                        
                            update new Account(
                                                Id = leadId2,
                                                OwnerId = userId
                                            );
                        
                        }
                    }   
                }
                
            }
            
            
            User u = [SELECT FirstName, LastName FROM User WHERE Id = :userId];
            String name = UserInfo.getName();
            Set<String> managerExceptions = new Set<String>{'Tiffanie Anzalone', 'Shawna Pendley', 'Ryan Rosas', 'David Emery', 'Gerard Finegan', 'Jeff Hanna', 'Floria Royals', 'Ray Slattery','JT Keenan', 'Michael Cashman'};
            String uname = (u.FirstName + ' ' + u.LastName);
            
            
            
            if(!managerExceptions.contains(uname)){
     
                //query event table
                Id uid = UserInfo.getUserId();
                List<Event> appointments = [SELECT Id, StartDateTime FROM Event WHERE OwnerId =:userId AND (Subject = '1on1 Sales Appointment' OR Subject = 'BLOCK')
                        AND DAY_ONLY(convertTimezone(StartDateTime)) = :Date.newInstance(Integer.valueOf(year),Integer.valueOf(month),Integer.valueOf(day))];
                
                //limit number per half hour
                for(Event app : appointments){
                
                    /*
                    //limit to 2 per 1/2 hour
                    if(!times.contains(app.StartDateTime.format('k:mm'))){
                        times.add(app.StartDateTime.format('k:mm'));
                    } else {
                        limited.add(app.StartDateTime.format('k:mm'));
                    }
                    */
                    
                    //limit to 1 per 1/2 hour
                    if(!times.contains(app.StartDateTime.format('k:mm'))){
                        times.add(app.StartDateTime.format('k:mm'));
                        limited.add(app.StartDateTime.format('k:mm'));
                    }
                    
                }
                
                List<Event> appointments2 = [SELECT Id, StartDateTime, EndDateTime FROM Event WHERE OwnerId =:userId AND Subject = 'BLOCK'
                        AND DAY_ONLY(convertTimezone(StartDateTime)) <= :Date.newInstance(Integer.valueOf(year),Integer.valueOf(month),Integer.valueOf(day)) AND DAY_ONLY(convertTimezone(EndDateTime)) >= :Date.newInstance(Integer.valueOf(year),Integer.valueOf(month),Integer.valueOf(day))];
                
                for(Event app2 : appointments2){
                
                    iHourCheck = '';
                    
                    iDayCheck = year + '-' + month + '-' + day;
                    
                    if (app2.StartDateTime.format('yyyy-MM-dd') == app2.EndDateTime.format('yyyy-MM-dd')) {
                        
                        // block all times between start time and end time
                        iStartHour = Integer.valueOf(app2.StartDateTime.format('k'));
                        iStartMinute = Integer.valueOf(app2.StartDateTime.format('mm'));
                        
                        if (iStartMinute == 0) {
                            iStartMid = 0;
                        } else {
                            iStartMid = 1;
                        }
                        
                        iEndHour = Integer.valueOf(app2.EndDateTime.format('k'));
                        iEndMinute = Integer.valueOf(app2.EndDateTime.format('mm'));
                        
                        if (iEndMinute == 0) {
                            iEndMid = 0;
                        } else {
                            iEndMid = 1;
                            //iEndHour = iEndHour + 1;
                        }
                        
                        // block all times before end time
                        for (Integer iA = iStartHour; iA < iEndHour; iA++) {
                        
                            //iTmpEndHour = iEndHour - 1;
                        
                            if (iA == iStartHour) {
                                if (iStartMid == 0) {
                                 
                                    iHourCheck = String.valueOf(iA) + ':00';
                                    if(!times.contains(iHourCheck)){
                                        times.add(iHourCheck);
                                        limited.add(iHourCheck);
                                    }
                                    
                                    iHourCheck = '0' + String.valueOf(iA) + ':00';
                                    if(!times.contains(iHourCheck)){
                                        times.add(iHourCheck);
                                        limited.add(iHourCheck);
                                    }
                                    
                                }
                                
                                
                            } else {
                                iHourCheck = String.valueOf(iA) + ':00';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                                    
                                iHourCheck = '0' + String.valueOf(iA) + ':00';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                            }
                            
                            if (iEndMid == 1 && iA == iEndHour) {
                            
                            } else {
                            
                                iHourCheck = String.valueOf(iA) + ':30';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                        
                                iHourCheck = '0' + String.valueOf(iA) + ':30';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                            
                            }
      
                            
                        
                        }
                        
                        
                    } else if (app2.StartDateTime.format('yyyy-MM-dd') == iDayCheck) {
                        
                        // block all times after start time
                        iStartHour = Integer.valueOf(app2.StartDateTime.format('k'));
                        iStartMinute = Integer.valueOf(app2.StartDateTime.format('mm'));
                        
                        if (iStartMinute == 0) {
                            iStartMid = 0;
                        } else {
                            iStartMid = 1;
                        }
                        
                        // block all times before end time
                        for (Integer iA = iStartHour; iA < 23; iA++) {
                        
                            if (iA == iStartHour) {
                                if (iStartMid == 0) {
                                 
                                    iHourCheck = String.valueOf(iA) + ':00';
                                    if(!times.contains(iHourCheck)){
                                        times.add(iHourCheck);
                                        limited.add(iHourCheck);
                                    }
                                    
                                    iHourCheck = '0' + String.valueOf(iA) + ':00';
                                    if(!times.contains(iHourCheck)){
                                        times.add(iHourCheck);
                                        limited.add(iHourCheck);
                                    }
                                    
                                }
                                
                                
                            } else {
                                iHourCheck = String.valueOf(iA) + ':00';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                                    
                                iHourCheck = '0' + String.valueOf(iA) + ':00';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                            }
      
                            iHourCheck = String.valueOf(iA) + ':30';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }
                        
                            iHourCheck = '0' + String.valueOf(iA) + ':30';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }
                        
                        }
                        
                        
                    } else if (app2.EndDateTime.format('yyyy-MM-dd') == iDayCheck) {
                        
                        iEndHour = Integer.valueOf(app2.EndDateTime.format('k'));
                        iEndMinute = Integer.valueOf(app2.EndDateTime.format('mm'));
                        
                        if (iEndMinute == 0) {
                            iEndMid = 0;
                        } else {
                            iEndMid = 1;
                            //iEndHour = iEndHour + 1;
                        }
                        
                        
                        
                        // block all times before end time
                        for (Integer iA = 0; iA < iEndHour; iA++) {
                        
                            iHourCheck = String.valueOf(iA) + ':00';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }
                        
                            
                        
                            iHourCheck = '0' + String.valueOf(iA) + ':00';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }
                        
                            
                            
                            if (iEndMid == 1 && iA == iEndHour) {
                            
                            } else {
                            
                                iHourCheck = String.valueOf(iA) + ':30';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                            
                                iHourCheck = '0' + String.valueOf(iA) + ':30';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                            
                            }
                        
                        }
                        
                    } else {
                    
                        // block all times
                        for (Integer iA = 0; iA < 23; iA++) {

                            iHourCheck = String.valueOf(iA) + ':00';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }
                        
                            iHourCheck = String.valueOf(iA) + ':30';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }
                        
                            iHourCheck = '0' + String.valueOf(iA) + ':00';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }
                        
                            iHourCheck = '0' + String.valueOf(iA) + ':30';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }

                        }
                    
                    }
                    
                    
                
                    
                    
                }
                
            } else {
            
                is_man = 1;
                
                //query event table
                Id uid = UserInfo.getUserId();
                List<Event> appointments = [SELECT Id, StartDateTime FROM Event WHERE OwnerId =:userId AND Subject = 'BLOCK'
                        AND DAY_ONLY(convertTimezone(StartDateTime)) = :Date.newInstance(Integer.valueOf(year),Integer.valueOf(month),Integer.valueOf(day))];
                
                //limit number per half hour
                for(Event app : appointments){
     
                    /*
                    //limit to 2 per 1/2 hour
                    if(!times.contains(app.StartDateTime.format('k:mm'))){
                        times.add(app.StartDateTime.format('k:mm'));
                    } else {
                        limited.add(app.StartDateTime.format('k:mm'));
                    }
                    */
                    
                    //limit to 1 per 1/2 hour
                    if(!times.contains(app.StartDateTime.format('k:mm'))){
                        times.add(app.StartDateTime.format('k:mm'));
                        limited.add(app.StartDateTime.format('k:mm'));
                    }
                    
                }
                
                List<Event> appointments3 = [SELECT Id, StartDateTime, EndDateTime FROM Event WHERE OwnerId =:userId AND Subject = 'BLOCK'
                        AND DAY_ONLY(convertTimezone(StartDateTime)) <= :Date.newInstance(Integer.valueOf(year),Integer.valueOf(month),Integer.valueOf(day)) AND DAY_ONLY(convertTimezone(EndDateTime)) >= :Date.newInstance(Integer.valueOf(year),Integer.valueOf(month),Integer.valueOf(day))];
                
                for(Event app2 : appointments3){
                
                    iHourCheck = '';
                    
                    iDayCheck = year + '-' + month + '-' + day;
                    
                    if (app2.StartDateTime.format('yyyy-MM-dd') == app2.EndDateTime.format('yyyy-MM-dd')) {
                        
                        // block all times between start time and end time
                        iStartHour = Integer.valueOf(app2.StartDateTime.format('k'));
                        iStartMinute = Integer.valueOf(app2.StartDateTime.format('mm'));
                        
                        if (iStartMinute == 0) {
                            iStartMid = 0;
                        } else {
                            iStartMid = 1;
                        }
                        
                        iEndHour = Integer.valueOf(app2.EndDateTime.format('k'));
                        iEndMinute = Integer.valueOf(app2.EndDateTime.format('mm'));
                        
                        if (iEndMinute == 0) {
                            iEndMid = 0;
                        } else {
                            iEndMid = 1;
                            //iEndHour = iEndHour + 1;
                        }
                        
                        // block all times before end time
                        for (Integer iA = iStartHour; iA < iEndHour; iA++) {
                        
                            if (iA == iStartHour) {
                                if (iStartMid == 0) {
                                 
                                    iHourCheck = String.valueOf(iA) + ':00';
                                    if(!times.contains(iHourCheck)){
                                        times.add(iHourCheck);
                                        limited.add(iHourCheck);
                                    }
                                    
                                    iHourCheck = '0' + String.valueOf(iA) + ':00';
                                    if(!times.contains(iHourCheck)){
                                        times.add(iHourCheck);
                                        limited.add(iHourCheck);
                                    }
                                    
                                }
                                
                                
                            } else {
                                iHourCheck = String.valueOf(iA) + ':00';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                                    
                                iHourCheck = '0' + String.valueOf(iA) + ':00';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                            }
      
                            if (iEndMid == 1 && iA == iEndHour) {
                            
                            } else {
                            
                                iHourCheck = String.valueOf(iA) + ':30';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                        
                                iHourCheck = '0' + String.valueOf(iA) + ':30';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                            
                            }
      
                            
                        
                        }
                        
                        
                    } else if (app2.StartDateTime.format('yyyy-MM-dd') == iDayCheck) {
                        
                        // block all times after start time
                        iStartHour = Integer.valueOf(app2.StartDateTime.format('k'));
                        iStartMinute = Integer.valueOf(app2.StartDateTime.format('mm'));
                        
                        if (iStartMinute == 0) {
                            iStartMid = 0;
                        } else {
                            iStartMid = 1;
                        }
                        
                        // block all times before end time
                        for (Integer iA = iStartHour; iA < 23; iA++) {
                        
                            if (iA == iStartHour) {
                                if (iStartMid == 0) {
                                 
                                    iHourCheck = String.valueOf(iA) + ':00';
                                    if(!times.contains(iHourCheck)){
                                        times.add(iHourCheck);
                                        limited.add(iHourCheck);
                                    }
                                    
                                    iHourCheck = '0' + String.valueOf(iA) + ':00';
                                    if(!times.contains(iHourCheck)){
                                        times.add(iHourCheck);
                                        limited.add(iHourCheck);
                                    }
                                    
                                }
                                
                                
                            } else {
                                iHourCheck = String.valueOf(iA) + ':00';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                                    
                                iHourCheck = '0' + String.valueOf(iA) + ':00';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                            }
      
                            iHourCheck = String.valueOf(iA) + ':30';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }
                        
                            iHourCheck = '0' + String.valueOf(iA) + ':30';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }
                        
                        }
                        
                        
                    } else if (app2.EndDateTime.format('yyyy-MM-dd') == iDayCheck) {
                        
                        iEndHour = Integer.valueOf(app2.EndDateTime.format('k'));
                        iEndMinute = Integer.valueOf(app2.EndDateTime.format('mm'));
                        
                        if (iEndMinute == 0) {
                            iEndMid = 0;
                        } else {
                            iEndMid = 1;
                            //iEndHour = iEndHour + 1;
                        }
                        
                        // block all times before end time
                        for (Integer iA = 0; iA < iEndHour; iA++) {
                        
                            iHourCheck = String.valueOf(iA) + ':00';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }
                        
                            
                        
                            iHourCheck = '0' + String.valueOf(iA) + ':00';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }
                        
                            
                            
                            if (iEndMid == 1 && iA == iEndHour) {
                            
                            } else {
                            
                                iHourCheck = String.valueOf(iA) + ':30';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                                
                                iHourCheck = '0' + String.valueOf(iA) + ':30';
                                if(!times.contains(iHourCheck)){
                                    times.add(iHourCheck);
                                    limited.add(iHourCheck);
                                }
                            
                            }
                        
                        }
                        
                    } else {
                    
                        // block all times
                        for (Integer iA = 0; iA < 23; iA++) {

                            iHourCheck = String.valueOf(iA) + ':00';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }
                        
                            iHourCheck = String.valueOf(iA) + ':30';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }
                        
                            iHourCheck = '0' + String.valueOf(iA) + ':00';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }
                        
                            iHourCheck = '0' + String.valueOf(iA) + ':30';
                            if(!times.contains(iHourCheck)){
                                times.add(iHourCheck);
                                limited.add(iHourCheck);
                            }

                        }
                    
                    }
 
                }
                
                List<Event> appointments2 = [SELECT Id, StartDateTime FROM Event WHERE OwnerId =:userId AND Subject = '1on1 Sales Appointment'
                    AND DAY_ONLY(convertTimezone(StartDateTime)) = :Date.newInstance(Integer.valueOf(year),Integer.valueOf(month),Integer.valueOf(day))];
                    
                for(Event app : appointments2){
        
                    // add check here for 5:30 through 7:30 pm
                    if (String.valueOf(app.StartDateTime.format('k:mm')) == '17:30' || String.valueOf(app.StartDateTime.format('k:mm')) == '18:00' || String.valueOf(app.StartDateTime.format('k:mm')) == '18:30' || String.valueOf(app.StartDateTime.format('k:mm')) == '19:00' || String.valueOf(app.StartDateTime.format('k:mm')) == '19:30') {
                        if (!timeChecker.containsKey(app.StartDateTime.format('k:mm'))) {
                            timeChecker.put(app.StartDateTime.format('k:mm'),1);
                    
                        } else {
                            tmpFoundCount = timeChecker.get(app.StartDateTime.format('k:mm'));
                            tmpFoundCount = tmpFoundCount + 1;
                            timeChecker.put(app.StartDateTime.format('k:mm'),tmpFoundCount);
                    
                        }
                    } 
            
            
            
                }
        
                if (is_man > 0) {
        
                    for ( String aID : timeChecker.keySet() ){
                        tmpFoundCount = timeChecker.get(aID);
                
                        if (tmpFoundCount >= uLimitSize) {
                            if(!times.contains(aID)){
                                times.add(aID);
                                limited.add(aID);
                            }
                        }
            
                    }
        
                }
            }
        }
        
        String dayOfWeekCheck = checkFriDate.format('EEEE');
        
        if (dayOfWeekCheck == 'Friday') {
            limited.add('19:30');
        } 
        
        for(Holiday h : [select activitydate from Holiday where isAllDay = true]){
            if (integer.valueof(year) == h.activitydate.year()) {
                if (integer.valueof(month) == h.ActivityDate.month()) {
                    if (integer.valueof(day) == h.ActivityDate.day()) {
                        limited.add('09:00');
                        limited.add('09:30');
                        limited.add('10:00');
                        limited.add('10:30');
                        limited.add('11:00');
                        limited.add('11:30');
                        limited.add('12:00');
                        limited.add('12:30');
                        limited.add('13:00');
                        limited.add('13:30');
                        limited.add('14:00');
                        limited.add('14:30');
                        limited.add('15:00');
                        limited.add('15:30');
                        limited.add('16:00');
                        limited.add('16:30');
                        limited.add('17:00');
                        limited.add('17:30');
                        limited.add('18:00');
                        limited.add('18:30');
                        limited.add('19:00');
                        limited.add('19:30');
                    }
                }
            }
        }

        
        //output list of strings
        return limited;
    }
    
}