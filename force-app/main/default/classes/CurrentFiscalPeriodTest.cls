@isTest
public class CurrentFiscalPeriodTest {
	@isTest
    static void testGetCurrentFiscalPeriod() {  
       
        // Call the method under test
        Test.startTest();
        List<CurrentFiscalPeriod.Results> results = CurrentFiscalPeriod.GetCurrentFiscalPeriod();
        Test.stopTest();
        // Assert that the method returns the expected results
        System.assertEquals(1, results.size());
        CurrentFiscalPeriod.Results result = results[0];       
       
    }

}