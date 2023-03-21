public with sharing class zBAM_ManagerSettingsController {

	public List<SelectOption> profileOptions {get;set;}
	public String selectedProfile {get;set;}
	public BillingAccountManagerSettings__c managerSettings {get;set;}
	private BillingAccountManagerSettings__c userSettings;
	public Boolean isAdmin {get;set;}
	private List<Profile> tenantProfiles = new List<Profile>();
	private final String DEFAULT_SETTINGS_LABEL = '--Organizational Default Settings--';
	public final String DEFAULT_SETTINGS_VALUE {get;set;}
	private String returnToLevel;
	private String newHPM;
    public zqu.NotificationOptions notificationOptions {get;set;}
    public List<zqu__ProductRatePlanCharge__c> charges;
    public Boolean TRUE_BOOLEAN {get;set;}

	public zBAM_ManagerSettingsController() {
		userSettings = BillingAccountManagerSettings__c.getInstance(UserInfo.getProfileId());
		isAdmin = userSettings.hasAdminPermissions__c;
		DEFAULT_SETTINGS_VALUE = 'Default';
		profileOptions = new List<SelectOption>();
		tenantProfiles = [Select Id, Name FROM Profile];
		createProfileOptions(tenantProfiles);
		managerSettings = BillingAccountManagerSettings__c.getOrgDefaults();
		selectedProfile = DEFAULT_SETTINGS_VALUE;
        if (managerSettings.ReturnToPage__c == null || managerSettings.ReturnToPage__c == '')
            returnToLevel = 'Billing Account';
        else
			returnToLevel = managerSettings.ReturnToPage__c;
		newHPM = managerSettings.UseNewHpm__c;
        
        TRUE_BOOLEAN = true;
        
        //Generate notification object and fills in information
        notificationOptions = new zqu.NotificationOptions();
        notificationOptions.isPopup = true;
        notificationOptions.continueAction = 'continueToNextPage();';
        notificationOptions.backLabel = 'Remain';
        notificationOptions.successTitle = 'SUCCESS! Payment method created!';
        notificationOptions.failureTitle = 'AN ERROR OCCURRED!';
        
        charges = [SELECT Name, Id, zqu__ZuoraId__c, zqu__ProductRatePlan__r.Name from zqu__ProductRatePlanCharge__c where zqu__Type__c='One-Time' AND zqu__Model__c='Flat Fee Pricing'];

	}
    
    /**
        Getter for the list of options for products
    */
    public List<SelectOption> getProductChargeOptions() {
        List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('','-- Select one --'));
        if (!charges.isEmpty()){
            for (zqu__ProductRatePlanCharge__c charge : charges){
                if (charge.zqu__ZuoraId__c != null)
                 	options.add(new SelectOption(charge.zqu__ZuoraId__c,'[' + charge.zqu__ProductRatePlan__r.Name + ']' + ' ' + charge.Name));
            }
        }
        return options; 
    }

	private void createProfileOptions(List<Profile> profileList){
		profileOptions.add(new SelectOption(DEFAULT_SETTINGS_VALUE, DEFAULT_SETTINGS_LABEL));
		for (Profile profile : profileList){
			profileOptions.add(new SelectOption(profile.Id, profile.Name));
		}
	}

	public void changeProfile(){
		if (selectedProfile == DEFAULT_SETTINGS_VALUE){
			managerSettings = BillingAccountManagerSettings__c.getOrgDefaults();
		} else {
			managerSettings = BillingAccountManagerSettings__c.getInstance(selectedProfile);
		}
		managerSettings.ReturnToPage__c = returnToLevel;
		managerSettings.UseNewHPM__c = newHPM;
	}

	public void saveSettings(){
		if (managerSettings.SetupOwnerId == null && selectedProfile != DEFAULT_SETTINGS_VALUE){
			managerSettings.SetupOwnerId = selectedProfile;
		}
        if (managerSettings.EnableCredits__c==false){
            managerSettings.CreditCharge__c=null;
            managerSettings.AllowCrediting__c=false;
        } else {
            if (managerSettings.CreditCharge__c == null || managerSettings.CreditCharge__c == ''){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'If crediting is enabled, a credit charge must be set!');
                ApexPages.addMessage(myMsg);
                return;
            }
        }
        if (managerSettings.AllowCrediting__c == false)
            managerSettings.MaximumCreditAllowed__c=null;
		upsert managerSettings;
	}

	public void setToDefault(){
		if (selectedProfile != DEFAULT_SETTINGS_VALUE && managerSettings.Id != null){
			delete managerSettings;
			managerSettings = BillingAccountManagerSettings__c.getInstance(selectedProfile);
		}
	}
    
    /**
        Confirm error and clears error messages.
    */
    public void confirmError(){
        ApexPages.getMessages().clear();
    }
}