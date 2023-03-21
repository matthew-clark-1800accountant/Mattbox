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
global class Z_CreateQuote_DefaultValuePlugin extends zqu.CreateQuoteController.PopulateDefaultFieldValuePlugin {

	//Quote Subscription Types
	private static final String NEW_SUB_TEXT = 'Subscription';
	private static final String AMEND_SUB_TEXT = 'Amendment';
	private static final String RENEW_SUB_TEXT = 'Renewal';

	//Support Zuora Objects in custom setting
	private static final String ACCOUNT_TEXT = 'Account';
	private static final String BILL_TO_TEXT = 'Bill To Contact';
	private static final String SOLD_TO_TEXT = 'Sold To Contact';
	private static final String SUBSCRIPTION_TEXT = 'Subscription';

	//Debug string used for System.debugs
	private static final String DEBUG_STR = 'Z_CreateQuote_DefaultValuePlugin: ';

	//Error message starter text
	private static final String ERROR_RETRIEVING_INFO_TEXT = 'Could not retrieve value from Zuora for field: ';

	/**
	* Main method, defaults fields on the Quote using custom setting records for "Zuora Quote to ZObject Mapping"
	**/
    global override void populateDefaultFieldValue (SObject record, zqu.PropertyComponentController.ParentController pcc) {   
    	final String FUNC_STR = DEBUG_STR + 'populateDefaultFieldValue: '; 
    	System.debug(FUNC_STR+'Starting default values, \nrecord: '+record+', \npcc: '+pcc);

    	//Only want to call the default functionality when we're not in a test (will cause errors)
        if(!Test.isRunningTest()) {
        	super.populateDefaultFieldValue(record, pcc);    
        }

        zqu__Quote__c quote = (zqu__Quote__c) record;
        
        //If Quote already exists, retrieve the relevant information from the object
        if(quote.Id != null) {
            quote = [
                Select Id, zqu__SubscriptionType__c, zqu__ExistSubscriptionID__c, zqu__ZuoraAccountID__c
                FROM zqu__Quote__c
                WHERE Id =: quote.Id
            ];
        }

        //Retrieve params from URL
        Map<String, String> pageParams = ApexPages.currentPage().getParameters();
        String quoteType = pageParams.get('quoteType');
        String billingAccountId = pageParams.get('billingAccountId');
        String subscriptionId = pageParams.get('subscriptionId');

        System.debug(FUNC_STR+'pageParams: '+pageParams);
        System.debug(FUNC_STR+'quoteType: '+quoteType+', billingAccountId: '+billingAccountId+', subscriptionId: '+subscriptionId);

        //Populate Account / Contact information for New Sub Existing Billing Account, Amend, and Renew Quotes
        Boolean populateAccountInfo = (String.isNotBlank(quoteType) && String.isNotBlank(billingAccountId) && ((quoteType.equalsIgnoreCase(NEW_SUB_TEXT) && String.isNotBlank(billingAccountId)) || quoteType.equalsIgnoreCase(AMEND_SUB_TEXT) || quoteType.equalsIgnoreCase(RENEW_SUB_TEXT) ));

        //Populate Subscription information for Amend / Renew Quotes
        Boolean populateSubscriptionInfo = (String.isNotBlank(quoteType) && String.isNotBlank(subscriptionId) && (quoteType.equalsIgnoreCase(AMEND_SUB_TEXT) || quoteType.equalsIgnoreCase(RENEW_SUB_TEXT)));

        //Holds set of fields to query on Zuora objects
        Set<String> accountFields = new Set<String>();
        Set<String> contactFields = new Set<String>();
        Set<String> subscriptionFields = new Set<String>();

        //List of Quote to ZObject Mapping Custom Settings
        List<Zuora_Quote_to_ZObject_Mapping__c> quoteToObjectMappings = Zuora_Quote_to_ZObject_Mapping__c.getall().values();

        //Gather up fields from custom settings
        for (Zuora_Quote_to_ZObject_Mapping__c quoteToZObjectMapping : quoteToObjectMappings) {
        	if (z_AccountCustomFieldsUpdate.confirmQuoteType(quote, quoteToZObjectMapping) && z_AccountCustomFieldsUpdate.validateMappingSetting(quoteToZObjectMapping)) {
        		if (quoteToZObjectMapping.Zuora_Object__c.equalsIgnoreCase(ACCOUNT_TEXT)) {
        			accountFields.add(quoteToZObjectMapping.Zuora_Object_Field__c);
        		} else if (quoteToZObjectMapping.Zuora_Object__c.equalsIgnoreCase(BILL_TO_TEXT) || quoteToZObjectMapping.Zuora_Object__c.equalsIgnoreCase(SOLD_TO_TEXT)) {
        			contactFields.add(quoteToZObjectMapping.Zuora_Object_Field__c);
        		} else if (quoteToZObjectMapping.Zuora_Object__c.equalsIgnoreCase(SUBSCRIPTION_TEXT)) {
        			subscriptionFields.add(quoteToZObjectMapping.Zuora_Object_Field__c);
        		} 
        	}
        }

        System.debug(FUNC_STR+'accountFields - '+accountFields);
        System.debug(FUNC_STR+'contactFields - '+contactFields);
        System.debug(FUNC_STR+'subscriptionFields - '+subscriptionFields);

        Zuora.zObject queriedAccount = null;
        Zuora.zObject queriedBillTo = null;
        Zuora.zObject queriedSoldTo = null;
        Zuora.zObject queriedSubscription = null;

        if (populateAccountInfo && (!accountFields.isEmpty() || !contactFields.isEmpty()) || (populateSubscriptionInfo && !subscriptionFields.isEmpty())) {
        	Zuora.zApi zApi = new Zuora.zApi();
        	
        	try {
        		Zuora.zApi.LoginResult loginResult = (!Test.isRunningTest()) ? zApi.zLogin() : new Zuora.zApi.LoginResult();  
        	} catch (Exception ex) {
        		appendError('Error occurred trying to log in to Zuora: '+ex.getMessage());
        		return;
        	}

        	//Retrieve Account information
        	if (populateAccountInfo && (!accountFields.isEmpty() || !contactFields.isEmpty())) {
        		System.debug(FUNC_STR+'Entering populateAccountInfo block');
        		//Add contact ids for later use
        		accountFields.add('BillToId');
        		accountFields.add('SoldToId');
        		String accountQuery = buildQueryString(accountFields, 'Account', billingAccountId);

        		List<Zuora.zObject> zAccounts = queryZuora(zApi, accountQuery, 'Account');
        		System.debug(FUNC_STR+'Retrieved Accounts from Zuora: '+zAccounts);
        		if (zAccounts != null && zAccounts.size() > 0) {
        			queriedAccount = zAccounts[0];

        			String billToId = (String)queriedAccount.getValue('BillToId');
        			String soldToId = (String)queriedAccount.getValue('SoldToId');

        			if (String.isNotBlank(billToId) && String.isNotBlank(soldToId)) {
        				String contactQuery = buildQueryString(contactFields, 'Contact', billToId);
        				contactQuery = (contactQuery != null) ? contactQuery + ' or Id = \''+soldToId+'\'' : null;
        				List<Zuora.zObject> zContacts = queryZuora(zApi, contactQuery, 'Contact');
        				System.debug(FUNC_STR+'Retrieved Contacts from Zuora: '+zContacts);
        				if (zContacts != null && zContacts.size() > 0) {
        					System.debug(FUNC_STR+'Looping through Contacts');
        					for (Zuora.zObject con : zContacts) {
        						System.debug(FUNC_STR+'Starting Contact: '+con);
        						if ((String)con.getValue('Id') == billToId) {
        							System.debug(FUNC_STR+'Found Bill To Contact');
        							queriedBillTo = con;
        						}
        						if ((String)con.getValue('Id') == soldToId) {
        							System.debug(FUNC_STR+'Found Sold To Contact');
        							queriedSoldTo = con;
        						}
        					}
        					System.debug(FUNC_STR+'Done looping through Contacts');
        				} else {
        					System.debug(FUNC_STR+'Failed to retrieve Contacts from Zuora');
        				}
        			} else {
        				System.debug(FUNC_STR+'Bill To Id or Sold To Id null on Account');
        			}
        		} else {
        			System.debug(FUNC_STR+'Failed to retrieve Accounts from Zuora');
        		}
        	}

        	//Retrieve Subscription information
        	if (populateSubscriptionInfo && !subscriptionFields.isEmpty()) {
        		System.debug(FUNC_STR+'Entering populateSubscriptionInfo block');
        		String subQuery = buildQueryString(subscriptionFields, 'Subscription', subscriptionId);
        		List<Zuora.zObject> zSubs = queryZuora(zApi, subQuery, 'Subscription');
        		System.debug(FUNC_STR+'Retrieved Subscriptions from Zuora: '+zSubs);
        		if (zSubs != null && zSubs.size() > 0) {
        			queriedSubscription = zSubs[0];
        		} else {
        			System.debug(FUNC_STR+'Failed to retrieve Subscriptions from Zuora');
        		}
        	}

        	//TODO: cycle through custom setting and set defaults
        	for (Zuora_Quote_to_ZObject_Mapping__c quoteToZObjectMapping : quoteToObjectMappings) {
        		if (z_AccountCustomFieldsUpdate.confirmQuoteType(quote, quoteToZObjectMapping) && z_AccountCustomFieldsUpdate.validateMappingSetting(quoteToZObjectMapping)) {
    				if (queriedAccount != null && quoteToZObjectMapping.Zuora_Object__c.equalsIgnoreCase(ACCOUNT_TEXT) && queriedAccount.getValue(quoteToZObjectMapping.Zuora_Object_Field__c) != null) {
    					try {
    						record.put(quoteToZObjectMapping.Quote_Field__c,queriedAccount.getValue(quoteToZObjectMapping.Zuora_Object_Field__c));
    					} catch (Exception ex) {
    						System.debug(FUNC_STR+'Exception occurred trying to populate quote field '+quoteToZObjectMapping.Quote_Field__c+' with value '+queriedAccount.getValue(quoteToZObjectMapping.Zuora_Object_Field__c));
    					}
    				} else if (queriedBillTo != null && quoteToZObjectMapping.Zuora_Object__c.equalsIgnoreCase(BILL_TO_TEXT) && queriedBillTo.getValue(quoteToZObjectMapping.Zuora_Object_Field__c) != null) {
    					try {
    						record.put(quoteToZObjectMapping.Quote_Field__c,queriedBillTo.getValue(quoteToZObjectMapping.Zuora_Object_Field__c));
    					} catch (Exception ex) {
    						System.debug(FUNC_STR+'Exception occurred trying to populate quote field '+quoteToZObjectMapping.Quote_Field__c+' with value '+queriedBillTo.getValue(quoteToZObjectMapping.Zuora_Object_Field__c));
    					}
    				} else if (queriedSoldTo != null && quoteToZObjectMapping.Zuora_Object__c.equalsIgnoreCase(SOLD_TO_TEXT) && queriedSoldTo.getValue(quoteToZObjectMapping.Zuora_Object_Field__c) != null) {
    					try {
    						record.put(quoteToZObjectMapping.Quote_Field__c,queriedSoldTo.getValue(quoteToZObjectMapping.Zuora_Object_Field__c));
    					} catch (Exception ex) {
    						System.debug(FUNC_STR+'Exception occurred trying to populate quote field '+quoteToZObjectMapping.Quote_Field__c+' with value '+queriedSoldTo.getValue(quoteToZObjectMapping.Zuora_Object_Field__c));
    					}
    				} else if (queriedSubscription != null && quoteToZObjectMapping.Zuora_Object__c.equalsIgnoreCase(SUBSCRIPTION_TEXT) && queriedSubscription.getValue(quoteToZObjectMapping.Zuora_Object_Field__c) != null) {
    					try {
    						record.put(quoteToZObjectMapping.Quote_Field__c,queriedSubscription.getValue(quoteToZObjectMapping.Zuora_Object_Field__c));
    					} catch (Exception ex) {
    						System.debug(FUNC_STR+'Exception occurred trying to populate quote field '+quoteToZObjectMapping.Quote_Field__c+' with value '+queriedSubscription.getValue(quoteToZObjectMapping.Zuora_Object_Field__c));
    					}
    				}
        		}
        	}

        	System.debug(FUNC_STR+'Done defaulting fields');
        } else {
        	System.debug(FUNC_STR+'No need to query Zuora for Account, Contact, or Subscription information');
        }
    }

    /**
    * Helper method for querying Zuora with a valid query string
    **/
    private static List<Zuora.zObject> queryZuora(Zuora.zApi zApi, String queryString, String queryObject) {
    	final String FUNC_STR = DEBUG_STR+'queryZuora: ';
    	List<Zuora.zObject> queriedObjects = new List<Zuora.zObject>();

    	if (zApi != null && String.isNotBlank(queryString) && String.isNotBlank(queryObject)) {
    		try {
    			queriedObjects = (!Test.isRunningTest()) ? zApi.zQuery(queryString) : Z_CreateQuote_DefaultValuePluginTest.retrieveTestObjects(queryObject);
    		} catch (Exception ex) {
    			System.debug(FUNC_STR+'Exception occurred retrieving Accounts from Zuora: '+ex.getMessage());
    		}
    	} else {
    		System.debug(FUNC_STR+'Invalid parameters');
    	}

    	return queriedObjects;
    }

    /**
    * Helper method for building a Zuora query string for a given object and fields
    **/
    private static String buildQueryString(Set<String> tempFields, String queryObject, String objectId) {
    	final String FUNC_STR = DEBUG_STR+'buildQueryString: ';
    	String queryString = null;

    	if (tempFields != null && !tempFields.isEmpty() && String.isNotBlank(queryObject) && String.isNotBlank(objectId)) {
    		List<String> fields = new List<String>();
    		fields.addAll(tempFields);

    		queryString = '';

    		for (Integer i = 0; i < fields.size(); i++) {
    			String field = fields[i];

    			if (i != 0) {
    				queryString += ','+field+' ';
    			} else {
    				queryString = 'Select '+field;
    			}
    		}

    		queryString += ' From '+queryObject+' Where Id = \''+objectId+'\'';
    	} else {
    		System.debug(FUNC_STR+'Incorrect parameters passed to method. Will return null');
    	}

    	System.debug(FUNC_STR+'Returning query string: '+queryString);
    	return queryString;
    }

    /**
    * Helper method for displaying errors to the page
    **/
    public static void appendError(String Message) {
      appendMessage(ApexPages.Severity.ERROR, message);
    } 

    /**
    * Helper method for displaying messages to the page
    **/
    public static void appendMessage(ApexPages.Severity severity, String message) {
      	System.Debug(DEBUG_STR+'appendMessage: '+message+', severity: '+severity);
      	ApexPages.addMessage(new ApexPages.Message(severity, message));
    }
}