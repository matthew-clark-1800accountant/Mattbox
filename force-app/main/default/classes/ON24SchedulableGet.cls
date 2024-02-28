global class ON24SchedulableGet{// implements Schedulable{
    //deprecated 9-11-23
    
    // @future (callout=true)
    // public static void run(){
    //     runSync();
    // }
    // public static void runSync(){
    //     List<ON24_Event__c> lstON24 = new List<ON24_Event__c>();
        
    //     //set up http request
    //     HTTP h = new HTTP();
    //     HTTPRequest req = new HTTPRequest();
    //     req.setMethod('GET');
    //     req.setTimeout(120000);
    //     ON24_Settings__c settings = ON24_Settings__c.getOrgDefaults();
    //     String theEndpoint = 'https://data.on24.com/utilApp/syndication/rss.jsp?';
    //     //get values for this out of the custom setting
    //     if(settings.Client_ID__c != null) theEndpoint += 'clientid='+settings.Client_ID__c;
    //     if(settings.Key__c != null)       theEndpoint += '&key='+settings.Key__c;
    //     if(settings.Config__c != null)    theEndpoint +='&config='+settings.Config__c;
    //     if(settings.Partner__c != null)   theEndpoint +='&partner='+settings.Partner__c;
    //     //add parameter for previous day
    //     Date yesterday = date.today().adddays(-1);
    //     String yesterformatted = string.valueof(yesterday.month()) + '/' + string.valueof(yesterday.day()) + '/' + string.valueof(yesterday.year());
    //     theEndpoint +='&fromdate=' + yesterformatted;
    //     req.setEndpoint(theEndpoint);
        
    //     //send the request and set up parsing
    //     HTTPResponse res = h.send(req);
    //     system.debug('ON24 response: '+res.getBody());
    //     DOM.document doc = new DOM.document();
        
    //     String thebody = res.getBody();
    //     system.debug(thebody);
    //     thebody = xmlcdata.addCDataNodes(thebody);

    //     system.debug(thebody);
        
    //     doc.load(theBody);
    //     DOM.xmlnode eventList = doc.getRootElement();
        
    //     //parse that shiz
    //     for(Dom.xmlNode theEvent : eventList.getChildren()){
    //         if(theEvent.getName() == 'event'){
    //             ON24_Event__c on24 = new ON24_Event__c();
    //             on24.Event_ID__C = theEvent.getChildElement('eventid',null).getText();
    //             on24.Session_ID__c = theEvent.getChildElement('sessionid',null).getText();
    //             on24.Event_Name__c = XMLCData.text(theEvent.getChildElement('eventtitle',null));
                
    //             String KeyElement = XMLCData.text(theEvent.getChildElement('audienceurl',null));
                
    //             system.debug('KeyElement = ' + keyElement);
                
    //             if(KeyElement.contains('http://event.on24.com')){
                                        
    //                 List<String> split1 = KeyElement.split('&');
    //                 List<String> split2 = split1[0].split('/');
                    
    //                 on24.Key__c = split2[split2.size() - 1];
                    
    //             } else if (KeyElement.contains('https://event.on24.com')){
                    
    //                 List<String> split1 = KeyElement.split('&');
    //                 List<String> split2 = split1[0].split('/');
                    
    //                 on24.Key__c = split2[split2.size() - 1];
                    
    //             } else {
    //                 on24.Key__c = KeyElement.split('k=')[1].split('&')[0];

    //             }
                
                
    //             system.debug(theEvent.getChildElement('audienceurl',null).getText());
    //             String strDT = theEvent.getChildElement('eventtime',null).getText();
    //             if(strDT.contains(':')){
    //                 DateTime theDateTime = DateTime.parse(strDT.substring(0,strDT.indexOf(':')+6));
    //                 on24.Event_Time__c = theDateTime;
                    
    //                 TimeZone tz = UserInfo.getTimeZone();
                    
    //                 system.debug('this offset: ' + tz.getOffset(on24.Event_Time__c));
    //                 system.debug(json.serialize(on24.event_time__c));
                    
    //                 system.debug(on24.event_time__c);
                    
    //                 on24.Event_Time__c = on24.Event_Time__c.addSeconds(tz.getOffset(on24.Event_Time__c) / 1000);
                    
    //             }
    //             lstON24.add(on24);
    //         }
    //     }
        
    //     //upsert that shiz on the external ID field
    //     system.debug('ON42 post parsing: '+lstON24);
    //     upsert lstON24 Event_ID__C;
    // }

    // global void execute(SchedulableContext sc) {
    //     ON24SchedulableGet.run();
    // }
    

}