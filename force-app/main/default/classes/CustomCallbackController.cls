public with sharing class CustomCallbackController extends zqu.ZCheckoutBaseCallbackController {
  public CustomCallbackController() {
    this.hostedPageSettingName = 'Credit Card';
  }
  
  public String refId {
    get;
    set;
  }
  
  public String objectId{
    get;    set;
  }
  
  public override void processCallbackParameters() {
    super.processCallbackParameters();
    this.refId = callbackparameters.get('refId');
    this.objectId = callbackparameters.get('field_passthrough1');
  }
}