public without sharing class DeleteCalendarBlocksBatchable implements Database.batchable<sObject>{

    List<Id> userIds;

    public DeleteCalendarBlocksBatchable(List<Id> inputIds){
        System.debug(inputIds);
        userIds = inputIds;
        System.debug('DeleteCalendarBlocksBatchable.DeleteCalendarBlocksBatchable()');
    }

    public Database.QueryLocator start(Database.BatchableContext BC){
        Datetime startTime = Datetime.now();
        List<Id> userIdList = userIds;
        String query = 'SELECT Id FROM Event WHERE StartDateTime >= :startTime AND Type_of_Appointment__c = \'Calendar Block\' '
        +'AND OwnerId IN :userIdList';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<Event> scope){        
        System.debug(scope.size());
        delete scope;
    }

    public void finish(Database.BatchableContext BC){}

    @InvocableMethod(label='Delete Future Calendar Blocks')
    public static void startBatch(List<List<Id>> userIds){
        if(!userIds.isEmpty()){
            DeleteCalendarBlocksBatchable bat = new DeleteCalendarBlocksBatchable(userIds[0]);
            Database.executeBatch(bat);
        }
    }
}