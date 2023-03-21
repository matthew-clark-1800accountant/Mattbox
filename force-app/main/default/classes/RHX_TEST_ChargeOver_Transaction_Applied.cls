@isTest(SeeAllData=true)
public class RHX_TEST_ChargeOver_Transaction_Applied {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM ChargeOver_Transaction_Applied__c ORDER BY LastModifiedDate DESC LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new ChargeOver_Transaction_Applied__c()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}