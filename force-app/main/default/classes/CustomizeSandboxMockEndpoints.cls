@isTest
global with sharing class CustomizeSandboxMockEndpoints implements HttpCalloutMock {
    public String calculatorFieldResponse = '{"totalSize":22,"done":true,"records":[{"attributes":{"type":"Calculator_Field__c","url":"/services/data/v43.0/sobjects/Calculator_Field__c/a1j3Z00000CI733QAD"},"Name":"Filing Status","Required_In_Environment__c":"Standard"},{"attributes":{"type":"Calculator_Field__c","url":"/services/data/v43.0/sobjects/Calculator_Field__c/a1j3Z00000CI734QAD"},"Name":"Number of Employees","Required_In_Environment__c":"Standard;ClientBooks;Sprout;Vendasta"}]}';
    public String calculatorDropdownResponse = '{"totalSize":939,"done":true,"records":[{"attributes":{"type":"Calculator_Dropdown__c","url":"/services/data/v43.0/sobjects/Calculator_Dropdown__c/a1Z3Z000006buloUAA"},"Name":"IT Coffee","Default__c":false,"Display_Format__c":null,"Dropdown_Value__c":"Coffee","Form_Field__c":"Industry Type","Number_of_Hours__c":0.0,"Price_Adjustment__c":0.0,"Product__c":"Business Return","Setup_fee__c":false,"Sort__c":9.0},{"attributes":{"type":"Calculator_Dropdown__c","url":"/services/data/v43.0/sobjects/Calculator_Dropdown__c/a1Z3Z000006bulpUAA"},"Name":"IT Dentistry","Default__c":false,"Display_Format__c":null,"Dropdown_Value__c":"Dentistry","Form_Field__c":"Industry Type","Number_of_Hours__c":0.0,"Price_Adjustment__c":0.0,"Product__c":"Business Return","Setup_fee__c":false,"Sort__c":14.0}]}';
    public String calculatorRuleResponse = '{"totalSize":41,"done":true,"records":[{"attributes":{"type":"Calculator_Rule__c","url":"/services/data/v43.0/sobjects/Calculator_Rule__c/a1a3Z00000Jid3nQAB"},"Action__c":"Disable Product","Active__c":true,"Amount__c":null,"Name":"Disable 1023","Criteria_Field_1__c":"Lead_Type_New__c","Criteria_Field_2__c":"Lead_Source__c","Criteria_Object__c":"Account","Environment__c":null,"Field_1_Operator__c":"Contains String","Field_1_Value__c":"Non-Profit","Field_2_Operator__c":"Equal String","Field_2_Value__c":"LegalZoom","Message__c":"This client already has completed Form 1023 through our dedicated partner"}]}';
    public String apiTokenResponse = '{"access_token":"00Dj0000000HTLp!ASAAQA18J2Jep4at0WiM9oL4_PEPG351eo1GXjDC_JkRRWEOqTcoWIva92.R2bv1OLLqqp0o2v0hhpgJf2JIDJ1VyIfKJkJC","signature":"6qwDBA/+HEsco0Kz5Wbdp5aYwFg28k72zN5tVF/Hmf4=","scope":"api","instance_url":"https://1800accountant.my.salesforce.com","id":"https://login.salesforce.com/id/00Dj0000000HTLpEAO/0055e000007ARqqAAG","token_type":"Bearer","issued_at":"1679944062447"}';
    
    public String rollupRuleResponse = '{"totalSize":98,"done":true,"records":[{"attributes":{"type":"rh2__PS_Export_Rollups__c","url":"/services/data/v43.0/sobjects/rh2__PS_Export_Rollups__c/a4K5e000000jYe5EAE"},"rh2__type__c":"filter","rh2__RollupOrFilterData__c":'
    +'"{\\\"attributes\\\":{\\\"type\\\":\\\"rh2__HS_Filter__c\\\"},\\\"Id\\\":\\\"a275e00000168TGAAY\\\",\\\"Name\\\":\\\"FC-0062\\\",\\\"rh2__ImportId__c\\\":\\\"Task FC-0078\\\",\\\"rh2__Condition__c\\\":\\\"Collection Calls\\\",\\\"rh2__JSON__c\\\":\\\"'
    +'{\\\\\\\"table\\\\\\\":\\\\\\\"Task\\\\\\\",\\\\\\\"sorts\\\\\\\":[{\\\\\\\"objName\\\\\\\":\\\\\\\"Task\\\\\\\",\\\\\\\"logic\\\\\\\":\\\\\\\"DESC\\\\\\\",\\\\\\\"itemNumber\\\\\\\":0,\\\\\\\"field\\\\\\\":\\\\\\\"Id\\\\\\\"}],\\\\\\\"relSObjectType\\\\\\\":{},\\\\\\\"offsetVar\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"limitVar\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"invalidBoolMessage\\\\\\\":null,\\\\\\\"hasCriteriaPicklist\\\\\\\":null,\\\\\\\"filterFieldType\\\\\\\":null,\\\\\\\"dh\\\\\\\":{},\\\\\\\"criterion\\\\\\\":[{\\\\\\\"objName\\\\\\\":\\\\\\\"Task\\\\\\\",\\\\\\\"logic\\\\\\\":\\\\\\\"=\\\\\\\",\\\\\\\"id\\\\\\\":0,\\\\\\\"fieldType\\\\\\\":\\\\\\\"PICKLIST\\\\\\\",\\\\\\\"field\\\\\\\":\\\\\\\"calltype\\\\\\\",\\\\\\\"condition\\\\\\\":\\\\\\\"Outbound\\\\\\\"},{\\\\\\\"objName\\\\\\\":\\\\\\\"Task\\\\\\\",\\\\\\\"logic\\\\\\\":\\\\\\\"=\\\\\\\",\\\\\\\"id\\\\\\\":2,\\\\\\\"fieldType\\\\\\\":\\\\\\\"DATETIME\\\\\\\",\\\\\\\"field\\\\\\\":\\\\\\\"createddate\\\\\\\",\\\\\\\"condition\\\\\\\":\\\\\\\"LAST_N_DAYS:365\\\\\\\"},{\\\\\\\"objName\\\\\\\":\\\\\\\"Task\\\\\\\",\\\\\\\"logic\\\\\\\":\\\\\\\"!=\\\\\\\",\\\\\\\"id\\\\\\\":null,\\\\\\\"fieldType\\\\\\\":\\\\\\\"INTEGER\\\\\\\",\\\\\\\"field\\\\\\\":\\\\\\\"calldurationinseconds\\\\\\\",\\\\\\\"condition\\\\\\\":\\\\\\\"null\\\\\\\"},{\\\\\\\"objName\\\\\\\":\\\\\\\"Task\\\\\\\",\\\\\\\"logic\\\\\\\":\\\\\\\"!=\\\\\\\",\\\\\\\"id\\\\\\\":null,\\\\\\\"fieldType\\\\\\\":\\\\\\\"DATETIME\\\\\\\",\\\\\\\"field\\\\\\\":\\\\\\\"vonage_trigger__c\\\\\\\",\\\\\\\"condition\\\\\\\":\\\\\\\"null\\\\\\\"},{\\\\\\\"objName\\\\\\\":\\\\\\\"Task\\\\\\\",\\\\\\\"logic\\\\\\\":\\\\\\\"=\\\\\\\",\\\\\\\"id\\\\\\\":null,\\\\\\\"fieldType\\\\\\\":\\\\\\\"PICKLIST\\\\\\\",\\\\\\\"field\\\\\\\":\\\\\\\"assigned_to_role__c\\\\\\\",\\\\\\\"condition\\\\\\\":\\\\\\\"Collections\\\\\\\"}],\\\\\\\"removeNullsLast\\\\\\\":false,\\\\\\\"recName\\\\\\\":\\\\\\\"FC-0062\\\\\\\",\\\\\\\"isSubQuery\\\\\\\":true,\\\\\\\"isBatch\\\\\\\":true,\\\\\\\"groupBy\\\\\\\":null,\\\\\\\"filterName\\\\\\\":\\\\\\\"Collection Calls\\\\\\\",\\\\\\\"boolLogic\\\\\\\":\\\\\\\"((1 AND 3) OR 4) AND 2 AND 5\\\\\\\"}\\\",\\\"rh2__Logic__c\\\":\\\"rh2.HS_Filter\\\",\\\"rh2__XRef__c\\\":\\\"Task\\\"}"'+
    //+'"{}"'+
    ',"rh2__filterJobRollupKey__c":"FC-0062"}]}';
   
    public String leadResponse = '{"totalSize":10,"done":true,"records":[{"attributes":{"type":"Lead","url":"/services/data/v43.0/sobjects/Lead/00Q5e00000TbwwZEAR"},"FirstName":"Robert","LastName":"Perez","Email":"pnphome2010@yahoo.com","Status":"New","LeadSource":"1800Accountant-Legacy","Lead_Type_New__c":"Financing;Data append","Campaign__c":null,"Marketing_Channel__c":null,"Phone":null,"Company":"PNP Pest Control Services","Industry":null,"State":"TX"}]}';
    public String contactResponse = '{"totalSize":10,"done":true,"records":[{"attributes":{"type":"Contact","url":"/services/data/v43.0/sobjects/Contact/0035e00000QEs7vAAD"},"FirstName":"Andrew","LastName":"OConnor","Email":"awoconnor1987@gmail.com","Lead_Source__c":null,"Lead_Type__c":"LAP","CampaignID__c":null,"Last_SF_Activity__c":null,"Time_Zone__c":null,"MailingState":"TX","Phone":null,"Account":{"attributes":{"type":"Account","url":"/services/data/v43.0/sobjects/Account/0015e00000TyYUkAAN"},"Name":"KB CONSTRUCTION","Lead_Source__c":null,"Lead_Type_New__c":"LAP","Campaign__c":null,"Marketing_Channel__c":null,"Industry":null,"State_of_Formation__c":null,"BillingState":null,"Phone":null}}]}';
    
    public String outboundMessageResponse = '{"size":13,"totalSize":13,"done":true,"queryLocator":null,"entityTypeName":"WorkflowOutboundMessage","records":[{"attributes":{"type":"WorkflowOutboundMessage","url":"/services/data/v43.0/tooling/sobjects/WorkflowOutboundMessage/04kj0000000blO0AAI"},"Id":"04kj0000000blO0AAI","Name":"NewClientPortal-AccountSync"},{"attributes":{"type":"WorkflowOutboundMessage","url":"/services/data/v43.0/tooling/sobjects/WorkflowOutboundMessage/04k3Z000000Cfi4QAC"},"Id":"04k3Z000000Cfi4QAC","Name":"NewClientPortal-ActiveSubLineSync"},{"attributes":{"type":"WorkflowOutboundMessage","url":"/services/data/v43.0/tooling/sobjects/WorkflowOutboundMessage/04k3Z000000CfhzQAC"},"Id":"04k3Z000000CfhzQAC","Name":"NewClientPortal-ActiveSubSync"}]}';
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        String reqEndpoint = req.getEndpoint();
        String bodyString = '';
        System.debug('***reqEndpoint: '+reqEndpoint);
        if(!reqEndpoint.contains('tooling')){
            if(reqEndpoint.contains('Calculator_Field__c')){
                bodyString = calculatorFieldResponse;
            } else if (reqEndpoint.contains('Calculator_Dropdown__c')){
                bodyString = calculatorDropdownResponse;
            } else if (reqEndpoint.contains('Calculator_Rule__c')){
                bodyString = calculatorRuleResponse;
            } else if (reqEndpoint.contains('token')){ //double check this one
                bodyString = apiTokenResponse;
            } else if (reqEndpoint.contains('rh2__PS_Export_Rollups__c')){
                bodyString = rollupRuleResponse;
            } else if (reqEndpoint.contains('FROM+Lead')){
                bodyString = leadResponse;
            } else if (reqEndpoint.contains('FROM+Contact')){
                bodyString = contactResponse;
            }
        } else {
            if(reqEndpoint.contains('query')){ //request to get endpoint data
                bodyString = outboundMessageResponse;
            } else if (reqEndpoint.contains('sobjects')){ //update or delete records

            }
        }
        
        // System.assertEquals('https://example.com/example/test', req.getEndpoint());
        // System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(bodyString);
        res.setStatusCode(200);
        return res;
    }
}