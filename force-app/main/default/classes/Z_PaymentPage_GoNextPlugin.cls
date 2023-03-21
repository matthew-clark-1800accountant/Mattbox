/*    Copyright (c) 2014 Zuora, Inc.
 *
 *   Permission is hereby granted, free of charge, to any person obtaining a copy of 
 *   this software and associated documentation files (the "Software"), to use copy, 
 *   modify, merge, publish the Software and to distribute, and sublicense copies of 
 *   the Software, provided no fee is charged for the Software.  In addition the
 *   rights specified above are conditioned upon the following:
 *
 *   The above copyright notice and this permission notice shall be included in all
 *   copies or substantial portions of the Software.
 *
 *   Zuora, Inc. or any other trademarks of Zuora, Inc.  may not be used to endorse
 *   or promote products derived from this Software without specific prior written
 *   permission from Zuora, Inc.
 *
 *   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *   FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
 *   ZUORA, INC. BE LIABLE FOR ANY DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES
 *   (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *   LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 *   ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.  
 *
 *   IN THE EVENT YOU ARE AN EXISTING ZUORA CUSTOMER, USE OF THIS SOFTWARE IS GOVERNED
 *
 *   BY THIS AGREEMENT AND NOT YOUR MASTER SUBSCRIPTION AGREEMENT WITH ZUORA.
 */
global class Z_PaymentPage_GoNextPlugin extends zqu.PaymentPageController.DefaultHostedPageLiteGoNextPlugin {

    private List < String > errorMessages = new List < String > ();
    private static Zuora.zApi zapi;
    private Zuora.zObject zAccount = new Zuora.zObject('Account'); 
    public Boolean testFindPM {get;set;} 
    public Boolean testFindPMError {get;set;}
    public Boolean testUpdateSuccess {get;set;}
    public Boolean testUpdateException {get;set;}  

    private static final String DEBUG_STR = 'Z_PaymentPage_GoNextPlugin: ';

    String paymentMethodId;
    
    public Z_PaymentPage_GoNextPlugin() {
        this.testFindPM = true;
        this.testFindPMError = true; 
        this.testUpdateSuccess = true;
        this.testUpdateException = true;
    }

    public static Zuora.zApi getApiStub() {
        if (zapi == null) { 
            zapi = new Zuora.zApi();
            if (!Test.isRunningTest()){
                zapi.zLogin();
            }
        }
        return zapi;
    }

    global override PageReference navigateNext(String paymentMethodType, Map < String, String > callbackParameters) {
     
        // If the transaction was not successful, display the error message to the user
        Boolean success = Boolean.valueOf(callbackParameters.get('success')); 
        if(!success) {
            String errorMessage = callbackParameters.get('errorMessage');
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage));
            return null;
        } else {
            //set defaultPaymentMethod and autoPay
            getApiStub();
            paymentMethodId = callbackParameters.get('refId');
            getZuoraAccount();
            
            if ( this.zAccount != null && this.zAccount.getValue('Id') != null) {
                System.Debug('Setting Default Payment Method');
                setDefaultPaymentMethod();
            } else {
                System.Debug('Not setting default payment method');
            }

            updateQuoteWithRefId(paymentMethodId);
            
            //send user to success visualforce page
            PageReference pageRef = Page.Z_PaymentMethodCapture;
            pageRef.getParameters().put('success','true');
            pageRef.setRedirect(true);
            return pageRef;
        }
    }

    private void updateQuoteWithRefId(String refId) {
        final String FUNC_STR = DEBUG_STR + 'updateQuoteWithRefId: ';
        System.debug(FUNC_STR+'Starting updateQuoteWithRefId with refId: '+refId);

        String quoteId = ApexPages.currentPage().getParameters().get('id');
        System.debug(FUNC_STR+'quoteId: '+quoteId);

        if (String.isNotBlank(refId) && String.isNotBlank(quoteId)) {
            System.debug(FUNC_STR+'refId not blank. Searching for Quote');

            zqu__Quote__c quote = Z_PaymentMethodCaptureUtil.searchForQuote(quoteId);

            if (quote != null) {
                System.debug(FUNC_STR+'Found quote. Will update with refId '+refId);
                quote.zqu__ElectronicPaymentMethodId__c = refId;
                try {
                    update quote;
                } catch (Exception ex) {
                    System.debug(FUNC_STR+'Exception occurred updating Quote: '+ex.getMessage());
                }
            } else {
                System.debug(FUNC_STR+'Failed to retrieve quote. Will not update with refId');
            }
        } else {
            System.debug(FUNC_STR+'refId passed to function or quote id in url is blank. Will not update Quote');
        }
    }
    
    private void getZuoraAccount() {
        try {
            String zoql = 'SELECT AccountId FROM PaymentMethod WHERE id = \'' + paymentMethodId + '\'';
            List < Zuora.zObject > zobjs = (!Test.isRunningTest()) ? zapi.zquery(zoql) : Z_PaymentPage_GoNextPluginTest.retrieveFakePaymentMethod(testFindPM);        
          
            if (zobjs != null && zobjs.size() > 0) { 
                zAccount.setValue('Id', (String) zobjs.get(0).getValue('AccountId'));
                System.debug('zAccount ID = ' + zAccount.getValue('Id'));
            } else {
                errorMessages.add('Cannot Find AccountId');
            }

            if (Test.isRunningTest() && testFindPMError) {
                throw new Zuora.zRemoteException('Test Message');
            }
        } catch (Exception e) {
            System.debug('Exception occurred: '+e.getMessage());
            if (e instanceof Zuora.zRemoteException) {
                System.debug('Exception occurred: '+e.getMessage());
                Zuora.zRemoteException re = (Zuora.ZRemoteException) e;
            }
            errorMessages.add('ZoqlError: ' + e.getMessage());
        }
    }
    
    private void setDefaultPaymentMethod() {
        try {
            zAccount.setValue('DefaultPaymentMethodId', this.paymentMethodId); 
            zAccount.setValue('AutoPay', 'true');

            List <Zuora.zApi.SaveResult> results = (!Test.isRunningTest()) ? zapi.zUpdate(new List < Zuora.zObject > {zAccount}) : new List<Zuora.zApi.SaveResult>{Z_PaymentPage_GoNextPluginTest.createSaveResult(testUpdateSuccess)};
            System.Debug('Update Account Results: '+results);

            if (Test.isRunningTest() && this.testUpdateException) {
                throw new Zuora.zRemoteException('Test Message');
            }
        } catch (Exception e) {
            System.debug('Exception occurred: '+e.getMessage());
            if (e instanceof Zuora.zRemoteException) {
                Zuora.zRemoteException re = (Zuora.ZRemoteException) e;
            }
            errorMessages.add('Error Setting Default Payment Method ' + e.getMessage());
            return;
        }
    }

    
}