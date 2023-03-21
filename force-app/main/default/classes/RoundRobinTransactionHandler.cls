public class RoundRobinTransactionHandler {
    
    /*Map<String, Round_Robin_Transaction_Setting__c> roundRobinMap;
    Map<String, List<Round_Robin_Transaction_Setting__c>> companyBrandListMap;
    Map<String, Double> roundRobinMax;
    Map<String, Map<Double, Round_Robin_Transaction_Setting__c>> roundRobinProportions = new Map<String, Map<Double, Round_Robin_Transaction_Setting__c>>();
    Map<String, Bill62__Payment_Gateway__c> paymentGatewayMap;*/
    public Integer robinIndex;
    public List<String> assignList;
    
    public RoundRobinTransactionHandler(){
        List<Round_Robin_Transaction_Setting__c> settingList = [SELECT ID, Percentage__c, Name FROM Round_Robin_Transaction_Setting__c ORDER BY CreatedDate];
        //system.debug('settingList: '+settingList);
        Set<String> gatewayNames = new Set<String>();
        for(Round_Robin_Transaction_Setting__c rt: settingList){
            gatewayNames.add(rt.Name);
        }
        
        List<Bill62__Payment_Gateway__c> gatewayList = [SELECT ID, Name FROM Bill62__Payment_Gateway__c];
        Map<String,String> gatewayNameToIDMap = new Map<String,String>();
        for(Bill62__Payment_Gateway__c pg: gatewayList){
            gatewayNameToIDMap.put(pg.Name, pg.ID);
        }
        
        assignList = new List<String>();
        Decimal preIndex = Org_Defaults__c.getOrgDefaults().Round_Robin_Index__c;
        if(preIndex == null){
            robinIndex = 0;
        }else{
            robinIndex = Integer.valueOf(preIndex);
        }
        
        Integer totalEntries = 0;
        //got all the data we need, now create the assignment list
        for(Round_Robin_Transaction_Setting__c rt: settingList){
            //the assignList is a list of 100 IDs. based on the percentage on the round robin records, create that many records in the list
            if(rt.Percentage__c == null || rt.Percentage__c <= 0) continue;
            if(!gatewayNameToIDMap.containsKey(rt.Name)) continue;
            //system.debug('no short circuit in round robin');
            String gateID = gatewayNameToIDMap.get(rt.Name);
            //system.debug('gateID: '+gateID);
            //system.debug('percentage: '+Integer.valueOf(rt.Percentage__c));
            for(Integer i = Integer.valueOf(rt.Percentage__c);i > 0; i--){
                assignList.add(gateID);
                totalEntries++;
                if(totalEntries == 100) break;
            }
            if(totalEntries == 100) break;
            //system.debug('assignList size: '+assignList.size());
        }
        //system.debug('round robin gatelist size first pass: '+assignList.size());
        if(assignList.size() < 100 && assignList.size() != 0){
            //system.debug('adding dupes to gatelist');
            //in case we don't have 100 entries, duplicate
            while(assignList.size() < 100){
                List<String> tempList = assignList.clone();
                for(String s: tempList){
                    assignList.add(s);
                    totalEntries++;
                    if(totalEntries == 100) break;
                }
            }
        }
        
        //system.debug('round robin gatelist size second pass: '+assignList.size());
        /*roundRobinMap = Round_Robin_Transaction_Setting__c.getAll();
        companyBrandListMap = new Map<String, List<Round_Robin_Transaction_Setting__c>>();
        roundRobinMax = new Map<String, Double>();
        for (Round_Robin_Transaction_Setting__c r : roundRobinMap.values()){
            if (!companyBrandListMap.containsKey(r.Company_Brand__c)){
                companyBrandListMap.put(r.Company_Brand__c, new List<Round_Robin_Transaction_Setting__c>());
                roundRobinMax.put(r.Company_Brand__c, 0);
                roundRobinProportions.put(r.Company_Brand__c, new Map<Double, Round_Robin_Transaction_Setting__c>());
            }
            companyBrandListMap.get(r.Company_Brand__c).add(r);
            Double tmpPercent = roundRobinMax.get(r.Company_Brand__c);
            tmpPercent = tmpPercent + r.Percentage__c;
            roundRobinMax.remove(r.Company_Brand__c);
            roundRobinMax.put(r.Company_Brand__c, tmpPercent);
            roundRobinProportions.get(r.Company_Brand__c).put(tmpPercent, r);
            System.debug('tmpPerecent: ' + tmpPercent + ', name: ' + r.Name);
        }
        
        paymentGatewayMap = new Map<String, Bill62__Payment_Gateway__c>();
        for (Bill62__Payment_Gateway__c pg : [SELECT ID, NAME, Bill62__Is_Testing__c FROM Bill62__Payment_Gateway__c WHERE Bill62__Active__c = TRUE LIMIT 100]){
            paymentGatewayMap.put(pg.Name, pg);
        }
        */
    }
    
    public void updateIndex(){
        Org_Defaults__c o = Org_Defaults__c.getOrgDefaults();
        if(o == null) o = new Org_Defaults__c();
        o.Round_Robin_Index__c = robinIndex;
        upsert o;
    }
    
    public String assignPaymentGateway(){
        if(assignList.size() == 0) return null;
        String returnGatewayId = assignList[robinIndex];
        robinIndex++;
        if(robinIndex == 100) robinIndex = 0;
        //system.debug('round robin delivering: '+returnGatewayID +' from index '+robinIndex);
        return returnGatewayID;
        
        /*system.debug('companyBrand: ' + companyBrand);
        String returnGatewayId;
        if (roundRobinMax.containsKey(companyBrand)){
            Double max = roundRobinMax.get(companyBrand);
            Double thisRandom = Math.random()*max;
            system.debug('thisRandom: ' + thisRandom);
            String assignedPaymentGatewayName;
            List<Double> thresholdList = new List<Double>();
            for (Double x : roundRobinProportions.get(companyBrand).keySet()){
                thresholdList.add(x);
            }
            thresholdList.sort();
            for (Double x : thresholdList){
                system.debug('threshold: ' + x + ', Name: ' + roundRobinProportions.get(companyBrand).get(x).Name);
            }
            for (Double x : thresholdList){
                if (thisRandom <= x){
                    assignedPaymentGatewayName = roundRobinProportions.get(companyBrand).get(x).Name;
                    system.debug('assigned: ' + assignedPaymentGatewayName);
                    break;
                }
            }
            
            if (paymentGatewayMap.containsKey(assignedPaymentGatewayName)){
                returnGatewayId = paymentGatewayMap.get(assignedPaymentGatewayName).Id;
                system.debug('returnGatewayId: ' + returnGatewayId);
            }
        } else {
            system.debug(LoggingLevel.ERROR,'No company brand value found for: ' + companyBrand);
        }
        
        return returnGatewayId;*/
    }

}