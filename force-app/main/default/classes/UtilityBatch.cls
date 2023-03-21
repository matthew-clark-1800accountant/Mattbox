//UtilityBatch
global class UtilityBatch implements Database.Batchable<sObject>,Database.Stateful,Database.AllowsCallouts {

    global UtilityBatch(){

    }

    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id, Name, Support_Accountant__c FROM Account';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope){
		List<Account> theList = (List<Account>)scope;
        List<Account_Product__c> insertAPs = new List<Account_Product__c>();
		for(Account a:theList){
            List<String> listPayrollName;
            String prEmployees;
            Integer empQty;
        
            List<Id> listAccountProductIds = new List<Id>();
            List<Id> listPayrollProductIds = new List<Id>();
            Set<Id> setProductIds;
        
            Map<Id, Product2> mapProducts = new Map<Id, Product2>([Select Id
                                                                        , Name 
                                                                    from Product2 
                                                                    where Id IN (Select Bill62__Product__c 
                                                                                from Bill62__Subscription__c 
                                                                                where Bill62__Account__c = :a.Id)]);
        
            // We're only creating Payroll Account Products currently
            List<Product_Category__c> listPCs = [Select Id
                                                        , Name 
                                                from Product_Category__c 
                                                where Name = 'Payroll' 
                                                    and Id IN (Select Product_Category__c 
                                                                from Selected_Product_Category__c 
                                                                where Product__c IN :mapProducts.keySet())];
        
            // This gets us the Product and it's name associated with the Payroll Product Category for this Account
            /*
            Product2 p = [Select Id
                                , Name 
                            from Product2 
                            where Id IN (Select Product__c 
                                        from Selected_Product_Category__c 
                                        where Product_Category__c IN (Select Id 
                                                                    from Product_Category__c 
                                                                    where Name = 'Payroll')
                                        )
                                and Id IN (Select Bill62__Product__c 
                                            from Bill62__Subscription__c 
                                            where Bill62__Account__c = :a.Id)
                            LIMIT 1]);
            */
            List<Bill62__Subscription__c> subs = [Select Bill62__Product__c 
                                            from Bill62__Subscription__c 
                                            where Bill62__Account__c = :a.Id];
            for(Bill62__Subscription__c s : subs){
                listAccountProductIds.add(s.Bill62__Product__c);
            }
            setProductIds = new Set<Id>(listAccountProductIds);
        
            List<Selected_Product_Category__c> spcs = [Select Product__c 
                                        from Selected_Product_Category__c 
                                        where Product_Category__c IN (Select Id 
                                                                    from Product_Category__c 
                                                                    where Name = 'Payroll')];
            for(Selected_Product_Category__c spc : spcs){
                listPayrollProductIds.add(spc.Product__c);
            }
            setProductIds.retainAll(listPayrollProductIds);
            
            if(setProductIds.size() > 0){
                Product2 p = [Select Id, Name from Product2 where Id IN :setProductIds LIMIT 1];
                listPayrollName = p.Name.split('-');
                prEmployees = listPayrollName[1].trim();
                listPayrollName = prEmployees.split(' ');
                empQty = Integer.valueOf(listPayrollName[0]);
             
                // Create Account Products for each Product Category
                for(Product_Category__c pc : listPCs){
                    Account_Product__c ap = new Account_Product__c();
                    ap.RecordTypeId = Schema.SObjectType.Account_Product__c.getRecordTypeInfosByName().get('Payroll').getRecordTypeId();
                    ap.Account__c = a.Id;
                    ap.Product_Category__c = pc.Id;
                    ap.Payroll_Accountant__c = a.Support_Accountant__c;
                    ap.Number_of_Employees__c = empQty;
                    ap.Status__c = 'Set-Up';
                    insertAPs.add(ap);
                }
            } 
        }
        
        insert insertAPs;
    }

    global void finish(Database.BatchableContext BC){
        //don't do nothin!
    }

}