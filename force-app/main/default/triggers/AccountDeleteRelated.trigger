trigger AccountDeleteRelated on Account (before delete) {
    AccountDeleteRelatedRecords deletetron = new AccountDeleteRelatedRecords(new List<Id>(Trigger.oldMap.keySet()));
    deletetron.deleteRelatedRecords();
}