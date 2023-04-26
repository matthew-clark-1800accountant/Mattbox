@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        //System.assertEquals('https://example.com/example/test', req.getEndpoint());
        //
        // Create a fake response
        HttpResponse res = new HttpResponse();
        System.debug(req.getEndpoint());
        if(req.getEndpoint().contains('callout:X1800Accountant_SFAPI')){
            System.assertEquals('POST', req.getMethod());
            ApiCalloutWrapper a = (ApiCalloutWrapper) JSON.deserialize(req.getBody(), ApiCalloutWrapper.class);
            System.debug(a);
        }
        
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
        return res;
    }

    private class ApiCalloutWrapper{
        private Id eventId;
        private Boolean isUpdate;
        private EventWrapper eventData;
    }
    private class EventWrapper{
        private Id OwnerId;
        private Datetime StartDateTime;
        private Datetime EndDateTime;
        private String ShowAs;
        private String Type_of_Appointment;

        private EventWrapper(Event ev){
                this.OwnerId = ev.OwnerId;
                this.StartDateTime = ev.StartDateTime;
                this.EndDateTime = ev.EndDateTime;
                this.ShowAs = ev.ShowAs;
                this.Type_of_Appointment = ev.Type_of_Appointment__c;
        }
    }
}