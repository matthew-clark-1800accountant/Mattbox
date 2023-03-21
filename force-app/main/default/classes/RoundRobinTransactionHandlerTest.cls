@isTest
public class RoundRobinTransactionHandlerTest{
    
    @testSetup
    public static void setUpData(){
        //set up test data for entire class
        Contact c = new Contact();
        c.FirstName = 'Test';
        c.LastName = 'Contact';
        insert c;
        Bill62__Payment_Method__c pm = new Bill62__Payment_Method__c();
        pm.Bill62__Customer__c = c.ID;
        pm.Bill62__Card_Holder_Name__c = 'Test Contact';
        pm.Bill62__Card_Number__c = '1111111111111111';
        pm.Bill62__Card_Type__c = 'Visa';
        pm.Bill62__Expiration_Date__c = System.Date.TODAY().addMonths(8);
        pm.Bill62__Payment_Type__c = 'Credit Card'; 
        insert pm;
        
        List<Bill62__Payment_Gateway__c> gL = new List<Bill62__Payment_Gateway__c>();
        Bill62__Payment_Gateway__c gate1 = new Bill62__Payment_Gateway__c(Name='Gate1',Bill62__Is_Testing__c=true,Bill62__Test_Login_Encrypted__c='test',Bill62__Test_Password_Encrypted__c='test');
        gL.add(gate1);
        Bill62__Payment_Gateway__c gate2 = new Bill62__Payment_Gateway__c(Name='Gate2',Bill62__Is_Testing__c=true,Bill62__Test_Login_Encrypted__c='test',Bill62__Test_Password_Encrypted__c='test');
        gL.add(gate2);
        Bill62__Payment_Gateway__c gate3 = new Bill62__Payment_Gateway__c(Name='Gate3',Bill62__Is_Testing__c=true,Bill62__Test_Login_Encrypted__c='test',Bill62__Test_Password_Encrypted__c='test');
        gL.add(gate3);
        Bill62__Payment_Gateway__c gate4 = new Bill62__Payment_Gateway__c(Name='Gate4',Bill62__Is_Testing__c=true,Bill62__Test_Login_Encrypted__c='test',Bill62__Test_Password_Encrypted__c='test');
        gL.add(gate4);
        insert gL;
        
        //it's important that these get inserted one at a time, they are ordered by createdDate later
        Round_Robin_Transaction_Setting__c rrt1 =  new Round_Robin_Transaction_Setting__c(Name=gate1.Name,Percentage__c=40.0);
        insert rrt1;
        Round_Robin_Transaction_Setting__c rrt2 =  new Round_Robin_Transaction_Setting__c(Name=gate2.Name,Percentage__c=25.0);
        insert rrt2;
        Round_Robin_Transaction_Setting__c rrt3 =  new Round_Robin_Transaction_Setting__c(Name=gate3.Name,Percentage__c=35.0);
        insert rrt3;
        Round_Robin_Transaction_Setting__c rrt4 =  new Round_Robin_Transaction_Setting__c(Name=gate4.Name,Percentage__c=0.0);
        insert rrt4;
        
        Org_Defaults__c o = new Org_Defaults__c();
        o.Amex_Gateway__c = gate4.ID;
        o.Discover_Gateway__c = gate4.ID;
        o.Round_Robin_Index__c = 0;
        insert o;
        
    }

    public static testmethod void testRoundRobin1(){
        //Get Test Data.
        Bill62__payment_method__c pm = [SELECT ID FROM Bill62__Payment_Method__c];
        Contact c = [SELECT ID FROM Contact];
        
        List<String> gate1List = new List<String>();
        List<String> gate2List = new List<String>();
        List<String> gate3List = new List<String>();
        List<String> gate4List = new List<String>();
        
        List<Bill62__payment__c> payList = new List<Bill62__Payment__c>();
        //create 100 payments, and check that they were round robined properly
        for(Integer i = 100;i > 0;i--){
            Bill62__Payment__c pay = new Bill62__Payment__c();
            pay.Bill62__Customer__c = c.ID;
            pay.Bill62__Payment_Method__c = pm.Id;
            payList.add(pay);
        }
        
        insert payList;
        
        payList = [SELECT ID, Bill62__payment_gateway__r.Name, bill62__payment_gateway__c FROM Bill62__Payment__c];
        
        //start test
        Test.startTest();
        for(Bill62__Payment__c p: payList){
            if(p.Bill62__payment_gateway__c != null){
                if(p.Bill62__payment_gateway__r.Name == 'Gate1') gate1list.add(p.ID);
                if(p.Bill62__payment_gateway__r.Name == 'Gate2') gate2list.add(p.ID);
                if(p.Bill62__payment_gateway__r.Name == 'Gate3') gate3list.add(p.ID);
                if(p.Bill62__payment_gateway__r.Name == 'Gate4') gate4list.add(p.ID);
            }
        }
        
        system.assertEquals(40, gate1list.size(), 'Gate 1 did not have 40 payments');
        system.assertEquals(25, gate2list.size(), 'Gate 2 did not have 25 payments');
        system.assertEquals(35, gate3list.size(),'Gate 3 did not have 35 payments');
        system.assertEquals(0, gate4list.size(), 'Gate 4 did not have 0 payments');
        //...system.assertEquals(expected, actual);
        //stop test
        Test.stopTest();
    }
    
    public static testmethod void testRoundRobin2(){
        //Get Test Data.
        Bill62__payment_method__c pm = [SELECT ID FROM Bill62__Payment_Method__c];
        Contact c = [SELECT ID FROM Contact];
        
        List<String> gate1List = new List<String>();
        List<String> gate2List = new List<String>();
        List<String> gate3List = new List<String>();
        List<String> gate4List = new List<String>();
        
        List<Bill62__payment__c> payList = new List<Bill62__Payment__c>();
        //create 50 payments, and check that they were round robined properly
        for(Integer i = 50;i > 0;i--){
            Bill62__Payment__c pay = new Bill62__Payment__c();
            pay.Bill62__Customer__c = c.ID;
            pay.Bill62__Payment_Method__c = pm.Id;
            payList.add(pay);
        }
        
        insert payList;
        
        List<Bill62__payment__c> payList2 = new List<Bill62__Payment__c>();
        //create 90 payments to check it picked up where it left off
        for(Integer i = 90;i > 0;i--){
            Bill62__Payment__c pay = new Bill62__Payment__c();
            pay.Bill62__Customer__c = c.ID;
            pay.Bill62__Payment_Method__c = pm.Id;
            payList2.add(pay);
        }
        
        insert payList2;
        
        payList = [SELECT ID, Bill62__payment_gateway__r.Name, bill62__payment_gateway__c FROM Bill62__Payment__c];
        
        //start test
        Test.startTest();
        for(Bill62__Payment__c p: payList){
            if(p.Bill62__payment_gateway__c != null){
                if(p.Bill62__payment_gateway__r.Name == 'Gate1') gate1list.add(p.ID);
                if(p.Bill62__payment_gateway__r.Name == 'Gate2') gate2list.add(p.ID);
                if(p.Bill62__payment_gateway__r.Name == 'Gate3') gate3list.add(p.ID);
                if(p.Bill62__payment_gateway__r.Name == 'Gate4') gate4list.add(p.ID);
            }
        }
        
        system.assertEquals(80, gate1list.size(), 'Gate 1 did not have 40 payments');
        system.assertEquals(25, gate2list.size(), 'Gate 2 did not have 25 payments');
        system.assertEquals(35, gate3list.size(),'Gate 3 did not have 35 payments');
        system.assertEquals(0, gate4list.size(), 'Gate 4 did not have 0 payments');
        //...system.assertEquals(expected, actual);
        //stop test
        Test.stopTest();
    }

}