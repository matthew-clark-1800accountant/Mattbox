public without sharing class DedicatedAccountsPayableController {
    public Bill62__Subscription_Line__c dateHolder{get;set;}
    public static Date startDate{get;set;}
    public static Date endDate{get;set;}
    private List<AccountWrapper> accountData;
    public Dedicated_Accounts_Report_Settings__c setting{get;set;}

    public DedicatedAccountsPayableController(){
        //set default dates
        setting = Dedicated_Accounts_Report_Settings__c.getOrgDefaults();
        
        dateHolder = new Bill62__Subscription_Line__c();
        dateHolder.Bill62__Cycle_Start_Date__c = System.today().toStartOfMonth();
        dateHolder.Bill62__Cycle_End_Date__c = dateHolder.Bill62__Cycle_Start_Date__c.addDays(Date.daysInMonth(dateHolder.Bill62__Cycle_Start_Date__c.year(), dateHolder.Bill62__Cycle_Start_Date__c.month()) - 1);
        startDate = dateHolder.Bill62__Cycle_Start_Date__c;
        endDate = dateHolder.Bill62__Cycle_End_Date__c;
        
        fetchData();
    }
    
    public void fetchData(){
        startDate = dateHolder.Bill62__Cycle_Start_Date__c;
        endDate = dateHolder.Bill62__Cycle_End_Date__c;
        
        //get the Accounts
        Map<ID, Account> accountMap = new Map<ID, Account>([SELECT ID, Name, Customer_Number__c FROM Account 
        WHERE Account_Status__c = 'Dedicated' 
        AND CreatedDate <= :setting.Dedicated_Date__c 
        AND CreatedDate >= :setting.Dedicated_Start_Date__c
        ORDER BY Name]);
        
        Set<ID> AccountIDs = accountMap.keySet();
        
        //get existing Payments for the Accounts
        List<Bill62__Payment__c> payments = [SELECT ID, Name, Bill62__Amount__c, Bill62__Status__c, Bill62__Account__c, 
            Bill62__Subscription_Line__r.Cycle_Type__c,Bill62__Amount_Refunded__c,Bill62__Payment_Date__c,Bill62__Description__c,
            Bill62__Subscription_Line__c,Bill62__Transaction_Id__c
            FROM Bill62__Payment__c WHERE Bill62__Account__c IN :AccountIDs 
            AND 
            (
                (Bill62__Payment_Date__c >= :dateHolder.Bill62__Cycle_Start_Date__c 
                AND Bill62__Payment_Date__c <= :dateHolder.Bill62__Cycle_End_Date__c
                AND Bill62__Status__c NOT IN ('Authorized','Cancelled'))
                OR
                (Bill62__Payment_Date__c < :dateHolder.Bill62__Cycle_Start_Date__c
                AND Bill62__Subscription_Line__r.Cycle_Type__c = 'Quarterly')
            )];
        Set<String> paymentIDs = new Set<String>();
        Set<String> subLineIDs = new Set<String>();
        for(Bill62__Payment__c pay: payments){
            paymentIDs.add(pay.Id);
            if(pay.Bill62__Subscription_Line__c != null) subLineIDs.add(pay.Bill62__Subscription_Line__c);
        }
        
        //get Quarterly sublines outside the date range for the Accounts
        List<Bill62__Subscription_Line__c> subLines = [SELECT ID, Name, Bill62__Amount__c, Bill62__Subscription__c,Cycle_Type__c,
            Bill62__Subscription__r.Bill62__Account__c, Bill62__Cycle_Start_Date__c,Bill62__Schedule_Payment_Date__c,
            Bill62__Payment__c  
            FROM Bill62__Subscription_Line__c WHERE
            Bill62__Subscription__r.Bill62__Account__c IN :AccountIDs
            AND
            (
                Bill62__Payment__r.Bill62__Payment_Date__c < :dateHolder.Bill62__Cycle_Start_Date__c 
                OR 
                (
                    (Bill62__Cycle_Start_Date__c > :dateHolder.Bill62__Cycle_End_Date__c AND Bill62__Schedule_Payment_Date__c = null)
                    OR
                    (Bill62__Schedule_Payment_Date__c > :dateHolder.Bill62__Cycle_Start_Date__c)
                )
            )
            /*(
                (Bill62__Cycle_Start_Date__c >= :dateHolder.Bill62__Cycle_Start_Date__c AND Bill62__Cycle_End_Date__c <= :dateHolder.Bill62__Cycle_End_Date__c)
                OR
                (Bill62__Schedule_Payment_Date__c >= :dateHolder.Bill62__Cycle_Start_Date__c AND Bill62__Schedule_Payment_Date__c <= :dateHolder.Bill62__Cycle_End_Date__c)
                OR
                (Bill62__Cycle_Start_Date__c <= :dateHolder.Bill62__Cycle_Start_Date__c AND Bill62__Cycle_End_Date__c <= :dateHolder.Bill62__Cycle_End_Date__c
                AND Cycle_Type__c = 'Quarterly')
                OR
                (Bill62__Cycle_Start_Date__c >= :dateHolder.Bill62__Cycle_Start_Date__c AND Bill62__Cycle_Start_Date__c <= :dateHolder.Bill62__Cycle_End_Date__c
                AND Cycle_Type__c = 'Quarterly')
                OR
                (Bill62__Cycle_Start_Date__c <= :dateHolder.Bill62__Cycle_Start_Date__c AND Bill62__Cycle_End_Date__c >= :dateHolder.Bill62__Cycle_End_Date__c
                AND Cycle_Type__c = 'Quarterly')
            )*/
            AND Cycle_Type__c = 'Quarterly' 
            AND Bill62__Billing_Frequency__c = 'Recurring' 
            AND Bill62__Payment__c NOT IN :paymentIDs
            AND ID NOT IN :subLineIDs
            ORDER BY Bill62__Cycle_Start_Date__c ASC];
        
        
        //Map the existing Payments to Account
        Map<String,List<Bill62__Payment__c>> accountToPayMap = new Map<String,List<Bill62__Payment__c>>();
        for(Bill62__Payment__c pay: payments){
            pay.Bill62__Description__c = pay.Name;
            pay.Bill62__Transaction_Id__c = pay.Id;
            if(accountToPayMap.containsKey(pay.Bill62__Account__c)){
                List<Bill62__Payment__c> temp = accountToPayMap.get(pay.Bill62__Account__c);
                temp.add(pay);
                accountToPayMap.put(pay.Bill62__Account__c, temp);
            }else{
                List<Bill62__Payment__c> temp = new List<Bill62__Payment__c>();
                temp.add(pay);
                accountToPayMap.put(pay.Bill62__Account__c, temp);
            }
        }
        
        //Map the Quarterlies outside the date range to Account
        Set<String> subIDs = new Set<String>();
        for(Bill62__Subscription_Line__c subLine: subLines){
            if(paymentIDs.contains(subLine.Bill62__Payment__c) || subIDs.contains(subLine.Bill62__Subscription__c)){ 
                continue;
            }else{
                subIDs.add(subLine.Bill62__Subscription__c);
            }
            
            Bill62__Payment__c placeHolder = new Bill62__Payment__c();
            placeHolder.Bill62__Subscription_Line__r = subLine;
            placeHolder.Bill62__Status__c = 'Pending';
            placeHolder.Bill62__Amount__c = subLine.Bill62__Amount__c;
            placeHolder.Bill62__Account__c = subLine.Bill62__Subscription__r.Bill62__Account__c;
            placeHolder.Bill62__Transaction_Id__c = subLine.Id;
            placeHolder.Bill62__Description__c = subLine.Name;
            if(subLine.Bill62__Schedule_Payment_Date__c != null){
                placeHolder.Bill62__Payment_Date__c = subLine.Bill62__Schedule_Payment_Date__c;
            }else{
                placeHolder.Bill62__Payment_Date__c = subLine.Bill62__Cycle_Start_Date__c;
            }
            
            if(accountToPayMap.containsKey(placeHolder.Bill62__Account__c)){
                List<Bill62__Payment__c> temp = accountToPayMap.get(placeHolder.Bill62__Account__c);
                temp.add(placeHolder);
                accountToPayMap.put(placeHolder.Bill62__Account__c, temp);
            }else{
                List<Bill62__Payment__c> temp = new List<Bill62__Payment__c>();
                temp.add(placeHolder);
                accountToPayMap.put(placeHolder.Bill62__Account__c, temp);
            }
        }
        
        //build the data structure for display
        accountData = new List<AccountWrapper>();
        for(String s: accountMap.keySet()){
            if(accountToPayMap.containsKey(s)){
                accountData.add(new AccountWrapper(accountMap.get(s), accountToPayMap.get(s)));
            }else{
                accountData.add(new AccountWrapper(accountMap.get(s), new List<Bill62__Payment__c>()));
            }
        }
    }
    
    public void ghettoSetter(){
        startDate = dateHolder.Bill62__Cycle_Start_Date__c;
        endDate = dateHolder.Bill62__Cycle_End_Date__c;
    }
    
    public Decimal amountPaidPaid{
        get{
            List<AccountWrapper> wl = getPaidAccounts();
            amountPaidPaid = 0.0;
            for(AccountWrapper aw: wl){
                amountPaidPaid += aw.totalPaid;
            }
            return amountPaidPaid;
        }set;
    }
    
    public Decimal amountPaidOutside{
        get{
            List<AccountWrapper> wl = getQuarterlyAccounts();
            amountPaidOutside = 0.0;
            for(AccountWrapper aw: wl){
                amountPaidOutside += aw.totalPaid;
            }
            return amountPaidOutside;
        }set;
    }
    
    public Decimal amountPaidCollections{
        get{
            List<AccountWrapper> wl = getCollectionsAccounts();
            amountPaidCollections = 0.0;
            for(AccountWrapper aw: wl){
                amountPaidCollections += aw.totalPaid;
            }
            return amountPaidCollections;
        }set;
    }
    
    public Decimal amountDuePaid{
        get{
            List<AccountWrapper> wl = getPaidAccounts();
            amountDuePaid = 0.0;
            for(AccountWrapper aw: wl){
                amountDuePaid += aw.totalDue;
            }
            return amountDuePaid;
        }set;
    }
    
    public Decimal amountDueOutside{
        get{
            List<AccountWrapper> wl = getQuarterlyAccounts();
            amountDueOutside = 0.0;
            for(AccountWrapper aw: wl){
                amountDueOutside += aw.totalDue;
            }
            return amountDueOutside;
        }set;
    }
    
    public Decimal amountDueCollections{
        get{
            List<AccountWrapper> wl = getCollectionsAccounts();
            amountDueCollections = 0.0;
            for(AccountWrapper aw: wl){
                amountDueCollections += aw.totalDue;
            }
            return amountDueCollections;
        }set;
    }
    
    //getters to split the data up into appropriate sections
    public List<AccountWrapper> getPaidAccounts(){
        List<AccountWrapper> returnList = new List<AccountWrapper>();
        for(AccountWrapper aw: accountData){
            if(aw.totalPaid > 0.0){ 
                AccountWrapper theClone = aw.myClone();
                List<PaymentWrapper> pwClone = new List<PaymentWrapper>();
                for(paymentWrapper pw: aw.payments){
                    if(pw.thePayment.Bill62__Status__c == 'Pending' || 
                    (pw.thePayment.Bill62__Payment_Date__c < startDate && pw.thePayment.Bill62__Status__c == 'Paid')){
                        //removes.add(i);
                    }else{
                        pwClone.add(pw);
                    }
                }
                theClone.payments = pwClone;
                if(theClone.payments.size() > 0) returnList.add(theClone);
            }
        }
        return returnList;
    }
    
    public List<AccountWrapper> getQuarterlyAccounts(){
        List<AccountWrapper> returnList = new List<AccountWrapper>();
        for(AccountWrapper aw: accountData){
            AccountWrapper theClone = aw.myClone();
            List<PaymentWrapper> pwClone = new List<PaymentWrapper>();
            
            for(PaymentWrapper pw: aw.payments){
                if(pw.thePayment.Bill62__Status__c == 'Paid' 
                && pw.thePayment.Bill62__Payment_Date__c >= startDate){
                    pwClone = new List<PaymentWrapper>();
                    break;
                }
                
                if(pw.thePayment.Bill62__Subscription_Line__r.Cycle_Type__c == 'Quarterly' && 
                    (pw.thePayment.Bill62__Payment_Date__c < startDate || pw.thePayment.Bill62__Payment_Date__c > endDate)
                ){
                    pwClone.add(pw);
                }
            }
            theClone.payments = pwClone;
            if(theClone.payments.size() > 0) returnList.add(theClone);

        }
        return returnList;
    }
    
    public List<AccountWrapper> getCollectionsAccounts(){
        List<AccountWrapper> returnList = new List<AccountWrapper>();
        for(AccountWrapper aw: accountData){
            for(PaymentWrapper pw: aw.payments){
                if(pw.thePayment.Bill62__Status__c == 'Collections'){
                    returnList.add(aw);
                    break;
                }
            }
        }
        return returnList;
    }
    
    public List<AccountWrapper> getProblemAccounts(){
        //redo in this getter, because it's got different criteria: Accounts with no Subs, or Subs with no Lines
        List<AccountWrapper> returnList = new List<AccountWrapper>();
        Map<ID, Account> accountMap = new Map<ID, Account>([SELECT ID, Name, Customer_Number__c FROM Account 
        WHERE Account_Status__c = 'Dedicated' 
        AND CreatedDate <= :setting.Dedicated_Date__c 
        AND CreatedDate >= :setting.Dedicated_Start_Date__c
        ORDER BY Name]);
        
        List<Bill62__Subscription__c> subList = [SELECT ID, Bill62__Account__c, 
            (SELECT ID FROM Bill62__Subscription_Lines__r)
            FROM Bill62__Subscription__c
            WHERE Bill62__Account__c IN :accountMap.keyset()];
        Set<String> accountsWithSubs = new Set<String>();
        Set<String> accountsWithSubsButNoLines = new Set<String>();
        for(Bill62__Subscription__c sub: subList){
            accountsWithSubs.add(sub.Bill62__Account__c);
            if(sub.Bill62__Subscription_Lines__r.size() == 0) accountsWithSubsButNoLines.add(sub.Bill62__Account__c);
        }
        
        for(Account a: accountMap.values()){
            if(!accountsWithSubs.contains(a.Id) || accountsWithSubsButNoLines.contains(a.Id)){
                AccountWrapper aw = new AccountWrapper(a, new List<Bill62__payment__c>());
                returnList.add(aw);
            }
        }
        return returnList;
    }
    
    
    public class AccountWrapper{
        public Account theAccount{get;set;}
        public Decimal totalDue{
            get{
                totalDue = 0.0;
                for(PaymentWrapper p: payments){
                    if(p.thePayment.Bill62__Status__c != 'Paid' && p.thePayment.Bill62__Status__c != 'Partially Refunded'
                    && p.thePayment.Bill62__Status__c != 'Chargeback-Won'){
                        totalDue += (p.thePayment.Bill62__Amount__c);
                    }
                }
                return totalDue;
            }set;
        }
        public Decimal totalPaid{
            get{
                totalPaid = 0.0;
                for(PaymentWrapper p: payments){
                    if(p.thePayment.Bill62__Status__c == 'Paid' || p.thePayment.Bill62__Status__c == 'Partially Refunded'
                    || p.thePayment.Bill62__Status__c == 'Chargeback-Won'){
                        totalPaid += (p.thePayment.Bill62__Amount__c);
                        if(p.thePayment.Bill62__Amount_Refunded__c != null){
                            totalPaid -= p.thePayment.Bill62__Amount_Refunded__c;
                        }
                    }
                }
                return totalPaid;
            }set;
        }
        public List<PaymentWrapper> payments{get;set;}
        
        public AccountWrapper(Account a, List<Bill62__Payment__c> pays){
            theAccount = a;
            payments = new List<PaymentWrapper>();
            for(Bill62__Payment__c pay: pays){
                payments.add(new PaymentWrapper(pay));
            }
        }
        
        public AccountWrapper myClone(){
            List<Bill62__payment__c> payList = new List<Bill62__payment__c>();
            for(PaymentWrapper pw: this.payments){
                payList.add(pw.thePayment);
            }
            AccountWrapper theClone = new AccountWrapper(this.theAccount, payList);
            return theClone;
        }
    }
    public class PaymentWrapper{
        public Bill62__Payment__c thePayment{get;set;}
        public Boolean dueInRange{get;set;}
        public Boolean isPaid{
            get{
                if(thePayment.Bill62__Status__c == 'Paid' || thePayment.Bill62__Status__c == 'Partially Refunded'
                    || thePayment.Bill62__Status__c == 'Chargeback-Won'){
                    isPaid = true;
                }else{
                    isPaid = false;
                }
                return isPaid;
            }set;
        }
        
        public PaymentWrapper(Bill62__Payment__c pay){
            thePayment = pay;
            if(pay.Bill62__Payment_Date__c >= DedicatedAccountsPayableController.startDate 
            && pay.Bill62__Payment_Date__c <= DedicatedAccountsPayableController.endDate){
                dueInRange = true;
            }else{
                dueInRange = false;
            }
        }
    }
}