@isTest
private class TestTransferActions {
	
	static testMethod void TestSetTransferEligibilityonLeads() {
		Lead l = new Lead();
		l.firstname = 'Test';
		l.lastname =  'Lead';
		l.Company = 'Test Company';
		l.Status = 'New';
		Test.startTest();
		insert l;
		TransferActions.SetTransferEligibilityonLeads();
		Lead testlead = [SELECT ID,Status,Transfer_Eligible__c FROM Lead WHERE ID = :l.id];
		System.assert(testlead.Transfer_Eligible__c == FALSE,'Lead given transfer eligibility incorrectly');
		Test.stopTest();
	}
	
	static testMethod void TestSetTransferEligibilityonAccounts() {
		Account a = new Account();
		a.name = 'Test Account';
		a.Lead_Status__c = 'New';
		Test.startTest();
		insert a;
		TransferAccts.SetTransferEligibilityonAccounts();
		Account testacct = [SELECT ID,Lead_Status__c,Transfer_Eligible__c FROM Account WHERE ID = :a.id];
		System.assert(testacct.Transfer_Eligible__c == FALSE,'Account given transfer eligibility incorrectly');
		Test.stopTest();
	}
}