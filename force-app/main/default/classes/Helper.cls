/*
@ Name          : Helper
@ Author        : customersuccess@cloud62.com
@ Date          : 20 Apr, 2015
@ Description   : Helper class.
*/

public class Helper {
    
    public Helper(){
        
    }
    
    /**********************Begin addTask method********************************/
    
    public static Task addTask(String   theCaseId,
                               String   theAssigneeId,
                               String   theSubject,
                               Date     theDate,
                               String   theDescription,
                               String   theType,
                               Boolean  theIsReminder,
                               Datetime theReminderDateTime){
        
        Task theTask = new Task(WhatId=            theCaseId,
                                OwnerId=           theAssigneeId,
                                Subject=           theSubject,
                                ActivityDate=      theDate,
                                Description=       theDescription,
                                Type=              theType,
                                isReminderSet=     theIsReminder,
                                ReminderDateTime=  theReminderDateTime);
        
        return theTask;
        
    }
    
    /**********************End addTask method**********************************/

}