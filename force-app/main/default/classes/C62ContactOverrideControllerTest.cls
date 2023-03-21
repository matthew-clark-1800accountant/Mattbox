@isTest public class C62ContactOverrideControllerTest{

    @testSetup static void createData(){
        Contact c = new Contact(LastName = 'LastName', FirstName = 'FirstName');
        insert c;
        
        Bill62__Payment__c p = new Bill62__Payment__c(RecordTypeId = '012j0000000cJaSAAU', Bill62__Customer__c = c.Id, Bill62__Status__c = 'Collections');
        insert p;
    }
    
    static testMethod void test0(){
        Contact ct = [SELECT Id FROM Contact WHERE Name = 'FirstName LastName'];
        List<Contact> contactList = [SELECT Id FROM Contact WHERE Name = 'FirstName LastName'];
        System.debug('Contact: ' + contactList);        
        Bill62__Payment__c payment = [SELECT Id, Bill62__Customer__c, Bill62__Status__c FROM Bill62__Payment__c WHERE Bill62__Customer__c = :contactList[0].Id];
        System.debug('Payments: ' + payment);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(contactList[0]);
        C62ContactOverrideController controller = new C62ContactOverrideController(sc);
        
        System.assertEquals(contactList[0].Id, payment.Bill62__Customer__c);
        System.assertEquals(1, contactList.size());
    }

}