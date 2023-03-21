trigger ContactDataClean on Contact (before insert, before update) {
//
//    for(Contact c : Trigger.new)  {
//        if(X1800Utilities.StateAbbrev.keyset().contains(c.MailingState)) c.MailingState = X1800Utilities.StateAbbrev.get(c.MailingState);
//        if(X1800Utilities.Timezones.keyset().contains(c.MailingState)) c.timezone__c = X1800Utilities.TimeZones.get(c.MailingState);
//        else c.timezone__c ='';
//    }

}