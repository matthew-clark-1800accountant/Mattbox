/*Deprecated
@Name            : BatchProcessLegalZoom 
@Author          : customersuccess@cloud62.com
@Date            : 
@Description     : 
@Last Modify     : 
*/
global class BatchProcessLegalZoom implements Database.Batchable<sObject>, Schedulable{ //
    
    String query = '';
    
    global void execute(SchedulableContext ctx) {
        BatchProcessLegalZoom batch1 = new BatchProcessLegalZoom();
        ID batchprocessid = Database.executeBatch(batch1);
    }
    
    global Database.querylocator start(Database.BatchableContext BC){
    //     //BatchGovernorLimitUtility.insertBatchRun('BatchProcessLegalZoom');
    //     query = 'Select Id, Name, Account__c, Business_Purpose__c, City__c, '
    //         + ' Contact__c, Current_Status__c,  Date_Orders__c, Date_Started__c, '
    //         + ' EMail__c, First_Name__c, Last_Name__c, Mailing_Address__c, Number__c,'
    //         + ' Order__c,   Order_Number__c, Package__c, Phone__c,  Postal_Code__c, '
    //         + ' Process__c, Product_Name__c, Sent_to_Customer__c, State__c, State_of_Formation__c, '
    //         + ' Status__c '
    //         + ' FROM Legal_Zoom__c'
    //         + ' WHERE STATUS__C = NULL OR STATUS__C = \'Pending\' '
    //         //+ ' LIMIT 10'
    //         + '';
    //     if (Test.isRunningTest()){
    //         query += ' LIMIT 200';
    //     }
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext NC, List<sObject> scope){
    //     /*List<Legal_Zoom__c> scopeList = (List<Legal_Zoom__c>) scope;
    //     Set<String> accNameSet = new Set<String>();
    //     Map<String, Legal_Zoom__c> accDetailMap = new Map<String, Legal_Zoom__c>();
    //     List<Account> insertAccount = new List<Account>();
    //     List<Contact> insertContact = new List<Contact>();
    //     List<Bill62__Order__c> insertOrder = new List<Bill62__Order__c>();
    //     List<Bill62__Subscription__c> insertSub = new List<Bill62__Subscription__c>();
    //     Map<String, Bill62__Order__c> orderMap = new Map<String, Bill62__Order__c>();
    //     Map<String, Map<String, Legal_Zoom__c>> emailMap = new Map<String, Map<String, Legal_Zoom__c>>();
    //     Set<String> emailSet = new Set<String>();
        
    //     for (Legal_Zoom__c l : scopeList){
    //         accNameSet.add(l.Name);
    //         accDetailMap.put(l.Name, l);
    //         emailSet.add(l.Email__c);
    //         if (!emailMap.containsKey(l.Name)){
    //             emailMap.put(l.Name, new Map<String, Legal_Zoom__c>());
    //         }
    //         emailMap.get(l.Name).put(l.Email__c, l);
    //     }
        
    //     List<Account> accList = [SELECT ID, NAME FROM ACCOUNT WHERE NAME IN: accNameSet];
    //     Map<String, Account> accMap = new Map<String, Account>();
    //     for (Account a : accList){
    //         accMap.put(a.Name, a);
    //     }
        
    //     for (String x : accNameSet){
    //         if (!accMap.containsKey(x)){
    //             Account newAcc = createAccount(accDetailMap.get(x));
    //             insertAccount.add(newAcc);
    //             accMap.put(x, newAcc);
    //         }
    //     }
        
    //     insert insertAccount;
        
    //     List<Contact> contactList = [SELECT ID, FIRSTNAME, LASTNAME,
    //         ACCOUNTID, ACCOUNT.NAME, Email
    //         FROM CONTACT WHERE Account.Name IN: accNameSet];
    //     Map<String, Map<String, Contact>> conMap = new Map<String, Map<String, Contact>>();
    //     for (Contact c : contactList){
    //         if (!conMap.containsKey(c.Account.Name)){
    //             conMap.put(c.Account.Name, new Map<String, Contact>());
    //         }
    //         conMap.get(c.Account.Name).put(c.Email, c);
    //     }
        
    //     for (String accName : emailMap.keySet()){
    //         if(accMap.containsKey(accName)){
    //             for (Legal_Zoom__c l : emailMap.get(accName).values()){
    //                 Boolean create = false;
    //                 if (!conMap.containsKey(accName)){
    //                     create = true;
    //                 }else if (!conMap.get(accName).containsKey(l.Email__c)){
    //                     create = true;
    //                 }
    //                 if (create){
    //                     Contact newCon = createContact(l, accMap.get(l.Name).Id);
    //                     insertContact.add(newCon);
    //                     if (!conMap.containsKey(accName)){
    //                         conMap.put(accName, new Map<String, Contact>());
    //                     }
    //                     conMap.get(accName).put(l.Email__c, newCon);
    //                 }
    //             }
    //         }   
    //     }
        
    //     insert insertContact;
        
    //     for (Legal_Zoom__c l : scopeList){
    //         Bill62__Order__c o = new Bill62__Order__c();
    //         o.Bill62__Account__c = accMap.get(l.Name).Id;
    //         o.Bill62__Customer__c = conMap.get(l.Name).get(l.Email__c).Id;
    //         o.Bill62__Legacy_Order_ID__c = Integer.valueOf(l.Order_Number__c);
    //         orderMap.put(l.Order_Number__c, o);
    //         insertOrder.add(o); 
    //     }
        
    //     insert insertOrder;
        
    //     for (Legal_Zoom__c l : scopeList){
    //         Bill62__Subscription__c s = new Bill62__Subscription__c();
    //         s.Order__c = orderMap.get(l.Order_Number__c).Id;
    //         s.Bill62__Customer__c = conMap.get(l.Name).get(l.Email__c).Id;
    //         s.Bill62__Product__c = Org_Defaults__c.getOrgDefaults().Default_Product__c; //need to add logic to get the right product
    //         s.RecordTypeId = Org_Defaults__c.getOrgDefaults().Subscription_RT__c; //add logic to get the right RT
    //         s.Bill62__Billing_Frequency__c = 'Monthly';
    //         s.Bill62__Monthly_Billing_Start_Day__c = '1';
    //         s.Bill62__Start_Date__c = Date.today();
    //         insertSub.add(s);
            
    //         l.Account__c = accMap.get(l.Name).Id;
    //         l.Contact__c = conMap.get(l.Name).get(l.Email__c).Id;
    //         l.Order__c = orderMap.get(l.Order_Number__c).Id;
    //         l.Status__c = 'Processed';
    //     }
        
    //     insert insertSub;
        
    //     update scopeList;
    //     */
        
    }
    
    global void finish(Database.BatchableContext BC){
        
    }
    // /*
    // public Account createAccount(Legal_Zoom__c l){
    //     System.debug('Creating account: ' + l.Name);
    //     Account a = new Account();
    //     a.Name = l.Name;
    //     a.Fax = 'warrentest';
    //     return a;
    // }
    
    // public Contact createContact(Legal_Zoom__c l, String accId){
    //     Contact c = new Contact();
    //     c.FirstName = l.First_Name__c;
    //     c.LastName = l.Last_Name__c;
    //     c.Email = l.Email__c;
    //     c.Department = 'warrentest';
    //     c.AccountId = accId;
    //     c.MailingStreet = l.Mailing_Address__c;
    //     c.MailingCity = l.City__c;
    //     c.MailingState = l.State__c;
    //     c.MailingPostalCode = l.Postal_Code__c;
    //     return c;
    // }*/

}