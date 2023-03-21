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
global class Z_PaymentPage_IHostedPageLitePlugin implements zqu.PaymentPageController.IHostedPageLitePlugin {

    private final String DEBUG_STR = 'Z_PaymentPage_IHostedPageLitePlugin: ';
    private final Integer address1MaxLength = 255;
    private final Integer address2MaxLength = 255;

    private Id quoteId;
    private zqu__Quote__c quote {get;set;}
    public Boolean hasQuote {
        get {
            if (String.isNotBlank(quoteId) && quote != null) {
                return true;
            } else {
                return false;
            }
        }
    }

    private Id billingAccountId; 
    private Zuora__CustomerAccount__c sfdcBillingAccount {get;set;}
    public Boolean hasAccountInSFDC {
        get {
            if (String.isNotBlank(billingAccountId) && sfdcBillingAccount != null) {
                return true;
            } else {
                return false;
            }
        }
    }

    private String zuoraAccountId;
    private Zuora.ZObject zuoraAccount {get;set;}
    public Boolean hasAccountInZuora {
        get {
            if (String.isNotBlank(zuoraAccountId) && zuoraAccount != null) {
                return true;
            } else {
                return false;
            }
        }
    }

    private String billToContactId;
    private Zuora.ZObject billToContact;
    public Boolean hasBillToContact {
        get {
            if (String.isNotBlank(billToContactId) && billToContact != null) {
                return true;
            } else {
                return false;
            }
        }
    }

    private String soldToContactId;
    private Zuora.ZObject soldToContact;
    public Boolean hasSoldToContact {
        get {
            if (String.isNotBlank(soldToContactId) && soldToContact != null) {
                return true;
            } else {
                return false;
            }
        }
    }

    

    global Map < String, String > getAdditionalParameters(String paymentMethodType) {
        final String FUNC_STR = DEBUG_STR + 'getAdditionalParameters: ';
        System.debug(FUNC_STR+'Starting getAdditionalParameters');

        Map < String, String > defaultValues = new Map < String, String >();

        Boolean foundQuote = searchForQuote();
        Boolean foundSfdcAccount = searchForSFDCBillingAccount();
        if (!foundQuote && !foundSfdcAccount) {
            Boolean foundZuoraAccount = searchForZuoraAccount();
        }

        defaultValues = setExistingAccount(defaultValues);
                 
        // Set the default values for payment method type credit card
        if(paymentMethodType == zqu.PaymentPageController.PAYMENT_METHOD_TYPE_CREDIT_CARD) {
            defaultValues = populateContactInfo(defaultValues);   
        }

        return defaultValues;
    }

    private Map<String,String> setExistingAccount(Map<String,String> defaultValues) {
        final String FUNC_STR = DEBUG_STR + 'setExistingAccount: ';
        System.debug(FUNC_STR+'Starting Method');

        defaultValues = (defaultValues != null) ? defaultValues : new Map<String,String>();

        if (this.hasQuote) {
            System.debug(FUNC_STR+'Page related to Quote. Will check for Account Id');

            if (String.isNotBlank(this.quote.zqu__ZuoraAccountId__c)) {
                System.debug(FUNC_STR+'Populating account Id from Quote: '+this.quote.zqu__ZuoraAccountId__c);
                defaultValues.put('field_accountId', this.quote.zqu__ZuoraAccountId__c);
            } else {
                System.debug(FUNC_STR+'Quote has no Account Id specified. Will not populate field_accountId');
            }
        } else if (this.hasAccountInSFDC && String.isNotBlank(this.sfdcBillingAccount.Zuora__Zuora_Id__c)) {
            System.debug(FUNC_STR+'Populating account Id from Billing Account in SFDC: '+this.sfdcBillingAccount.Zuora__Zuora_Id__c);
            defaultValues.put('field_accountId', this.sfdcBillingAccount.Zuora__Zuora_Id__c);
        } else if (this.hasAccountInZuora && String.isNotBlank((String)this.zuoraAccount.getValue('Id'))) {
            System.debug(FUNC_STR+'Populate account Id from Account in Zuora: '+(String)this.zuoraAccount.getValue('Id'));
            defaultValues.put('field_accountId', (String)this.zuoraAccount.getValue('Id'));
        } else {
            System.debug(FUNC_STR+'Failed to retrieve existing Account Id');
        }

        return defaultValues; 
    }

    /**
    * This method looks at the 'id' param in the URL and attempts to find a related Quote in SFDC. If successful, it will set this.quote and return true
    **/
    private Boolean searchForQuote() {
        final String FUNC_STR = DEBUG_STR + 'searchForQuote: ';
        System.debug(FUNC_STR+'Starting searchForQuote');

        String quoteId = ApexPages.currentPage().getParameters().get('id');
        Boolean foundQuote = false;

        if (String.isNotBlank(quoteId)) {
            this.quote = Z_PaymentMethodCaptureUtil.searchForQuote(quoteId);

            if (quote != null) {
                System.debug(FUNC_STR+'Found Quote based on Id: '+quoteId);
                foundQuote = true;
                this.quoteId = quote.Id;
            } else {
                System.debug(FUNC_STR+'Failed to find Quote based on Id: '+quoteId);
            }
        } else {
            System.debug(FUNC_STR+'Id param in URL is blank. Will not search for Quote');
        }

        return foundQuote;
    }

    /**
    * This method looks at the 'accId' param in the URL and attempts to find a related Billing Account in SFDC. If successful, it will set this.sfdcBillingAccount and return true
    **/
    private Boolean searchForSFDCBillingAccount() {
        final String FUNC_STR = DEBUG_STR + 'searchForSFDCBillingAccount: ';
        System.debug(FUNC_STR+'Starting searchForSFDCBillingAccount');

        String accId = ApexPages.currentPage().getParameters().get('accId');
        Boolean foundAccount = false;

        if (String.isNotBlank(accId)) {
            this.sfdcBillingAccount = Z_PaymentMethodCaptureUtil.searchForSFDCBillingAccount(accId);

            if (sfdcBillingAccount != null) {
                System.debug(FUNC_STR+'Found Billing Account based on Id: '+accId);
                this.billingAccountId = sfdcBillingAccount.Id;
                foundAccount = true;
            } else {
                System.debug(FUNC_STR+'Failed to find Billing Account based on Id: '+accId);
            }
        } else {
            System.debug(FUNC_STR+'accId param in URL is blank. Will not search for Billing Account');
        }

        return foundAccount;
    }

    private Boolean searchForZuoraAccount() {
        final String FUNC_STR = 'searchForZuoraAccount: ';
        System.debug(FUNC_STR+'Starting searchForZuoraAccount');

        String accId = ApexPages.currentPage().getParameters().get('accId');
        Boolean foundAccount = false;

        this.zuoraAccount = Z_PaymentMethodCaptureUtil.searchForZuoraAccount(accId, true);
        if (zuoraAccount != null) {
            System.debug(FUNC_STR+'Found Account in Zuora');
            this.zuoraAccountId = (String)zuoraAccount.getValue('Id');
            this.billToContactId = (String)zuoraAccount.getValue('BillToId');
            this.soldToContactId = (String)zuoraAccount.getValue('SoldToId');
            foundAccount = true;
        } else {
            System.debug(FUNC_STR+'Failed to find Account in Zuora');
        }

        return foundAccount;
    }

    private Boolean searchForZuoraContacts() {
        final String FUNC_STR = 'searchForZuoraContacts: ';
        System.debug(FUNC_STR+'Starting searchForZuoraContacts');

        Boolean foundContacts = false;

        List<Zuora.ZObject> contacts = Z_PaymentMethodCaptureUtil.searchForZuoraContacts(this.billToContactId, this.soldToContactId, true);

        if (contacts != null && contacts.size() > 0) {
            System.debug(FUNC_STR+'Found Contacts in Zuora');
            foundContacts = true;

            for (Zuora.ZObject contact : contacts) {
                String contactId = (String)contact.getValue('Id');

                if (contactId == this.billToContactId) {
                    this.billToContact = contact;
                }
                if (contactId == this.soldToContactId) {
                    this.soldToContact = contact;
                }
            }
        } else {
            System.debug(FUNC_STR+'Failed to find Contacts in Zuora');
        }

        return foundContacts;
    }

    /**
    * Main method used for populating Contact info. Will populate Cotnact information from Quote, Billing Account, or directly from Zuora
    * Returns a populated defaultValues map
    **/
    private Map<String,String> populateContactInfo(Map<String,String> defaultValues) {
        final String FUNC_STR = DEBUG_STR + 'populateContactInfo: ';
        System.debug(FUNC_STR+'Starting populateContactInfo with defaultValues: '+defaultValues);

        defaultValues = (defaultValues != null) ? defaultValues : new Map <String,String>();

        Zuora_Customer_HPM_Setting__c hpmSetting = Zuora_Customer_HPM_Setting__c.getValues(Z_PaymentMethodCaptureUtil.getHpmSettingName());
        System.debug(FUNC_STR+'hpmSetting: '+hpmSetting);

        if (hpmSetting != null) {

            if (hpmSetting.Populate_Contact_Info_for_Quotes__c && this.quote != null) {
                System.debug(FUNC_STR+'Found Quote and custom setting is configured to populate Contact information for Quotes');

                if (quote != null && quote.zqu__BillToContact__c != null) {
                    System.debug(FUNC_STR+'Quote is not null and has a Bill To Contact');

                    List<Contact> billToContacts = [SELECT Id, MailingCountry, MailingState, MailingStreet, MailingCity, MailingPostalCode, Phone, Email FROM Contact WHERE Id = :quote.zqu__BillToContact__c LIMIT 1];
                    if (billToContacts.size() > 0) {
                        Contact billTo = billToContacts[0];

                        String address = billTo.MailingStreet;
                        String city = billTo.MailingCity;
                        String country = billTo.MailingCountry;
                        String email = billTo.Email;
                        String phone = billTo.Phone;
                        String state = billTo.MailingState;
                        String postalCode = billTo.MailingPostalCode;

                        defaultValues = populateMap(defaultValues, address, city, country, email, phone, state, postalCode);
                    }
                } else {
                    System.debug(FUNC_STR+'this.quote is null or Bill To Contact is not set. Will not default values');
                }
            } else if (hpmSetting.Populate_Contact_Info_for_BA__c && this.sfdcBillingAccount != null) {
                System.debug(FUNC_STR+'Found Billing Account and custom setting is configured to populate Contact information for Billing Accounts');

                if (sfdcBillingAccount != null) {
                    String address = sfdcBillingAccount.Zuora__BillToAddress1__c;
                    String city = sfdcBillingAccount.Zuora__BillToCity__c;
                    String country = sfdcBillingAccount.Zuora__BillToCountry__c;
                    String email = sfdcBillingAccount.Zuora__BillToWorkEmail__c;
                    String phone = sfdcBillingAccount.Zuora__BillToWorkPhone__c;
                    String state = sfdcBillingAccount.Zuora__BillToState__c;
                    String postalCode = sfdcBillingAccount.Zuora__BillToPostalCode__c;

                    defaultValues = populateMap(defaultValues, address, city, country, email, phone, state, postalCode);
                } else {
                    System.debug(FUNC_STR+'this.sfdcBillingAccount is null. Will not default values');
                }
            } else if (hpmSetting.Populate_Contact_Info_for_BA__c && this.zuoraAccount != null) {
                Boolean foundContacts = searchForZuoraContacts();
                System.debug(FUNC_STR+'foundContacts: '+foundContacts);

                if (foundContacts) {
                    //Populate contact information from Bill To Contact

                    if (hasBillToContact) {
                        String address = (String)billToContact.getValue('Address1');
                        String city = (String)billToContact.getValue('City');
                        String country = (String)billToContact.getValue('Country');
                        String email = (String)billToContact.getValue('WorkEmail');
                        String phone = (String)billToContact.getValue('WorkPhone');
                        String state = (String)billToContact.getValue('State');
                        String postalCode = (String)billToContact.getValue('PostalCode');

                        defaultValues = populateMap(defaultValues, address, city, country, email, phone, state, postalCode);
                    } else {
                        System.debug(FUNC_STR+'hasBillToContact is false');
                    }
                } else {
                    System.debug(FUNC_STR+'Failed to find Contacts in Zuora');
                }
            } else {
                System.debug(FUNC_STR+'Either could not find related objects or custom setting configured to not populate contact information into IFrame');
            }
        } else {
            System.debug(FUNC_STR+'hpmSetting is null. Will not populate any defualts into IFrame');
        }

        return defaultValues;
    }

    /**
    * Helper method for populating the defaultValues map. Ensures that each parameter is not null and is configured to be populated in the HPM Setting
    * Returns a populated defaultValues map
    **/
    private Map<String,String> populateMap(Map<String,String> defaultValues, String address1, String city, String country, String email, String phone, String state, String postalCode) {
        final String FUNC_STR = DEBUG_STR + 'populateMap: ';
        System.debug(FUNC_STR+'Starting populateMap');

        defaultValues = (defaultValues != null) ? defaultValues : new Map<String,String>();

        Zuora_Customer_HPM_Setting__c hpmSetting = Zuora_Customer_HPM_Setting__c.getValues(Z_PaymentMethodCaptureUtil.getHpmSettingName());
        System.debug(FUNC_STR+'hpmSetting: '+hpmSetting);

        Map<String,String> countryCodeMap = new Map<String,String>();
        Map<String,String> stateCodeMap = new Map<String,String>();

        Map<String,Zuora_Country_ISO_Codes__c> tempCodeMap = Zuora_Country_ISO_Codes__c.getall();
        for (String key : tempCodeMap.keySet()) {
            Zuora_Country_ISO_Codes__c code = tempCodeMap.get(key);
            if (code != null && String.isNotBlank(code.X3_Digit_ISO__c)) {
                //Store everything as upper case to make matching easier
                String normalKey = key.toUpperCase();
                String normalValue = code.X3_Digit_ISO__c.toUpperCase();
                countryCodeMap.put(normalKey, normalValue);
            } else {
                System.Debug(FUNC_STR+'Code or 3 Digit ISO blank for key '+key);
            }
        }   

        Map<String,Zuora_State_Conversions__c> tempStateCodeMap = Zuora_State_Conversions__c.getall();
        for (String key : tempStateCodeMap.keySet()) {
            Zuora_State_Conversions__c code = tempStateCodeMap.get(key);
            if (code != null && String.isNotBlank(code.State_Picklist_Option__c)) {
                //Store name as uppercase, don't modify picklist option
                String normalKey = key.toUpperCase();
                stateCodeMap.put(normalKey, code.State_Picklist_Option__c);
            } else {
                System.Debug(FUNC_STR+'Code or Picklist option blank for key '+key);
            }
        }

        if (hpmSetting != null) {
            if (hpmSetting.Populate_Address1__c && String.isNotBlank(address1)) {
                System.debug(FUNC_STR+'Putting "'+address1+'" into field_creditCardAddress1');
                if (address1.length() > address1MaxLength) {
                    String newAddress1 = address1.substring(0,address1MaxLength);

                    Integer maxLength = (address1MaxLength+address2MaxLength < address1.length()) ? address1MaxLength+address2MaxLength : address1.length();
                    String newAddress2 = address1.substring(address1MaxLength,maxLength);
                    defaultValues.put('field_creditCardAddress1', removeLines(newAddress1));
                    defaultValues.put('field_creditCardAddress2', removeLines(newAddress2));
                } else {
                    defaultValues.put('field_creditCardAddress1', removeLines(address1));
                }   
            }
            if (hpmSetting.Populate_City__c && String.isNotBlank(city)) {
                System.debug(FUNC_STR+'Putting "'+city+'" into field_creditCardCity');
                defaultValues.put('field_creditCardCity', removeLines(city));
            }
            if (hpmSetting.Populate_Country__c && String.isNotBlank(country)) {
                //Use Country override if it exists
                String countryCode = countryCodeMap.get(country.toUpperCase());
                String countryToUse = (String.isNotBlank(countryCode)) ? countryCode : country;
                System.debug(FUNC_STR+'Putting "'+countryToUse+'" into field_creditCardCountry');
                defaultValues.put('field_creditCardCountry', removeLines(countryToUse));
            }
            if (hpmSetting.Populate_Email__c && String.isNotBlank(email)) {
                System.debug(FUNC_STR+'Putting "'+email+'" into field_email');
                defaultValues.put('field_email', removeLines(email));
            }
            if (hpmSetting.Populate_Phone__c && String.isNotBlank(phone)) {
                System.debug(FUNC_STR+'Putting "'+phone+'" into field_phone');
                defaultValues.put('field_phone', removeLines(phone));
            }
            if (hpmSetting.Populate_State__c && String.isNotBlank(state)) {
                //Use State override if it exists
                String stateCode = stateCodeMap.get(state.toUpperCase());
                String stateToUse = (String.isNotBlank(stateCode)) ? stateCode : state;
                System.debug(FUNC_STR+'Putting "'+stateToUse+'" into field_creditCardState');
                defaultValues.put('field_creditCardState', removeLines(stateToUse));
            }
            if (hpmSetting.Populate_Postal_Code__c && String.isNotBlank(postalCode)) {
                System.debug(FUNC_STR+'Putting "'+postalCode+'" into field_creditCardPostalCode');
                defaultValues.put('field_creditCardPostalCode', removeLines(postalCode));
            }
        } else {
            System.debug(FUNC_STR+'hpmSetting is null. Will not populate any fields');
        }

        return defaultValues;
    }

    /**
    * Helper method to remove newline characters from address fields
    **/
    private String removeLines(String originalString) {
        final String FUNC_STR = 'removeLines: ';
        System.debug(FUNC_STR+'Starting removeLines');

        String modifiedString = (String.isNotBlank(originalString)) ? originalString : '';
        modifiedString = modifiedString.replace('\r\n', ' ');
        modifiedString = modifiedString.replace('\n', ' ');
        modifiedString = modifiedString.replace('\r', ' ');

        return modifiedString;
    }
}