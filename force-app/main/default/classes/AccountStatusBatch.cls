global class AccountStatusBatch implements Database.Batchable<sObject>, Schedulable {
    public String batchQuery = 
          'SELECT Id, Name, Account_Status__c, ChargeOver_Most_Recent_Payment_Date__c, Finance_Status__c, Blacklisted__c, Business_Account__c, Partner_Account__c  '
        + 'FROM Account '
        + 'WHERE Account_Status__c != \'Blacklisted\' '
        + 'AND Account_Status__c != \'Business Account\' '
        + 'AND Account_Status__c != \'Partner Account\' '
        + 'AND Account_Status__c != \'Prospect\' '
        ;

    public AccountStatusBatch() {}
    public Database.QueryLocator start(Database.BatchableContext bc)  {
        return Database.getQueryLocator(batchQuery);
    }
    public void execute(SchedulableContext context) {
        AccountStatusBatch assignStatus = new AccountStatusBatch();
        Database.executeBatch(assignStatus, 200);
    }
    public void execute(Database.BatchableContext bc, List<Account> accounts){
        this.execute(accounts);
    }
    public void execute(List<Account> accounts) {
        List<Id> accountIds = new List<Id>();
        List<Account> toUpdateAccounts = new List<Account>();
        for(Account a : accounts){
            a.Account_Status__c = 'Prospect';
            toUpdateAccounts.add(a);
            accountIds.add(a.Id);
        }
        update toUpdateAccounts;
        AccountStatusHandler.assignAccountStatus(accountIds);
    }

    public void finish(Database.BatchableContext bc){}     
}