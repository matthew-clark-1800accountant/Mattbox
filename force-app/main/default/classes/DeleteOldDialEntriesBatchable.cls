public without sharing class DeleteOldDialEntriesBatchable implements Database.batchable<sObject>, Schedulable {

    public Integer daysAgo {get;set;}
    public DeleteOldDialEntriesBatchable(Integer days){
        System.debug('DeleteOldDialEntriesBatchable.DeleteOldDialEntriesBatchable()');
        this.daysAgo = days;
    }

    public Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id FROM NVMConnect__ProcessedDialEntry__c WHERE CreatedDate < N_DAYS_AGO:'+this.daysAgo;
        return Database.getQueryLocator(query);
    }

    public void execute(SchedulableContext context) {
        Database.executeBatch(new DeleteOldDialEntriesBatchable(60), 200);
    }

    public void execute(Database.BatchableContext BC, List<NVMConnect__ProcessedDialEntry__c> scope){        
        System.debug(scope.size());
        delete scope;
    }

    public void finish(Database.BatchableContext BC){}


}