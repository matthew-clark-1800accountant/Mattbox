public class AccountProductCategoriesController {
    
    public ApexPages.StandardController mySC;
    public Account a;
    public String aId;
    public Boolean outstandingPaymentsExist;
    public List<String> listProductCategories;
    public List<Bill62__Subscription__c> listActiveSubs;
    public List<Bill62__Subscription__c> listOldSubs;
    public List<Id> listActiveProductIds;
    public List<Id> listOldProductIds;
    public List<Product2> listActiveProducts;
    public List<Product2> listOldProducts;
    public List<Bill62__Payment__c> listOutstandingPayments {get; set;}
    public List<Bill62__Payment__c> listPastQueuedPayments {get;set;}
    public Set<String> setActiveCategories;
    public Set<String> setOldCategories;
    public String accountActiveCategories {get;set;}
    public String accountOldCategories {get;set;}
    
    public AccountProductCategoriesController(ApexPages.StandardController sc){
        mySC = sc;
        a = (Account)sc.getRecord();
        aId = sc.getId();
        listProductCategories = new List<String>();
        setActiveCategories = new Set<String>();
        setOldCategories = new Set<String>();
        accountActiveCategories = 'Active Products: ';
        accountOldCategories = 'Canceled / Suspended Products: ';
        Date today = date.today();
        
        // Get Product Categories list from schema
        Schema.sObjectType objType = Product2.getSObjectType(); 
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();       
        map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap(); 
        List<Schema.PicklistEntry> values = fieldMap.get('Product_Categories__c').getDescribe().getPickListValues();
        for(Schema.PicklistEntry v: values){
            listProductCategories.add(v.getValue());  
        }
        
        // Get Active Products and their respective Categories for current Account
        listActiveSubs = [Select Id
                        , Bill62__Account__c
                        , Bill62__Product__c
                        , Bill62__Active__c 
                        , Bill62__Suspended__c
                        , Bill62__Termination_Date__c
                        , Bill62__End_Date__c
                   from Bill62__Subscription__c 
                   where Bill62__Account__c = :aId
                        and Bill62__Active__c = true
                        and Bill62__Suspended__c = false
                        and (Bill62__Termination_Date__c > :today or Bill62__Termination_Date__c = null)
                        and (Bill62__End_Date__c > :today or Bill62__End_Date__c = null)
                  ];
        
        if(listActiveSubs.size() > 0){
        
            listActiveProductIds = new List<Id>();
            for(Bill62__Subscription__c s : listActiveSubs){
                listActiveProductIds.add(s.Bill62__Product__c);
            }
        
            listActiveProducts = [Select Id, Name, Product_Categories__c from Product2 where Id IN :listActiveProductIds];
            
            for(Product2 p : listActiveProducts){
                if(p.Product_Categories__c == null){
                    continue;
                }
                List<String> myCategories = p.Product_Categories__c.split(';');
                List<String> selectedCategories = new List<String>();               
                
                // Create list from all categories, flagging which ones are on product and which ones aren't
                for(String c : listProductCategories){  
                    for(String m : myCategories){
                        if(c == m){
                            selectedCategories.add(m);
                        }
                    }
                }
                
                setActiveCategories.addAll(selectedCategories);
            }
            
            if(setActiveCategories.size() > 0){
               accountActiveCategories = sortCategories(accountActiveCategories, setActiveCategories);
            } else {
                accountActiveCategories += 'None';
            }
            
        } else {
           // No Active Product Categories to display
           accountActiveCategories += 'None';
        }
        
        // Get Old Products and their respective Categories for current Account
        listOldSubs = [Select Id
                        , Bill62__Account__c
                        , Bill62__Product__c
                        , Bill62__Active__c 
                        , Bill62__Suspended__c
                        , Bill62__Termination_Date__c
                        , Bill62__End_Date__c
                   from Bill62__Subscription__c 
                   where Bill62__Account__c = :aId
                        and (Bill62__Active__c = false
                        or Bill62__Suspended__c = true
                        or Bill62__Termination_Date__c <= :today
                        or Bill62__End_Date__c <= :today)
                  ];
        
        if(listOldSubs.size() > 0){
        
            listOldProductIds = new List<Id>();
            for(Bill62__Subscription__c s : listOldSubs){
                listOldProductIds.add(s.Bill62__Product__c);
            }
            
            listOldProducts = [Select Id, Name, Product_Categories__c from Product2 where Id IN :listOldProductIds];
            
            for(Product2 p : listOldProducts){
                if(p.Product_Categories__c == null){
                    continue;
                }
                List<String> myCategories = p.Product_Categories__c.split(';');
                List<String> selectedCategories = new List<String>();               
                
                // Create list from all categories, flagging which ones are on product and which ones aren't
                for(String c : listProductCategories){  
                    for(String m : myCategories){
                        if(c == m){
                            selectedCategories.add(m);
                        }
                    }
                }
                
                setOldCategories.addAll(selectedCategories);
            }
            
            // Remove any Old Categories that are also still Active for other Products
            if(setActiveCategories.size() > 0){
                setOldCategories.removeAll(setActiveCategories);
            }
            
            if(setOldCategories.size() > 0){
               accountOldCategories = sortCategories(accountOldCategories, setOldCategories);
            } else {
                accountOldCategories += 'None';
            }
            
        } else {
            // No Old Product Categories to display
            accountOldCategories += 'None';
        }
        
        if(!accountActiveCategories.contains('None')){
            a.Active_Products__c = accountActiveCategories.split(':')[1].trim();
        } else {
            a.Active_Products__c = 'None';
        }
        
        if(!accountOldCategories.contains('None')){
            a.Canceled_Suspended_Products__c = accountOldCategories.split(':')[1].trim();
        } else {
            a.Canceled_Suspended_Products__c = 'None';
        }
        
        // Get Outstanding Invoices based on (field) Bill62__Status__c == 'Collections'
        //second alert added 11/23/16 - Queued payments in the past
        List<Bill62__Payment__c> payList = [Select Id, Bill62__Status__c
                   from Bill62__Payment__c 
                   where Bill62__Account__c = :aId
                        and (Bill62__Status__c = 'Collections' OR 
                        ( (Bill62__Status__c = 'Queued' OR Bill62__Status__c = 'Queued Retry') AND Bill62__Payment_Date__c < TODAY ) ) ]; 
        listOutstandingPayments = new List<Bill62__Payment__c>();
        listPastQueuedPayments = new List<Bill62__Payment__c>();
        for(Bill62__Payment__c pay: payList){
            if(pay.Bill62__Status__c == 'Collections') listOutstandingPayments.add(pay);
            if(pay.Bill62__Status__c == 'Queued' || pay.Bill62__Status__c == 'Queued Retry') listPastQueuedPayments.add(pay);
        }
    }
    
    public void updateFields(){
        update a;
    }
    
    public String sortCategories(String prefix, Set<String> setCats){
        String categories = '';
        
        /*Deprecated to not be hardcoded, custom setting below
        if(setCats.contains('Tax Consulting')){
            categories = categories + ', Tax Consulting';
        }
        if(setCats.contains('Business Tax Prep')){
            categories = categories + ', Business Tax Prep';
        }
        if(setCats.contains('Personal Tax Prep')){
            categories = categories + ', Personal Tax Prep';
        }
        if(setCats.contains('Full-Service Bookkeeping')){
            categories = categories + ', Full-Service Bookkeeping';
        }
        if(setCats.contains('Payroll')){
            categories = categories + ', Payroll';
        }
        if(setCats.contains('Estimated Taxes')){
            categories = categories + ', Estimated Taxes';
        }
        if(setCats.contains('Two-Year Review')){
            categories = categories + ', Two-Year Review';
        }
        if(setCats.contains('Loan Agreement')){
            categories = categories + ', Loan Agreement';
        }
        if(setCats.contains('Sales and Use Tax')){
            categories = categories + ', Sales and Use Tax';
        }
        if(setCats.contains('Client Books')){
            categories = categories + ', Client Books';
        }*/
        List<Account_Product_Settings__c> customSettings = [SELECT Product_Category__c FROM Account_Product_Settings__c
            ORDER BY Sort_Order__c ASC];
            
        for(Account_Product_Settings__c aps: customSettings){
            if(setCats.contains(aps.Product_Category__c)){
                categories += ', '+aps.Product_Category__c;
            }
        }
        
        if(categories.length() < 3){
            categories = 'None';
        } else {
            categories = categories.substring(2);
        }
        
        return prefix + categories;
    }
}