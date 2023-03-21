trigger TaskDelete on Task (before delete) {  
   
    String profileId=UserInfo.getProfileId();
    String profileName=[SELECT Id,Name FROM Profile WHERE Id=:profileId].Name;

    System.debug(LoggingLevel.FINE, 'InsideSalesUser - Zuora :: ' + profileName);
    
    if(
        (profileName.containsIgnoreCase('zuora') && profileName.containsIgnoreCase('InsideSalesUser'))||
        (profileName.containsIgnoreCase('sales') && profileName.containsIgnoreCase('manager') ))
    {
        Trigger.old[0].addError('You do not have permission to delete Task records....');
    }
}