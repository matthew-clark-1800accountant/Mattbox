public class Z_TestFactory {
	
    public static Account makeAccount(){
        Account acc = new Account();
        
        acc.Name = 'Test';
        
        return acc;
    }
    
    public static Product2 makeProduct(){
        Product2 prod = new Product2();
        prod.Name = 'Test';
        prod.zqu__Type__c = 'Bundle';
        prod.Description = 'Test';
        prod.Price_Description__c = 'Test';
        
        insert prod;
        
        return prod;
    }
    
    public static Product2 makeProductStandalone(){
        Product2 prod = new Product2();
        prod.Name = 'Test';
        prod.zqu__Type__c = 'Standalone';
        prod.Description = 'Test';
        prod.Price_Description__c = 'Test';
        
        insert prod;
        
        return prod;
    }
    
    public static zqu__ProductRatePlan__c makePRP(Id prodId){
        zqu__ProductRatePlan__c prp = new zqu__ProductRatePlan__c();
        prp.Name = 'Test';
        prp.zqu__Product__c = prodId;
        
        insert prp;
        
        return prp;
    }
    
    public static zqu__ProductRatePlanCharge__c makePRPC(Id prpId){
        zqu__ProductRatePlanCharge__c prpc = new zqu__ProductRatePlanCharge__c();
        prpc.Name = 'Test';
        prpc.zqu__ProductRatePlan__c = prpId;
        
        insert prpc;
        
        return prpc;
    }
    
    public static zqu__Quote__c makeQuote(Id accId){
        zqu__Quote__c q = new zqu__Quote__c();
        
        q.Name = 'Test';
        q.zqu__Account__c = accId;
        
        insert q;
        
        return q;
    }
    
    public static zqu__QuoteProductOption__c makeQPO(Id qId, Id pId, Id p2Id){
        zqu__QuoteProductOption__c qpo = new zqu__QuoteProductOption__c();
        qpo.zqu__Quote__c = qId;
        qpo.zqu__RootProduct__c = pId;
        qpo.zqu__ChildProduct__c = p2Id;
        qpo.zqu__ParentProduct__c = pId;
        
        insert qpo;
        
        return qpo;
    }
    
    public static zqu__QuoteAmendment__c makeQA(Id qId){
        zqu__QuoteAmendment__c qa = new zqu__QuoteAmendment__c();
        qa.zqu__Quote__c = qId;
        qa.zqu__Type__c = 'NewProduct';
        
        insert qa;
        
        return qa;
    }
    
    public static zqu__QuoteRatePlan__c makeQRP(Id qaId, Id prpId){
        zqu__QuoteRatePlan__c qrp = new zqu__QuoteRatePlan__c();
        qrp.zqu__QuoteAmendment__c = qaId;
        qrp.zqu__ProductRatePlan__c = prpId;
        qrp.Name = 'Test';
        
        insert qrp;
        
        return qrp;
    }
    
    public static zqu__QuoteRatePlanOption__c makeQRPO(Id qrpId, Id qpoId, Id prpId, Id pId){
        zqu__QuoteRatePlanOption__c qrpo = new zqu__QuoteRatePlanOption__c();
        qrpo.zqu__QuoteRatePlan__c = qrpId;
        qrpo.zqu__QuoteProductOption__c = qpoId;
        qrpo.zqu__ProductRatePlan__c = prpId;
        qrpo.zqu__Product__c = pId;
        
        insert qrpo;
        
        return qrpo;
    }
    
    public static zqu__QuoteRatePlanCharge__c makeQRPC(Id qrpId, Id prpcId){
        zqu__QuoteRatePlanCharge__c qrpc = new zqu__QuoteRatePlanCharge__c();
        qrpc.zqu__QuoteRatePlan__c = qrpId;
        qrpc.zqu__ProductRatePlanCharge__c = prpcId;
        qrpc.Name = 'Test';
        
        insert qrpc;
        
        return qrpc;
    }
    
    public static zqu__QuoteRatePlanChargeOption__c makeQRPCO(Id qrpcId, Id qrpoId, Id prpcId, Id prpId){
        zqu__QuoteRatePlanChargeOption__c qrpco = new zqu__QuoteRatePlanChargeOption__c();
        qrpco.zqu__QuoteRatePlanCharge__c = qrpcId;
        qrpco.zqu__QuoteRatePlanOption__c = qrpoId;
        qrpco.zqu__ProductRatePlanCharge__c = prpcId;
        qrpco.zqu__ProductRatePlan__c = prpId;
        
        insert qrpco;
        
        return qrpco;
    }
    
}