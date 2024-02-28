@isTest
public with sharing class CustomizeSandboxTest {
    @TestSetup
    static void makeData(){
        System.debug('**makeData');
        Chargeover_URL__C urlSetting = new Chargeover_URL__C();
        urlSetting.Chargeover_URL__C = 'https://1800accountant-training.chargeover.com';
        urlSetting.Chargeover_User__c = 'BRsZymlzMcYphijWPFIq5dUk6NtJVrL8';
        urlSetting.Chargeover_Pass__c = 'RH8lzb3Tuvae2GI9qcmsSFkjJABQP0nt';
        urlSetting.Scheduler_URL__c = 'https://1800accountant.com/sfapi/schedule/index_training.php';
        urlSetting.SetupOwnerId = UserInfo.getOrganizationId();
        insert urlSetting;
    }

    @isTest
    static void testMySandboxPrep() {
        Test.setMock(HttpCalloutMock.class, new CustomizeSandboxMockEndpoints());
        Test.startTest();
        CustomizeSandbox.runAllUpdates(1, true);
        Test.stopTest();
        System.assert(true);
    }

}