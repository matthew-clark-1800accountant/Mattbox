/**    
*
* Author: Koby Campbell
* Date: April 2021
* Test: Update_Lead_Owner_to_Queue_Test
* Other Dependencies:   Lead Reassignment Queue & Reassignment Query Custom Metadata Types 
*                       to allow for customization of the queries to reassign Leads from and
*                       the queue to reassign the Leads to.
*/
global class Update_Lead_Owner_to_Queue implements Database.Batchable<sObject>, Schedulable {

    public class MisconfiguredMetadataException extends Exception {}
    public class MissingQueryException extends Exception {}
    //Default constructor with Bark and Paid Media Leads query
    public Update_Lead_Owner_to_Queue() { 
        this.establishQuery('Partner (Lead)');
        this.setType('Partner (Lead)');
    }
    //Alternate constructor to use additional Lead queries
    public Update_Lead_Owner_to_Queue(String queryString) { 
        this.establishQuery(queryString);
    }

    private List<Lead> leads;
    public void setLeads(List<Lead> leads) { this.leads = leads; }
    public void setLeads() {
        this.leads = Database.query(this.c_query);
    }
    
    //The type of Leads the batch is querying for
    private String type;
    public void setType(String type) { this.type = type; }

    //Custom Lead query for the batch job
    private String c_query;
    public void establishQuery(String queryLabel) { 
        String query = [
            SELECT Id, MasterLabel, Query__c, Object__c 
            FROM Reassignment_Query__mdt
            WHERE Object__c = 'Lead'
            AND MasterLabel = :queryLabel
        ].Query__c;
        this.c_query = query; 
    }

    // Get the queue name and object type in the metadata to reassign leads to
    public static Id getQueue(String queueType) {
        List<Lead_Reassignment_Queue__mdt> getQueueToReassign = ([
            SELECT Id, MasterLabel, Queue_Object_Type__c, Reassignment_Queue_Name__c
            FROM Lead_Reassignment_Queue__mdt
            WHERE Queue_Type__c = :queueType
        ]);
        //We should only get one queue at this point
        if(getQueueToReassign.isEmpty() || getQueueToReassign.size() > 1) {
            throw new MisconfiguredMetadataException('Please check that the Lead Reassignment Queue Custom Metadata Type is configured correctly. Only one queue can be used for reassignment.');
        }

        Lead_Reassignment_Queue__mdt queueData = getQueueToReassign[0];
        String m_query = 'SELECT Id FROM '+ queueData.Queue_Object_Type__c +' WHERE Name = \''+queueData.Reassignment_Queue_Name__c+'\' LIMIT 1';
        return Database.query(m_query).Id;
    }

    //execute with a batch size of 1
    public void execute(SchedulableContext context) {
        Update_Lead_Owner_to_Queue updateLeads = new Update_Lead_Owner_to_Queue();
        Database.executeBatch(updateLeads, 1);
    }

    public Database.QueryLocator start(Database.BatchableContext context) {   
        if(null == c_query) {
            throw new MissingQueryException('Batch job is missing Lead query');
        }
        return Database.getQueryLocator(this.c_query);    
    }    

    public void manualExecution() {   
        Id queueId = Update_Lead_Owner_to_Queue.getQueue('General Lead Queue');
        List<Lead> toUpdateLeads = new List<Lead>();
        for(Lead l : leads) {
            l.OwnerId = queueId;
            toUpdateLeads.add(l);
        }
        update toUpdateLeads;
    }
    //Reassign the Lead Owner and update
    public void execute(Database.BatchableContext context, List<Lead> leads) {
        this.setLeads(leads);
        this.manualExecution();
    }

    public void finish(Database.BatchableContext context) {
        //After the batch is constructed the first time, rerun with Partner Leads query
        if(this.type == 'Partner (Lead)') {            
            Update_Lead_Owner_to_Queue nextJob = new Update_Lead_Owner_to_Queue('Tier 1 (Lead)');
            nextJob.setType('Tier 1 (Lead)');
            Database.executeBatch(nextJob, 1); 
        }
        if(this.type == 'Tier 1 (Lead)') {
            //Add on additional Lead types here to reassign as needed
        }
    } 
}