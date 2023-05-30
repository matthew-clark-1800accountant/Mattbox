public class GuidedSellingClientControllerExtension {
    public Opportunity opportunity {get; set;}

    //@RemoteAction
    public static String getsfBaseUrl(){
        return GuidedSellingControllerExtension.getsfBaseUrl();
    }

    public static String getsiteBaseUrl(){
        return GuidedSellingControllerExtension.getsiteBaseUrl();
    }

    public static String getschedulerBaseUrl(){
        return GuidedSellingControllerExtension.getschedulerBaseUrl();
    }

    public static String getsocketBaseUrl(){
        return GuidedSellingControllerExtension.getsocketBaseUrl();
    }

    public GuidedSellingClientControllerExtension(ApexPages.StandardController stdController) {
        //First identify the record Id passed in the parameters through the flow
        Id recordId = ApexPages.currentPage().getParameters().get('rId');
        String recordIdType = recordId?.getSObjectType().getDescribe().getName(); 
        Id eventId = ('Event' == recordIdType) ? recordId : null;
        Id leadId = ('Lead' == recordIdType) ? recordId : null;
        Id accountId = ('Account' == recordIdType) ? recordId : null;
        Id opportunityId = ('Opportunity' == recordIdType) ? recordId : null;
        //If there is an Event Id, get either an Opportunity or Account
        if(null != eventId){
            Event event = [
                SELECT Id, WhatId, WhoId
                FROM Event
                WHERE Id = :recordId
            ];
            //Getting either an Account or Opportunity from the Event
            if(null != event.WhatId && 'Account' == event.WhatId.getSObjectType().getDescribe().getName()){
                accountId = event.WhatId;
            }
            if(null != event.WhatId && 'Opportunity' == event.WhatId.getSObjectType().getDescribe().getName()){
                opportunityId = event.WhatId;
            }
        }
        //If there is a Lead Id, it was converted and we can get the Opportunity Id
        if(null != leadId){
            Lead lead = [
                SELECT Id, Name, Entity_Type__c, Company, LeadSource, Email, Owner.Name, Owner.Email, ConvertedOpportunityId
                FROM Lead
                WHERE Id = :leadId
            ];
            opportunityId = lead.ConvertedOpportunityId;
        }
        //In the case an Event has an Account and Opportunity, we only want the Opportunity
        if(null == opportunityId && null != accountId){
            Opportunity findLatestOpportunity = [
                SELECT Id, Name, AccountId
                FROM Opportunity
                WHERE AccountId = :accountId
                ORDER BY CreatedDate DESC
                LIMIT 1
            ];
            opportunityId = findLatestOpportunity.Id;
        }
        if(null != opportunityId){
            opportunity = [
                SELECT Id, Name, Account.Owner.Name, Account.Owner.TSA_Introduction__c, Account.Owner.Initials__c, Account.Lead_Source__c, Account.Lead_Type_New__c     
                FROM Opportunity
                WHERE Id = :opportunityId
            ];
        }
    }
}