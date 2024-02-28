public class ON24EventLinkGeneratorController {
    //deprecated 11-9-23
    // public Map<String,List<ON24_Event__c>> getEventNameMap(){
    //     Map<String,List<ON24_Event__c>> eventNameMap = new Map<String,List<ON24_Event__c>>();
    //     for(ON24_Event__c e : [SELECT Id, Event_Time__c,Key__c,Event_ID__c,Event_Name__c FROM ON24_Event__c WHERE Event_Time__c != null and Day_Only(Event_Time__c) <= :Date.today().addDays(7) and Event_Time__c > :DateTime.now() order by Event_Time__c asc ]){
    //         if(eventNameMap.get(e.Event_Name__c) == null){
    //             eventNameMap.put(e.Event_Name__c, new List<ON24_Event__c>());
    //         }
    //         eventNameMap.get(e.Event_Name__c).add(e);
    //     }
        
    //     return eventNameMap;
    // }
    // public String link {get;set;}
    // public String generateThisLink {get;set;}
    
    // public PageReference goToRegistration(){
    //     generateLink();
    //     return new PageReference(link);
    // }
    
    // public void generateLink(){
    //     system.debug(generateThisLink);
    //     String sandboxURL = 'ostrich-1800accountant.cs22.force.com';
    //     String prodURL = '1800accountant.force.com';
    //     link = 'http://' + prodURL + '/WebinarRegistration?Id='+ ApexPages.currentPage().getParameters().get('id') + '&Setter=' + UserInfo.getUserId() + '&EventName=' + EncodingUtil.urlEncode(generateThisLink, 'UTF-8') + '&tzoffset=' + string.valueof(ArizonaTimeOffset.offset());
    // }
    
    // public ON24EventLinkGeneratorController(){
    //     link = '';
        
    // }

}