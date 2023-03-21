public with sharing class zBAM_AddNewACHCallback extends zqu.ZCheckoutBaseCallbackController {
    /**
        Default Callback page.
    */
    public String refId {get;set;}
    public String objectId {get;set;}
    public String success {get;set;}
    
    public zBAM_AddNewACHCallback() {
        this.hostedPageSettingName = 'NewACH';
    }
    
    public override void processCallbackParameters() {
        super.processCallbackParameters();
        this.refId = callbackparameters.get('refId');
        this.objectId = callbackparameters.get('field_passthrough1');
        this.success = callbackparameters.get('success');
    }
}