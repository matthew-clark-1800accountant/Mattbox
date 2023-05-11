/**
*   Overview: Test class for LeadPreventOwnerChange trigger
*   Author: Koby Campbell
*   Date: May 2021
*/
@isTest
public class LeadPreventOwnerChangeTest {
@isTest
    private static void testPreventChangeBarkLeadOwner() {
        Id profileId = [SELECT Id, Name FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id;

        User testUser = TestDataGenerator.createTestUser(profileId);
        User testUser2 = TestDataGenerator.createTestUser(profileId);
        insert new List<User>{testUser, testUser2};
        
        Boolean errorThrown;
        
        System.runAs(testUser) {
            try {
                Lead lead = TestDataGenerator.createTestLead(testUser.Id);
                lead.LeadSource = 'Bark';
                lead.Email = 'test@example.com';
                insert lead;
                lead.OwnerId = testUser2.Id;
                update lead;
            } catch (Exception e) {
                errorThrown = true;

            }
        }
        System.assertEquals(true, errorThrown, 'An unauthorized user was able to change the Bark Lead owner');
    }
@isTest
    private static void testAllowChangeBarkLeadOwner() {
        Id profileId = [SELECT Id, Name FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id;

        User testUser = TestDataGenerator.createTestUser(profileId);
        Id queueId = Update_Lead_Owner_to_Queue.getQueue('General Lead Queue');
        insert testUser;
        Boolean errorThrown = false;
        System.runAs(testUser) {
            try {
                Lead lead = TestDataGenerator.createTestLead(testUser.Id);
                lead.LeadSource = 'Bark';
                lead.Email = 'test@example.com';
                insert lead;
                lead.OwnerId = queueId;
                update lead;
            } catch (Exception e) {
                errorThrown = true;
                system.debug (e);
            }
        }
        System.assertEquals(false, errorThrown, 'The user should be able to change the Bark Lead Owner to the General Queue');
    }
}