public with sharing class NVMCallSummaryTriggerHandler {

    public static void updateTracking(List<NVMStatsSF__NVM_Call_Summary__c> summaries){
        try{
            updateTrackingWithIds(new List<Id>(new Map<Id, NVMStatsSF__NVM_Call_Summary__c>(summaries).keySet()));
        } catch (Exception ex){ System.debug(ex.getMessage()); if(Test.isRunningTest()){throw ex;}}
    }

    public static void updateTrackingWithIds(List<Id> summaryIds){
        List<String> ignoredQueues = new List<String>{'DID Queue', 'SMS Queue'};
        List<NVMStatsSF__NVM_Call_Summary__c> querySummaries = 
            [SELECT Id, CreatedDate, NVMStatsSF__Queue_Name__c,
            NVMStatsSF__Ring_List__c, NVMStatsSF__Agent_List__c,
            NVMStatsSF__NVM_AgentID__c, NVMStatsSF__Agent2_ID__c,
            NVMStatsSF__Queue_Agent_Queue_List__c, NVMStatsSF__Agent__r.Profile.Name
            FROM NVMStatsSF__NVM_Call_Summary__c 
            WHERE Id IN :summaryIds
            AND NVMStatsSF__Ring_List__c != null
            //AND (NOT (NVMStatsSF__Queue_Name__c IN :ignoredQueues))
            //AND (NVMStatsSF__Queue_Agent_Queue_List__c LIKE '%live%' OR NVMStatsSF__Queue_Name__c != '')
        ];
        List<NVMStatsSF__NVM_Call_Summary__c> summaries = new List<NVMStatsSF__NVM_Call_Summary__c>();

        //filter out summaries based on criteria and exceptions
        for(NVMStatsSF__NVM_Call_Summary__c sum : querySummaries){
            //if agent 1 is an sdr, ignore queue name
            if(sum.NVMStatsSF__Agent__r.Profile.Name == 'Appointment Setter'){
                summaries.add(sum);
                continue;
            }

            //skip summaries with disallowed queue names
            if(ignoredQueues.contains(sum.NVMStatsSF__Queue_Name__c)){
                continue;
            }
            if(isBlank(sum.NVMStatsSF__Queue_Name__c) && (isBlank(sum.NVMStatsSF__Queue_Agent_Queue_List__c) || !sum.NVMStatsSF__Queue_Agent_Queue_List__c.toLowerCase().contains('live'))){
                continue;
            }

            summaries.add(sum);
        }
        if(summaries.isEmpty()){
            System.debug('no valid summaries found');
            return;
        }
        
        Map<String, NVMStatsSF__NVM_Call_Summary__c> indexToCallSummary = new Map<String, NVMStatsSF__NVM_Call_Summary__c>();
        Map<String, Integer> indexToCallTime = new Map<String, Integer>();
        Map<String, Integer> indexToRingTime = new Map<String, Integer>();
        List<Rep_Call_Tracking__c> recordsToUpsert = new List<Rep_Call_Tracking__c>();
        Set<String> agentIds = new Set<String>();
        Map<String, NVMStatsSF__NVM_Agent_Summary__c> agentIdToAgentSummary = new Map<String, NVMStatsSF__NVM_Agent_Summary__c>();
        //List<String> combinedIds = new List<String>();
        Date curDate = summaries[0].CreatedDate.dateGMT();
        List<String> liveSummaryIds = new List<String>();
        for(NVMStatsSF__NVM_Call_Summary__c summary : summaries){
            System.debug(summary);
            if(isBlank(summary.NVMStatsSF__Queue_Agent_Queue_List__c) || !summary.NVMStatsSF__Queue_Agent_Queue_List__c.toLowerCase().contains('live')){
                liveSummaryIds.add(summary.Id);
            }
            if(!isBlank(summary.NVMStatsSF__Agent_List__c)){
                for(String agentId : summary.NVMStatsSF__Agent_List__c.split(',')){
                    if(agentId.contains('+')) { continue; } //ignore external transfers
                    agentId.replaceAll('--', '-');
                    agentIds.add(agentId.trim().split('-')[0]);
                    String index = agentId.trim().split('-')[0]+'-'+summary.Id;
                    indexToCallTime.put(index, Integer.valueOf(agentId.trim().split('-')[1]));
                    indexToCallSummary.put(index, summary);
                }
            }
            if(!isBlank(summary.NVMStatsSF__Ring_List__c)){
                for(String agentId : summary.NVMStatsSF__Ring_List__c.split(',')){
                    String ringTime = agentId.trim().split(':')[1];
                    if(ringTime == '0'){ continue; } //ignore ring times of 0
                    agentIds.add(agentId.trim().split(':')[0]);
                    String index = agentId.trim().split(':')[0]+'-'+summary.Id;
                    
                    indexToRingTime.put(index, Integer.valueOf(agentId.trim().split(':')[1]));
                    indexToCallSummary.put(index, summary);
                }
            }            
        }
        System.debug(agentIds);
        for(NVMStatsSF__NVM_Agent_Summary__c agentSummary : 
            [SELECT Id, NVMStatsSF__AgentID__c, NVMStatsSF__Agent__c FROM NVMStatsSF__NVM_Agent_Summary__c WHERE NVMStatsSF__Date__c = :curDate AND NVMStatsSF__AgentID__c IN :agentIds]){
                agentIdToAgentSummary.put(agentSummary.NVMStatsSF__AgentID__c, agentSummary);
        }

        for(String index : indexToCallSummary.keySet()){
            NVMStatsSF__NVM_Call_Summary__c summary = indexToCallSummary.get(index);
            String agentId = index.split('-')[0];
            Rep_Call_Tracking__c trackingRec = new Rep_Call_Tracking__c(
                Combined_Index__c = index,
                Vonage_Call_Summary__c = summary.Id,
                Vonage_AgentID__c = agentId
            );
            if(indexToCallTime.containsKey(index)){
                trackingRec.Call_Time__c = indexToCallTime.get(index);
            }
            if(indexToRingTime.containsKey(index)){
                trackingRec.Ring_Time__c = indexToRingTime.get(index);
            }
            if(agentId == summary.NVMStatsSF__NVM_AgentID__c){
                trackingRec.Is_Agent_1__c = true;
                //trackingRec.Rep_User__c = summary.NVMStatsSF__Agent__c;
            }
            if(agentId == summary.NVMStatsSF__Agent2_ID__c){
                trackingRec.Is_Agent_2__c = true;
                //trackingRec.Rep_User__c = summary.NVMStatsSF__Agent2__c;
            }
            if(agentIdToAgentSummary.containsKey(agentId)){
                NVMStatsSF__NVM_Agent_Summary__c agentSummary = agentIdToAgentSummary.get(agentId);
                trackingRec.Vonage_Agent_Summary__c = agentSummary.Id;
                trackingRec.Rep_User__c = agentSummary.NVMStatsSF__Agent__c;
            }
            if(liveSummaryIds.contains(summary.Id)){
                trackingRec.Is_Live_Transfer__c = true;
            } else {
                trackingRec.Is_Live_Transfer__c = false;
            }
            recordsToUpsert.add(trackingRec);
        }
        upsert recordsToUpsert Rep_Call_Tracking__c.fields.Combined_Index__c;
    }

    public static Boolean isBlank(String fieldValue){
        return (fieldValue == null || fieldValue == '');
    }
}