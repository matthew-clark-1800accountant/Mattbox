trigger UpdateSoldBy on Account (before insert) {
    for(Account a: Trigger.New){
        a.Sales_Rep__c = a.OwnerId;
    }
}