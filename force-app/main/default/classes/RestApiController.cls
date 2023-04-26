public with sharing class RestApiController {
    private class CustomException extends Exception{}

    public static Boolean logResults = false;
    public static String runQuery(String query){

        //String endPoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v43.0/query/?q=';
        String endPoint = 'https://1800accountant.my.salesforce.com'+'/services/data/v43.0/query/?q=';
        String escapedQuery = EncodingUtil.urlEncode(query, 'UTF-8');
        HttpRequest req; 
        HttpResponse res; 
        Http h; 

        req = new HttpRequest(); 
        req.setHeader('Authorization', 'Bearer ' + getApiToken()); 
        req.setEndpoint(endPoint+escapedQuery); 
        req.setMethod('GET'); 
        h = new Http(); 
        res = h.send(req); 
        printLomgString(res.getBody()); 
        logOutput('rest runQuery', res.getBody());
        return res.getBody();
    }

    // public static String explainQuery(String query){

    //     //String endPoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v43.0/query/?q=';
    //     String endPoint = 'https://1800accountant.my.salesforce.com'+'/services/data/v43.0/query/?explain=';
    //     String escapedQuery = EncodingUtil.urlEncode(query, 'UTF-8');
    //     HttpRequest req; 
    //     HttpResponse res; 
    //     Http h; 

    //     req = new HttpRequest(); 
    //     req.setHeader('Authorization', 'Bearer ' + getApiToken()); 
    //     req.setEndpoint(endPoint+escapedQuery); 
    //     req.setMethod('GET'); 
    //     h = new Http(); 
    //     res = h.send(req); 
    //     printLomgString(res.getBody()); 
    //     logOutput('rest runQuery', res.getBody());
    //     return res.getBody();
    // }

    // public static String getNextRecords(String nextRecordsUrl){
    //     String endPoint = URL.getSalesforceBaseUrl().toExternalForm()+nextRecordsUrl;
    //     String endPoint = 'https://1800accountant.my.salesforce.com'+nextRecordsUrl;
    //     HttpRequest req; 
    //     HttpResponse res; 
    //     Http h; 

    //     req = new HttpRequest(); 
    //     req.setHeader('Authorization', 'Bearer ' + getApiToken()); 
    //     req.setEndpoint(endPoint); 
    //     req.setMethod('GET'); 
    //     h = new Http(); 
    //     res = h.send(req); 
    //     System.debug(res.getBody()); 
    //     logOutput('getNextRecords', res.getBody());
    //     return res.getBody();
    // }
    
    public static String getApiToken(){
        // String token = UserInfo.getSessionId();
        // if(token == null){
        //     CustomException ex = new CustomException('No session Id found');
        //     ex.setMessage('No session Id found');
        //     throw ex;
        // } 
        // return token;
        String endPoint = 'https://1800accountant.my.salesforce.com/services/oauth2/token';
        HttpRequest req; 
        HttpResponse res; 
        Map<String,Object> responseData;
        Http h; 

        //String body = '{"grant_type": "client_credentials", "client_id": "3MVG9fMtCkV6eLheBO26ScdZCApUPNzGIcEy.4Nswh_Ir3vmchh0xLG2_omgx7_CQ5mAihcnbsYO11orUZcCY", "client_secret":"2648177197F1477D425D73C699A0E23889040F925111ADB6D3F72DEE266F4574"}';
        String body = 'grant_type=client_credentials&client_id=3MVG9fMtCkV6eLheBO26ScdZCApUPNzGIcEy.4Nswh_Ir3vmchh0xLG2_omgx7_CQ5mAihcnbsYO11orUZcCY&client_secret=2648177197F1477D425D73C699A0E23889040F925111ADB6D3F72DEE266F4574';
        req = new HttpRequest(); 
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded'); 
        req.setEndpoint(endPoint); 
        req.setMethod('POST'); 

        try{
            req.setBody(body); 
            h = new Http(); 
            res = h.send(req);              
            //logOutput('getApiToken', res.getBody());
            responseData = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
            System.debug((String) responseData?.get('access_token')); 
        } catch (Exception ex){
            System.debug(ex.getMessage());
        }
        return (String) responseData?.get('access_token');
    }

    //@future(callout=true)
    public static void logOutput(String title, String output){
        if(logResults){
            // ContentNote cnt = new ContentNote();
            // cnt.Content = Blob.valueof(output);
            // cnt.Title = title+Datetime.now().time();
            // cnt.ownerId = Userinfo.getUserId();
            // insert cnt;
        }
    }

    public static void printLomgString(String lomgString){
        Integer index = 0;
        Integer part = 0;
        Integer partSize = 200;
        while (index < lomgString.length() - partSize) {
            System.debug(part+': '+lomgString.substring(index, index+partSize));
            index += partSize;
            part++;
        }
        System.debug(part+': '+lomgString.substring(index));
        System.debug('-');
    }
}