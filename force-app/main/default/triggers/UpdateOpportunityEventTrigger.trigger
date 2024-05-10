trigger UpdateOpportunityEventTrigger on Update_Opportunity__e (after insert) {
    UpdateOpportunityEventTriggerHandler.updateOpportunities(Trigger.new);
}