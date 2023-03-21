public class SubscriptionManagementController 
{
    public ApexPages.StandardController stdController;
    public String accId {get; set ;}
    public List<Bill62__Subscription__c> activesubscriptions {get ; set ;}
    public List<Bill62__Subscription__c> pendingsubscriptions {get ; set ;}
    public List<Bill62__Subscription__c> pastsubscriptions {get ; set ;}
    public Set<String> setActiveCats;
    public String strActiveCats;
    public Integer subCountPersonalTE = 0;
    public String soqlPersonalTE;
    public Integer subCountBusinessTE = 0;
    public String soqlBusinessTE;
    
    public SubscriptionManagementController(ApexPages.StandardController stdController) 
    {
        accId = stdController.getId();
        //System.debug(accId);
        
        activesubscriptions = [SELECT Id, 
                               Bill62__Account__c, 
                               Bill62__Product__r.Product_Categories__c, 
                               Bill62__Status__c, 
                               Bill62__Start_Date__c, 
                               Bill62__End_Date__C, 
                               Bill62__Billing_Frequency__c, 
                               CP_Access__c 
                               FROm Bill62__Subscription__c 
                               WHERE Bill62__Account__c = :accId
                               		AND Bill62__Status__c = 'Active' 
                               ] ;
        pendingsubscriptions = [SELECT Id, 
                               Bill62__Account__c, 
                               Bill62__Product__r.Product_Categories__c, 
                               Bill62__Status__c, 
                               Bill62__Start_Date__c, 
                               Bill62__End_Date__C, 
                               Bill62__Billing_Frequency__c, 
                               CP_Access__c 
                               FROm Bill62__Subscription__c 
                               WHERE Bill62__Account__c = :accId
                               		AND Bill62__Status__c = 'Pending' 
                               ] ;
        pastsubscriptions = [SELECT Id, 
                             Bill62__Account__c, 
                             Bill62__Product__r.Product_Categories__c, 
                             Bill62__Status__c, 
                             Bill62__Start_Date__c, 
                             Bill62__End_Date__C, 
                             Bill62__Billing_Frequency__c, 
                             CP_Access__c 
                             FROm Bill62__Subscription__c 
                             WHERE Bill62__Account__c = :accId
                             		AND Bill62__Status__c = 'Terminated' 
                             ] ;

    }
    // update Account with proper access
	public void updateAccess()
	{
		Account accToUpdate1;
        if (activesubscriptions.size() > 0)
        {
            // Query + Count for personal tax extension category
			String soqlPersonalTE = 'SELECT Count() FROM Bill62__Subscription__c WHERE Bill62__Account__c = :accId AND Bill62__Status__c = \'Active\' AND Bill62__Subscription__c.Bill62__Product__r.Product_Categories__c INCLUDES (\'Personal Tax Extension\')';
			subCountPersonalTE = Database.countQuery(soqlPersonalTE);
            
            //System.debug(Database.countQuery(soqlPersonalTE));
            System.debug(subCountPersonalTE);
            //looks for more than 0 subs with Personal TE category
				if (subCountPersonalTE > 0)
				{
					accToUpdate1 = new Account(Id = accId, Tax_Extension_Personal_2015__c = TRUE);
                }	
            	if (subCountPersonalTE == 0)
                {
                    	accToUpdate1 = new Account(Id = accId, Tax_Extension_Personal_2015__c = FALSE);
                }
            	if (accToUpdate1 != null)
                    update accToUpdate1;
		}
        //Business Tax Extension Access
        Account accToUpdate;
        if (activesubscriptions.size() > 0)
        {
            // Query + Count for business tax extension category
			String soqlBusinessTE = 'SELECT Count() FROM Bill62__Subscription__c WHERE Bill62__Account__c = :accId AND Bill62__Status__c = \'Active\' AND Bill62__Subscription__c.Bill62__Product__r.Product_Categories__c INCLUDES (\'Business Tax Extension\')';
			subCountBusinessTE = Database.countQuery(soqlBusinessTE);
            
            //System.debug(Database.countQuery(soqlBusinessTE));
            //System.debug(accId);
            //System.debug(subCountBusinessTE > 0);
            //looks for more than 0 subs with Business TE category
            	if (subCountBusinessTE > 0)
				{
					accToUpdate = new Account(Id = accId, Tax_Extension_Business_2015__c = TRUE);
				}
            	if (subCountBusinessTE == 0)
				{
					accToUpdate = new Account(Id = accId, Tax_Extension_Business_2015__c = FALSE);
				}
            	if (accToUpdate != null)
                    update accToUpdate;
		}
	}

}