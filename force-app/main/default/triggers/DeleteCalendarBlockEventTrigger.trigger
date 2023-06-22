trigger DeleteCalendarBlockEventTrigger on Delete_Calendar_Block__e (after insert) {
    DeleteCalendarBlockEventTriggerHandler.afterInsert(Trigger.new);
}