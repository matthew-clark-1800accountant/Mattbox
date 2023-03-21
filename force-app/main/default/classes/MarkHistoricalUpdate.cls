public class MarkHistoricalUpdate implements Database.Batchable<sObject>, Schedulable {
    public String batchQuery = 
          'SELECT Id, Name, Service_End_Date__c, Cancel_Date_Time__c '
        + 'FROM ChargeOver_Subscription_Line_Item__c '
        + 'WHERE Service_End_Date__c < TODAY '
        + 'AND Cancel_Date_Time__c != null '
        + 'AND Status__c IN (\'Active\', \'Paused\', \'Active - Pending Cancel\', \'Suspended\')';

    public MarkHistoricalUpdate() {}
    public Database.QueryLocator start(Database.BatchableContext bc)  {
        return Database.getQueryLocator(batchQuery);
    }
    public void execute(SchedulableContext context) {
        MarkHistoricalUpdate markUpdate = new MarkHistoricalUpdate();
        Database.executeBatch(markUpdate, 200);
    }
    public void execute(Database.BatchableContext bc, List<ChargeOver_Subscription_Line_Item__c> coSubLines){
        this.execute(coSubLines);
    }
    public void execute(List<ChargeOver_Subscription_Line_Item__c> coSubLines) {
        List<ChargeOver_Subscription_Line_Item__c> toUpdateCoSubLines = new List<ChargeOver_Subscription_Line_Item__c>();
        for(ChargeOver_Subscription_Line_Item__c subscriptionLine : coSubLines){
            subscriptionLine.Historical_Update__c = true;
            toUpdateCoSubLines.add(subscriptionLine);
        }
        update toUpdateCoSubLines;
        
    }

    public void finish(Database.BatchableContext bc){}    
}