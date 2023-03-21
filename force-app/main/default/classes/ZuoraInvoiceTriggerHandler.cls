public class ZuoraInvoiceTriggerHandler {
    /*
    public static void updateInvoicePaymentAmount (List<Zuora__ZInvoice__c> newInvoices) {
        System.debug('newInvoices :: ' + newInvoices);

        // Get all Account IDs
        List<Id> accountsToQuery = new List<Id>();

        for (Zuora__ZInvoice__c invoice : newInvoices) {
            if (invoice.Zuora__Account__c != null) {
                accountsToQuery.add(invoice.Zuora__Account__c);
            }
        }

        System.debug(LoggingLevel.DEBUG, 'collected accountsToQuery size :: ' + accountsToQuery.size());
        // Run function to update all relevant events on all accounts

        EventTriggerHandler.updateInvoicePaymentAmountByAccount(accountsToQuery);
        return;
    } */
}