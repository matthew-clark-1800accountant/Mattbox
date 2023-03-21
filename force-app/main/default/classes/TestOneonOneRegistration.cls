@isTest

private class TestOneonOneRegistration {

    static testmethod void multiSelect() {
        
        Account acc= new Account(name = 'Acme');
        insert acc;
        ApexPages.currentPage().getParameters().put('id', acc.id);
        ApexPages.currentPage().getParameters().put('ownerId', null);
        
        OneonOneRegistrationController twoTest= new OneonOneRegistrationController();
        twotest.dosubmit();
        twotest.thelead = null;
        twotest.myDate = '12/12/12';
        twotest.myTime = '1:30';
        twotest.topage2();
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User urep = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, isActive=true,
            TimeZoneSidKey='America/Los_Angeles', UserName='teewtretnmmioin@testorg.com');
        insert urep;
        
        ApexPages.StandardController stc = new ApexPages.StandardController(acc);
        
        
        String FirstName = 'test';
        String LastName = 'mctester';
        String myTime = '12:30';
        String myDate = '12/12/12';
        String phone = '555-555';
        String email = 'test@example.com';
        String state = 'NY';
        Test.setCurrentPage(Page.OneOnOneRegistration);
        ApexPages.currentPage().getParameters().put('firstname', FirstName);
        ApexPages.currentPage().getParameters().put('lastname', LastName);
        ApexPages.currentPage().getParameters().put('phone', phone);
        ApexPages.currentPage().getParameters().put('email', email);
        ApexPages.currentPage().getParameters().put('state', state);
        ApexPages.currentPage().getParameters().put('ownerId', '005j000000BEyMX');
        ApexPages.currentPage().getParameters().put('setter', 'setter');
        
        /*ApexPages.currentPage().getParameters().put(
        ApexPages.currentPage().getParameters().put(
        */
        OneonOneRegistrationController oneTest = new OneonOneRegistrationController(stc);            
        
        onetest.myDate = '12/12/12';
        onetest.myTime = '12:30';
        onetest.getMultiSelect();
        onetest.makeLead();
        onetest.toPage2();
        onetest.doSubmit();
        List<String> hd = OneonOneRegistrationController.getHolidayDates();    
        List<String> al = OneonOneRegistrationController.appointmentLimit(myDate, urep.id, acc.id);
        
        
    }
}