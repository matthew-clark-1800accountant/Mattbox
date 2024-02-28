@isTest
    public with sharing class GuidedSellingMockEndpoints implements HttpCalloutMock {
   
    public String leadResponse = '{"totalSize":10,"done":true,"records":[{"attributes":{"type":"Lead","url":"/services/data/v43.0/sobjects/Lead/00Q5e00000TbwwZEAR"},"FirstName":"Robert","LastName":"Perez","Email":"pnphome2010@yahoo.com","Status":"New","LeadSource":"1800Accountant-Legacy","Lead_Type_New__c":"Financing;Data append","Campaign__c":null,"Marketing_Channel__c":null,"Phone":null,"Company":"PNP Pest Control Services","Industry":null,"State":"TX"}]}';
    public String contactResponse = '{"totalSize":10,"done":true,"records":[{"attributes":{"type":"Contact","url":"/services/data/v43.0/sobjects/Contact/0035e00000QEs7vAAD"},"FirstName":"Andrew","LastName":"OConnor","Email":"awoconnor1987@gmail.com","Lead_Source__c":null,"Lead_Type__c":"LAP","CampaignID__c":null,"Last_SF_Activity__c":null,"Time_Zone__c":null,"MailingState":"TX","Phone":null,"Account":{"attributes":{"type":"Account","url":"/services/data/v43.0/sobjects/Account/0015e00000TyYUkAAN"},"Name":"KB CONSTRUCTION","Lead_Source__c":null,"Lead_Type_New__c":"LAP","Campaign__c":null,"Marketing_Channel__c":null,"Industry":null,"State_of_Formation__c":null,"BillingState":null,"Phone":null}}]}';
    
    public String outboundMessageResponse = '{"size":13,"totalSize":13,"done":true,"queryLocator":null,"entityTypeName":"WorkflowOutboundMessage","records":[{"attributes":{"type":"WorkflowOutboundMessage","url":"/services/data/v43.0/tooling/sobjects/WorkflowOutboundMessage/04kj0000000blO0AAI"},"Id":"04kj0000000blO0AAI","Name":"NewClientPortal-AccountSync"},{"attributes":{"type":"WorkflowOutboundMessage","url":"/services/data/v43.0/tooling/sobjects/WorkflowOutboundMessage/04k3Z000000Cfi4QAC"},"Id":"04k3Z000000Cfi4QAC","Name":"NewClientPortal-ActiveSubLineSync"},{"attributes":{"type":"WorkflowOutboundMessage","url":"/services/data/v43.0/tooling/sobjects/WorkflowOutboundMessage/04k3Z000000CfhzQAC"},"Id":"04k3Z000000CfhzQAC","Name":"NewClientPortal-ActiveSubSync"}]}';
    public HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        String reqEndpoint = req.getEndpoint();
        String bodyString = '';
        System.debug('***reqEndpoint: '+reqEndpoint);
        // if(!reqEndpoint.contains('tooling')){
        //     if(reqEndpoint.contains('Calculator_Field__c')){
        //         bodyString = calculatorFieldResponse;
        //     } else if (reqEndpoint.contains('Calculator_Dropdown__c')){
        //         bodyString = calculatorDropdownResponse;
        //     } else if (reqEndpoint.contains('Calculator_Rule__c')){
        //         bodyString = calculatorRuleResponse;
        //     } else if (reqEndpoint.contains('token')){ //double check this one
        //         bodyString = apiTokenResponse;
        //     } else if (reqEndpoint.contains('rh2__PS_Export_Rollups__c')){
        //         bodyString = rollupRuleResponse;
        //     } else if (reqEndpoint.contains('FROM+Lead')){
        //         bodyString = leadResponse;
        //     } else if (reqEndpoint.contains('FROM+Contact')){
        //         bodyString = contactResponse;
        //     }
        // } else {
        //     if(reqEndpoint.contains('query')){ //request to get endpoint data
        //         bodyString = outboundMessageResponse;
        //     } else if (reqEndpoint.contains('sobjects')){ //update or delete records

        //     }
        // }
        
        // System.assertEquals('https://example.com/example/test', req.getEndpoint());
        // System.assertEquals('GET', req.getMethod());
        LaunchGuidedSellingInvocable.SessionKeyApiResponse resp = new LaunchGuidedSellingInvocable.SessionKeyApiResponse();
        resp.session_id = 'test session id';
        resp.controller_token='test controller token';
        resp.presentation_token='test presentation token';
        resp.channel_id='test channel id';
        bodyString = JSON.serialize(resp);
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(bodyString);
        res.setStatusCode(200);
        return res;
    }
}