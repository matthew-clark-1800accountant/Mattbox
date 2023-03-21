@IsTest (SeeAllData=true)
public with sharing class zBAM_testAddNewCard {

    static TestMethod void AddNewCardTest() {
        Test.startTest();
 
        // Instantiate Your Test Controller       
        zBAM_AddNewCard anc = new zBAM_AddNewCard();
        anc.getExtraParameters();
        anc.successActions();
        anc.getPageRef();
        anc.getBackURL();
        anc.getNextURL();
        anc.navigateBack();
        // Call all the methods in your Class
        
        Test.stopTest();
    }
}