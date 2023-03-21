trigger AccountStatus on Account (after insert, after update) {
    List<Account> toUpdateAccounts = new List<Account>();
    List<Id> accountIds = new List<Id>();

    for(Account a : Trigger.new){
        if(Trigger.isInsert){
            //Seperating these three because they are statuses based off Account attributes, not attributes on related lists
            if(a.Blacklisted__c){
                Account updateAccount = new Account(Id = a.Id, Account_Status__c = 'Blacklisted');
                toUpdateAccounts.add(updateAccount);
            }
            if(a.Business_Account__c){
                Account updateAccount = new Account(Id = a.Id, Account_Status__c = 'Business Account');
                toUpdateAccounts.add(updateAccount);
            }
            if(a.Partner_Account__c){
                Account updateAccount = new Account(Id = a.Id, Account_Status__c = 'Partner Account');
                toUpdateAccounts.add(updateAccount);
            }
        //If the status is not any of the above we need to determine the status    
        } else {
            Account oldAccount = Trigger.oldMap.get(a.Id);
            if(a.Blacklisted__c && a.Blacklisted__c != oldAccount.Blacklisted__c){
                Account updateAccount = new Account(Id = a.Id, Account_Status__c = 'Blacklisted');
                toUpdateAccounts.add(updateAccount);
            }
            if(a.Business_Account__c && a.Business_Account__c != oldAccount.Business_Account__c){
                Account updateAccount = new Account(Id = a.Id, Account_Status__c = 'Business Account');
                toUpdateAccounts.add(updateAccount);
            }
            if(a.Partner_Account__c  && a.Partner_Account__c != oldAccount.Partner_Account__c){
                Account updateAccount = new Account(Id = a.Id, Account_Status__c = 'Partner Account');
                toUpdateAccounts.add(updateAccount);
            }
            if(a.ChargeOver_Most_Recent_Payment_Date__c != oldAccount.ChargeOver_Most_Recent_Payment_Date__c){
                accountIds.add(a.Id);
            }
        }
    }
    update toUpdateAccounts;
    
    if(!accountIds.isEmpty()){
        AccountStatusHandler.assignAccountStatus(accountIds);
    }

}