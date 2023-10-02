public class CreateTestDataBatchable implements Database.Batchable<SObject>{
    public String query;
    public List<Id> contactIds;
    public Set<Id> profileIds;
    public Id currentUserId;

    public CreateTestDataBatchable(String queryString){
        query = queryString;
        contactIds = new List<Id>(new Map<Id,Contact>([SELECT Id FROM Contact LIMIT 1000]).keySet());
        List<String> profileNames = new List<String>{'InsideSalesUser - Zuora', 'Inbound User', 'Sales Manager'};
        List<Profile> salesProfiles = [SELECT Id FROM Profile WHERE Name IN :profileNames];
        profileIds = new Map<Id, Profile>(salesProfiles).keySet();
        currentUserId = UserInfo.getUserId();
    }

    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
     }
  
    public void execute(Database.BatchableContext BC, List<User> scope){
        System.debug(query);
        System.debug(contactIds);
        System.debug(profileIds);
        for(Integer i=0; i<scope.size(); i++){
            MulticalendarDataService.makeTestData(scope[i].Id, contactIds[Math.mod(i,contactIds.size())]);
        }
    }
  
     public void finish(Database.BatchableContext BC){
     }


}