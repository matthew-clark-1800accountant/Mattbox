trigger FeedCommentTrigger on FeedComment (after insert, after update) {
	if(Trigger.isInsert){
        FeedCommentTriggerHandler.updateCase(Trigger.new);
    }
    if(Trigger.isUpdate){
        //Placeholder for future code
    }
}