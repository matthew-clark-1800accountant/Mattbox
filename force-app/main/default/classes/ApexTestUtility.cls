/**
 *  About
 *  -----
 *  Author: Appluent
 *  Create date: 03 Oct 2017
 *  
 *  Details
 *  -----
 *  Utility class to create Test Data
 *  
 *  Update History
 *  -----
 *  
 *  Issues / TODOs
 *  ----- 
 *
**/
@isTest
public class ApexTestUtility {

	public static Account createAccount(String name) {
	    
	    Account newAccount = new Account();
	    newAccount.Name = name;
	    return newAccount;
	    
	}

	public static Lead createLead(String name) {
	    
	    Lead newLead = new Lead();
	    newLead.LastName = name;
	    return newLead;
	    
	}

	public static User createUser(String lastName, String profileName, String email, String username) {
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name=:profileName ].Id,
            LastName = 'lastName',
            Email = email,
            Username = username,
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        return u;
    }

    public static Event createEvent(string subject) {
	    
	    Event newEvent = new Event(
	    	Subject=subject,
	    	StartDateTime= DateTime.newInstance(2018, 11, 16, 11, 0, 0),
	    	EndDateTime=DateTime.newInstance(2018, 11, 16, 12, 0, 0),
			Portal_Event_Owner__c='Matthew Clark'
	    	//,Call_Result__c= 'Contacted'
	    );
	    return newEvent;
	    
	}

	public static Contact createContact(string lastName,string firstName) {
	    
	    Contact newContact = new Contact(
	    	LastName=lastName,
	    	FirstName = firstName
	    );
	    return newContact;
	    
	}



}