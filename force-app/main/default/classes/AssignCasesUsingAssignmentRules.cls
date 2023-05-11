public class AssignCasesUsingAssignmentRules {

    @InvocableMethod(label='Assign Using Case Assignment Rules')
    public static void CaseAssign(List<Id> CaseIds)
    {
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.useDefaultRule= true;          
            Case Cases=[select id from case where case.id in :CaseIds];
            Cases.setOptions(dmo);
            update Cases;
   }
}