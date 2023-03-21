/**
* Author: Koby Campbell
* Date: April 2021
* Revised: October 2021
* Test: Update_Account_Owner_Test
* Other Dependencies:   Lead Reassignment Queue & Reassignment Query Custom Metadata Types 
*                       to allow for customization of the queries of Accounts to reassign and
*                       the queue to reassign the Accounts to.
*/
global class Update_Account_Owner_to_Lead_Queue implements Database.Batchable<sObject>, Schedulable {
    
    public class MisconfiguredMetadataException extends Exception {}
    public class MissingQueryException extends Exception {}
    //Default constructor with Bark and Paid Media Leads query
    public Update_Account_Owner_to_Lead_Queue() { 
        this.establishQuery('Partner (Account)');
        this.setType('Partner (Account)');
    }
    //Alternate constructor to use additional Account queries
    public Update_Account_Owner_to_Lead_Queue(String queryString) { 
        this.establishQuery(queryString);
    }
 
    private List<Account> accounts;
    public void setAccounts(List<Account> accounts) { this.accounts = accounts;  }
    public void setAccounts() {
        this.accounts = Database.query(this.c_query);

    }
    //Custom Account query for the batch job
    private String c_query;
    public void establishQuery(String queryLabel) { 
        String query = [
            SELECT Id, MasterLabel, Query__c, Object__c 
            FROM Reassignment_Query__mdt
            WHERE Object__c = 'Account'
            AND MasterLabel = :queryLabel
        ].Query__c;
        this.c_query = query; 
    }

    //The type of Accounts the batch is querying for
    private String type;
    public void setType(String type) { this.type = type; }

    //Execute with a batch size of 1
    public void execute(SchedulableContext context) {
        Update_Account_Owner_to_Lead_Queue updateAccounts = new Update_Account_Owner_to_Lead_Queue();
        Database.executeBatch(updateAccounts, 1);
    }

    public Database.QueryLocator start(Database.BatchableContext context) {   
        if(null == c_query) {
            throw new MissingQueryException('Batch job is missing Account query');
        }
        return Database.getQueryLocator(this.c_query);    
    }    

    public void manualExecution() {   
        Id queueId = Update_Lead_Owner_to_Queue.getQueue('General Lead Queue');
        List<Account> toUpdateAccounts = new List<Account>();
        for(Account a : accounts) {
            a.OwnerId = queueId;
            toUpdateAccounts.add(a);
        }
        update toUpdateAccounts;
    }
    //Reassign the Account Owner and update
    public void execute(Database.BatchableContext context, List<Account> accounts) {
        this.setAccounts(accounts);
        this.manualExecution();
    }

    public void finish(Database.BatchableContext context) {
        //After the batch is constructed the first time, rerun with pitched accounts query
        if(this.type == 'Partner (Account)') {            
            Update_Account_Owner_to_Lead_Queue nextJob = new Update_Account_Owner_to_Lead_Queue('Tier 1 - Pitched (Account)');
            nextJob.setType('Tier 1 - Pitched (Account)');
            Database.executeBatch(nextJob, 1); 
        }
        //After the batch is constructed the second time, rerun with partner accounts query
        if(this.type == 'Tier 1 - Pitched (Account)') {
            Update_Account_Owner_to_Lead_Queue nextJob = new Update_Account_Owner_to_Lead_Queue('Tier 1 - Unpitched (Account)');
            nextJob.setType('Tier 1 - Unpitched (Account)');
            Database.executeBatch(nextJob, 1); 
        }
        if(this.type == 'Tier 1 - Unpitched (Account)') {
            //Add on additional Account types to reassign as needed
        }
    } 
}