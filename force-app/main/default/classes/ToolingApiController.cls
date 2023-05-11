public with sharing class ToolingApiController {
    private class CustomException extends Exception{}

    public class OutboundMsg { public List<RecordWrapper> records;}
    public class RecordWrapper { public MetadataWrapper Metadata; public String Id; public String Name; }
    public class MetadataWrapper { public String endpointUrl; public Double apiVersion=35.0; public String integrationUser; public String name;}
    public class CompositeRequestWrapper { public Boolean allOrNone; public List<CompositeSubrequestWrapper> compositeRequest; }
    public class CompositeSubrequestWrapper { public Object body; public String method; public String referenceId; public String url;}
    public class CompositePostWrapper { public Boolean allOrNone; public List<sObject> records; }
    //patch requests can also use CompositePostWrapper ^
    public class CompositeGetWrapper  { public List<String> ids; public List<String> fields; }
    public class CompositeGetResponseWrapper { public String Id; public Map<String,String> attributes; }
    //public class CompositeDeleteWrapper { public Boolean allOrNone; public List<String> ids;}
    public static Boolean logResults = true;
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
        printLomgString(res.getBody());             
        logOutput('tooling runquery', res.getBody());
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

    // public static String testOutboundUpdate(){
    //     String resStr = ToolingApiController.runQuery('select Name, Id from WorkflowOutboundMessage order by Name limit 100');
    //     ToolingApiController.OutboundMsg om = (ToolingApiController.OutboundMsg) JSON.deserialize(resStr, ToolingApiController.OutboundMsg.Class);
    //     String recId = om.records[0].Id;
    //     resStr = ToolingApiController.runQuery('select Metadata from WorkflowOutboundMessage where Id=\''+recId+'\' order by Name limit 100');
    //     //printLomgString(resStr);
    //     om = (ToolingApiController.OutboundMsg) JSON.deserialize(resStr, ToolingApiController.OutboundMsg.Class);
    //     om.records[0].Metadata.endpointUrl += 'test';
    //     printLomgString(JSON.serialize(om));
    //     RecordWrapper rec = om.records[0];
    //     rec.Metadata.apiVersion=35.0;
    //     String omString = JSON.serialize(rec, true);
    //     printLomgString('omString: '+omString);
    //     // updateObject('WorkflowOutboundMessage', recId, omString);
    //     // return omString;

    //     String endPoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v43.0/tooling/sobjects/WorkflowOutboundMessage/';
    //     printLomgString(endPoint+recId+'/');
    //     HttpRequest req; 
    //     HttpResponse res; 
    //     Http h; 

    //     req = new HttpRequest(); 
    //     //req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID()); 
    //     req.setHeader('Authorization', 'Bearer ' + getToolingToken());
    //     req.setHeader('Content-Type', 'application/json'); 
    //     req.setEndpoint(endPoint+recId+'/'); 
    //     req.setMethod('PATCH'); 

    //     try{
    //         String body = omString;
    //         req.setBody(body); 
    //         h = new Http(); 
    //         res = h.send(req); 
    //         printLomgString(res.getBody()); 
    //     } catch (Exception ex){
    //         printLomgString(ex.getMessage());
    //     }
    //     return res.getBody();
    // }

    

    @future(callout=true)
    public static void updateObject(String objectType, String recId, String jsonBody){
        String endPoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v43.0/tooling/sobjects/'+objectType+'/';
        printLomgString(endPoint+recId+'/');
        printLomgString(jsonBody);
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
            printLomgString(res.getBody());            
            logOutput('updateObject', res.getBody());
        } catch (Exception ex){
            printLomgString(ex.getMessage());
        }
        //return res.getBody();
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

    @future(callout=true)
    public static void deleteRecords(List<String> idList, String objectType){
        CompositeRequestWrapper compReq = new CompositeRequestWrapper();
        compReq.allOrNone = true;
        compReq.compositeRequest = new List<CompositeSubrequestWrapper>();
        String endPoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v43.0/tooling/composite';
        for(String id : idList){
            CompositeSubrequestWrapper subReq = new CompositeSubrequestWrapper();
            subReq.method = 'DELETE';
            subReq.url = '/services/data/v43.0/tooling/sobjects/'+objectType+'/'+id;
            System.debug(subReq.url);
            subReq.referenceId = 'refid'+id;
            compReq.compositeRequest.add(subReq);
        } 
        printLomgString(endPoint);
        HttpRequest req; 
        HttpResponse res; 
        Http h; 
        String jsonBody = JSON.serialize(compReq, true);
        printLomgString(jsonBody);

        req = new HttpRequest(); 
        //req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID()); 
        req.setHeader('Authorization', 'Bearer ' + getToolingToken());
        req.setHeader('Content-Type', 'application/json'); 
        req.setEndpoint(endPoint); 
        req.setMethod('POST'); 

        try{
            req.setBody(jsonBody); 
            h = new Http(); 
            res = h.send(req); 
            printLomgString(res.getBody()); 
            logOutput('deleteRecords', res.getBody());
        } catch (Exception ex){
            printLomgString(ex.getMessage());
        }
    }

    //@future(callout=true)
    // public static void updateRecords(Map<String,Object> idToRecordJson, String objectType){
    //     CompositeRequestWrapper compReq = new CompositeRequestWrapper();
    //     compReq.allOrNone = true;
    //     compReq.compositeRequest = new List<CompositeSubrequestWrapper>();
    //     String endPoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v43.0/tooling/composite/';
    //     for(String id : idToRecordJson.keySet()){
    //         CompositeSubrequestWrapper subReq = new CompositeSubrequestWrapper();
    //         subReq.method = 'PATCH';
    //         subReq.url = '/services/data/v43.0/tooling/sobjects/'+objectType+'/'+id+'/';
    //         subReq.body = idToRecordJson.get(id);
    //         System.debug(subReq.url);
    //         System.debug('**body: '+subReq.body);
    //         subReq.referenceId = 'refid'+id;
    //         compReq.compositeRequest.add(subReq);
    //     }
    //     // String endPoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v43.0/composite/sobjects?ids=';
    //     // for(String id : idList){
    //     //     endPoint += id+',';
    //     // }
    //     // endPoint = endPoint.substring(0,endPoint.length()-1);
    //     // endPoint += '&allOrNone=true';
    //     printLomgString(endPoint);
    //     HttpRequest req; 
    //     HttpResponse res; 
    //     Http h; 
    //     //todo: fix this monstrosity
    //     String jsonBody = JSON.serialize(compReq, true).replace('"{', '{').replace('}"', '}').replace('\\"', '"');
    //     printLomgString(jsonBody);

    //     req = new HttpRequest(); 
    //     //req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID()); 
    //     req.setHeader('Authorization', 'Bearer ' + getToolingToken());
    //     req.setHeader('Content-Type', 'application/json'); 
    //     req.setEndpoint(endPoint); 
    //     req.setMethod('POST'); 

    //     try{
    //         req.setBody(jsonBody); 
    //         h = new Http(); 
    //         res = h.send(req); 
    //         printLomgString(res.getBody()); 
    //         logOutput('updateRecords', res.getBody());
    //     } catch (Exception ex){
    //         printLomgString(ex.getMessage());
    //     }
    // }

    //@future(callout=true)
    public static void logOutput(String title, String output){
        if(logResults){
            ContentNote cnt = new ContentNote();
            cnt.Content = Blob.valueof(output);
            cnt.Title = title+Datetime.now().time();
            cnt.ownerId = Userinfo.getUserId();
            insert cnt;
        }
    }
}