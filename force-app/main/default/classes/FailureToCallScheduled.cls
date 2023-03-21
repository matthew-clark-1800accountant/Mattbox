public with sharing class FailureToCallScheduled implements Schedulable {
    public void execute(SchedulableContext sc) {
      System.debug('FailureToCallScheduled.execute()');
       FailureToCallBatchable b = new FailureToCallBatchable(); 
       Database.executeBatch(b);
    }
 }