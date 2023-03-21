/**
* Author: Koby Campbell
* Date: June 2021
* Test: 
* Other Dependencies:   
*/
global class UsersAvailabilityUpdate implements Database.Batchable<sObject>, Schedulable {
    
    public UsersAvailabilityUpdate() { 
        this.setUserQuery();
        this.setUsers();
    }


    public String userQuery;
    public void setUserQuery() { 
        this.userQuery = 
            'SELECT Id, isActive, Scheduler_Availability__c, Profile.Name ' 
            +'FROM User ' 
            +'WHERE Profile.Name = \'InsideSalesUser - Zuora\' '
            +'AND isActive = true ' 
        ;
    }
 
    private List<User> users;
    public void setUsers(List<User> users) { this.users = users; }
    public void setUsers() {
        this.users = Database.query(this.userQuery);
    }

    //Execute with a batch size of 1
    public void execute(SchedulableContext context) {
        UsersAvailabilityUpdate updateUsers = new UsersAvailabilityUpdate();
        Database.executeBatch(updateUsers, 1);
    }

    public Database.QueryLocator start(Database.BatchableContext context) {   

        return Database.getQueryLocator(this.userQuery);    
    }    

    public void manualExecution() {   
        List<User> toUpdateUsers = new List<User>();
        for(User u : users) {
            u.Scheduler_Availability__c = 'Unavailable';
            toUpdateUsers.add(u);
        }
        update toUpdateUsers;
    
    }
    //Reassign the Account Owner and update
    public void execute(Database.BatchableContext context, List<User> users) {
        this.setUsers(users);
        this.manualExecution();
    }

    public void finish(Database.BatchableContext context) {

    } 
}