@isTest(seeAllData=true)
private class ON24EventRegistrationControllerTest {
 
    /** Test **/
    static testMethod void testRegistration() {
        
        Test.startTest();
        
        PageReference pageRef = Page.RegistrationComplete;

        Test.setCurrentPage(pageRef);
        
        String firstName = 'test';
        
        String testID = '';
        
        ON24EventRegistrationController controller = new ON24EventRegistrationController();
        
        Lead[] leads = [SELECT Id, FirstName, LastName, Email, Phone, Webinar_Request__c, Status, Company, OwnerId FROM Lead WHERE FirstName='test' LIMIT 1];
        System.debug(leads.size());
        if (leads.size() > 0)
        testID = leads[0].Id;
        
        ApexPages.currentPage().getParameters().put('Id', testID);
        
        controller = new ON24EventRegistrationController();
        
        String eventTest = controller.getEventFT(); 
        System.debug(eventTest);
        controller.selEvent = eventTest;
        
        ApexPages.currentPage().getParameters().put('selEvent', eventTest);
        ApexPages.currentPage().getParameters().put('LastName', 'lastname');
        ApexPages.currentPage().getParameters().put('FirstName', 'firstname');
        ApexPages.currentPage().getParameters().put('Phone', '5551234455665');
        ApexPages.currentPage().getParameters().put('Email', 'firstlast@acme.com');
        
        controller.encode('test');
        controller.cancel();
        controller.regCompleteRedir();
        controller.schedRedir();
        controller.delay();
        
        PageReference nextPage = controller.eventRegister();
        
        Account[] accounts = [SELECT Id FROM Account WHERE name='test' LIMIT 1];
        System.debug(accounts.size());
        if (accounts.size() > 0)
        testID = accounts[0].Id;
        
        ApexPages.currentPage().getParameters().put('Id', testID);
        
        controller = new ON24EventRegistrationController();

        
        
        eventTest = controller.getEventFT(); 
        System.debug(eventTest);
        controller.selEvent = eventTest;
        controller.LastName = 'lastname';
        controller.FirstName = 'firstname';
        controller.Phone = '5551234455665';
        controller.Email = 'firstlast@acmetest.com';
        
        ApexPages.currentPage().getParameters().put('selEvent', eventTest);
        ApexPages.currentPage().getParameters().put('LastName', 'lastname');
        ApexPages.currentPage().getParameters().put('FirstName', 'firstname');
        ApexPages.currentPage().getParameters().put('Phone', '5551234455665');
        ApexPages.currentPage().getParameters().put('Email', 'firstlast@acme.com');
        
        controller.encode('test');
        controller.cancel();
        controller.regCompleteRedir();
        controller.schedRedir();
        controller.delay();
        
        PageReference nextPage2 = controller.eventRegister();

      
        Test.stopTest();
    }
    
    
}