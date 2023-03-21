public without sharing class C62HTMLPaymentReceiptController{

    public List<lineWrapper> wrapperList{get;set;}
    public String purchased{get;set;}
    public Decimal monthlyCharge{get;set;}
    public Decimal totalDue{get;set;}
    public Bill62__Payment__c thePayment{get;set;}     
    public Date orderDate{get;set;}
    public ID paymentID{get;set;}
    public Integer debug{get;set;}
    public Date dueDate{get;set;}
    public String cycleType{get;set;}
    public String specialMessage{get;set;}
    public Boolean hasSpecialMessage{get;set;}
    public ID X1800_Logo {get;set;}
    public String servUrl {get;set;}
    public List<String> billingNotes {get;set;}
    public Map<String, String> billingNotesMap {get;set;}
    public Boolean hasBillingNotes {get;set;}
    
    public C62HTMLPaymentReceiptController(){
        X1800_Logo = [SELECT ID FROM Document WHERE DeveloperName = 'X1800_Logo' LIMIT 1].Id;
        servUrl = Url.getSalesforceBaseUrl().toExternalForm();
    }
    
    public Bill62__Payment__c getPayment(){
        billingNotesMap = new Map<String, String>();
        system.debug('paymentID: '+paymentID);
        purchased = '';
        monthlyCharge = 0.0;
        debug = 0;
        thePayment = new Bill62__Payment__c();
        orderDate = System.Date.TODAY();
        List<Bill62__payment__c> payList = [SELECT ID, Name, Bill62__Order__c, Bill62__Subscription__c, Bill62__Subscription__r.Bill62__Order__c, Bill62__Amount__c,
            Bill62__Payment_Method__r.Name, Bill62__Subscription__r.Bill62__Billing_Schedule__c, Bill62__Processing_Message__c, Bill62__Amount_Used__c,
            Bill62__Subscription__r.Bill62__Start_Date__c,Bill62__Payment_Date__c, Bill62__Payment_Method__r.Bill62__Customer__r.Account.Name,
            Bill62__Payment_Method__r.Bill62__Customer__r.Name, 
            Bill62__Payment_Method__r.Bill62__Customer__r.Account.Company_Brand__c, Bill62__Payment_Method__r.Bill62__Phone_Number__c,
            Bill62__Payment_Method__r.Bill62__Billing_Address__r.Bill62__Street_1__c,Bill62__Payment_Method__r.Bill62__Billing_Address__r.Bill62__Street_2__c,
            Bill62__Payment_Method__r.Bill62__Billing_Address__r.Bill62__City__c,Bill62__Payment_Method__r.Bill62__Billing_Address__r.Bill62__State_Province__c,
            Bill62__Payment_Method__r.Bill62__Billing_Address__r.Bill62__Country__c,Bill62__Payment_Method__r.Bill62__Billing_Address__r.Bill62__Zip_Postal_Code__c, 
            Bill62__Payment_Method__r.Bill62__Card_Type__c, Bill62__Payment_Method__r.Credit_Card_Last_4__c
            FROM Bill62__Payment__c WHERE ID = :paymentID];
        if(payList.size() > 0){
            thePayment = payList[0];
            system.debug('found a payment: '+ thePayment);
            //thePayment.Bill62__Processing_Message__c = '';
            //thePayment.Bill62__Amount_Used__c = 0.0;
        }
        
        monthlyCharge = 0.0;
        totalDue = 0.0;
        wrapperList = new List<lineWrapper>();
        Map<String, List<Bill62__Subscription_Line__c>> crazyMap = new Map<String, List<Bill62__Subscription_Line__c>>();
        Map<String, Bill62__Subscription_Line__c> recurringMap = new Map<String, Bill62__Subscription_Line__c>();
        
        List<Bill62__Subscription_Line__c> subLines;
        if(thePayment.Bill62__Subscription__r.Bill62__Order__c != null){
        system.debug('in the order');
            //calculate for entire Order
            subLines = [SELECT ID, Bill62__Cycle_Start_Date__c, Bill62__Amount__c, Bill62__Cycle_Type__c, Bill62__Payment__c,
                Bill62__Subscription__r.Bill62__Product__r.Description, Bill62__Subscription__r.Bill62__Product__r.Product_Receipt_Name__c,
                Bill62__Billing_Frequency__c, Bill62__Subscription__r.Bill62__Product__r.Add_Special_Message__c, Bill62__Subscription__r.Bill62__Product__r.Billing_Schedule_Notes__c
                FROM Bill62__Subscription_Line__c WHERE Bill62__Subscription__r.Bill62__Order__c = :thePayment.Bill62__Order__c AND Bill62__Payment__c = :paymentId];
        }else{
        system.debug('not in the order');
            //just sub
            subLines = [SELECT ID, Bill62__Cycle_Start_Date__c, Bill62__Amount__c, Bill62__Cycle_Type__c, Bill62__Payment__c,
                Bill62__Subscription__r.Bill62__Product__r.Description, Bill62__Subscription__r.Bill62__Product__r.Product_Receipt_Name__c,
                Bill62__Billing_Frequency__c, Bill62__Subscription__r.Bill62__Product__r.Add_Special_Message__c, Bill62__Subscription__r.Bill62__Product__r.Billing_Schedule_Notes__c
                FROM Bill62__Subscription_Line__c WHERE Bill62__Subscription__c = :thePayment.Bill62__Subscription__c AND Bill62__Payment__c = :paymentId];
        }        
        
        hasSpecialMessage = false;
        hasBillingNotes = false;
        specialMessage = Org_Defaults__c.getOrgDefaults().Special_Invoice_Message__c;
        for(Bill62__Subscription_Line__c sl: subLines){

            if(sl.Bill62__Subscription__r.Bill62__Product__r.Billing_Schedule_Notes__c != null){
                hasBillingNotes = true;
                billingNotesMap.put(sl.Bill62__Subscription__r.Bill62__Product__c, sl.Bill62__Subscription__r.Bill62__Product__r.Billing_Schedule_Notes__c);
            }

            if(sl.Bill62__Subscription__r.Bill62__Product__r.Add_Special_Message__c) hasSpecialMessage = true;
            
            if(sl.Bill62__Billing_Frequency__c == 'One-Time'){
                if(dueDate == null){
                    dueDate = sl.Bill62__Cycle_Start_Date__c;
                }else{
                    if(sl.Bill62__Cycle_Start_Date__c > dueDate){
                        dueDate = sl.Bill62__Cycle_Start_Date__c;
                    }
                }
                
                if(sl.Bill62__Amount__c != null && sl.Bill62__Payment__c != thePayment.Id){
                    totalDue += sl.Bill62__Amount__c;
                }
                
                if(crazyMap.containsKey(sl.Bill62__Subscription__r.Bill62__Product__r.Product_Receipt_Name__c)){
                    List<Bill62__Subscription_Line__c> temp = crazyMap.get(sl.Bill62__Subscription__r.Bill62__Product__r.Product_Receipt_Name__c);
                    temp.add(sl);
                    crazyMap.put(sl.Bill62__Subscription__r.Bill62__Product__r.Product_Receipt_Name__c, temp);
                }else{
                    List<Bill62__Subscription_Line__c> temp = new List<Bill62__Subscription_Line__c>();
                    temp.add(sl);
                    crazyMap.put(sl.Bill62__Subscription__r.Bill62__Product__r.Product_Receipt_Name__c, temp);
                }
            }else{
                //recurring
                if(!recurringMap.containsKey(sl.Bill62__Subscription__c)){
                    recurringMap.put(sl.Bill62__Subscription__c, sl);
                }
                cycleType = sl.Bill62__Cycle_Type__c;
                cycleType = cycleType.toLowerCase();
            }
        }
        
        if(hasBillingNotes){
            billingNotes = billingNotesMap.values();
        }

        for(String s: recurringMap.keySet()){
            if(recurringMap.get(s).Bill62__Amount__c != null) monthlyCharge += recurringMap.get(s).Bill62__Amount__c;
        }
        
        List<List<Bill62__Subscription_Line__c>> lineList = new List<List<Bill62__Subscription_Line__c>>();
system.debug(crazyMap);
        for(String s: crazyMap.keySet()){
            List<Bill62__Subscription_Line__c> subsLineList = crazyMap.get(s);
            system.debug(subsLineList);
            for(Bill62__Subscription_Line__c sl : subsLineList){
                system.debug(sl);
                List<Bill62__Subscription_Line__c> subList = new List<Bill62__Subscription_Line__c>();
                lineList.add(subsLineList);
                break;
            }
        }

        for(List<Bill62__Subscription_Line__c> sbl : lineList){
            lineWrapper snoopDogg = new lineWrapper(sbl);
            wrapperList.add(snoopDogg);
        }        
                       
        
        return thePayment;
    }
     
    public class lineWrapper{
         public List<Bill62__Subscription_Line__c> subLines{get;set;}
         public String ProductName{
             get{
                if(subLines != null && subLines.size() > 0){
                    ProductName = subLines[0].Bill62__Subscription__r.Bill62__Product__r.Product_Receipt_Name__c;
                }
                return ProductName;
            }set;
        }
         public String ProductDescription{
             get{
                if(subLines != null && subLines.size() > 0){
                    ProductDescription = sublines[0].Bill62__Subscription__r.Bill62__Product__r.Description;
                }
                return ProductDescription;
            }set;
        }
         public Decimal lineAmount{
             get{
                if(subLines != null && subLines.size() > 0){
                    lineAmount = 0;
                    for(Bill62__Subscription_Line__c sl: subLines){
                        lineAmount += sl.Bill62__Amount__c;
                    }
                }
                return lineAmount;
            }set;
        }
        
        public lineWrapper(List<Bill62__Subscription_Line__c> sls){
            subLines = sls;
            
        }
    }
    
}