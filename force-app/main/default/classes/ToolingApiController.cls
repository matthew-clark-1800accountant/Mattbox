public with sharing class ToolingApiController {
    private class CustomException extends Exception{}

    public class OutboundMsg { List<RecordWrapper> records;}
    public class RecordWrapper { MetadataWrapper Metadata; String Id; String Name; }
    public class MetadataWrapper { String endpointUrl; Double apiVersion=35.0; String integrationUser; String name;}

    
    public ToolingApiController() {

    }

    public static String runQuery(String query){

        String userToTrace = System.UserInfo.getUserId();
        String endPoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v43.0/tooling/query/?q=';
        String escapedQuery = EncodingUtil.urlEncode(query, 'UTF-8');
        HttpRequest req; 
        HttpResponse res; 
        Http h; 

        req = new HttpRequest(); 
        req.setHeader('Authorization', 'Bearer ' + getToolingToken()); 
        //req.setHeader('Content-Type', 'application/json'); 
        req.setEndpoint(endPoint+escapedQuery); 
        req.setMethod('GET'); 
        //req.setBody('{"TracedEntityId":"' + userToTrace + '","LogType":"USER_DEBUG","DebugLevelId":"7dl700000008ONeAAM"}'); 
        h = new Http(); 
        res = h.send(req); 
        System.debug(res.getBody()); 
        return res.getBody();
    }
    
    public static String getToolingToken(){
        String token = UserInfo.getSessionId();
        if(token == null){
            CustomException ex = new CustomException('No session Id found');
            ex.setMessage('No session Id found');
            throw ex;
        } 
        return token;
    }

    public static String testOutboundUpdate(){
        String resStr = ToolingApiController.runQuery('select Name, Id from WorkflowOutboundMessage order by Name limit 100');
        ToolingApiController.OutboundMsg om = (ToolingApiController.OutboundMsg) JSON.deserialize(resStr, ToolingApiController.OutboundMsg.Class);
        String recId = om.records[0].Id;
        resStr = ToolingApiController.runQuery('select Metadata from WorkflowOutboundMessage where Id=\''+recId+'\' order by Name limit 100');
        //system.debug(resStr);
        om = (ToolingApiController.OutboundMsg) JSON.deserialize(resStr, ToolingApiController.OutboundMsg.Class);
        om.records[0].Metadata.endpointUrl += 'test';
        system.debug(om);
        RecordWrapper rec = om.records[0];
        rec.Metadata.apiVersion=35.0;
        String omString = JSON.serialize(rec, true);
        System.debug('omString: '+omString);
        return updateObject('WorkflowOutboundMessage', recId, omString);
        
        // String endPoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v43.0/tooling/sobjects/WorkflowOutboundMessage/';
        // System.debug(endPoint+recId+'/');
        // HttpRequest req; 
        // HttpResponse res; 
        // Http h; 

        // req = new HttpRequest(); 
        // //req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID()); 
        // req.setHeader('Authorization', 'Bearer ' + getToolingToken());
        // req.setHeader('Content-Type', 'application/json'); 
        // req.setEndpoint(endPoint+recId+'/'); 
        // req.setMethod('PATCH'); 

        // try{
        //     String body = omString;
        //     req.setBody(body); 
        //     h = new Http(); 
        //     res = h.send(req); 
        //     System.debug(res.getBody()); 
        // } catch (Exception ex){
        //     System.debug(ex.getMessage());
        // }
        // return res.getBody();
    }

    public static String updateObject(String objectType, String recId, String jsonBody){
        String endPoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v43.0/tooling/sobjects/'+objectType+'/';
        System.debug(endPoint+recId+'/');
        HttpRequest req; 
        HttpResponse res; 
        Http h; 

        req = new HttpRequest(); 
        //req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID()); 
        req.setHeader('Authorization', 'Bearer ' + getToolingToken());
        req.setHeader('Content-Type', 'application/json'); 
        req.setEndpoint(endPoint+recId+'/'); 
        req.setMethod('PATCH'); 

        try{
            req.setBody(jsonBody); 
            h = new Http(); 
            res = h.send(req); 
            System.debug(res.getBody()); 
        } catch (Exception ex){
            System.debug(ex.getMessage());
        }
        return res.getBody();
    }
}