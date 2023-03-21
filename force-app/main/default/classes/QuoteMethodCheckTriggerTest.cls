@isTest(seeAllData=false)
private class QuoteMethodCheckTriggerTest {
 
    Set<String> quoteIDs = new Set<String>();
    public static List<zqu__Quote__c> quotesList;
    
    static void init(){
    quotesList = new List<zqu__Quote__c>();

    }
 
    /** Test **/
    static testMethod void testWithExistingQuote() {
    init();
    Test.startTest();
      
      zqu__Quote__c aa =new zqu__Quote__c(Name='TestQ');
     insert aa;

     aa.Name = 'New';
     update aa;


    //insert quotesList;

      
    Test.stopTest();
    }
    
    
}