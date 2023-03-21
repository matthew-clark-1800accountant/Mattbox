public class C62ContactOverrideController{

    public ApexPages.StandardController sc;
    public Contact contact;
    public String cId;
    public List<Bill62__Payment__c> collectionPayments {get; set;}

    public C62ContactOverrideController(ApexPages.StandardController controller){
        sc = controller;
        contact = (Contact)controller.getRecord();
        cId = controller.getId();
        collectionPayments = [SELECT Id FROM Bill62__Payment__c WHERE Bill62__Customer__c = :cId and Bill62__Status__c = 'Collections'];
        System.debug(collectionPayments);
        System.debug(collectionPayments.size());
    }

}