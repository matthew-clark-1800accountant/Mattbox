trigger UpdateAccountOnEvent on Event (after insert, after update) {
//
//    map<Id,Event> acctIDs = new map<Id,Event>();
//    map<Id,Event> contIDs = new map<Id,Event>();
//    map<Id,Event> acctIDs2 = new map<Id,Event>();
//    map<Id,Event> contIDs2 = new map<Id,Event>();
//    List<Account> accstoupdate = new List<Account>();
//
//    for(Event e :Trigger.new)  {
//        if(e.Subject == 'Merchant Services 1-1' && e.ActivityDateTime>System.now())  {
//            if(e.whatid<>null && ((String)e.WhatId).startsWith(Schema.SObjectType.Account.getKeyPrefix()))  acctIDs.put(e.whatid,e);
//            else if(e.whoid<>null && ((String)e.WhoId).startsWith(Schema.SObjectType.Contact.getKeyPrefix())) contIDs.put(e.whoid,e);
//        } else {
//            if(e.whatid<>null && ((String)e.WhatId).startsWith(Schema.SObjectType.Account.getKeyPrefix()))  acctIDs2.put(e.whatid,e);
//            else if(e.whoid<>null && ((String)e.WhoId).startsWith(Schema.SObjectType.Contact.getKeyPrefix())) contIDs2.put(e.whoid,e);
//        }
//    }
//    if(!acctIDs.keyset().isEmpty())  {
//        Set<Account> accounts = new Set<Account>([Select Id,Name from Account WHERE Id IN :acctIDs.keyset()]);
//        for(Account a : accounts)  {
//            if(a.id<>null && acctIDs.keyset().contains(a.id))  {
//                Event e = acctIDs.get(a.id);
//                a.Merchant_Sales_1_1_Scheduled__c = e.ActivityDateTime;
//                a.Merchant_Sales_Rep__c = e.ownerid;
//                a.Merchant_Sales_Status__c = '1-1 Scheduled';
//                a.EventIDNum__c = e.id;
//                accstoupdate.add(a);
//            }
//        }
//    }
//    if(!acctIDs2.keyset().isEmpty())  {
//        Set<Account> accounts = new Set<Account>([Select Id,Name from Account WHERE Id IN :acctIDs2.keyset()]);
//        for(Account a : accounts)  {
//            if(a.id<>null && acctIDs2.keyset().contains(a.id))  {
//                Event e = acctIDs2.get(a.id);
//                a.EventIDNum__c = e.id;
//                accstoupdate.add(a);
//            }
//        }
//    }
//    if(!contIDs.keyset().isEmpty())  {
//        Set<Contact> conts = new Set<Contact>([Select Id,Name,AccountID from Contact WHERE Id IN :contIDs.keyset()]);
//        Set<Id> accIDs = new Set<Id>();
//        for(Contact c: conts)  {
//            accIDs.add(c.accountid);
//        }
//        Map<Id,Account> accounts = new Map<Id,Account>([Select Id,Name from Account WHERE Id IN :accIDs]);
//
//        for(Contact c: conts)  {
//            Event e = contIDs.get(c.id);
//            if(c.accountid<>null && accounts.keyset().contains(c.accountid))  {
//                Account a = accounts.get(c.accountid);
//                a.Merchant_Sales_1_1_Scheduled__c = e.ActivityDateTime;
//                a.Merchant_Sales_Status__c = '1-1 Scheduled';
//                a.EventIDNum__c = e.id;
//                accstoupdate.add(a);
//            }
//        }
//    }
//    if(!contIDs2.keyset().isEmpty())  {
//        Set<Contact> conts = new Set<Contact>([Select Id,Name,AccountID from Contact WHERE Id IN :contIDs2.keyset()]);
//        Set<Id> accIDs2 = new Set<Id>();
//        for(Contact c: conts)  {
//            accIDs2.add(c.accountid);
//        }
//        Map<Id,Account> accounts = new Map<Id,Account>([Select Id,Name from Account WHERE Id IN :accIDs2]);
//
//        for(Contact c: conts)  {
//            Event e = contIDs2.get(c.id);
//            if(c.accountid<>null && accounts.keyset().contains(c.accountid))  {
//                Account a = accounts.get(c.accountid);
//                a.EventIDNum__c = e.id;
//                accstoupdate.add(a);
//            }
//        }
//    }
//    if(!accsToUpdate.isEmpty()) update accsToUpdate;
}