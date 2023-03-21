public class NewOrderLineController {

    String contactID;
    String accountID;
    String orderID;
    Contact c;
    Bill62__Order__c o;
    String cName;
    String aName;
    String today;
    String nextYear;
    String nextYearM1;
    String todayNum;
    String paymentMethodID;
    String paymentMethodName;

    public NewOrderLineController() {
        orderID = ApexPages.currentPage().getParameters().get('id');
        o = [SELECT ID, NAME FROM Bill62__Order__c WHERE ID =: orderID];
        contactID = ApexPages.currentPage().getParameters().get('contactID');
        c = [SELECT ID, NAME, ACCOUNTID, Account.Name FROM CONTACT WHERE ID =: contactID];
        accountId = c.AccountId;
        cName = c.Name.replace(' ', '+');
        aName = c.Account.Name.replace(' ', '+');
        today = Datetime.now().format('MM/dd/yyyy');
        nextYear = Datetime.now().addYears(1).format('MM/dd/yyyy');
        nextYearM1 = Datetime.now().addYears(1).addDays(-1).format('MM/dd/yyyy');
        if (Date.today().day() > 28){
            todayNum = '28';
        } else {
            todayNum = String.valueOf(Date.today().day());
        }
        
        List<Bill62__Payment_Method__c> payMeth = [SELECT ID, NAME, Bill62__Payment_For__c FROM Bill62__Payment_Method__c
            WHERE Bill62__Customer__c = : contactID];
        for (Bill62__Payment_Method__c p : payMeth){
            if (p.Bill62__Payment_For__c == 'Default'){
                paymentMethodID = p.Id;
                paymentMethodName = p.Name.replace(' ', '+');
            }
        }
        
        if (paymentMethodID == null){
            if (payMeth.size() > 0){
                Bill62__Payment_Method__c p = payMeth[0];
                paymentMethodID = p.Id;
                paymentMethodName = p.Name.replace(' ', '+');
            }
        }
    }

    public PageReference init() {
        return new PageReference('/a1A/e?CF00Nj00000049nHL=' + cName
            + '&CF00Nj00000049nHL_lkid=' + contactId
            + '&CF00Nj00000049nxe=' + aName 
            + '&CF00Nj00000049nxe_lkid=' + AccountId
            + '&CF00Nj00000049nxj=' + o.Name
            + '&CF00Nj00000049nxj_lkid=' + orderID
            + '&CF00Nj00000049nO9=' + paymentMethodName 
            + '&CF00Nj00000049nO9_lkid=' + paymentMethodID 
            + '&00Nj00000049nNw=1'
            + '&00Nj00000049nOC=' + today
            + '&00Nj00000049nO1=' + nextYearM1
            + '&00Nj00000049nNx=' + nextYear
            + '&00Nj00000049nO7=' + todayNum
            + '&retURL=%2F' + orderID);
    }

}