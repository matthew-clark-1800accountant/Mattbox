@isTest
public class zChargeTesting {
	
    @isTest public static void test1(){
        Test.startTest();
        Product2 p = Z_TestFactory.makeProduct();
        zqu__ProductRatePlan__c prp = Z_TestFactory.makePRP(p.Id);
        zqu__ProductRatePlanCharge__c prpc = Z_TestFactory.makePRPC(prp.Id);
        
        Product2 p2 = Z_TestFactory.makeProductStandalone();
        zqu__ProductRatePlan__c prp2 = Z_TestFactory.makePRP(p2.Id);
        zqu__ProductRatePlanCharge__c prpc2 = Z_TestFactory.makePRPC(prp2.Id);
        
        Account acc = Z_TestFactory.makeAccount();
        zqu__Quote__c q = Z_TestFactory.makeQuote(acc.Id);
        
        zqu__QuoteAmendment__c qa2 = Z_TestFactory.makeQA(q.Id);
        zqu__QuoteRatePlan__c qrp2 = Z_TestFactory.makeQRP(qa2.Id, prp.Id);
        zqu__QuoteRatePlanCharge__c qrpc2 = Z_TestFactory.makeQRPC(qrp2.Id, prpc.Id);
        
        zqu__QuoteProductOption__c qpo = Z_TestFactory.makeQPO(q.Id, p.Id, p2.Id);
        zqu__QuoteAmendment__c qa = Z_TestFactory.makeQA(q.Id);
        zqu__QuoteRatePlan__c qrp = Z_TestFactory.makeQRP(qa.Id, prp2.Id);
        zqu__QuoteRatePlanOption__c qrpo = Z_TestFactory.makeQRPO(qrp.Id, qpo.Id, prp2.Id, p2.Id);
        zqu__QuoteRatePlanCharge__c qrpc = Z_TestFactory.makeQRPC(qrp.Id, prpc2.Id);
        zqu__QuoteRatePlanChargeOption__c qrpco = Z_TestFactory.makeQRPCO(qrpc.Id, qrpo.Id, prpc2.Id, prp2.Id);
        
        Test.stopTest();
    }
}