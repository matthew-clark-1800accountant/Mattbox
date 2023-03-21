global class eventNotifier_scheduler implements Schedulable {
    global void execute(SchedulableContext ctx) {
        eventNotifier evn = new eventNotifier();
        database.executeBatch(evn);
    }
}