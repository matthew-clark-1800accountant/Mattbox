@isTest private class CreatePayrollDatesControllerTest {
    
    @testSetup static void CreateTestData(){
        Account a = new Account();
        a.Name = 'Test Account';
        insert a;
        
        Account_Product__c ap = new Account_Product__c();
        ap.Account__c = a.Id;
        ap.Payroll_Accountant__c = UserInfo.getUserId();
        ap.Start_Date__c = date.newInstance(2015, 7, 7);
        ap.Interval__c = 'Monthly';
        insert ap;        
    }
    
    static testMethod void CreatePayrollDates(){
        Account a = [Select Id from Account LIMIT 1];
        Account_Product__c ap = [Select Id, Account__c from Account_Product__c where Account__c = :a.Id LIMIT 1];
        CreatePayrollDatesController cpd = new CreatePayrollDatesController(new ApexPages.StandardController(ap));
        cpd.CreatePayrollDates();
    }
}