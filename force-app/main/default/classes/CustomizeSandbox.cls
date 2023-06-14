global without sharing class CustomizeSandbox {
    private class CustomException extends Exception {}
    public class RestResponse{
        public Integer totalSize;
        public List<sObject> records;
        public String nextRecordsUrl;
    }

    public class RestRollupResponse{
        public Integer totalSize;
        public List<rh2__PS_Export_Rollups__c> records;
        public String nextRecordsUrl;
    }

    public static String getEvironmentName(){
        System.Domain d = System.DomainParser.parse(URL.getOrgDomainUrl());
        if(d.getSandboxName() == null){
            return 'production';
        } else {
            return d.getSandboxName().toLowerCase();
        }        
    }

    public static Set<String> getUsersToUpdate(){
        System.debug(getEvironmentName());
        if(getEvironmentName() == 'training'){
            return trainingUsers;
        } else {
            return stagingUsers;
        }
    }

    public static Set<String> stagingUsers = new Set<String>{
        'Drew Troutner',
        'E API',
        'Eric Yunker',
        'Matthew Clark',
        'Portal API',
        'ChargeOver Billing',
        'Daytime Admin',
        'Mukesh Srivastav',
        'Wade Hansen',
        'Elliot Kemp',
        'Marketing Analytics',
        'Rohit Pratti',
        'Alfredo Gago',
        'Jovan Reyes'
    };

    public static Set<String> trainingUsers = new Set<String>{
        'Drew Troutner',
        'E API',
        'Eric Yunker',
        'ChargeOver Billing',
        'Billing User1',
        'Sales User1',
        'Sales User2',
        'Sales User3',
        'Sales User4',
        'Sales User5',
        'Sales User6',
        'Sales User7',
        'Sales User8',
        'Sales User9',
        'Sales User10',
        'Sales User11',
        'Sales User12',
        'Sales User13',
        'Sales User14',
        'Sales User15',
        'Sales User 16',
        'Sales User 17'
    };

    public static List<String> calculatorQueries = new List<String>{
        'SELECT Name, Default__c, Display_Format__c, Dropdown_Value__c, Form_Field__c, Number_of_Hours__c, Price_Adjustment__c, Product__c, Setup_fee__c, Sort__c FROM Calculator_Dropdown__c',
        'SELECT Name, Required_In_Environment__c FROM Calculator_Field__c',
        'SELECT Action__c, Active__c, Amount__c, Name, Criteria_Field_1__c, Criteria_Field_2__c, Criteria_Object__c, Environment__c, Field_1_Operator__c, Field_1_Value__c, Field_2_Operator__c, Field_2_Value__c, Message__c FROM Calculator_Rule__c WHERE Active__c = true'
        //'SELECT Active__c, Name, Default__c, Environment__c, Sort__c FROM Calculator_Offer__c',
        //'SELECT Active__c, Amount__c, Name, Delay_Days__c, Master_Product__c, Upsell_Product__c FROM Calculator_Offer_Product__c'
    };

    public static List<String> outboundMessages = new List<String>{
        'NewClientPortal-AccountSync',
        'NewClientPortal-ActiveSubLineSync',
        'NewClientPortal-ActiveSubSync',
        'NewClientPortal-AppointmentSync',
        'NewClientPortal-CaseCommentSync',
        'NewClientPortal-CaseSync',
        'NewClientPortal-ContactSync',
        'NewClientPortal-LeadSync',
        'NewClientPortal-NoteSync',
        'NewClientPortal-PaymentMethodSync',
        'NewClientPortal-PaymentSync',
        'NewClientPortal-SubscriptionLineSync',
        'NewClientPortal-UserSync',
        'NewClientPortal-SubscriptionSync'
    };

    public static String getOutboundMessageString(){
        String retString = '';
        for(String msgStr : outboundMessages){
            retString += '\''+msgStr+'\',';
        }
        return retString.substring(0, retString.length()-1);
    }

    public static Integer batchSize = 50;
    public static Integer totalRecordCount = 500;
    public static String rollupQuery = 'SELECT rh2__type__c, rh2__RollupOrFilterData__c, rh2__filterJobRollupKey__c FROM rh2__PS_Export_Rollups__c';
    public static String leadQuery = 'SELECT FirstName,LastName,email,Status,LeadSource,Lead_Type_New__c,Campaign__c,Marketing_Channel__c,Phone,Company, Industry, State FROM Lead WHERE Email != null ORDER BY Phone LIMIT '+batchSize+' OFFSET ';
    public static String accountFields = 'Account.name, Account.Lead_Source__c, Account.Lead_Type_New__c, Account.Campaign__c, Account.Marketing_Channel__c, Account.Industry, Account.State_of_Formation__c, Account.BillingState, Account.Phone';
    public static String contactQuery = 'SELECT FirstName,LastName, email, Lead_Source__c, Lead_Type__c, CampaignID__c, Last_SF_Activity__c, Time_Zone__c, MailingState, Phone, '+accountFields+' FROM Contact WHERE Email != null AND AccountId != null ORDER BY Phone LIMIT '+batchSize+' OFFSET ';
    //public static String accountQuery = 'SELECT id, name, Lead_Source__c, Lead_Type_New__c, Campaign__c, Marketing_Channel__c, Last_SF_Activity__c, Time_Zone__c, Industry, State_of_Formation__c, BillingState, Phone FROM account limit 500';

    public static void runAllUpdates(Integer size){
        totalRecordCount = size;
        updateOutboundMessages();
        //updateUsers(getUsersToUpdate());
        transferCalculatorData();
        transferRollupData();
        importSeedData();
        updateCustomSettings();
    }

    @future
    public static void updateUsers(Set<String> userNameList){
        List<User> userList = [SELECT Id, Email FROM User WHERE Name IN :userNameList];
        Integer index;
        for(User u : userList){
            u.IsActive = true;
            index = u.Email.lastIndexOf('.invalid');
            if(index != -1){
                u.Email = u.Email.substring(0,index);
            }
        }
        update userList;
        // for(User u : userList){
        //     System.resetPassword(u.Id, true);
        // }
    }

    @future(callout=true)
    public static void transferCalculatorData(){

        //String requestString;
        String jsonString;
        RestResponse response;
        List<sObject> recordList = new List<sObject>();

        for(String requestString : calculatorQueries){
            System.debug('query: '+requestString);
            jsonString = RestApiController.runQuery(requestString);
                response = (RestResponse) JSON.deserialize(jsonString, RestResponse.class);
                recordList.addAll(response.records);
            
            
            system.debug(response.nextRecordsUrl);
            // while(response?.nextRecordsUrl != null){
            //     jsonString = RestApiController.getNextRecords(response.nextRecordsUrl);
            //     response = (RestResponse) JSON.deserialize(jsonString, RestResponse.class);
            //     recordList.addAll(response.records);
            //     system.debug(response.nextRecordsUrl);
            // }
        }
        insert recordList;
    }

    @future(callout=true)
    public static void transferRollupData(){

        //String requestString;
        String jsonString;
        RestResponse response;
        List<sObject> recordList = new List<sObject>();
        String requestString = rollupQuery;

        System.debug('query: '+requestString);
        jsonString = RestApiController.runQuery(requestString);
        if(Test.isRunningTest()){
            System.debug('**test');
            Map<String,Object> resMap = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
            List<Object> recList = (List<Object>)resMap.get('records');
            for(Object rec : recList){
                Map<String,Object> recMap = (Map<String,Object>)rec;
                rh2__PS_Export_Rollups__c rolEx = new rh2__PS_Export_Rollups__c();
                rolEx.rh2__type__c = (String)recMap.get('rh2__type__c');
                rolEx.rh2__RollupOrFilterData__c = (String)recMap.get('rh2__RollupOrFilterData__c');
                rolEx.rh2__filterJobRollupKey__c = (String)recMap.get('rh2__filterJobRollupKey__c');
                recordList.add(rolEx);
            }
        } else {
            System.debug('**not test');
            response = (RestResponse) JSON.deserialize(jsonString, RestResponse.class);
            recordList.addAll(response.records);
        }  
        system.debug(response?.nextRecordsUrl);
        // while(response?.nextRecordsUrl != null){
        //     jsonString = RestApiController.getNextRecords(response.nextRecordsUrl);
        //     response = (RestResponse) JSON.deserialize(jsonString, RestResponse.class);
        //     recordList.addAll(response.records);
        //     system.debug(response.nextRecordsUrl);
        // }
        
        insert recordList;
    }

    public static void importSeedData(){
        for(Integer i = 0; i < totalRecordCount; i += batchSize){
            importSeedDataBatch(i);
        }
    }

    @future(callout=true)
    public static void importSeedDataBatch(Integer offset){
        System.debug('importSeedDataBatch '+offset);
        Date today = Date.today();
        String dateString = '.'+today.month()+today.day()+today.year();
        String jsonString;
        RestResponse response;
        List<Lead> leadList = new List<Lead>();
        List<Account> accountList = new List<Account>();
        List<Contact> contactList = new List<Contact>();
        User generalQueue = [SELECT Id FROM User WHERE Name = 'General Lead Queue'];
        List<User> trainingUserList = [SELECT Id FROM User WHERE Name LIKE 'Training User%'];
        String requestString = leadQuery + offset;
        String environment = getEvironmentName();

        System.debug('query: '+requestString);
        jsonString = RestApiController.runQuery(requestString);
        response = (RestResponse) JSON.deserialize(jsonString, RestResponse.class);
        leadList.addAll((List<Lead>)response.records);
        System.debug(response.nextRecordsUrl);
        // while(response.nextRecordsUrl != null){
        //     jsonString = RestApiController.getNextRecords(response.nextRecordsUrl);
        //     response = (RestResponse) JSON.deserialize(jsonString, RestResponse.class);
        //     leadList.addAll((List<Lead>)response.records);
        //     System.debug(response.nextRecordsUrl);
        // }
        //System.debug(recordList);
        
        for(Lead l : leadList){
            l.email = (l.email==null) ? l.email+dateString : l.lastname.deleteWhitespace()+dateString+'@gmail.com';
            l.phone = '1234567890';//'111'+l.phone.substring(3,10);
            if(environment == 'training' && Math.random() > 0.5){ //assign half of the training leads to a random training user
                Integer index = Math.floor(trainingUserList.size()*Math.random()).intValue();
                //System.debug('index: '+index);
                l.OwnerId = trainingUserList[index].Id;
            } else {
                l.OwnerId = generalQueue.Id;
            }
            //.debug(l.ownerId);
        }

        requestString = contactQuery+offset;

        System.debug('query: '+requestString);
        jsonString = RestApiController.runQuery(requestString);
        response = (RestResponse) JSON.deserialize(jsonString, RestResponse.class);
        for(Contact con : (List<Contact>)response.records){
            con.Account.phone ='1234567890';// '111'+ con.Account.phone?.substring(3,10);
            if(environment == 'training' && Math.random() > 0.5){ //assign half of the training accounts to a random training user
                Integer index = Math.floor(trainingUserList.size()*Math.random()).intValue();
                //System.debug('index: '+index);
                con.Account.OwnerId = trainingUserList[index].Id;
            } else {
                con.Account.OwnerId = generalQueue.Id;
            }
            //system.debug(con.Account.ownerId);
            accountList.add(con.Account);

            con.Account = null;
            con.phone ='1234567890';// '111'+con.phone?.substring(3,10);
            con.email = (con.email==null) ? con.email+dateString : con.lastname.deleteWhitespace()+dateString+'@gmail.com';
            contactList.add(con);
        }
        System.debug(response.records[0]);
        // while(response.nextRecordsUrl != null){
        //     jsonString = RestApiController.getNextRecords(response.nextRecordsUrl);
        //     response = (RestResponse) JSON.deserialize(jsonString, RestResponse.class);
        //     for(Contact con : (List<Contact>)response.records){
        //         con.Account.phone ='1234567890';//= '111'+con.Account.phone?.substring(3,10);
        //         if(environment == 'training' && Math.random() > 0.5){ //assign half of the training accounts to a random training user
        //             Integer index = Math.floor(trainingUserList.size()*Math.random()).intValue();
        //             //System.debug('index: '+index);
        //             con.Account.OwnerId = trainingUserList[index].Id;
        //         } else {
        //             con.Account.OwnerId = generalQueue.Id;
        //         }
        //         accountList.add(con.Account);

        //         con.Account = null;
        //         con.phone ='1234567890';// '111'+con.phone?.substring(3,10);
        //         con.email = (con.email==null) ? con.email+dateString : con.lastname.deleteWhitespace()+dateString+'@gmail.com';
        //         contactList.add(con);
        //     }
        //     System.debug(response.nextRecordsUrl);
        // }
        System.debug(leadList);
        System.debug(accountList);
        System.debug(contactList);
        System.Savepoint sp = Database.setSavepoint();
        try{            
            insert leadList;
            insert accountList;
            for(Integer i=0; i<contactList.size(); i++){
                contactList[i].AccountId = accountList[i].Id;
            }
            insert contactList;
        } catch (CustomException ex){
            Database.rollback(sp);
            System.debug(ex.getMessage());
            throw ex;
        }
    }

    @future
    public static void updateCustomSettings(){
        Chargeover_URL__C urlSetting = Chargeover_URL__C.getOrgDefaults();
        System.debug(urlSetting);
        String env = getEvironmentName();
        System.debug(env);
        if(env == 'training' || Test.isRunningTest()){
            urlSetting.Chargeover_URL__C = 'https://1800accountant-training.chargeover.com';
            urlSetting.Chargeover_User__c = 'BRsZymlzMcYphijWPFIq5dUk6NtJVrL8';
            urlSetting.Chargeover_Pass__c = 'RH8lzb3Tuvae2GI9qcmsSFkjJABQP0nt';
            urlSetting.Scheduler_URL__c = 'https://1800accountant.com/sfapi/schedule/index_training.php';
        } else if(env == 'uat'){
            urlSetting.Chargeover_URL__C = 'https://1800accountant-uat.chargeover.com';
            urlSetting.Chargeover_User__c = 'pvWrnGbt7yg2xRJU5VoC8XZDYEm4MOBi';
            urlSetting.Chargeover_Pass__c = 'u3ZQtif9s210TmXBoLzSe5rgEvJOVdCn';
            urlSetting.Scheduler_URL__c = 'https://1800accountant.com/sfapi/schedule/index_uat.php';
        } else if(env == 'staging') {
            urlSetting.Chargeover_URL__C = 'https://1800accountant-staging.chargeover.com';
            urlSetting.Chargeover_User__c = 'kRqAcM6KgPwTOpQZ0y9BtW1aNhrCEHGX';
            urlSetting.Chargeover_Pass__c = 'RSOIVMiJ60qK4seNwk7lgyxTfFBtUznv';
            urlSetting.Scheduler_URL__c = 'https://1800accountant.com/sfapi/schedule/index_stage.php';
        }
        
        update urlSetting;
    }

    //@future(callout=true)
    public static void updateOutboundMessages(){
        System.debug(Limits.getDMLRows());
        System.debug(Limits.getDMLStatements());
        String query = 'select Id, Name from WorkflowOutboundMessage where Name in ('+getOutboundMessageString()+') order by Name limit 100';
        //ToolingApiController.printLomgString(query);
        String resStr = ToolingApiController.runQuery(query);
        ToolingApiController.printLomgString(resStr);
        ToolingApiController.OutboundMsg om = (ToolingApiController.OutboundMsg) JSON.deserialize(resStr, ToolingApiController.OutboundMsg.Class);
    
        if(getEvironmentName() == 'training' || Test.isRunningTest()){
            List<String> idList = new List<String>();
            for(ToolingApiController.RecordWrapper rec : om.records){
                idList.add(rec.Id);
            }
            ToolingApiController.deleteRecords(idList, 'WorkflowOutboundMessage');
        } 
        if(getEvironmentName() != 'training') {
            //Map<String,String> idToRecordJson = new Map<String,String>();
            Map<String,Object> idToRecord = new Map<String,Object>();
            List<ToolingApiController.RecordWrapper> recList = om.records;
            String newUrl;
            String integrationUsername;
            List<User> integrationUsers = [SELECT Username FROM User WHERE Alias = 'API' LIMIT 1];
            if(!integrationUsers.isEmpty()){
                integrationUsername = integrationUsers[0].Username;
            } else {
                integrationUsername = 'api@1800accountant.com';
            }
            
            if(getEvironmentName() == 'uat'){
                newUrl = 'https://uat.1800accountant.com/cbapi/app.php/salesforce/outbound-message?token=55b6943cce16e';
            } else if(getEvironmentName() == 'staging'){
                newUrl = 'https://staging.1800accountant.com/cbapi/app.php/salesforce/outbound-message?token=55b6943cce16e';
            } else {
                system.debug('current environment not supported');
                //return;
                newUrl = Datetime.now()+'testurl.com';
            }
            for(ToolingApiController.RecordWrapper rec : recList){
                String id = rec.Id;
                String name = rec.Name;
                rec.Id = null;
                rec.Name = null;
                rec.Metadata = new ToolingApiController.MetadataWrapper();
                rec.Metadata.endpointUrl = newUrl;
                rec.Metadata.integrationUser = integrationUsername;
                rec.Metadata.apiVersion=35.0;
                rec.Metadata.name = name;
                //rec.Metadata.integrationUserId = null;
                //idToRecordJson.put(rec.Id, JSON.serialize(rec));
                //om.records = new List<ToolingApiController.RecordWrapper>{rec};
                //idToRecord.put(id, rec);
                ToolingApiController.updateObject('WorkflowOutboundMessage', id, JSON.serialize(rec, true));
            }
            //ToolingApiController.updateRecords(idToRecord, 'WorkflowOutboundMessage');
        }
        
    }
}