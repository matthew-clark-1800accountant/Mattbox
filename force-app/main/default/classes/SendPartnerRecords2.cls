public class SendPartnerRecords2
{

    @future(callOut=true)
    public static void actualSendPartnerRecord(Id pnc,Id accountId,Id contactId)
    {
              
        
              
        List<PartnerNetworkRecordConnection> pnrcExist = [select id,LocalRecordId, PartnerRecordId,Status from PartnerNetworkRecordConnection where localRecordId = :accountId and connectionId='04Pf10000004CC2EAM' and status='Sent'  limit 1];
        PartnerNetworkRecordConnection pnrc =null;
        PartnerNetworkRecordConnection  pnrc2 =null;
        List<PartnerNetworkRecordConnection> listtoInsert = new List<PartnerNetworkRecordConnection>();
        if(pnrcExist !=null && pnrcExist.size() > 0 )
        {
            pnrc2 = new PartnerNetworkRecordConnection();
            pnrc2.ConnectionId = pnc;
            pnrc2.LocalRecordId = contactId;  
            pnrc2.ParentRecordId = accountId; 
            pnrc2.SendClosedTasks = false;
            pnrc2.SendOpenTasks = true;
            pnrc2.SendEmails = false; 
            listtoInsert.add(pnrc2);
        }
        else
        {
            pnrc = new PartnerNetworkRecordConnection();
            pnrc.ConnectionId = pnc;
            pnrc.LocalRecordId = accountId;  
            pnrc.SendClosedTasks = false;
            pnrc.SendOpenTasks = true;
            pnrc.SendEmails = false;  
            System.debug('Line no 31 in SendPArtnerRecord2');
            pnrc2 = new PartnerNetworkRecordConnection();
            pnrc2.ConnectionId = pnc;
            pnrc2.LocalRecordId = contactId;  
            pnrc2.SendClosedTasks = false;
            pnrc2.SendOpenTasks = true;
            pnrc2.SendEmails = false;  
            listtoInsert.add(pnrc);
            listtoInsert.add(pnrc2);
        }
        /*PartnerNetworkRecordConnection pnrc = new PartnerNetworkRecordConnection();
        pnrc.ConnectionId = pnc;
        pnrc.LocalRecordId = accountId;  
        pnrc.SendClosedTasks = false;
        pnrc.SendOpenTasks = true;
        pnrc.SendEmails = false;  
        //insert pnrc;
        System.debug('Line no 15 in SendPArtnerRecord2');
        PartnerNetworkRecordConnection pnrc2 = new PartnerNetworkRecordConnection();
        pnrc2.ConnectionId = pnc;
        pnrc2.LocalRecordId = contactId;  
        //pnrc2.ParentRecordId = accountId; 
        pnrc2.SendClosedTasks = false;
        pnrc2.SendOpenTasks = true;
        pnrc2.SendEmails = false;  
        //insert pnrc2;
        */
        
        
        if(listtoInsert.size() > 0) insert listtoInsert;
    }


}