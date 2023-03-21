public class DormantAccountStatusBatch implements Database.Batchable<sObject>, Schedulable {
    public Date fifteenMonthsAgo;
    public String batchQuery = 
          'SELECT Id, Name, Account_Status__c, ChargeOver_Most_Recent_Payment_Date__c, Finance_Status__c '
        + 'FROM Account '
        + 'WHERE ChargeOver_Most_Recent_Payment_Date__c < :fifteenMonthsAgo '
        + 'AND Finance_Status__c != \'Dormant\' ';

    public DormantAccountStatusBatch() { 
        this.fifteenMonthsAgo = Date.today().addMonths(-15);
    }
    public Database.QueryLocator start(Database.BatchableContext bc)  {
        return Database.getQueryLocator(batchQuery);
    }
    public void execute(SchedulableContext context) {
        DormantAccountStatusBatch assignStatus = new DormantAccountStatusBatch();
        Database.executeBatch(assignStatus, 1);
    }
    public void execute(Database.BatchableContext bc, List<Account> accounts){
        this.execute(accounts);
    }
    public void execute(List<Account> accounts) {
        List<Id> accountIds = new List<Id>();
        for(Account a : accounts){
            accountIds.add(a.Id);
        }
        AccountStatusHandler.assignAccountStatus(accountIds);
    }

    public void finish(Database.BatchableContext bc){}    
}