@isTest
public with sharing class ManagerReassignmentsReportTest {
    @isTest
    public static void testGetData(){
        User manager = [SELECT Id FROM User WHERE Profile.Name = 'Sales Manager' AND IsActive = true LIMIT 1];
        List<User> reps = [SELECT Id, Name FROM User WHERE Profile.Name = 'InsideSalesUser - Zuora' AND IsActive = true LIMIT 2];
        Lead l = new Lead(FirstName='first',LastName='last',status='new', company='company', email='test1@gtest.com', OwnerId = manager.Id);
        insert l;
        Event_History__c history = new Event_History__c();
        insert history; 
        Event testEvent = new Event(
            OwnerId = reps[0].Id,
            WhoId = l.Id,
            Subject = 'Test Event',
            StartDateTime = System.now(),
            EndDateTime = System.now().addMinutes(30),
            Email_Campaign_ID__c = '12345',
            Type_of_Appointment__c = 'Tax Savings Analysis',
            Portal_Event_Owner__c = 'Matthew Clark',
            Event_History__c = history.Id,
            Original_Assigned_to__c = reps[0].Id
        );
        insert testEvent;

        Event_Field_Update__c up = new Event_Field_Update__c(
            Updated_Field__c = 'Assigned To',
            Old_Value__c = reps[0].Name,
            New_Value__c = reps[1].Name,
            Event_History__c = history.Id,
            Updated_By__c = manager.Id
        );
        insert up;

        ManagerReassignmentsReport.getData();
    } 
}