global class Z_DefaultValues extends zqu.CreateQuoteController.PopulateDefaultFieldValuePlugin{ 
   
   global override void populateDefaultFieldValue(SObject record, zqu.PropertyComponentController.ParentController pcc){   
      String quoteId = ApexPages.currentPage().getParameters().get('id');
       
      Id accountId = (Id) ApexPages.currentPage().getParameters().get('crmAccountId');
       
      system.debug('accountId: ' + accountId);
      
      if (!Test.isRunningTest()) 
          super.populateDefaultFieldValue(record, pcc);
       //Populate default values in the quote header 
       //    String subType = (String)record.get('zqu__SubscriptionType__c');
       /*
       String subType = ApexPages.currentPage().getParameters().get('quoteType');
       System.Debug('[DG]====================> subType: ' + subType);
       
       String subscriptionId = ApexPages.currentPage().getParameters().get('subscriptionId');
       System.Debug('[DG]====================> subscriptionId: ' + subscriptionId);
       
       String billingAccountId = ApexPages.currentPage().getParameters().get('billingAccountId');
       System.Debug('[DG]====================> billingAccountId: ' + billingAccountId);
       */
       
       Date validUntil = Date.today().addDays(30);
       record.put('zqu__ValidUntil__c', validUntil);   
       
       record.put('zqu__StartDate__c', Date.today());  
       
       record.put('zqu__QuoteBusinessType__c', 'New');
       record.put('zqu__Primary__c', false);
       record.put('zqu__PaymentMethod__c', 'Credit Card');
       record.put('zqu__Currency__c', 'USD');
       record.put('zqu__BillingMethod__c', 'Email');
       record.put('zqu__PaymentTerm__c', 'Due Upon Receipt');
       record.put('zqu__Subscription_Term_Type__c', 'Evergreen');
       record.put('zqu__ApplyCreditBalance__c', false);
       record.put('zqu__GenerateInvoice__c', true);
       record.put('zqu__ProcessPayment__c', true);
       record.put('zqu__InvoiceProcessingOption__c', 'Account');
       
       List<Account> primaryContact = [
          SELECT 
              Id,
              Primary_Contact__c,
              Primary_Contact__r.Name
          FROM 
              Account 
          WHERE 
              Id =:accountId
          ];     
       if (Test.isRunningTest()){
          primaryContact = [
          SELECT 
              Id,
              Primary_Contact__c,
              Primary_Contact__r.Name
          FROM 
              Account
          ];  
       }
       
       system.debug('Contact: ' + primaryContact);
         
        // Checks to see if an account was returned and that the primary contact exists       
        if  ((primaryContact.size() > 0 && primaryContact[0].Primary_Contact__c != null)) {            
           // System.debug('mp: about to add ' + contacts[0].Id + ' as a contact ID');

          if (primaryContact.size() > 1)
            record.addError('WARNING!  More than 1 Primary Billing Contact has been found!  Defaulting to first contact: ' + primaryContact[0].Primary_Contact__r.Name);
          
          record.put('zqu__BillToContact__c', primaryContact[0].Primary_Contact__c);            
          record.put('zqu__SoldToContact__c', primaryContact[0].Primary_Contact__c);        
         
            if (!Test.isRunningTest()){
              // Before retrieving  the lookup  options, needs to populate the map first            
              super.setLookupOptions(pcc);            
             
              // Now retrieve the lookup component options            
              zqu.LookupComponentOptions billToOptions = super.getLookupOption('zqu__BillToContact__c');            
              billToOptions.targetId = primaryContact[0].Primary_Contact__c;            
              billToOptions.targetName = primaryContact[0].Primary_Contact__r.Name;            
              zqu.LookupComponentOptions soldToOptions  = super.getLookupOption('zqu__SoldToContact__c');            
              soldToOptions.targetId = primaryContact[0].Primary_Contact__c;            
              soldToOptions.targetName = primaryContact[0].Primary_Contact__r.Name;
            }
        }
   }
}