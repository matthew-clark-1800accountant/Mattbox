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
public with sharing class Z_PaymentMethodCaptureUtil {

	private static final String DEBUG_STR = 'Z_PaymentMethodCaptureUtil: ';
	public static final String NEW_SUB_TEXT = 'New Subscription';
	public static final String AMEND_SUB_TEXT = 'Amend Subscription';
	public static final String RENEW_SUB_TEXT = 'Renew Subscription';

	//Holds connector to zuora apis
	public static Zuora.ZApi zApi {
	    get {
	        if (zApi == null) {
	            System.debug(DEBUG_STR+'Instantiating zApi and logging into Zuora');
	            zApi = new Zuora.ZApi();
	            if (!Test.isRunningTest()) {
	                zApi.zLogin();
	            }
	        }
	        return zApi;
	    } set;
	}

	/**
	* Generic method for querying an abstract object. Returns list of all retrieved records
	* Takes some Id related to the object, the api name of the object, a list of fields to query, and the filter field (defaults to 'Id')
	**/
	public static List<SObject> searchForObject(String objectId, String objectType, Set<String> objectFields, String objectLookupField) {
		final String FUNC_STR = DEBUG_STR + 'searchForObject: ';
		System.debug(FUNC_STR+'Starting searchForObject');
	
		objectLookupField = (String.isNotBlank(objectLookupField)) ? objectLookupField : 'Id';
		objectFields = (objectFields != null) ? objectFields : new Set<String>();
	
		List<SObject> retrievedObjects = new List<SObject>();
	
		if (String.isNotBlank(objectId) && String.isNotBlank(objectType)) {
			//Remove Id field if it exists. We will always query this field
			if (objectFields.contains('Id')) {
				objectFields.remove('Id');
			}
			
			//Object query string
			String objectQuery = 'SELECT Id';
			
			//Cycle through Objects Fields set and build query string
			for (String field : objectFields) {
				objectQuery += ', '+field;
			}
			
			objectQuery += ' FROM '+objectType+' WHERE '+objectLookupField+' = :objectId';
			System.debug(FUNC_STR+'objectQuery: '+objectquery);
	
			try {
				retrievedObjects = Database.query(objectQuery);
			} catch (Exception ex) {
				System.debug(FUNC_STR+'Exception occurred trying to query objects: '+ex.getMessage());
			}
		} else {
			System.debug(FUNC_STR+'objectId or objectType passed into function is blank');
		} 
	
		System.debug(FUNC_STR+'Returning objects: '+retrievedObjects);
		return retrievedObjects;
	}


	public static zqu__Quote__c searchForQuote(String objectId) {
	    final String FUNC_STR = DEBUG_STR + 'searchForQuote: ';
	    System.debug(FUNC_STR+'Starting searchForQuote');

	    //Base Quote Fields we need to query
	    Set<String> quoteFields = new Set<String>{
	    	'zqu__ZuoraAccountId__c',
	    	'zqu__BillToContact__c',
	    	'zqu__ElectronicPaymentMethodId__c',
	    	'zqu__SubscriptionType__c',
	    	'zqu__PaymentMethod__c'
	    };
	    String objectType = 'zqu__Quote__c';
	    String objectLookupField = 'Id';

	    System.debug(FUNC_STR+'objectId: '+objectId+', objectType: '+objectType+', objectLookupField: '+objectLookupField+', quotefields: '+quotefields);

	    List<zqu__Quote__c> quotes = (List<zqu__Quote__c>)searchForObject(objectId, objectType, quoteFields, objectLookupField);

	    zqu__Quote__c quote = (quotes != null && quotes.size() > 0) ? quotes[0] : null;

	    if (quote != null) {
	    	//Retrieve additional Quote Fields from custom setting
	    	Set<String> additionalQuoteFields = new Set<String>();

	    	List<Zuora_Customer_HPM_Quote_Field__c> quoteDisplayFields = Zuora_Customer_HPM_Quote_Field__c.getAll().values();

	    	for (Zuora_Customer_HPM_Quote_Field__c quoteDisplayField : quoteDisplayFields) {
	    		//Check Quote Subscription Type
	    		if (quoteDisplayField.Active__c && 
	    			((quote.zqu__SubscriptionType__c == NEW_SUB_TEXT && quoteDisplayField.Enable_For_New_Subscriptions__c) ||
	    			(quote.zqu__SubscriptionType__c == AMEND_SUB_TEXT && quoteDisplayField.Enable_for_Amendments__c) ||
	    			(quote.zqu__SubscriptionType__c == RENEW_SUB_TEXT && quoteDisplayField.Enable_for_Renewals__c))) {

	    			System.debug(FUNC_STR+'Zuora_Customer_HPM_Quote_Field__c "'+quoteDisplayField.Name+'" is enabled for this Quote Type. Will search for additional quote fields');

	    			//Only need to search for field if we haven't already queried it
	    			if (String.isNotBlank(quoteDisplayField.Quote_Field_API_Name__c) && !quoteFields.contains(quoteDisplayField.Quote_Field_API_Name__c) && !quoteDisplayField.Quote_Field_API_Name__c.equalsIgnoreCase('Id')) {
	    				System.debug(FUNC_STR+'Adding additional Quote Field: '+quoteDisplayField.Quote_Field_API_Name__c);
	    				additionalQuoteFields.add(quoteDisplayField.Quote_Field_API_Name__c);
	    			} else {
	    				System.debug(FUNC_STR+'No need to add additional Quote Field: '+quoteDisplayField.Quote_Field_API_Name__c);
	    			}
	    		} else {
	    			System.debug(FUNC_STR+'Zuora_Customer_HPM_Quote_Field__c "'+quoteDisplayField.Name+'" is not enabled for this Quote Type');
	    		}
	    		
	    	}

	    	if (additionalQuoteFields.size() > 0) {
	    		System.debug(FUNC_STR+'Found '+additionalQuoteFields.size()+' additional fields we need to query for');

	    		quoteFields.addAll(additionalQuoteFields);
	    		quotes = (List<zqu__Quote__c>)searchForObject(objectId, objectType, quoteFields, objectLookupField);

	    		quote = (quotes != null && quotes.size() > 0) ? quotes[0] : null;
	    	} else {
	    		System.debug(FUNC_STR+'No additional Quote Fields to Query');
	    	}
	    }

	    System.debug(FUNC_STR+'Returning Quote: '+quote);
	    return quote;
	}

	public static Zuora__CustomerAccount__c searchForSFDCBillingAccount(String objectId) {
	    final String FUNC_STR = DEBUG_STR + 'searchForBillingAccount: ';
	    System.debug(FUNC_STR+'Starting searchForBillingAccount');

	    Zuora__CustomerAccount__c billingAccount = null;

	    //Search for Quote if id is not blank
	    if (String.isNotBlank(objectId)) {
	        System.debug(FUNC_STR+'Searching for Billing Account related to id: '+objectId);
	        List<Zuora__CustomerAccount__c> billingAccounts = [SELECT Id, Zuora__Zuora_Id__c, Zuora__BillToCity__c, Zuora__BillToCountry__c, Zuora__BillToAddress1__c, Zuora__BillToState__c, Zuora__BillToPostalCode__c, Zuora__BillToWorkEmail__c, Zuora__BillToWorkPhone__c,Zuora__PaymentMethod_Type__c FROM Zuora__CustomerAccount__c WHERE Id = :objectId or Zuora__Zuora_Id__c = :objectId or Zuora__AccountNumber__c = :objectId LIMIT 1];

	        if (billingAccounts != null && billingAccounts.size() > 0) {
	            System.debug(FUNC_STR+'Found a related Billing Account');

	            if (String.isNotBlank(billingAccounts[0].Zuora__Zuora_Id__c)) {
	                System.debug(FUNC_STR+'Retrieved Zuora Account Id "'+billingAccounts[0].Zuora__Zuora_Id__c+'" from Billing Account');
	                billingAccount = billingAccounts[0];
	            } else {
	                System.debug(FUNC_STR+'Zuora Account id on Billing Account is blank');
	            }
	        } else {
	            System.debug(FUNC_STR+'Failed to find a related Billing Account in SFDC');
	        }
	    } else {
	        System.debug(FUNC_STR+'id param passed to method is blank');
	    }

	    return billingAccount;
	}

	public static Zuora.ZObject searchForZuoraAccount(String objectId, Boolean testFindAccount) {
	    final String FUNC_STR = DEBUG_STR + 'getZuoraAccount: ';
	    System.debug(FUNC_STR+'Starting method');

	    testFindAccount = (testFindAccount != null) ? testFindAccount : true;

	    Zuora.ZObject billingAccount = null;

	    //Search for Quote if id is not blank
	    if (String.isNotBlank(objectId)) {
	        System.debug(FUNC_STR+'Searching for Account in Zuora related to id: '+objectId);

	        String zoql = 'SELECT Id,BillToId,SoldToId FROM Account WHERE Id = \'' + objectId + '\' or AccountNumber = \''+objectId+'\'';
	        
	        List <Zuora.zObject> billingAccounts = (!Test.isRunningTest()) ? zApi.zquery(zoql) : Z_PaymentMethodCaptureUtilTest.retrieveTestAccount(testFindAccount);  
	        System.debug(FUNC_STR+'Retrieved Accounts from Zuora: '+billingAccounts);

	        if (billingAccounts != null && billingAccounts.size() > 0) {
	            System.debug(FUNC_STR+'Found a related Billing Account');

	            if (String.isNotBlank((String)billingAccounts[0].getValue('Id'))) {
	                System.debug(FUNC_STR+'Retrieved Zuora Account Id "'+(String)billingAccounts[0].getValue('Id')+'" from Zuora Account');
	                billingAccount = billingAccounts[0];
	            } else {
	                System.debug(FUNC_STR+'Id on Zuora Account is blank');
	            }
	        } else {
	            System.debug(FUNC_STR+'Failed to find a related Billing Account in SFDC');
	        }
	    } else {
	        System.debug(FUNC_STR+'accid param in URL is blank');
	    }

	    return billingAccount;      
	}

	public static List<Zuora.ZObject> searchForZuoraContacts(String billToId, String soldToId, Boolean testFindContacts) {
		final String FUNC_STR = 'searchForZuoraContacts: ';
		System.debug(FUNC_STR+'Starting method');

		testFindContacts = (testFindContacts != null) ? testFindContacts : true;

		List<Zuora.ZObject> contacts = new List<Zuora.ZObject>();

		if (String.isNotBlank(billToId) && String.isNotBlank(soldToId)) {
			System.debug(FUNC_STR+'Searching for Contacts in Zuora related to ids "'+billToId+'" or "'+soldToId+'"');

			String zoql = 'SELECT Id,Address1,City,Country,FirstName,LastName,PostalCode,State,WorkEmail,WorkPhone FROM Contact WHERE Id = \''+billToId+'\' or Id = \''+soldToId+'\'';
			System.debug(FUNC_STR+'Querying Zuora with string: '+zoql);

			try {
				contacts = (!Test.isRunningTest()) ? zApi.zQuery(zoql) : Z_PaymentMethodCaptureUtilTest.retrieveTestContacts(testFindContacts);
			} catch (Exception ex) {
				System.debug(FUNC_STR+'Exception occurred querying Zuora for Contacts: '+ex.getMessage());
			}
		} else {
			SYstem.debug(FUNC_STR+'billToId or soldToId is blank. Will not query contacts');
		}

		return contacts;
	}

	public static void setupCountrySettings() {
	  String usaCode = 'USA';
	  String canCode = 'CAN';

	  List<String> usaOptions = new List<String>{
	    'united states',
	    'united states of america',
	    'us',
	    'usa'
	  };

	  if (Test.isRunningTest()) {
	  	//Insert a test record to ensure doesn't already exist
	  	usaOptions.add('Zuora Test Country');
	  }

	  List<String> canOptions = new List<String>{
	    'ca',
	    'can',
	    'canada'
	  };

	  Map<String,Zuora_Country_ISO_Codes__c> codeMap = Zuora_Country_ISO_Codes__c.getall();
	  List<Zuora_Country_ISO_Codes__c> newCodes = new List<Zuora_Country_ISO_Codes__c>();

	  for (String countryName : usaOptions) {
	    Zuora_Country_ISO_Codes__c newCode = createCode(countryName, usaCode, codeMap);
	    if (newCode != null) {
	      newCodes.add(newcode);
	    }
	  }

	  for (String countryName : canOptions) {
	    Zuora_Country_ISO_Codes__c newCode = createCode(countryName, canCode, codeMap);
	    if (newCode != null) {
	      newCodes.add(newCode);
	    }
	  }

	  if (newCodes.size() > 0) {
	    System.debug('Inserting '+newCodes.size()+' new Country Mappings');
	    insert newCodes;
	  } else {
	    System.debug('No need to insert any new Country Mappings');
	  }
	}

	public static void setupStateSettings() {
	  System.debug('Starting upload of states');


	  Map<String,String> usStates = new Map<String,String>{
	    'al' => 'Alabama',
	    'alabama' => 'Alabama',
	    'ak' => 'Alaska',
	    'alaska' => 'Alaska',
	    'az' => 'Arizona',
	    'Arizona' => 'Arizona',
	    'ar' => 'Arkansas',
	    'Arkansas' => 'Arkansas',
	    'ca' => 'California',
	    'California' => 'California',
	    'co' => 'Colorado',
	    'Colorado' => 'Colorado',
	    'ct' => 'Connecticut',
	    'Connecticut' => 'Connecticut',
	    'de' => 'Delaware',
	    'Delaware' => 'Delaware',
	    'fl' => 'Florida',
	    'Florida' => 'Florida',
	    'ga' => 'Georgia',
	    'Georgia' => 'Georgia',
	    'hi' => 'Hawaii',
	    'Hawaii' => 'Hawaii',
	    'id' => 'Idaho',
	    'Idaho' => 'Idaho',
	    'il' => 'Illinois',
	    'Illinois' => 'Illinois',
	    'in' => 'Indiana',
	    'Indiana' => 'Indiana',
	    'ia' => 'Iowa',
	    'Iowa' => 'Iowa',
	    'ks' => 'Kansas',
	    'Kansas' => 'Kansas',
	    'ky' => 'Kentucky',
	    'Kentucky' => 'Kentucky',
	    'la' => 'Louisiana',
	    'Louisiana' => 'Louisiana',
	    'me' => 'Maine',
	    'Maine' => 'Maine',
	    'md' => 'Maryland',
	    'Maryland' => 'Maryland',
	    'ma' => 'Massachusetts',
	    'Massachusetts' => 'Massachusetts',
	    'mi' => 'Michigan',
	    'Michigan' => 'Michigan',
	    'mn' => 'Minnesota',
	    'Minnesota' => 'Minnesota',
	    'ms' => 'Mississippi',
	    'Mississippi' => 'Mississippi',
	    'mo' => 'Missouri',
	    'Missouri' => 'Missouri',
	    'mt' => 'Montana',
	    'Montana' => 'Montana',
	    'ne' => 'Nebraska',
	    'Nebraska' => 'Nebraska',
	    'nv' => 'Nevada',
	    'Nevada' => 'Nevada',
	    'nh' => 'New Hampshire',
	    'New Hampshire' => 'New Hampshire',
	    'nj' => 'New Jersey',
	    'New Jersey' => 'New Jersey',
	    'nm' => 'New Mexico',
	    'New Mexico' => 'New Mexico',
	    'ny' => 'New York',
	    'New York' => 'New York',
	    'nc' => 'North Carolina',
	    'North Carolina' => 'North Carolina',
	    'nd' => 'North Dakota',
	    'North Dakota' => 'North Dakota',
	    'oh' => 'Ohio',
	    'Ohio' => 'Ohio',
	    'ok' => 'Oklahoma',
	    'Oklahoma' => 'Oklahoma',
	    'or' => 'Oregon',
	    'Oregon' => 'Oregon',
	    'pa' => 'Pennsylvania',
	    'Pennsylvania' => 'Pennsylvania',
	    'ri' => 'Rhode Island',
	    'Rhode Island' => 'Rhode Island',
	    'sc' => 'South Carolina',
	    'South Carolina' => 'South Carolina',
	    'sd' => 'South Dakota',
	    'South Dakota' => 'South Dakota',
	    'tn' => 'Tennessee',
	    'Tennessee' => 'Tennessee',
	    'tx' => 'Texas',
	    'Texas' => 'Texas',
	    'ut' => 'Utah',
	    'Utah' => 'Utah',
	    'vt' => 'Vermont',
	    'Vermont' => 'Vermont',
	    'va' => 'Virginia',
	    'Virginia' => 'Virginia',
	    'wa' => 'Washington',
	    'Washington' => 'Washington',
	    'wv' => 'West Virginia',
	    'West Virginia' => 'West Virginia',
	    'wi' => 'Wisconsin',
	    'Wisconsin' => 'Wisconsin',
	    'wy' => 'Wyoming',
	    'Wyoming' => 'Wyoming',
	    'aa' => 'Armed Forces America',
	    'Armed Forces America' => 'Armed Forces America',
	    'ae' => 'Armed Forces',
	    'Armed Forces' => 'Armed Forces',
	    'ap' => 'Armed Forces Pacific',
	    'Armed Forces Pacific' => 'Armed Forces Pacific',
	    'dc' => 'Washington DC',
	    'Washington DC' => 'Washington DC',
	    'gu' => 'Guam',
	    'Guam' => 'Guam',
	    'pr' => 'Puerto Rico',
	    'Puerto Rico' => 'Puerto Rico',
	    'vi' => 'Virgin Islands',
	    'Virgin Islands' => 'Virgin Islands'
	  };
	  System.debug('Created us state map: '+usStates);

	  if (Test.isRunningTest()) {
	  	//Insert a test record to ensure doesn't already exist
	  	usStates.put('Zuora Test State','ZUORA_TEST_STATE');
	  }
	    

	  Map<String,String> canProvinces = new Map<String,String>{
	    'ab' => 'Alberta',
	    'Alberta' => 'Alberta',
	    'ba' => 'British Columbia',
	    'British Columbia' => 'British Columbia',
	    'mb' => 'Manitoba',
	    'Manitoba' => 'Manitoba',
	    'nb' => 'New Brunswick',
	    'New Brunswick' => 'New Brunswick',
	    'nl' => 'Newfoundland and Labrador',
	    'Newfoundland and Labrador' => 'Newfoundland and Labrador',
	    'ns' => 'Nova Scotia',
	    'Nova Scotia' => 'Nova Scotia',
	    'nt' => 'Northwest Territories',
	    'Northwest Territories' => 'Northwest Territories',
	    'nu' => 'Nunavut',
	    'Nunavut' => 'Nunavut',
	    'on' => 'Ontario',
	    'Ontario' => 'Ontario',
	    'pe' => 'Prince Edward Island',
	    'Prince Edward Island' => 'Prince Edward Island',
	    'qc' => 'Quebec',
	    'Quebec' => 'Quebec',
	    'sk' => 'Saskatchewan',
	    'Saskatchewan' => 'Saskatchewan',
	    'yt' => 'Yukon',
	    'Yukon' => 'Yukon'
	  };
	  System.debug('Created Canada Province map: '+canProvinces);

	  uploadStates(usStates);
	  uploadStates(canProvinces);
	}

	public static void uploadStates(Map<String,String> stateMap) {
	  Map<String,Zuora_State_Conversions__c> existingStates = Zuora_State_Conversions__c.getall();

	  List<Zuora_State_Conversions__c> statesToAdd = new List<Zuora_State_Conversions__c>();

	  for (String key : stateMap.keyset()) {
	    if (existingStates.get(key) == null) {
	      Zuora_State_Conversions__c newState = new Zuora_State_Conversions__c();
	      newState.Name = key;
	      newState.State_Picklist_Option__c = stateMap.get(key);
	      System.debug('Adding state: '+newState);
	      statesToAdd.add(newState);
	    } else {
	      System.debug('State already exists for "'+key+'"');
	    }
	  }

	  if (statesToAdd.size() > 0) {
	    System.debug('Adding '+statesToAdd.size()+' new states');
	    insert statesToAdd;
	  } else {
	    System.debug('No new states to add');
	  }
	}

	public static Zuora_Country_ISO_Codes__c createCode(String name, String code, Map<String,Zuora_Country_ISO_Codes__c> existingCodeMap) {
	  if (existingCodeMap.get(name) == null) {
	    System.debug('Creating custom setting record with name: '+name+', and code: '+code);
	      Zuora_Country_ISO_Codes__c newCode = new Zuora_Country_ISO_Codes__c();
	    newCode.Name = name;
	    newCode.X3_Digit_ISO__c = code;
	    return newCode;
	  } else {
	    System.debug('Custom setting record with name "'+name+'" already exists.');
	    return null;
	  }    
	}

	public static void performCustomizationSetup() {
		setupStateSettings();
		setupCountrySettings();
		createHPMSetting();
	}

	public static String getHpmSettingName() {
		return (!Test.isRunningTest()) ? 'Zuora Customer HPM Setting' : 'Zuora Customer HPM Setting Test';
	}

	public static void createHPMSetting() {
		String hpmSettingName = (!Test.isRunningTest()) ? 'Zuora Customer HPM Setting' : 'Zuora Customer HPM Setting Test';

		Zuora_Customer_HPM_Setting__c hpmSetting = Zuora_Customer_HPM_Setting__c.getall().get(hpmSettingName);

		if (hpmSetting == null) {
			System.debug('Creating new HPM Setting');
			hpmSetting = new Zuora_Customer_HPM_Setting__c();
			hpmSetting.Name = hpmSettingName;
			hpmSetting.Allow_for_Amend_Subscription_Quote__c = true;
			hpmSetting.Allow_for_New_Subscription_Quote__c = true;
			hpmSetting.Allow_for_Renew_Subscription_Quote__c = true;
			hpmSetting.Allow_for_Billing_Account_in_SFDC__c = true;
			hpmSetting.Allow_for_Billing_Account_in_Zuora__c = true;
			hpmSetting.Display_Quote_Charge_Fields__c = true;
			hpmSetting.Display_Quote_Fields__c = true;
			hpmSetting.Payment_Page_Component_Name__c = 'Customer_Payment_Page';
			hpmSetting.Populate_Address1__c = true;
			hpmSetting.Populate_City__c = true;
			hpmSetting.Populate_Contact_Info_for_BA__c = true;
			hpmSetting.Populate_Contact_Info_for_Quotes__c = true;
			hpmSetting.Populate_Country__c = true;
			hpmSetting.Populate_Email__c = true;
			hpmSetting.Populate_Phone__c = true;
			hpmSetting.Populate_Postal_Code__c = true;
			hpmSetting.Populate_State__c = true;
			hpmSetting.Update_Quote_With_Payment_Method_Id__c = true;

			System.debug('Inserting new HPM Setting: '+hpmSetting);
			insert hpmSetting;
			
		} else {
			System.debug('HPM Setting already exists. Will not create');
		}
	}
}