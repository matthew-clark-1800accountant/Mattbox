public class FeedCommentTriggerHandler {
    public static void updateCase(List<FeedComment> commentList){
           Profile salesManagerProfile = [SELECT Id FROM Profile WHERE Name = 'Sales Manager'];
           User currentUser = [SELECT Id, Sales_Team__c FROM User WHERE Id = :UserInfo.getUserId()];
           
           //Check if FeedComment was posted by Sales Manager whose Sales team is not null
           if(UserInfo.getProfileId() == salesManagerProfile.Id && currentUser.Sales_Team__c != null){           
           		//make a list of all the parent ids
           		List<Id> caseIds = new List<Id>();
           		for(FeedComment f : commentList){
               		caseIds.add(f.ParentId);
           		}           
               
           		//create a list that will hold cases that fit our criteria
           		List<Case> casesToUpdate = new List<Case>();
                for(Case caseToUpdate : [SELECT Id, Manager_Response_Date__c FROM Case WHERE Id IN :caseIds AND RecordType.DeveloperName ='Quality_Assurance']){
           			//If Case field 'Manager response date' is blank, set it to today.
                	if (caseToUpdate != null && caseToUpdate.Manager_Response_Date__c == null){
                    	caseToUpdate.Manager_Response_Date__c = System.today();
                    	casesToUpdate.add(caseToUpdate);
                	}
           		}
           		update casesToUpdate;
      		}
    }
}