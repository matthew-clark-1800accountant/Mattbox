public class EventSendEmail implements Queueable {
    public class WrongIdException extends Exception {}
    private string wrongIdError = 'Expecting Id of type Lead or Account';

    Map<Id, Id> sendEmailIdsToEvent;

    public EventSendEmail(Map<Id, Id> sendEmailIdsToEvent) {
        this.sendEmailIdsToEvent = sendEmailIdsToEvent;
    }

    public void execute(QueueableContext context) {
        List<Id> leadIds = new List<Id>();
        List<Id> accountIds = new List<Id>();
        for(Id id : sendEmailIdsToEvent.keySet()){
            if('Lead' == id.getSObjectType().getDescribe().getName()){
                leadIds.add(id);
            }
            if('Account' == id.getSObjectType().getDescribe().getName()){
                accountIds.add(id);
            }
            //Just in case there is an Id I'm not expecting
            if('Account' != id.getSObjectType().getDescribe().getName() &&
            'Lead' != id.getSObjectType().getDescribe().getName()){
                throw new WrongIdException(this.wrongIdError);
            }
        }
        //If the Event has a Lead WhoId, update the Lead with the Pre-TSA (Tax Savings Calculator) Link
        if(!leadIds.isEmpty()){
            //Segment here possibly
            List<Lead> leads = [
                SELECT Id, Email, Owner.Name, OwnerId, Owner.Email, Pre_TSA_Link__c
                FROM Lead
                WHERE Id IN :leadIds
            ];

            List<Lead> toUpdateLeads = new List<Lead>();
            for(Lead l : leads){
                l.Pre_TSA_Link__c = 'https://1800accountant.secure.force.com/PreTSA1?id='+sendEmailIdsToEvent.get(l.Id);
                toUpdateLeads.add(l);
            }
            update toUpdateLeads;
        }
        //If the Event has a Lead WhoId, update the Lead with the Pre-TSA (Tax Savings Calculator) Link
        if(!accountIds.isEmpty()){
            List<Account> accounts = [
                SELECT Id, Primary_Contact__c, Primary_Contact_Email__c, Owner.Name, Owner.Email, Pre_TSA_Link__c
                FROM Account
                WHERE Id IN :accountIds
            ];
            List<Account> toUpdateAccounts = new List<Account>();
            for(Account a : accounts){
                a.Pre_TSA_Link__c = 'https://1800accountant.secure.force.com/PreTSA1?id='+sendEmailIdsToEvent.get(a.Id);
                toUpdateAccounts.add(a);
            }
            update toUpdateAccounts;
        }
    }
}