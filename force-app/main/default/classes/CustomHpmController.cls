public with sharing class CustomHpmController extends zqu.ZCheckoutBaseController {
  public CustomHpmController() {
    this.hostedPageSettingName = 'Credit Card';
  }
 
  // If you do have the Back and Next buttons, add the target URLs in the following methods.
  public override String getBackUrl() {
     return '';
  }
  
  public override String getNextUrl() {
      return '/';
  }
  
  public override PageReference getPageRef() {
    setPageRef(Page.CustomHostedPage);
    return Page.CustomHostedPage;
  }
  
  public override Map<String, String> getExtraParameters() {
    return new Map<String,String> {
      'field_maxConsecutivePaymentFailures' => '1',
      'field_maxConsecutivePaymentFailures' => '1',
      'field_creditCardType' => 'MasterCard', // <-- custom parameter
      'param_supportedTypes' => 'Visa,MasterCard', // <-- custom parameter
      'field_creditCardCountry' => 'USA' // <-- custom parameter
    };
  }
}