public without sharing class MulticalendarDataService {

    /*
    exampleAppointment = {
        Id: 1,
        EventId: '0000231ABC0X',
        Disposition: 'Rescheduled',
        SecondaryDisposition: null,
        Initials: 'MC',
        Source: '1800Accountant',
        StartTime: 1470443417111,
        EndTime: 1470443417111
    }
    */
    public class Appointment{
        @auraEnabled
        public String Id;
        @auraEnabled
        public String Disposition;
        @auraEnabled
        public String SecondaryDisposition;
        @auraEnabled
        public String Initials;
        @auraEnabled
        public String Source;
        @auraEnabled
        public Long StartTime;
        @auraEnabled
        public Long EndTime;
        @auraEnabled 
        public String AppointmentType;
        @auraEnabled 
        public String LeadSource;
        @auraEnabled 
        public String Subject;
        @auraEnabled
        public Decimal NumberOfCalls;
        @auraEnabled 
        public String PartsString;
        @auraEnabled 
        public String LeadAccountName;

        public Appointment(String Id,
          String Disposition,
          String SecondaryDisposition,
          String Initials,
          String Source,
          Long StartTime,
          Long EndTime,
          String AppointmentType,
          String LeadSource,
          String Subject,
          Decimal NumberOfCalls,
          String PartsString,
          String LeadAccountName){
            this.Id=Id;
            this.Disposition=Disposition;
            this.SecondaryDisposition=SecondaryDisposition;
            this.Initials=Initials;
            this.Source=Source;
            this.StartTime=StartTime;
            this.EndTime=EndTime;
            this.AppointmentType=AppointmentType;
            this.LeadSource=LeadSource;
            this.Subject=Subject;
            this.NumberOfCalls=NumberOfCalls;
            this.PartsString = PartsString;
            this.LeadAccountName = LeadAccountName;
        }
    }

    public class Timeslot{
        @auraEnabled
        public Integer Id;
        @auraEnabled
        public Long TimeslotTime;
        @auraEnabled
        public List<Appointment> Appointments;

        public Timeslot(Integer Id, Long TimeslotTime){
            this.Id=Id;
            this.TimeslotTime=TimeslotTime;
            this.Appointments=new List<Appointment>();
        }
    }

    public class Rep{
        @auraEnabled
        public String Id;
        @auraEnabled
        public String Name;
        @auraEnabled
        public List<Tag> Tags;
        @auraEnabled
        public Boolean IsManager;
        @AuraEnabled
        public Long EndOfDay;
        @AuraEnabled
        public String SalesTeam;

        // public Rep(String Id, String Name, List<Tag> Tags, Boolean IsManager){
        //     this.Id=Id;
        //     this.Name=Name;
        //     this.Tags=Tags;
        //     this.IsManager=IsManager;
        // }

        public Rep(String Id, String Name, Boolean IsManager){
            this.Id=Id;
            this.Name=Name;
            this.Tags= new List<Tag>();
            this.IsManager=IsManager;
        }

        public Rep(String Id, String Name, Boolean IsManager, String SalesTeam){
            this.Id=Id;
            this.Name=Name;
            this.Tags= new List<Tag>();
            this.IsManager=IsManager;
            this.SalesTeam = SalesTeam;
        }
    }

    public class Tag{
        @AuraEnabled
        public Integer Id;
        @AuraEnabled
        public String Text;

        public Tag(Integer Id, String Text){
            this.Id=Id;
            this.Text=Text;
        }
    }

    public class CalendarView{
        @AuraEnabled
        public string label;
        @AuraEnabled
        public string value;

        public CalendarView(String label, String value){
            this.label=label;
            this.value=value;
        }
    }

    public class RepRejection{
        @AuraEnabled
        public string UserId;
        @AuraEnabled 
        public string Name;
        @AuraEnabled
        public string PhotoUrl;
        @AuraEnabled 
        public String RejectedTime;

        public RepRejection(String UserId, String Name, String PhotoUrl, String RejectedTime){
            this.UserId=UserId;
            this.Name=Name;
            this.PhotoUrl=PhotoUrl;
            this.RejectedTime=RejectedTime;
        }
    }

    public Integer timezoneOffset {
        get {
            TimeZone tz = TimeZone.getTimeZone('America/New_York');
            return tz.getOffset(Datetime.now());
        } 
        set;
    }

    public static List<List<String>> appointmentTypes = new List<List<String>>{
        new List<String>{'Tax Savings Analysis', null, null},
        // new List<String>{'Tax Savings Analysis', 'Consulted', null},
        new List<String>{'Tax Savings Analysis', 'Consulted', 'Sale'},
        new List<String>{'Tax Savings Analysis', 'Consulted', 'Not Interested'},
        new List<String>{'Tax Savings Analysis', 'Consulted', 'Follow-Up'},
        new List<String>{'Tax Savings Analysis', 'Consulted', 'Cancelled'},
        new List<String>{'Tax Savings Analysis', 'No Show', null},
        new List<String>{'Tax Savings Analysis', 'Rescheduled', null},
        new List<String>{'Tax Savings Analysis', 'Cancelled', null},
        new List<String>{'Tax Savings Analysis', 'Failure to Call' , null},

        new List<String>{'BNA', null, null},
        // new List<String>{'BNA', 'Consulted', null},
        new List<String>{'BNA', 'Consulted', 'Sale'},
        new List<String>{'BNA', 'Consulted', 'Not Interested'},
        new List<String>{'BNA', 'Consulted', 'Follow-Up'},
        new List<String>{'BNA', 'Consulted', 'Cancelled'},
        new List<String>{'BNA', 'No Show', null},
        new List<String>{'BNA', 'Rescheduled', null},
        new List<String>{'BNA', 'Cancelled', null},
        new List<String>{'BNA', 'Failure to Call' , null},
        new List<String>{'BNA', 'Follow-Up', 'Sale'},
        new List<String>{'BNA', 'Follow-Up', 'Not Interested'},
        new List<String>{'BNA', 'Follow-Up', 'Follow-Up Reschedule'},
        new List<String>{'BNA', 'Follow-Up', 'No Contact'},
        new List<String>{'BNA', 'Not Qualified', 'Already Has Requested Service'},
        new List<String>{'BNA', 'Not Qualified', 'Did Not Qualify For Upsell'},
        new List<String>{'BNA', 'Not Qualified', 'Wanted Meeting With Accountant'}
    };

    //todo: format time label based on user's timezone?
    @AuraEnabled(cacheable=true)
    public static List<String> getTimeslotLabels(){
        try{
            //set start time minutes to either :00 or :30
            Date todayDate = Date.today();
            Datetime startTime = Datetime.newInstance(todayDate.year(), todayDate.month(), todayDate.day());
            Datetime endOfDay = startTime.addDays(1);
            System.debug(startTime);
            List<String> labels = new List<String>();

            for(; startTime<endOfDay; startTime=startTime.addMinutes(30)){
                labels.add(startTime.format('hh:mm a'));
            }
            return labels;
        }catch(Exception ex){
            logError(ex);
            return null;
        }
       
    }

    //to-do: decide how to account for timezones
    @AuraEnabled(cacheable=true)
    public static List<Timeslot> getRepTimeslots(String repId, String dateString){
        try {
            Datetime startTime = (datetime)json.deserialize('"'+dateString+'"', datetime.class);
            Datetime endOfDay = startTime.addDays(1);

            List<Event> eventList = new List<Event>();
            if(repId == '0'){
                List<User> salesManagers = [SELECT Id FROM User WHERE Sales_Management_Role__c = 'Manager' AND Id != :UserInfo.getUserId()];
                Set<Id> managerIds = new Map<Id, User>(salesManagers).keySet();
                eventList = 
                [SELECT Id,
                Appointment_Disposition__c,
                Secondary_Disposition_Details__c,
                Type_of_Appointment__c,
                Lead_Source__c,
                of_Calls_for_Event__c,
                StartDateTime,
                EndDateTime,
                Subject,
                Who.Name
                FROM Event
                WHERE OwnerId IN :managerIds
                //AND StartDateTime = today];
                AND StartDateTime >= :startTime
                AND StartDateTime < :endOfDay
                AND ShowAs != 'Free'
                AND Type_of_Appointment__c != 'Calendar Block'];
            } else {
                eventList = 
                [SELECT Id,
                Appointment_Disposition__c,
                Secondary_Disposition_Details__c,
                Type_of_Appointment__c,
                Lead_Source__c,
                of_Calls_for_Event__c,
                StartDateTime,
                EndDateTime,
                Subject,
                Who.Name
                FROM Event
                WHERE OwnerId = :repId
                //AND StartDateTime = today];
                AND StartDateTime >= :startTime
                AND StartDateTime < :endOfDay
                AND ShowAs != 'Free'];
            }
            //System.debug('eventList: '+eventList);
            List<Appointment> appointments = new List<Appointment>();
            Map<Long, Timeslot> timeslotMap = new Map<Long, Timeslot>();
            Integer idNum = 0;
            for(; startTime<endOfDay; startTime=startTime.addMinutes(30)){
                timeslotMap.put(startTime.getTime(), new Timeslot(idNum, startTime.getTime()));
                idNum++;
            }
            for(Long longKey : timeslotMap.keySet()){
                //System.debug(timeslotMap.get(longKey));
            }
            List<String> multislotApptTypes = new List<String>{'Calendar Block', 'Discovery Call', 'Client Onboarding Follow-Up'};
            for(Event ev : eventList){
                System.debug(ev);
                String initials = '';
                if(ev.Type_of_Appointment__c != null){
                    if(ev.Type_of_Appointment__c == 'Tax Savings Analysis'){
                        initials = 'TSA';
                    } else if(ev.Type_of_Appointment__c == 'BNA'){
                        initials = 'BNA';
                    } else if(ev.Type_of_Appointment__c.containsWhitespace()){
                        Integer index = ev.Type_of_Appointment__c.indexOf(' ');
                        initials = ev.Type_of_Appointment__c.substring(0,1) + ev.Type_of_Appointment__c.substring(index+1,index+2);
                    } else {
                        initials = ev.Type_of_Appointment__c.substring(0,2);
                    }
                    initials = initials.toUpperCase();
                }            

                Long timeslotTime;
                //System.debug(ev.StartDateTime);
                //System.debug(ev.StartDateTime.getTime());
                Integer currentPart = 1;
                Integer totalParts = 1;
                if(ev.EndDateTime > ev.StartDateTime.addMinutes(30)){
                    Long timeDifference = ev.EndDateTime.getTime() - ev.StartDateTime.getTime();
                    Long minuteDifference = timeDifference / (1000*60);
                    totalParts = Math.ceil(minuteDifference / 30.0).intValue();
                }

                //split calendar blocks
                while(ev.EndDateTime > ev.StartDateTime.addMinutes(30) 
                && multislotApptTypes.contains(ev.Type_of_Appointment__c)){
                    Event ev1 = ev.clone(true);
                    ev1.EndDateTime = ev1.StartDateTime.addMinutes(30);
                    ev.StartDateTime = ev.StartDateTime.addMinutes(30);
                    //System.debug(ev1.StartDateTime);
                    timeslotTime = roundToHalfHourLong(ev1.StartDateTime);
                    String parts = (ev1.Type_of_Appointment__c == 'Calendar Block' || totalParts == 1) ? '' : '('+currentPart+'/'+totalParts+')';
                    String subject = (ev1.Type_of_Appointment__c == 'Calendar Block' || totalParts == 1) ? ev1.Subject : ev1.Subject+' '+parts;
                    currentPart++;
                    timeslotMap.get(timeslotTime)?.Appointments.add(new Appointment(
                        ev1.Id,
                        ev1.Appointment_Disposition__c,
                        ev1.Secondary_Disposition_Details__c,
                        initials,
                        ev1.Lead_Source__c,
                        ev1.StartDateTime.getTime(),
                        ev1.EndDateTime.getTime(),
                        ev1.Type_of_Appointment__c,
                        ev1.Lead_Source__c,
                        subject,
                        (ev1.of_Calls_for_Event__c == null ? 0 : ev1.of_Calls_for_Event__c),
                        parts,
                        ev1.Who.Name
                    ));
                }

                String parts = (ev.Type_of_Appointment__c == 'Calendar Block' || totalParts == 1) ? '' : '('+currentPart+'/'+totalParts+')';
                String subject = (ev.Type_of_Appointment__c == 'Calendar Block' || totalParts == 1) ? ev.Subject : ev.Subject+' '+parts;
                
                timeslotTime = roundToHalfHourLong(ev.StartDateTime); 
                timeslotMap.get(timeslotTime)?.Appointments.add(new Appointment(
                    ev.Id,
                    ev.Appointment_Disposition__c,
                    ev.Secondary_Disposition_Details__c,
                    initials,
                    ev.Lead_Source__c,
                    ev.StartDateTime.getTime(),
                    ev.EndDateTime.getTime(),
                    ev.Type_of_Appointment__c,
                    ev.Lead_Source__c,
                    subject,
                    (ev.of_Calls_for_Event__c == null ? 0 : ev.of_Calls_for_Event__c),
                    parts,
                    ev.Who.Name
                ));
            }

            List<Long> keyList = new List<Long>(timeslotMap.keySet());
            keyList.sort();
            List<Timeslot> timeslotList = new List<Timeslot>();
            for(Long timeslotTime : keyList){
                //System.debug(timeslotMap.get(timeslotTime));
                timeslotList.add(timeslotMap.get(timeslotTime));
            }
            return timeslotList;
        } 
        catch (Exception ex) {
            logError(ex);
            return null;
        }        
    }

    @AuraEnabled(cacheable=true)
    public static List<RepRejection> getRepRejections(String eventId){
        try{
            List<Event> eventList = [SELECT Event_History__c FROM Event WHERE Id = :eventId];
            if(!eventList.isEmpty()){
                List<Event_Field_Update__c> updates = [SELECT Id, New_Value__c, CreatedDate FROM Event_Field_Update__c WHERE 
                Updated_Field__c = 'Initial Rejected By' AND Event_History__c = :eventList[0].Event_History__c ORDER BY CreatedDate DESC];
                Map<String,String> userToDateMap = new Map<String,String>();
                for(Event_Field_Update__c up : updates){
                    userToDateMap.put(up.New_Value__c, up.CreatedDate.format('MM/dd/yy h:mm a'));
                }
                List<RepRejection> reps = new List<RepRejection>();
                for(User u : [SELECT Id, Name, SmallPhotoUrl FROM User WHERE Id IN :userToDateMap.keySet() OR Name IN :userToDateMap.keySet()]){
                    reps.add(new RepRejection(u.Id, u.Name, u.SmallPhotoUrl, userToDateMap.get(u.Id)));
                }
                return reps;
            } else {
                return null;
            }  
        }catch(Exception ex){
            logError(ex);
            return null;
        }              
    }

    public static Datetime roundToHalfHourTime(Datetime dt){        
        return Datetime.newInstance(roundToHalfHourLong(dt));
    }

    public static Long roundToHalfHourLong(Datetime dt){
        if(dt.minute() < 30){
            dt = dt.addMinutes(-dt.minute());
        } else {
            dt = dt.addMinutes(30-dt.minute());
        }
        //round to 0 seconds
        return dt.getTime()/100000*100000;
    }

    public static void makeTestData(String repId, String whoId){
        // if(repId == null){ repId = '0055e000007Xtx2AAC'; }
        // if(whoId == null){ whoId = '0038M00000HDXpLQAX'; }
        try{
            Integer numberOfTimeSlots = 5;
            Integer maxEventsPerSlot = 1;
            Integer maxNumberOfCalls = 2;
            List<Event> eventsToAdd = new List<Event>();

            for(Integer i=0; i<numberOfTimeSlots; i++){
                Datetime startTime = roundToHalfHourTime(Datetime.now()).addMinutes((i-1)*30);
                Datetime endTime = startTime.addMinutes(30);
                List<String> disposToUse = appointmentTypes.get(Integer.valueOf(Math.random()*(appointmentTypes.size()-1)));
                System.debug(disposToUse);
                for(Integer j=0; j<Math.random()*maxEventsPerSlot; j++){
                    eventsToAdd.add(new Event(
                        OwnerId=repId,
                        Subject='Tax Consultation',
                        Type_of_Appointment__c=disposToUse[0],
                        Lead_Source__c='1-800Accountant',
                        WhoId=whoId,
                        StartDateTime=startTime,
                        EndDateTime=endTime,
                        Appointment_Disposition__c = disposToUse[1],
                        Secondary_Disposition_Details__c = disposToUse[2],
                        of_Calls_for_Event__c = Math.floor(Math.random()*maxNumberOfCalls)
                    ));
                    System.debug(eventsToAdd[j]);
                }
            }

            List<Database.SaveResult> results = Database.insert(eventsToAdd);
            for(Database.SaveResult res : results){
                System.debug(res);
            }
        }catch(Exception ex){
            logError(ex);
        }        
    }

    @AuraEnabled(cacheable=false)
    public static void makeDataForReps(List<String> filterList){
        try{
            List<String> profileNames = new List<String>{'InsideSalesUser - Zuora', 'Inbound User', 'Sales Manager'};
            List<Profile> salesProfiles = [SELECT Id FROM Profile WHERE Name IN :profileNames];
            

            if(salesProfiles.isEmpty()){
                System.debug('no sales profiles found');
            } else {
                Set<Id> profileIds = new Map<Id, Profile>(salesProfiles).keySet();
                Id currentUserId = UserInfo.getUserId();
                String queryString = 'SELECT Id, Name, Skills_Sales__c, Available_Restricted_Lead_Sources__c FROM User WHERE ProfileId IN :profileIds AND Id != :currentUserId AND IsActive=true';
                if(filterList != null && !filterList.isEmpty()){
                    for(String filter : filterList){
                        if(filter != ''){
                            queryString += ' AND '+filter;
                        }
                    }
                }
                queryString += ' ORDER BY Name';
                System.debug(queryString);
                // List<User> repUsers = Database.query(queryString);
                // List<Contact> testContacts = [SELECT Id FROM Contact LIMIT :repUsers.size()];
                // for(Integer i=0; i<repUsers.size(); i++){
                //     makeTestData(repUsers[i].Id, testContacts[i].Id);
                // }
                CreateTestDataBatchable batch = new CreateTestDataBatchable(queryString);
                Database.executeBatch(batch, 10);
            }
        }catch(Exception ex){
            logError(ex);
        }
        
    }

    // @AuraEnabled(cacheable=true)
    // public static Boolean isRepBlocked(String userId){
    //     return false;
    // }

    

    // @AuraEnabled(cacheable=false)
    // public static String moveAppointment(String eventId, String repId, Long timeLong){
    //     Datetime startTime = Datetime.newInstance(timeLong);
    //     Datetime endTime = startTime.addMinutes(30);
    //     System.debug('Start time: '+startTime);
    //     Event appointment = new Event(Id=eventId, OwnerId=repId, StartDateTime=startTime, EndDateTime=endTime);
    //     System.debug(appointment);
    //     //Database.SaveResult sr = Database.update(appointment);
    //     update appointment;
    //     return String.valueOf('sr');
    // }

    @AuraEnabled(cacheable=false)
    public static void moveAppointment(String eventId, String repId){
        try{
            Event appointment = new Event(Id=eventId, OwnerId=repId);
            System.debug(appointment);
            update appointment;    
        }catch(Exception ex){
            logError(ex);
        }

    }

    @AuraEnabled(cacheable=true)
    public static List<Rep> getReps(List<String> filterList){
        try{
            //Boolean onlyQueryReps;
            // List<String> filterList;
            // if(filterMap.containsKey(true)){
            //     onlyQueryReps = true;
            //     filterList = filterMap.get(true);
            // } else {                
            //     onlyQueryReps = false;
            //     filterList = filterMap.get(false);
            // }
            System.debug('getReps()');
            List<String> profileNames = new List<String>{'InsideSalesUser - Zuora', 'Inbound User', 'Sales Manager', 'System Admin', 'System Administrator', 'Appointment Setter', 'Executive'};
            List<Profile> salesProfiles = [SELECT Id FROM Profile WHERE Name IN :profileNames];

            if(salesProfiles.isEmpty()){
                return null;
            } else {
                Set<Id> profileIds = new Map<Id, Profile>(salesProfiles).keySet();
                Id currentUserId = UserInfo.getUserId();
                //String queryString = 'SELECT Id, Name, Skills_Sales__c, Available_Restricted_Lead_Sources__c, Profile.Name, Sales_Management_Role__c FROM User WHERE ProfileId IN :profileIds AND Id != :currentUserId AND IsActive=true AND Sales_Team__c!=null';
                String queryString = 'SELECT Id, Name, Skills_Sales__c, Available_Restricted_Lead_Sources__c, Profile.Name, Sales_Management_Role__c, Sales_Team__c FROM User WHERE Id != :currentUserId AND IsActive=true';
                
                if(filterList != null && !filterList.isEmpty()){
                //if(filterString != null && filterString != ''){
                //     List<String> filterList = filterString.split(';');
                    for(String filter : filterList){
                        if(filter != '' && filter != null){
                            queryString += ' AND '+filter;
                        }
                    }
                }
                queryString += ' ORDER BY Name';
                System.debug(queryString);
                List<User> repUsers = Database.query(queryString);
                List<Rep> repList = new List<Rep>();
                String dayString = Datetime.now().format('EEEE');
                for(User u : repUsers){
                // for(Integer i=0; i<repUsers.size(); i++){
                //     User u = repUsers[i];
                    String profileName = u.Profile.Name.toLowerCase();
                    Boolean isManager = profileName.contains('manager') || profileName.contains('admin') || profileName.contains('executive');
                    Rep r = new Rep(u.Id, u.Name, isManager, u.Sales_Team__c);
                    if(isManager){
                        r.Tags.add(new Tag(r.Tags.size(), 'Manager'));
                    }
                    if(u.Sales_Management_Role__c == 'Team Lead'){
                        r.Tags.add(new Tag(r.Tags.size(), 'Team Lead'));
                    }
                    if(u.Skills_Sales__c != null){
                        if(u.Skills_Sales__c.contains('Cross-Sale')){
                            r.Tags.add(new Tag(r.Tags.size(),'BNA Rep'));
                        }
                        if(u.Skills_Sales__c.contains('Paid Digital–CORE')){
                            r.Tags.add(new Tag(r.Tags.size(),'Paid Digital'));
                        }
                        if(!u.Skills_Sales__c.contains('Partner-Subscribed Prospects')){
                            r.Tags.add(new Tag(r.Tags.size(),'No Partner Sub'));
                        }
                    } else {
                        r.Tags.add(new Tag(r.Tags.size(),'No Partner Sub'));
                    }          
                    if(u.Available_Restricted_Lead_Sources__c != null){
                        if(!u.Available_Restricted_Lead_Sources__c.contains('ZenBusiness')){
                            r.Tags.add(new Tag(r.Tags.size(),'No Zen'));
                        }
                        if(!u.Available_Restricted_Lead_Sources__c.contains('Tailor Brands')){
                            r.Tags.add(new Tag(r.Tags.size(),'No Tailor Brands'));
                        }
                        if(u.Available_Restricted_Lead_Sources__c.contains('UENI')){
                            r.Tags.add(new Tag(r.Tags.size(),'UENI'));
                        }
                    } else {
                        r.Tags.add(new Tag(r.Tags.size(),'No Zen'));
                        r.Tags.add(new Tag(r.Tags.size(),'No Tailor Brands'));
                    }
                    if(profileName == 'appointment setter'){
                        r.Tags.add(new Tag(r.Tags.size(),'SDR'));
                    }

                    Boolean autoBlocked = false;
                    Time t = Time.newInstance(19,30,0,0);
                    if(u.Skills_Sales__c != null){
                        if(u.Skills_Sales__c.contains('Cross-Sale')){
                            t = Time.newInstance(18,30,0,0);
                        }
                        if(u.Skills_Sales__c.contains('Paid Digital–CORE')){
                            t = Time.newInstance(20,30,0,0);
                        }
                    }
                    if(dayString == 'Sunday'){
                        autoBlocked = true;
                    } else if (dayString == 'Sunday'){
                        if(u.Skills_Sales__c != null && u.Skills_Sales__c.contains('Paid Digital–CORE')){
                            t = Time.newInstance(17,30,0,0);
                        } else {
                            autoBlocked = true;
                        }
                    }

                    if(autoBlocked){
                        r.EndOfDay = -1L;
                    } else {
                        Datetime endOfDay = Datetime.newInstance(Date.today(), t);//.addHours(-4);//timezone offset
                        r.EndOfDay = endOfDay.getTime();
                    }
                    
                    System.debug(r);
                    repList.add(r);
                }
                if(repList.isEmpty()){
                    return null;
                } else {
                    return repList;
                }
            }            
        }catch(Exception ex){
            logError(ex);
            return null;
        }        
    }

    @AuraEnabled(cacheable=true)
    public static Rep getCurrentUserData(){
        try{
            Id currentUserId = UserInfo.getUserId();
            String queryString = 'SELECT Id, Name, Skills_Sales__c, Available_Restricted_Lead_Sources__c, Profile.Name, Sales_Management_Role__c, Sales_Team__c FROM User WHERE Id = :currentUserId';
            System.debug(queryString);
            List<User> currentUsers = Database.query(queryString);
            User u = currentUsers[0];

            String profileName = u.Profile.Name.toLowerCase();
            Boolean isManager = profileName.contains('manager') || profileName.contains('admin');
            Rep r = new Rep(u.Id, u.Name, isManager, u.Sales_Team__c);

            if(isManager){
                r.Tags.add(new Tag(r.Tags.size(), 'Manager'));
            }
            if(u.Sales_Management_Role__c == 'Team Lead'){
                r.Tags.add(new Tag(r.Tags.size(), 'Team Lead'));
            }
            if(u.Skills_Sales__c != null){
                if(u.Skills_Sales__c.contains('Cross-Sale')){
                    r.Tags.add(new Tag(r.Tags.size(),'BNA Rep'));
                }
                if(u.Skills_Sales__c.contains('Paid Digital–CORE')){
                    r.Tags.add(new Tag(r.Tags.size(),'Paid Digital'));
                }
                if(!u.Skills_Sales__c.contains('Partner-Subscribed Prospects')){
                    r.Tags.add(new Tag(r.Tags.size(),'No Partner Sub'));
                }
            } else {
                r.Tags.add(new Tag(r.Tags.size(),'No Partner Sub'));
            }                 
            if(u.Available_Restricted_Lead_Sources__c != null){
                if(!u.Available_Restricted_Lead_Sources__c.contains('ZenBusiness')){
                    r.Tags.add(new Tag(r.Tags.size(),'No Zen'));
                }
                if(!u.Available_Restricted_Lead_Sources__c.contains('Tailor Brands')){
                    r.Tags.add(new Tag(r.Tags.size(),'No Tailor Brands'));
                }
                if(u.Available_Restricted_Lead_Sources__c.contains('UENI')){
                    r.Tags.add(new Tag(r.Tags.size(),'UENI'));
                }
            } else {
                r.Tags.add(new Tag(r.Tags.size(),'No Zen'));
                r.Tags.add(new Tag(r.Tags.size(),'No Tailor Brands'));
            }
            
            if(profileName == 'appointment setter'){
                r.Tags.add(new Tag(r.Tags.size(),'SDR'));
            }

            return r;            
        }catch(Exception ex){
            logError(ex);
            return null;
        }
    }


    //todo: add support for custom metadata queried by the current user
    @AuraEnabled(cacheable=true)
    public static List<CalendarView> getCalendarViews(){
        try{
            //Map<String, String> viewMap = new Map<String, String>();
            List<CalendarView> viewList = new List<CalendarView>();
            viewList.add(new CalendarView('All Reps', '(NOT (Profile.Name LIKE \'%admin%\' OR Profile.Name LIKE \'%manager%\' OR Profile.Name LIKE \'%appointment setter%\' OR Profile.Name LIKE \'%executive%\'))')); //default filter
            viewList.add(new CalendarView('Queues', 'Name IN (\'Do Not Reply\', \'General Lead Queue\', \'Dead Leads Queue\')')); //default filter
            viewList.add(new CalendarView('Paid Digital', 'Skills_Sales__c includes (\'Paid Digital–CORE\')')); //Paid Digital 
            viewList.add(new CalendarView('Client Success', 'Team_Role__c = \'Operations Team\' AND Department__c = \'Customer Service\'')); 
            Schema.DescribeFieldResult fieldResult = User.Sales_Team__c.getDescribe();
            for(Schema.PicklistEntry ple : fieldResult.getPicklistValues()){
                //if(fieldResult.isActive()){
                    String label;
                    String pleLabel = ple.getLabel();
                    if(pleLabel.contains('Team')){
                        label=pleLabel;
                    } else if (pleLabel.contains(' ')){
                        if(pleLabel.charAt(pleLabel.length()-1) == 115){
                            label=(pleLabel+'\' Team');
                        } else {
                            label=(pleLabel+'\'s Team');
                        }
                    } else {
                        label=(pleLabel+' Team');
                    }
                    viewList.add(new CalendarView(label, 'Sales_Team__c = \''+pleLabel+'\''));
                    //viewMap.put(label, 'Sales_Team__c = '+pleLabel);
                //}                
            }
            System.debug(viewList);
            return viewList;            
        }catch(Exception ex){
            logError(ex);
            return null;
        }
    }

    public static string formatPhone(String phoneNum){
        return '+1'+phoneNum.deleteWhitespace().remove('(').remove(')').remove('-');
    }

    // @AuraEnabled(cacheable=true)
    // public static Boolean hasEndedCall(String eventId){
    //     if(eventId == null){
    //         return false;
    //     }
    //     Event ev = [SELECT Id, WhoId, EndDateTime FROM Event WHERE Id = :eventId];
    //     Contact con = [SELECT Numeric_Phone__c FROM Contact WHERE Id = :ev.WhoId];
    //     String phoneNumber = '+1'+con.Numeric_Phone__c;
    //     Datetime startTime = ev.EndDateTime.addMinutes(-60);
    //     Datetime endTime = ev.EndDateTime.addMinutes(60);
    //     List<NVMStatsSF__NVM_Call_Summary__c> summaries = [SELECT Id FROM NVMStatsSF__NVM_Call_Summary__c WHERE NVMStatsSF__CLID__c = :phoneNumber
    //     AND CreatedDate > :startTime AND CreatedDate < :endTime];
    //     if(summaries.isEmpty()){
    //         return false;
    //     } else {
    //         return true;
    //     }
    // }

    @AuraEnabled(cacheable=true)
    public static Integer numberOfEndedCalls(String eventId){
        try{
            if(eventId == null){
                return 0;
            }
            String phoneNumber;
            Event ev = [SELECT Id, WhoId, EndDateTime FROM Event WHERE Id = :eventId];
            List<Contact> cons = [SELECT Numeric_Phone__c FROM Contact WHERE Id = :ev.WhoId];
            if(cons.isEmpty()){
                List<Lead> leads = [SELECT Phone FROM Lead WHERE Id = :ev.WhoId];
                if(leads.isEmpty()){
                    return 0;
                } else {
                    phoneNumber = formatPhone(leads[0].Phone);
                }
            } else {
                Contact con = cons[0];
                phoneNumber = '+1'+con.Numeric_Phone__c;
            }
            
            Datetime startTime = ev.EndDateTime.addMinutes(-60);
            Datetime endTime = ev.EndDateTime.addMinutes(60);
            List<NVMStatsSF__NVM_Call_Summary__c> summaries = [SELECT Id FROM NVMStatsSF__NVM_Call_Summary__c WHERE NVMStatsSF__CLID__c = :phoneNumber
            AND CreatedDate > :startTime AND CreatedDate < :endTime AND NVMStatsSF__CallEndTime__c != null];
            return summaries.size();
        }catch(Exception ex){
            logError(ex);
            return null;
        }
        
    }

    @AuraEnabled(cacheable=true)
    public static String getEnvironmentName(){
        String name = System.DomainParser.parse(URL.getOrgDomainUrl()).getSandboxName();
        if(name == null){
            return 'production';
        } else {
            return name;            
        }
    }

    public static void logError(Exception ex){
        if(getEnvironmentName()=='production'){
            sendEmail(ex.getMessage());
        } else {
            createNote(ex.getMessage());
        }
    }

    public static void sendEmail(String emailBody){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        String[] toAddresses = new String[] {'matthew.clark@1800accountant.com'}; 
        
        mail.setToAddresses(toAddresses);
        mail.setSenderDisplayName('Salesforce Support');
        mail.setSubject('Error, Error '+UserInfo.getName());
        mail.setPlainTextBody(emailBody);
        if(Limits.getEmailInvocations()+10 < Limits.getLimitEmailInvocations()){
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }

    @future
    public static void createNote(String errorMessage){
        String userName = UserInfo.getName();
        Id userId = [SELECT Id FROM User WHERE Name = 'Matthew Clark' LIMIT 1].Id;
        ContentVersion cv = new ContentVersion();
        cv.title = 'Multicalendar Exception: '+userName+' '+Datetime.now();     
        cv.VersionData =Blob.valueOf(errorMessage.escapeHtml4());
        cv.PathOnClient= userName+' MC Error '+Datetime.now().getTime()+'.snote'; //<your file title>.snote 
        cv.OwnerId = userId;
        cv.FirstPublishLocationId = userId;
        //cv.PublishStatus = 'P';
        //cv.NetworkId= networkid ;
        insert cv; 
    }

    @AuraEnabled(cacheable=true)
    public static Boolean showMaintenanceScreen(){
        User u = [SELECT Profile.Name FROM User WHERE Id = :UserInfo.getUserId()];
        String profileName = u.Profile.Name;
        if(profileName.toLowerCase().contains('admin')){
            return false;
        }
        Multicalendar_Maintenance__c mm = Multicalendar_Maintenance__c.getOrgDefaults();
        return mm.IsActiveMaintenance__c;
    }
}