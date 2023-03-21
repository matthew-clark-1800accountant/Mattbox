@isTest
private class eventNotifier_TC {

    static testmethod void test() {
        System.debug('eventNotifier_TC.test()');
        //create test records
        list<event> events =  new list<event>();
        list<task> tasks = new list<task>();
        list<contact> contacts =  new list<contact>();
        list<lead> leads = new list<lead>();
        list<user> agents = new list<user>(); 
        List<SObject> whoRecs = new List<SObject>();
        List<NVMContactWorld__InteractionEvent__c> interactions = new List<NVMContactWorld__InteractionEvent__c>();
      User owner = [SELECT Id, ManagerId FROM User WHERE Name = 'Matthew Clark' LIMIT 1];
        System.debug(owner);
        integer numOfRec = 8;
        
        string tstOwnerId;
        string tstWhoId;
        
        // creat contacts,leads,users
        for(integer j = 0;j<=numOfRec/2;j++){
            
            //...........create contacts...........................//
            contact tstContact =  new contact();
            tstContact.firstName = j+'test';
            tstContact.lastName = j+'test';
            whoRecs.add(tstContact);
            
            //create lead
            lead tstLead = new lead();
            tstLead.firstName = j+'test';
            tstLead.lastName = j+'test';
            tstLead.company = j+'companyTest';
            whoRecs.add(tstLead);
            
        }
        whoRecs.sort();
        System.debug('inserting whoRecs');
        insert whoRecs;
                
        for(integer i = 0;i<numOfRec;i++){  
            //.......create event....................//
   			event tstEvent =  new event();
            tstEvent.StartDateTime = System.now().addMinutes(-7);
            tstEvent.endDateTime = System.now().addHours(5);
            tstEvent.OwnerId = owner.Id;//'005j000000E11XuAAJ';//getAgents[i].id;
            tstEvent.whoId = whoRecs[i].id;
            //tstEvent.activityDateTime = System.today();
            tstEvent.Appointment_Disposition__c = 'Scheduled';
            //tstEvent.accountId =  a+'0012h00000G7reqAAB';
            tstEvent.type_of_appointment__c =  'Tax Savings Analysis';
            tstEvent.subject = '1on1 Sales Appointment';
            //tstEvent.DurationInMinutes = 60;
            events.add(tstEvent); 
            
            if(Math.mod(i, 2) == 0){
               NVMContactWorld__InteractionEvent__c interaction = new NVMContactWorld__InteractionEvent__c();
             interaction.ownerId = owner.Id;
             interaction.NVMContactWorld__Agent__c = owner.Id;
             interaction.NVMContactWorld__Who__c = whoRecs[i].Id;
             interaction.NVMContactWorld__Type__c = 'Consult';
             interaction.NVMContactWorld__TimeStamp__c = System.now();
             interaction.NVMContactWorld__IndexedCallObjectIdentifier__c = 'abcd1234';
             interactions.add(interaction);
            }
          }

       for(integer i = 0;i<numOfRec/2;i++){
             //.......create task....................//
             
       }

      //insert records
      System.debug('inserting interactions');
      insert interactions;
      System.debug('inserting events');
        insert events;
      System.debug('inserting tasks');
        insert tasks;
       list<event> checkevents = [SELECT Id,StartDateTime,OwnerId,whoId FROM event where StartDateTime >= today AND StartDateTime <= tomorrow  AND type_of_appointment__c = 'Tax Savings Analysis' AND subject = '1on1 Sales Appointment'];
        system.debug(checkevents);
        for(event e: checkevents){
             system.debug(e.StartDateTime);
        }    
       
        System.debug('Test.startTest()');
        Integer oldEmails = Limits.getEmailInvocations();
       Test.startTest();
  	   eventNotifier evn = new eventNotifier();
       database.executeBatch(evn);
       Test.stopTest();
       Integer newEmails = eventNotifier.emailNumber;
       if(owner.ManagerId == null){
        System.assertEquals(oldEmails+(numOfRec/2), newEmails);
       } else {
        System.assertEquals(oldEmails+numOfRec, newEmails);
       }
       
  }
    

}