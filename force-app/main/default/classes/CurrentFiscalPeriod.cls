global class CurrentFiscalPeriod{
    
    @InvocableMethod
    public static List<Results> GetCurrentFiscalPeriod (){
        Date currentFiscalStartDate = [SELECT StartDate FROM Period where FiscalYearSettings.YearType = 'Custom' AND Type = 'Month' AND EndDate > Today LIMIT 1].StartDate;
      	Date currentFiscalEndDate = [SELECT EndDate FROM Period where FiscalYearSettings.YearType = 'Custom' AND Type = 'Month' AND EndDate > Today LIMIT 1].EndDate;
      
      	Results currentResult = new Results();
        currentResult.currentFiscalStartDate = currentFiscalStartDate;
        currentResult.currentFiscalEndDate = currentFiscalEndDate;
        
        List<Results> resultsList = new List<Results>();
        resultsList.add(currentResult);
        return resultsList;
    }
    
    global class Results {
    	@InvocableVariable
    	global Date currentFiscalStartDate;
    
    	@InvocableVariable
		global Date currentFiscalEndDate;
	}
}