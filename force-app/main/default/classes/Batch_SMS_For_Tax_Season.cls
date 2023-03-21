//Deprecated
global class Batch_SMS_For_Tax_Season implements Database.Batchable<sObject> { //
    
    String query;
    
    global Batch_SMS_For_Tax_Season() {
        
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {

        query = 'Select Id, CreatedDate, Tax_Prep_Status__c, Account__c, Contact__c, Contact__r.Phone, Contact__r.Name, Name, Business__c, Personal__c from Accounting_Process__c where Tax_Prep_Status__c in (\'Additional info Request Sent\', \'Additional info Request Sent - No Notification\', \'Awaiting Client Approval\', \'Awaiting Client Approval - Owes\', \'Awaiting Client Approval - No Notification\')';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {

    //     List<Event_Trigger_Setting__mdt> eventSettingCustomMetadata = [SELECT Disable_Tax_Season_SMS_Scheduling__c FROM Event_Trigger_Setting__mdt 
    //                                                                     WHERE DeveloperName='Disable_SMS_Scheduling' ] ;

    //     List<Tax_Filing_Deadline__mdt> lstTaxFiling = [select id, Business_Tax_Filing_Deadline_SMS_Date__c, Business_Tax_Message__c, Personal_Tax_Filing_Deadline_SMS_Date__c, Personal_Text_Message__c 
    //                                                     from Tax_Filing_Deadline__mdt where developername='Tax_Filing_Deadline'];

    //     if(eventSettingCustomMetadata.size() > 0){
    //         if(eventSettingCustomMetadata[0].Disable_Tax_Season_SMS_Scheduling__c == true)
    //             return;
    //     }else{
    //         return;
    //     }

    //     List<Accounting_Process__c> lstAddtnlInfo = new List<Accounting_Process__c>();
    //     List<Accounting_Process__c> lstAwtngApprvl = new List<Accounting_Process__c>();
    //     List<Accounting_Process__c> lstPersonal = new List<Accounting_Process__c>();
    //     List<Accounting_Process__c> lstBusiness = new List<Accounting_Process__c>();

    //     for(SObject s : scope){

    //         Accounting_Process__c acctProcess = (Accounting_Process__c) s;

    //         if(acctProcess.Tax_Prep_Status__c == 'Additional info Request Sent' || acctProcess.Tax_Prep_Status__c == 'Additional info Request Sent - No Notification'){
    //             lstAddtnlInfo.add(acctProcess);
    //         } else if(acctProcess.Tax_Prep_Status__c == 'Awaiting Client Approval' || acctProcess.Tax_Prep_Status__c == 'Awaiting Client Approval - Owes' || acctProcess.Tax_Prep_Status__c == 'Awaiting Client Approval - No Notification'){
    //             lstAwtngApprvl.add(acctProcess);
    //         }

    //         if(acctProcess.Business__c){    //It's for Business
    //             lstBusiness.add(acctProcess);
    //         }

    //         if(acctProcess.Personal__c){    //It's for Personal
    //             lstPersonal.add(acctProcess);
    //         }
    //     }

    //     //if(lstAddtnlInfo.size() > 0)
    //     //    SMS_For_Tax_Season_Helper.createScheduleMsgForAddtnlInfo(lstAddtnlInfo);

    //     //if(lstAwtngApprvl.size() > 0)
    //     //    SMS_For_Tax_Season_Helper.createScheduleMsgForAwaitingApprvl(lstAwtngApprvl);
        
    //     //if(lstPersonal.size() > 0 && lstTaxFiling.size() > 0)
    //     //    SMS_For_Tax_Season_Helper.createScheduleMsgForPersonal(lstPersonal, lstTaxFiling[0]);

    //     //if(lstBusiness.size() > 0 && lstTaxFiling.size() > 0)
    //     //    SMS_For_Tax_Season_Helper.createScheduleMsgForBusiness(lstBusiness, lstTaxFiling[0]);

    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}