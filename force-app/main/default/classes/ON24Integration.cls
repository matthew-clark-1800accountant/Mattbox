public class ON24Integration {
    //deprecated 9-11-23
    // public List<ON24_Event__c> lstON24 {get;set;}
    // public ON24Integration(){
    //     String theString =	'<events>'+
    //                             '<event uniqid="980737_1">'+
    //                                 '<eventid>980737</eventid>'+
    //                                 '<sessionid>1</sessionid>'+
    //                                 '<eventtitle>TestEvent123</eventtitle>'+
    //                                 '<eventabstract>...</eventabstract>'+
    //                                 '<eventtime>04/14/15 05:00 PM GMT</eventtime>'+
    //                             '</event>'+
    //                             '<event uniqid="980738_1">'+
    //                                 '<eventid>980738</eventid>'+
    //                                 '<sessionid>1</sessionid>'+
    //                                 '<eventtitle>TestEvent456</eventtitle>'+
    //                                 '<eventabstract>...</eventabstract>'+
    //                                 '<eventtime>05/14/15 07:00 PM GMT</eventtime>'+
    //                             '</event>'+
    //                         '</events>';
    //     lstON24 = new List<ON24_Event__c>();
        
    //     Dom.document doc = new dom.document();
    //     doc.load(theString);
    //     dom.xmlnode eventList = doc.getRootElement();
        
    //     for(Dom.xmlNode x : eventList.getChildren()){
    //         if(x.getName() == 'event'){
    //             parseXML(x);
    //         }
	// 	}
    //     upsert lstON24 Event_ID__C;
    // }
    
    // public void parseXML(dom.xmlnode theEvent){
    //     ON24_Event__c on24 = new ON24_Event__c();
    //         on24.Event_ID__C = theEvent.getChildElement('eventid',null).getText();
    //     	on24.Session_ID__c = theEvent.getChildElement('sessionid',null).getText();
    //     	on24.Event_Name__c = theEvent.getChildElement('eventtitle',null).getText();
    //     	String strDT = theEvent.getChildElement('eventtime',null).getText();
    //     	if (strDT.contains(':')){
    //     		DateTime theDateTime = DateTime.parse(strDT.substring(0,strDT.indexOf(':')+6));
    //     		on24.Event_Time__c = theDateTime;
    //         }
    //     lstON24.add(on24);
    // }
    
}