public class CreatePayrollDatesController {
    
    public ApexPages.StandardController mySC;
    public Account_Product__c ap;
    public Account a;
    public String apId;
    public Date currentDate;
    public Date startDate;
    public Date endDate;
    public String interval;
    public List<Payroll_Date__c> listPDs;
    public Set<Date> setExistingPDs;
    public Map<Integer, Date> mapPDs;
    public List<Payroll_Holidays__c> listPayrollHolidays;
    public Set<Date> setHolidays;
    public Date sundayDate;
    public List<Task> listInsertTasks;
    
    public CreatePayrollDatesController(ApexPages.StandardController sc){
        mySC = sc;
        apId = sc.getId();
        ap = [Select Id, Start_Date__c, Interval__c, Payroll_Accountant__c, Account__c from Account_Product__c where Id = :apId LIMIT 1];
        a = [Select Id, Name from Account where Id = :ap.Account__c LIMIT 1];
        
        // Create Payroll Dates 6 months out - make this a custom setting
        currentDate = date.today();
        startDate = ap.Start_Date__c;
        endDate = currentDate.addMonths(6);
        interval = ap.Interval__c;
        sundayDate = date.valueOf('2015-01-04');
        
        // Compile list of Holiday Dates
        listPayrollHolidays = Payroll_Holidays__c.getAll().values();
        setHolidays = new Set<Date>();
        for(Payroll_Holidays__c ph : listPayrollHolidays){
            setHolidays.add(ph.Holiday_Date__c);
        }
    }
    
    public pageReference CreatePayrollDates(){
        Date payrollDate, newpayrollDate;
        Integer iterator = 1;
        listPDs = new List<Payroll_Date__c>();
        listInsertTasks = new List<Task>();
        setExistingPDs = new Set<Date>();
        mapPDs = new Map<Integer, Date>();
        
        if(startDate == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Start Date does not have a value!'));
            return null;
        }
        if(interval == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Interval does not have a value!'));
            return null;
        }
        if(interval == 'Manual'){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,'Interval is set to Manual.  Please create the Payroll Date records manually by using the \'New Payroll Date\' button.'));
            return null;
        }
        if(ap.Payroll_Accountant__c == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Payroll Accountant does not have a value!'));
            return null;
        }
        
        // Grab list of existing Payroll Dates for current Account Product - we don't want to recreate these
        List<Payroll_Date__c> listExistingPDs = [Select Id, Account_Product__c, Payroll_Process_Date__c from Payroll_Date__c where Account_Product__c = :apId Order By Payroll_Process_Date__c Desc];
        if(listExistingPDs.size() > 0){
            for(Payroll_Date__c p : listExistingPDs){
                setExistingPDs.add(p.Payroll_Process_Date__c);
                mapPDs.put(iterator, p.Payroll_Process_Date__c);
                iterator++;
            }
            
            newpayrolldate = startDate;            
            System.debug('Payroll Date: ' + newpayrolldate);

        } else {
            // if there are no existing Payroll Dates for Account Product, create initial (start date)
            payrollDate = startDate;
            this.AddPayrollDatesToInsert(payrollDate);
        }
        
        while (payrollDate < endDate)
        {
            // Calculate frequency of Payroll Dates
            if(interval == 'Weekly'){
                payrollDate = payrollDate.addDays(7);
            }
            if(interval == 'Bi-weekly'){
                payrollDate = payrollDate.addDays(14);                
            }
            if(interval == 'Monthly'){
                payrollDate = payrollDate.addMonths(1);
            }
            if(interval == 'Quarterly'){
                payrollDate = payrollDate.addMonths(3);
            }
            if(interval == '15th / 30th'){
                // Previous Payroll Date may have been bumped back from the 15th due to a weekend/holiday
                if(payrollDate.day() <= 15){
                    payrollDate = date.newInstance(payrollDate.year(), payrollDate.month(), 30);
                }
                // Previous Payroll Date is at the end of the month, add a month and set the day to 15
                // If month goes to 13 (Dec -> Jan), it will automatically create date in Jan of next year
                else if(payrollDate.day() > 15){
                    payrollDate = date.newInstance(payrollDate.year(), payrollDate.month() + 1, 15);
                }
                else {
                    break;
                }
            }
            
            System.debug('Payroll Date: ' + payrolldate);
            
            // Add Payroll Date if it didn't exceed End Date
            if(payrollDate <= endDate){
                this.AddPayrollDatesToInsert(payrollDate);
            }

        }
        
        if(newpayrollDate != NULL){
        endDate = newpayrollDate.addMonths(6);        
        while (newpayrollDate < endDate){
            // Calculate frequency of Payroll Dates
            if(interval == 'Weekly'){
                newpayrollDate = newpayrollDate.addDays(7);
            }
            if(interval == 'Bi-weekly'){
                newpayrollDate = newpayrollDate.addDays(14);                
            }
            if(interval == 'Monthly'){
                newpayrollDate = newpayrollDate.addMonths(1);
            }
            if(interval == 'Quarterly'){
                newpayrollDate = newpayrollDate.addMonths(3);
            }
            if(interval == '15th / 30th'){
                // Previous Payroll Date may have been bumped back from the 15th due to a weekend/holiday
                if(newpayrollDate.day() <= 15){
                    newpayrollDate = date.newInstance(newpayrollDate.year(), newpayrollDate.month(), 30);
                }
                // Previous Payroll Date is at the end of the month, add a month and set the day to 15
                // If month goes to 13 (Dec -> Jan), it will automatically create date in Jan of next year
                else if(newpayrollDate.day() > 15){
                    newpayrollDate = date.newInstance(newpayrollDate.year(), newpayrollDate.month() + 1, 15);
                }
                else {
                    break;
                }
            }
            
            System.debug('Payroll Date: ' + newpayrolldate);
            
            System.debug('last payroll exist: ' + mapPDS.get(1));
            //Add payroll dates that come after the last existing payroll date
            if(newpayrollDate > mapPDs.get(1)){
                this.AddPayrollDatesToInsert(newpayrollDate);            
            }

        }
        }
        
        // Insert Payroll Dates
        if(listPDs.size() > 0){
            insert listPDs;
            insert listInsertTasks;
        }
        
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Payroll Dates created successfully!'));
        return null;
    }
    
    public void AddPayrollDatesToInsert(Date prDate){
        system.debug(prDate);
        // If the Payroll Date lands on a holiday, bump it back one day
        if(setHolidays.contains(prDate)){
            prDate = prDate.addDays(-1);
            system.debug(prDate);
        }
        
        // If the the Payroll Date lands on a weekend, bump it back to a weekday
        if(this.DayOfWeek(prDate) == 'Sunday'){
            prDate = prDate.addDays(-1);
            system.debug(prDate);
        }
        if(this.DayOfWeek(prDate) == 'Saturday'){
            prDate = prDate.addDays(-1);
            system.debug(prDate);
        }
        
        // Only add Payroll Dates that don't already exist
        if(!setExistingPDs.contains(prDate)){
            Payroll_Date__c pd = new Payroll_Date__c();
            pd.Account_Product__c = apId;
            pd.Payroll_Process_Date__c = prDate;
            pd.Processed__c = false;
            listPDs.add(pd);
            
            // Create Task for Payroll Date
            this.CreatePayrollTask(prDate);
        }
    }
    
    public String DayOfWeek(Date prDate){
        String dayOfWeek = '';
        Integer intWeekDay = 0;
        
        // Get the number of days between the Payroll Date and a given Sunday
        intWeekDay = math.mod(sundayDate.daysBetween(prDate), 7);
        
        if(intWeekDay == 0){
            dayOfWeek = 'Sunday';
        }
        if(intWeekDay == 1){
            dayOfWeek = 'Monday';
        }
        if(intWeekDay == 2){
            dayOfWeek = 'Tuesday';
        }
        if(intWeekDay == 3){
            dayOfWeek = 'Wednesday';
        }
        if(intWeekDay == 4){
            dayOfWeek = 'Thursday';
        }
        if(intWeekDay == 5){
            dayOfWeek = 'Friday';
        }
        if(intWeekDay == 6){
            dayOfWeek = 'Saturday';
        }
        
        system.debug(dayOfWeek);
        return dayOfWeek;
    }
    
    public pageReference goBack(){
        return new PageReference('/' + apId);
    }
    
    public void CreatePayrollTask(Date prDate){
        Task payrollTask = new Task();
        payrollTask.OwnerId = ap.Payroll_Accountant__c;
        payrollTask.WhatId = ap.Account__c;
        payrollTask.ActivityDate = prDate.addDays(-3);
        payrollTask.Subject = 'Process Payroll for ' + a.Name + ' on ' + prDate.format();
        payrollTask.Status = 'Not Started';
        payrollTask.Priority = 'Normal';
        payrollTask.IsReminderSet = true;
        payrollTask.ReminderDateTime = DateTime.newInstance(prDate.addDays(-7), Time.newInstance(8,0,0,0));
        listInsertTasks.add(payrollTask);
    }

}