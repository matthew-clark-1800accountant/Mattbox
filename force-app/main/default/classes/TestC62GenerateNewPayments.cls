@isTest (seeAllData=true)
private class TestC62GenerateNewPayments {

    static testMethod void doTest() {     
        Test.startTest();
        C62GenerateNewPayments b = new C62GenerateNewPayments();
        Database.executeBatch(b);
        Test.stopTest();
    }
}