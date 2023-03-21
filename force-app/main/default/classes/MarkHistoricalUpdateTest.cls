@isTest
public class MarkHistoricalUpdateTest {
    @isTest
    public static void testMarkUpdate(){
        List<ChargeOver_Subscription_Line_Item__c> testBeforeUpdate = [
            SELECT Id, Name, Historical_Update__c
            FROM ChargeOver_Subscription_Line_Item__c
            WHERE Historical_Update__c = false
        ];
        System.assertEquals(1, testBeforeUpdate.size());
        Test.startTest();
        MarkHistoricalUpdate markUpdate = new MarkHistoricalUpdate();
        Database.executeBatch(markUpdate, 200);
        Test.stopTest();
        List<ChargeOver_Subscription_Line_Item__c> testUpdate = [
            SELECT Id, Name, Historical_Update__c
            FROM ChargeOver_Subscription_Line_Item__c
            WHERE Historical_Update__c = false
        ];
        System.assertEquals(0, testUpdate.size());
    }


    @TestSetup
    private static void testSetup() {
        ChargeOver_Subscription_Line_Item__c testCosl = new ChargeOver_Subscription_Line_Item__c(
            Status__c = 'Active',
            Service_End_Date__c = Date.today().addDays(-3),
            Cancel_Date_Time__c = Date.today()
        );
        insert testCosl;
    }
}