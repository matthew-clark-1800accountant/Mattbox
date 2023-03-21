trigger QuoteMethodCheckTrigger on zqu__Quote__c (after update) {
    
    Set<String> quoteIDs = new Set<String>();
    Set<String> quoteIDs2 = new Set<String>();
    Set<String> quoteIDs3 = new Set<String>();
    Set<String> quoteIDs4 = new Set<String>();
    Set<String> quoteIDs5 = new Set<String>();
    Set<String> quoteIDs6 = new Set<String>();
    Set<String> quoteIDs7 = new Set<String>();
    Set<String> quoteIDs8 = new Set<String>();
    Set<String> quoteIDs9 = new Set<String>();
    Set<String> quoteIDs10 = new Set<String>();
    Set<String> quoteIDs11 = new Set<String>();
    Set<String> quoteIDs12 = new Set<String>();
    Set<String> quoteIDs13 = new Set<String>();
    
    for (zqu__Quote__c q : Trigger.old) {
        if (q.zqu__PaymentMethod__c != 'ACH') {
             quoteIDs.add(q.Id);
            // we need to check to see if payment method should be ACH - finance package
            //a.addError('You can\'t delete this record!');
        }
    }
    
    Set<String> rpIDs = new Set<String>();
    List<zqu__ProductRatePlan__c> rpList = [SELECT ID, Name FROM zqu__ProductRatePlan__c WHERE Name Like '%Finance'];
    
    for (zqu__ProductRatePlan__c p: rpList){
        rpIDs.add(p.ID);
    }
    
    
    List<zqu__QuoteRatePlan__c> existingRPs = [SELECT ID, zqu__Quote__c, zqu__QuoteRatePlanFullName__c, Name, zqu__ProductRatePlan__c FROM zqu__QuoteRatePlan__c WHERE zqu__Quote__c IN :quoteIDs AND zqu__ProductRatePlan__c IN :rpIDs];

    Set<String> changeIDs = new Set<String>();

    for(zqu__QuoteRatePlan__c r: existingRPs){
        changeIDs.add(r.zqu__Quote__c);
    }
    
    //Update quotes
    If(changeIDs.size()>0){
        
        list<zqu__Quote__c> saveQuoteList = [SELECT Id, zqu__PaymentMethod__c FROM zqu__Quote__c WHERE Id IN :changeIDs];
        
        if(saveQuoteList.size()>0){
            for(zqu__Quote__c l : saveQuoteList){
                l.zqu__PaymentMethod__c = 'ACH';
            }
            
            update saveQuoteList;
                   
        }
    }

}