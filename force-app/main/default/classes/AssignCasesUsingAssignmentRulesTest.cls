@isTest 
      public class AssignCasesUsingAssignmentRulesTest{
      static testMethod void createnewcase() {
      User userToCreate = [Select id from user where isActive = TRUE Limit 1];
      
      Test.startTest();    
      Case caseToCreate =new Case();
      List<id> Ids= New List<Id>();
      caseToCreate.ownerid= userToCreate.id;
      caseToCreate.Type ='Bank Sync';
      caseToCreate.Status='New';
      insert caseToCreate; 
      
      Ids.add(caseToCreate.id);
      AssignCasesUsingAssignmentRules.caseAssign(Ids);
      
      Test.stopTest();
   }
}