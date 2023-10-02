public class AccountStatusHandler {

    public static void assignAccountStatus(List<Id> accountIds){
        Id portalProductId;
        if(!Test.isRunningTest()){
            portalProductId = [ SELECT Id, Name FROM Product2 WHERE ChargeOver__c = true AND Calculator_Location__c = 'A La Carte' AND Name = '1-800Accountant Access' LIMIT 1].Id;
        }
        Map<Id, Account> mappedAccounts = new Map<Id, Account>([
            SELECT Id, Name, Account_Status__c, ChargeOver_Most_Recent_Payment_Date__c, Finance_Status__c,
            ChargeOver_Initial_Payment_Date__c, Last_Account_Status__c,
                (SELECT Id, Name, Initial_Refund_Percentage__c, Status__c, Total_Initial_Paid_Amount__c
                    FROM ChargeOver_Subscriptions__r
                    WHERE (NOT Sale_Completed_By_Detail__c LIKE '%1099issuer%')
                ),
                (SELECT Id, Name, Number_of_Recurs__c, Product__c
                    FROM ChargeOver_Invoice_Line_Items__r
                    WHERE ChargeOver_Invoice__r.ChargeOver_Invoice_Status__c != 'Void'
                    AND (Payment_Type__c = 'Renewal'
                    OR (Payment_Type__c = 'Recurring'
                    AND Number_of_Recurs__c > 12
                    AND Product__c != :portalProductId)
                    )
                )
            FROM Account
            WHERE Id IN :accountIds
        ]);

        Map<Id, ChargeOver_Subscription__c> mappedSubscriptions = new Map<Id, ChargeOver_Subscription__c>([
            SELECT Id, Name, Status__c, Account__c, Initial_Refund_Percentage__c,
            (
                SELECT Id, Name, ChargeOver_Subscription__c, Account__c, ChargeOver_Invoice_Status__c, Invoice_Date__c
                FROM ChargeOver_Invoices__r
            ),
            (
                SELECT Id, Name, Status__c
                FROM ChargeOver_Subscription_Line_Items__r
                WHERE Status__c = 'Active - Pending Cancel'
            )
            FROM ChargeOver_Subscription__c
            WHERE Account__c IN :accountIds
        ]);

        // Map<Id, ChargeOver_Subscription__c> mappedActiveSubscriptions = new Map<Id, ChargeOver_Subscription__c>([
        //     SELECT Id, Name, Status__c, Account__c, Initial_Refund_Percentage__c,
        //     (
        //         SELECT Id, Name, ChargeOver_Subscription__c, Account__c, ChargeOver_Invoice_Status__c, Invoice_Date__c
        //         FROM ChargeOver_Invoices__r
        //     ),
        //     (
        //         SELECT Id, Name, Status__c
        //         FROM ChargeOver_Subscription_Line_Items__r
        //         WHERE Status__c = 'Active'
        //     )
        //     FROM ChargeOver_Subscription__c
        //     WHERE Account__c IN :accountIds
        // ]);

        Map<Id, Account> toUpdateAccounts = new Map<Id, Account>();
        for(Account a : mappedAccounts.values()){
            //Tracking attributes
            Boolean refunded = false;
            Boolean hasPending = false;
            Boolean allCancelled = true;
            Boolean allSuspended = true;
            //Status Booleans set to true when the conditions for the status is met
            Boolean current = false;
            Boolean dormant = false;
            Boolean pastDue = false;
            Boolean firstYear = false;
            Boolean renewed = false;
            Boolean pendingCancel = false;
            Boolean partnerSubscribed = false;
            for(ChargeOver_Subscription__c cos : a.ChargeOver_Subscriptions__r){
                //Tracking if they were refunded or not
                if(cos.Initial_Refund_Percentage__c > 30
                && cos.Total_Initial_Paid_Amount__c > 0){
                    refunded = true;
                }
                if(!mappedSubscriptions.get(cos.Id).ChargeOver_Subscription_Line_Items__r.isEmpty()
                && a.ChargeOver_Initial_Payment_Date__c != null){ //updated criteria -mc
                    pendingCancel = true;
                }
                //if(!mappedActiveSubscriptions.get(cos.Id).ChargeOver_Subscription_Line_Items__r.isEmpty()
                if(cos.Status__c == 'Current'
                && a.ChargeOver_Initial_Payment_Date__c == null){ //added new status -mc
                    partnerSubscribed = true;
                }
                //Tracking if all the statuses are cancelled
                if(null != cos.Status__c && !cos.Status__c.contains('Cancelled')){
                    allCancelled = false; 
                    //If they've got a current subscription the invoices need to be checked 
                    if('Current' == cos.Status__c || 'Overdue' == cos.Status__c){
                        Boolean hasANotVoid = false;
                        Boolean datelessThan = false;

                        //Tracking if the invoices have a void or overdue status
                        for(ChargeOver_Invoice__c inv : mappedSubscriptions.get(cos.Id).ChargeOver_Invoices__r){

                            if('Void' != inv.ChargeOver_Invoice_Status__c){
                                hasANotVoid = true;
                                if(inv.Invoice_Date__c <= Date.today()){
                                    datelessThan = true;
                                }
                            }
                        }
                        if(hasANotVoid){
                            if(a.ChargeOver_Invoice_Line_Items__r.isEmpty()){
                                firstYear = true;
                            } else {
                                if(datelessThan){
                                    renewed = true;
                                }
                            }
                        }

                    } 
                    //Separating the finance logic because it includes suspended status
                    if('Current' == cos.Status__c || 'Suspended' == cos.Status__c) {
                        Boolean noVoidOrOverdue = true;
                        for(ChargeOver_Invoice__c inv : mappedSubscriptions.get(cos.Id).ChargeOver_Invoices__r){
                            if('Void' == inv.ChargeOver_Invoice_Status__c
                            || 'Overdue' == inv.ChargeOver_Invoice_Status__c){
                                noVoidOrOverdue = false;
                            }
                        }
                        //If they do not this account qualifies for the current finance status
                        if(noVoidOrOverdue){
                            current = true;
                        }
                    }
                    if('Overdue' == cos.Status__c || 'Suspended' == cos.Status__c){
                        Boolean noVoid = true;
                        Boolean hasPastDue = false;
                        Date monthsAgo = Date.today().addMonths(-15);
                        for(ChargeOver_Invoice__c inv : mappedSubscriptions.get(cos.Id).ChargeOver_Invoices__r){
                            if('Overdue' == inv.ChargeOver_Invoice_Status__c){
                                hasPastDue = true;
                            }
                            if('Void' == inv.ChargeOver_Invoice_Status__c){
                                noVoid = false;
                            }
                        }
                        if(noVoid && (a.ChargeOver_Most_Recent_Payment_Date__c < monthsAgo)){
                            dormant = true;
                        } else if(hasPastDue) {
                            pastDue = true;
                        }
                    }
                    if('Suspended' != cos.Status__c){
                        allSuspended = false;
                    }
                }
            }

            //After checking all the subscriptions, invoices 
            if(firstYear && '1st Year Client' != a.Account_Status__c
                && a.ChargeOver_Most_Recent_Payment_Date__c != null){ //updated criteria -mc
                a.Account_Status__c = '1st Year Client';
                toUpdateAccounts.put(a.Id, a);
            }
            if(allSuspended && !mappedAccounts.get(a.Id).ChargeOver_Subscriptions__r.isEmpty() && 'Suspended' != a.Account_Status__c){
                a.Account_Status__c = 'Suspended';
                toUpdateAccounts.put(a.Id, a);
            }
            if(renewed && 'Renewed Client' != a.Account_Status__c
                && a.ChargeOver_Most_Recent_Payment_Date__c != null){ //updated criteria -mc
                a.Account_Status__c = 'Renewed Client';
                toUpdateAccounts.put(a.Id, a);
            }
            if(partnerSubscribed && 'Partner-Subscribed Prospect' != a.Account_Status__c){ //added new status -mc
                a.Account_Status__c = 'Partner-Subscribed Prospect';
                toUpdateAccounts.put(a.Id, a);
            }
            if(current && 'Current' != a.Finance_Status__c
            && a.ChargeOver_Most_Recent_Payment_Date__c != null){
                a.Finance_Status__c = 'Current';
                toUpdateAccounts.put(a.Id, a);
            }
            if(pastDue && 'Past Due' != a.Finance_Status__c
            && a.ChargeOver_Most_Recent_Payment_Date__c != null){
                a.Finance_Status__c = 'Past Due';
                toUpdateAccounts.put(a.Id, a);
            }
            if(dormant && 'Dormant' != a.Finance_Status__c
            && a.ChargeOver_Most_Recent_Payment_Date__c != null){
                a.Finance_Status__c = 'Dormant';
                toUpdateAccounts.put(a.Id, a);
            }
            
            //If all the subscriptions are cancelled
            if(allCancelled && !mappedAccounts.get(a.Id).ChargeOver_Subscriptions__r.isEmpty()){
                //Account statuses starting with active pending cancel
                if(pendingCancel){
                    if('Active-Pending Cancel (Pause)' != a.Account_Status__c){ // fixed typo (?) 
                        a.Account_Status__c = 'Active-Pending Cancel (Pause)';
                        toUpdateAccounts.put(a.Id, a);
                    }
                //If it doesn't meet that condition for account status, move on to refunded and paused
                } else {
                    //If it has a subscription more than 30% refunded
                    if(refunded){
                        if(a.Account_Status__c != 'Refunded'){
                            a.Account_Status__c = 'Refunded';
                            toUpdateAccounts.put(a.Id, a);
                        }
                    } else {
                        if('Paused' != a.Account_Status__c){
                            if('Partner-Subscribed Prospect' == a.Account_Status__c || 'Partner-Subscribed Prospect' == a.Last_Account_Status__c){
                                a.Account_Status__c = 'Prospect';
                                toUpdateAccounts.put(a.Id, a);
                            } else {
                                a.Account_Status__c = 'Paused Client';
                                toUpdateAccounts.put(a.Id, a);
                            }
                        }                            
                    }
                }
            }
            if(allCancelled && !mappedAccounts.get(a.Id).ChargeOver_Subscriptions__r.isEmpty()
            && a.ChargeOver_Initial_Payment_Date__c != null){
                //Finance statuses
                if(refunded){
                    if(a.Finance_Status__c != 'Refunded'){
                        a.Finance_Status__c = 'Refunded';
                        toUpdateAccounts.put(a.Id, a);
                    } 
                }   else {
                    a.Finance_Status__c = 'Paused';
                    toUpdateAccounts.put(a.Id, a);
                }
            }

        }
        update toUpdateAccounts.values();
    }
}