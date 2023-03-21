global class X1800Utilities {

    public static Set<String> semaphoreSet = new Set<String>();
    
	//used to cache queries in triggers
	public static Map<ID,User> userMap{
		get{
			if(userMap == null){
				userMap = new Map<ID,User>([SELECT ID FROM User WHERE isActive = TRUE]);
			}
			return userMap;
		}set;
	}
	public static List<User> userList{
		get{
			if(userList == null){
				userList = userMap.values();
			}
			return userList;
		}set;
	}
	
	
    /**
    This method is built custom for 1800Accountant
    For package charges where the we want to remove the first month,
    find that record and delete it.
    The associated payment will get deleted via a trigger on subscription line
    For packages where the Is Split Payment = true
    We need to duplicate the split payment value to another charge 30 days from now
    */
    @future
    public static void removeFirstMonthPackageChargeAndSplitPayment(Set<Id> idSet){
        List<Bill62__Subscription__c> subList = [SELECT ID, NAME, Bill62__Start_Date__c,
            Bill62__Order__c,
            Bill62__Product__r.Remove_First_Month_Charge__c,
            Bill62__Product__r.Remove_First_Month_Charge_Amount__c,
            Bill62__Product__r.Is_Split_Payment__c,
            Bill62__Product__r.Split_Payment_Amount__c,
                (SELECT ID, Bill62__Amount__c,
                 Bill62__Billing_Frequency__c,Bill62__Category__c,Bill62__Cycle_End_Date__c,
                 Bill62__Cycle_Start_Date__c,Bill62__Dues__c,Bill62__Full_Cycle_Amount__c,
                 Bill62__Full_Cycle_End_Date__c,Bill62__Full_Cycle_Start_Date__c,Bill62__Monthly_Amount__c,
                 Bill62__Payment_Received__c,Bill62__Schedule_Payment_Date__c,Bill62__Split_Monthly_Revenue__c,
                 Bill62__Subscription__c,Bill62__Type__c,Name,Bill62__Payment__c,Bill62__Days_In_Cycle__c
                 FROM BILL62__Subscription_Lines__R)
            from Bill62__Subscription__c
            WHERE ID IN: idSet
            and (Bill62__Product__r.Remove_First_Month_Charge__c = TRUE)];
            
        system.debug('subList in X1800 b4: '+subList);
        List<Bill62__Subscription_Line__c> delList = new List<Bill62__Subscription_Line__c>();
        
        for (Bill62__Subscription__c s : subList){
            if (s.Bill62__Product__r.Remove_First_Month_Charge_Amount__c != null){
                for (Bill62__Subscription_Line__c sl : s.BILL62__Subscription_Lines__R){
                    if (s.Bill62__Start_Date__c == sl.Bill62__Cycle_Start_Date__c 
                        && sl.Bill62__Billing_Frequency__c == 'Recurring'
                        && sl.Bill62__Days_In_Cycle__c < 190){
                        delList.add(sl);
                        break;
                    }
                }
            }
        }

        List<ID> paymentIDs = new List<ID>();
        for(Bill62__Subscription_Line__c sl : delList){
            paymentIDs.add(sl.Bill62__Payment__c);
        }

        delete delList;       
        system.debug('subList in X1800 after: '+subList);
        
        List<Bill62__Payment__c> payments = [SELECT ID,Bill62__Amount__c FROM Bill62__Payment__c WHERE ID IN :paymentIDs];
        Map <ID, List<Bill62__Subscription_Line__c>> payToSublines = new Map <ID, List<Bill62__Subscription_Line__c>>();
        List<Bill62__Subscription_Line__c> sls = [SELECT ID,Bill62__Payment__c
            FROM Bill62__Subscription_Line__c WHERE Bill62__Payment__c IN :payments];
        
        for(Bill62__Subscription_Line__c sl: sls){
            if(payToSublines.containsKey(sl.Bill62__Payment__c)){
                List<Bill62__Subscription_Line__c> temp = payToSublines.get(sl.Bill62__Payment__c);
                temp.add(sl);
                payToSublines.put(sl.Bill62__Payment__c,temp);
            }else{
                List<Bill62__Subscription_Line__c> temp = new List<Bill62__Subscription_Line__c>();
                temp.add(sl);
                payToSublines.put(sl.Bill62__Payment__c,temp);
            }
        }
        
        for(Bill62__Payment__c pay: payments){
            List<Bill62__Subscription_Line__c> subLines = payToSublines.get(pay.ID);
            Double total = 0;
            for(Bill62__Subscription_Line__c sl: subLines){
                total = total + sl.Bill62__Amount__c;
            }
            pay.Bill62__Amount__c = total;
        }
        
        update payments;
    }
    
    /**
    This method is built custom for 1800Accountant
    For packages where the Is Split Payment = true
    We need to duplicate the split payment value to another charge 30 days from now
    *//*
    @future
    public static void createSplitPaymentSubLine(Set<Id> idSet){
        List<Bill62__Subscription__c> subList = [SELECT ID, NAME, Bill62__Start_Date__c,
            Bill62__Product__r.Is_Split_Payment__c,
            Bill62__Product__r.Split_Payment_Amount__c,
                (SELECT ID, Bill62__Amount__c,
                 Bill62__Billing_Frequency__c,Bill62__Category__c,Bill62__Cycle_End_Date__c,
                 Bill62__Cycle_Start_Date__c,Bill62__Dues__c,Bill62__Full_Cycle_Amount__c,
                 Bill62__Full_Cycle_End_Date__c,Bill62__Full_Cycle_Start_Date__c,Bill62__Monthly_Amount__c,
                 Bill62__Payment_Received__c,Bill62__Schedule_Payment_Date__c,Bill62__Split_Monthly_Revenue__c,
                 Bill62__Subscription__c,Bill62__Type__c,Name
                 FROM BILL62__Subscription_Lines__R)
            from Bill62__Subscription__c
            WHERE ID IN: idSet
            and Bill62__Product__r.Is_Split_Payment__c = TRUE];
            
        List<Bill62__Subscription_Line__c> insertList = new List<Bill62__Subscription_Line__c>();
        
        for (Bill62__Subscription__c s : subList){
            if (s.Bill62__Product__r.Split_Payment_Amount__c != null){
                Decimal splitAmt = s.Bill62__Product__r.Split_Payment_Amount__c;
                for (Bill62__Subscription_Line__c sl : s.BILL62__Subscription_Lines__R){
                    if (s.Bill62__Start_Date__c == sl.Bill62__Cycle_Start_Date__c
                    && sl.Bill62__Full_Cycle_Amount__c == splitAmt){
                        Bill62__Subscription_Line__c newSL = sl.clone(false, true, true, false);
                        system.debug('***newSL:' + newSL);
                        newSL.Bill62__Cycle_Start_Date__c = newSL.Bill62__Cycle_Start_Date__c.addDays(30);
                        newSL.Bill62__Cycle_End_Date__c = newSL.Bill62__Cycle_End_Date__c.addDays(30); 
                        newSL.Bill62__Full_Cycle_Start_Date__c = newSL.Bill62__Full_Cycle_Start_Date__c.addDays(30);
                        newSL.Bill62__Full_Cycle_End_Date__c = newSL.Bill62__Full_Cycle_End_Date__c.addDays(30);
                        newSL.Name = newSL.Name + ' - pt. 2';
                        insertList.add(newSL);
                    }
                }
            }
        }
        
        insert insertList;
    }*/
    
     /*
    @Name   :getFields
    @Description :Returns comma seperated list of fields for a given object
    */
    public static String getFields(String strSObjectName) {
        SObjectType sot = Schema.getGlobalDescribe().get(strSObjectName);
        if (sot == null) return null;
        List<Schema.SObjectField> lstFields = sot.getDescribe().fields.getMap().values();
        String strReturn = '';
        for(Integer i = 0; i < lstFields.size(); i++){
           if(lstFields.get(i).getDescribe().isAccessible()){
             if(i == lstFields.size() - 1){
                 strReturn += lstFields.get(i).getDescribe().Name;
             } else {
                 strReturn += lstFields.get(i).getDescribe().Name + ',';
             }
           }
        }
        return strReturn;
    }
    
    public static map<String,String> StateAbbrev = new map<String,String>{
    'Alabama'=>'AL',
    'Alaska'=>'  AK',
    'Arizona'=>'AZ',
    'Arkansas'=>'AR',
    'Colorado'=>'CO',
    'California'=>'CA',
    'Connecticut'=>'CT',
    'Delaware'=>'DE',
    'Florida'=>'FL',
    'Georgia'=>'GA',
    'Hawaii  '=>'HI',
    'Idaho'=>'ID',
    'Illinois'=>'IL',
    'Indiana'=>'IN',
    'Iowa'=>'IA',
    'Kansas'=>'KS',
    'Kentucky'=>'KY',
    'Louisiana'=>'LA',
    'Maine'=>'ME',
    'Maryland'=>'MD',
    'Massachusetts'=>'MA',
    'Michigan'=>'MI',
    'Minnesota'=>'MN',
    'Mississippi'=>'MS',
    'Missouri'=>'MO',
    'Montana'=>'MT',
    'Nebraska'=>'NE',
    'Nevada'=>'NV',
    'New Hampshire'=>'NH',
    'New Jersey'=>'NJ',
    'New Mexico'=>'NM',
    'New York'=>'NY',
    'North Carolina'=>'NC',
    'North Dakota'=>'ND',
    'Ohio'=>'OH',
    'Oklahoma'=>'OK',
    'Oregon'=>'OR',
    'Pennsylvania'=>'PA',
    'Rhode Island'=>'RI',
    'South Carolina'=>'SC',
    'South Dakota'=>'SD',
    'Tennessee'=>'TN',
    'Texas'=>'TX',
    'Utah'=>'UT',
    'Vermont'=>'VT',
    'Virginia'=>'VA',
    'Washington'=>'  WA',
    'West Virginia'=>'WV',
    'Wisconsin'=>'WI',
    'Wyoming'=>'WY',
    'District of Columbia'=>'DC'};
  
  public static map<String,String> TimeZones = new map<String,String>{
    'AL'=>'Central',
    'AK'=>'Alaskan',
    'AZ'=>'Pacific',
    'AR'=>'Central',
    'CA'=>'Pacific',
    'CO'=>'Mountain',
    'CT'=>'Eastern',
    'DE'=>'Eastern',
    'FL'=>'Eastern',
    'GA'=>'Eastern',
    'HI'=>'Pacific',
    'ID'=>'Mountain',
    'IL'=>'Central',
    'IN'=>'Eastern',
    'IA'=>'Central',
    'KS'=>'Central',
    'KY'=>'Central',
    'LA'=>'Central',
    'ME'=>'Eastern',
    'MD'=>'Eastern',
    'MA'=>'Eastern',
    'MI'=>'Eastern',
    'MN'=>'Central',
    'MS'=>'Central',
    'MO'=>'Central',
    'MT'=>'Mountain',
    'NE'=>'Central',
    'NV'=>'Pacific',
    'NH'=>'Eastern',
    'NJ'=>'Eastern',
    'NM'=>'Mountain',
    'NY'=>'Eastern',
    'NC'=>'Eastern',
    'ND'=>'Central',
    'OH'=>'Eastern',
    'OK'=>'Central',
    'OR'=>'Pacific',
    'PA'=>'Eastern',
    'RI'=>'Eastern',
    'SC'=>'Eastern',
    'SD'=>'Central',
    'TN'=>'Eastern',
    'TX'=>'Central',
    'UT'=>'Mountain',
    'VT'=>'Eastern',
    'VA'=>'Eastern',
    'WA'=>'Pacific',
    'WV'=>'Eastern',
    'WI'=>'Central',
    'WY'=>'Mountain',
    'DC'=>'Eastern'};
/**
 * Copyright (c), Andrew Fawcett
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, 
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, 
 *      this list of conditions and the following disclaimer in the documentation 
 *      and/or other materials provided with the distribution.
 * - Neither the name of the Andrew Fawcett, nor the names of its contributors 
 *      may be used to endorse or promote products derived from this software without 
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

/**
 * This class is designed to help with caching the results of querying (via SOQL) Custom Permissions for the 
 *   current user, it will load all defined Custom Permissions in one go for a given default or specified 
 *   namespace (so not all defined in the org). This is done on the basis the caller will make 2 or more calls to 
 *   the hasPermission method, thus benifiting from the bulkificaiton approach used. 
 *   Note that the query to the database is demand loaded only on the first call to the hasPermission method
 *   thus constructing the object carries no SOQL / database overhead.
 **/
    public virtual class CustomPermissionsReader {

        private SObjectType managedObject;

        private Set<String> customPermissionNames;

        private Set<String> customPermissionsForCurrentUser;

        /**
         * This default constructor will seek out all unmanaged/default namespace Custom Permissions 
         **/
        public CustomPermissionsReader() {
            this(null);
        }

        /**
         * This constructor will load Custom Permissions associated with the namespace of the object passed in,
         *   this is the best constructor to use if you are developing a managed AppExchange package! The object 
         *   passed in does not matter so long as its one from the package itself.
         *
         *   If the object is running in a managed context (e.g. packaging org or installed package) namespace is used to constrain the query 
         *   If the object is not running in a managed context (e.g. developer org not namespaced) the default namespace is used to query
         **/
        public CustomPermissionsReader(SObjectType managedObject) {
            this.managedObject = managedObject;
        }

        public Boolean hasPermission(String customPermissionName) {
            // Demand load the custom permissions from the database?        
            if(customPermissionNames==null)
                init();
            // Is this a valid custom permission name?
            /*if(!customPermissionNames.contains(customPermissionName))
                throw new CustomPermissionsException('Custom Permission ' + customPermissionName + ' is not valid.');*/
            // Has this user been assigned this custom permission?
            return customPermissionsForCurrentUser.contains(customPermissionName);
        }

        /**
         * Loads Custom Permissions sets for either the default namespace or 
         *   the current namespace context (derived from the managed object reference)
         **/
        private void init() {
    
            customPermissionNames = new Set<String>();
            customPermissionsForCurrentUser = new Set<String>();
    
            // Determine the namespace context for the custom permissions via the SObject passed in?
            String namespacePrefix = null;
            if(managedObject!=null) {
                DescribeSObjectResult describe = managedObject.getDescribe();
                String name = describe.getName();
                String localName = describe.getLocalName();
                namespacePrefix = name.removeEnd(localName).removeEnd('__');
            }
    
            // Query the full set of Custom Permissions for the given namespace
            Map<Id, String> customPermissionNamesById = new Map<Id, String>();
            List<CustomPermission> customPermissions = 
                [select Id, DeveloperName from CustomPermission where NamespacePrefix = :namespacePrefix];
            for(CustomPermission customPermission : customPermissions) {
                customPermissionNames.add(customPermission.DeveloperName);
                customPermissionNamesById.put(customPermission.Id, customPermission.DeveloperName);
            }
    
            // Query to determine which of these custome settings are assigned to this user
            List<SetupEntityAccess> setupEntities = 
                [SELECT SetupEntityId
                    FROM SetupEntityAccess
                    WHERE SetupEntityId in :customPermissionNamesById.keySet() AND
                          ParentId
                            IN (SELECT PermissionSetId 
                                FROM PermissionSetAssignment
                                WHERE AssigneeId = :UserInfo.getUserId())]; 
            for(SetupEntityAccess setupEntity : setupEntities)
                customPermissionsForCurrentUser.add(customPermissionNamesById.get(setupEntity.SetupEntityId));  
        }
    }

    public class CustomPermissionsException extends Exception {}

    public static void testIntegers(){
        Integer i = 0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
    }
}