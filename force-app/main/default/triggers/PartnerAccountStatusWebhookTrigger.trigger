trigger PartnerAccountStatusWebhookTrigger on Partner_Account_Status__e (after insert) {

    // get current environment
    Current_API_Environment__c eset = Current_API_Environment__c.getOrgDefaults();
    String envName = eset.Environment_Name__c;

    // url of our webhook handler
    String url = 'https://1800accountant.com/sfapi/schedule/partneraccountmessage.php';
    
    // override URL if in staging environment
    if (envName == 'Staging') {
        url = 'https://staging.1800accountant.com/sfapi/schedule/partneraccountmessage.php';
    }

    // setup content to send
    String content = Webhook.jsonContent(Trigger.new, Trigger.old);
    
    // make webhook call
    Webhook.callout(url, content);

}