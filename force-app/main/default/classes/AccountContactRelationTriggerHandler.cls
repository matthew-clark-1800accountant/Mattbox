global with sharing class AccountContactRelationTriggerHandler
{
    private static final Id PORTAL_USER_ID = [SELECT Id FROM User WHERE Alias = 'drepl' AND Name = 'Portal API' LIMIT 1].Id;
    global class relationBlock
    {
        public Id businessAccount {get;set;}
        public Id primaryAccount {get;set;}
        public Id directContactId {get;set;}

        public relationBlock(Id busId, Id primId, Id dirId)
        {
            this.businessAccount = busId;
            this.primaryAccount = primId;
            this.directContactId = dirId;
        }
    }

    //Uncomment next line if you need to implement a before trigger.
    //    public static void doBeforeTrigger(AccountContactRelation[] triggerNew, Map<Id, AccountContactRelation> oldMap, Boolean isInsert, Boolean isUpdate){  }
    public static void doAfterTrigger(AccountContactRelation[] triggerNew, Map<Id, AccountContactRelation> newMap, Boolean isInsert, Boolean isUpdate, Boolean isDelete){ if(isInsert){ relateBusinessAccountToASL(triggerNew); } }

    private static void relateBusinessAccountToASL(AccountContactRelation[] triggerNew)
    {
        Set<Id> triggerNewAccountIds = new Set<Id>();
        Set<Id> isBusinessAccountIds = new Set<Id>();
        Map<Id,relationBlock> contactAccountMap = new Map<Id,relationBlock>();

        for(AccountContactRelation acr : triggerNew)
        {
            contactAccountMap.put(acr.ContactId, new relationBlock(acr.AccountId, null, acr.ContactId));
            triggerNewAccountIds.add(acr.AccountId);
        }



        System.debug('triggerNewAccountIds :: ' + triggerNewAccountIds);
        //Only drop into the below if we have an Account of Business type.
        if(!triggerNewAccountIds.isEmpty())
        {

            Map<Id, Account> triggerAccounts = new Map<Id, Account>();
            for(Account act : [SELECT Id, Business_Account__c, CreatedById FROM Account WHERE Id IN : triggerNewAccountIds])
            {
                if(act.Business_Account__c && PORTAL_USER_ID == act.CreatedById)
                {
                    isBusinessAccountIds.add(act.Id);
                    triggerAccounts.put(act.Id, act);
                }
            }

            //Round 2 - get the account where the contact is Direct.
            Set<Id> primaryAccounts = new Set<Id>();
            Map<Id, Set<Id>> allBusinessIdForRelatedParentAccounts = new Map<Id,Set<Id>>();
            Set<Id> businessAccounts = new Set<Id>();
            for(AccountContactRelation rel :[SELECT AccountId, ContactId, Id, IsDirect FROM AccountContactRelation WHERE ContactId IN :contactAccountMap.keySet()])
            {
                if(contactAccountMap.containsKey(rel.ContactId))
                {
                    if(rel.IsDirect)
                    {
                        relationBlock currentBlock = contactAccountMap.get(rel.ContactId);
                        currentBlock.primaryAccount = rel.AccountId;
                        contactAccountMap.put(rel.ContactId, currentBlock);
                        primaryAccounts.add(rel.AccountId);
                    } else if(!rel.IsDirect)
                    {
                        businessAccounts.add(rel.AccountId);
                        if(allBusinessIdForRelatedParentAccounts.containsKey(rel.ContactId))
                        {
                            Set<Id> idSet = allBusinessIdForRelatedParentAccounts.get(rel.ContactId);
                            idSet.add(rel.AccountId);
                            allBusinessIdForRelatedParentAccounts.put(rel.ContactId, idSet);
                        }
                        allBusinessIdForRelatedParentAccounts.put( rel.ContactId, new Set<Id>{rel.AccountId} );
                    }
                }
            }
            System.debug(LoggingLevel.FINE, 'relationship blocks built as :: ' + contactAccountMap);
            Set<Id> firstBusinessAccountPreviouslyCreated = new Set<Id>();
            Active_Subscription_Line__c[] queriedRelatedLines = new Active_Subscription_Line__c[0];
            for(Active_Subscription_Line__c line : [SELECT Id, Product__r.ZZ_Primary_Category__c, Applied_Account__c, Account__c FROM Active_Subscription_Line__c WHERE Account__c IN : primaryAccounts AND Product__r.ZZ_Primary_Category__c = 'Business'])
            {
                System.debug(LoggingLevel.FINE, 'line is :: ' + line);
                //If our applied account value exists, make sure it isn't already populated as a personal account value.
                if(null != line.Applied_Account__c && !primaryAccounts.contains(line.Applied_Account__c))
                {
                    //Also verify we haven't already related a business account related to the same personal account. If we have to any business account at all,
                    //related to this personal account, we don't need to continue operating on this ASL. We are storing the personal account Id because that is the one
                    //that remains consistent across all ASL, so we'll know if we related a business account already.
                    if(businessAccounts.contains(line.Applied_Account__c))
                    {
                        firstBusinessAccountPreviouslyCreated.add(line.Account__c);
                    }
                }
                queriedRelatedLines.add(line);
            }

            //Map of Primary Account Id, unmodified ASL records.
            Map<Id, Active_Subscription_Line__c[]> linesMap = new Map<Id, Active_Subscription_Line__c[]>();
            for(Active_Subscription_Line__c line : queriedRelatedLines)
            {
                //Validate we do not have a business account related to this primary account already used for relation. We only want the 1st new business account for the primary account.
                //If we have move on to the next record.
                if(!firstBusinessAccountPreviouslyCreated.contains(line.Account__c))
                {
                    System.debug(LoggingLevel.DEBUG, 'firstBusinessAccountPreviouslyCreated is false. Processing ASL records...');
                    Active_Subscription_Line__c[] lineCollection;
                    if(linesMap.containsKey(line.Account__c))
                    {
                        lineCollection = linesMap.get(line.Account__c);
                    } else { lineCollection = new Active_Subscription_Line__c[0]; }

                    System.debug(LoggingLevel.FINE, 'line category should be type business :: ' + line.Product__r.ZZ_Primary_Category__c);

                    //Redundant check for certainty.
                    if('Business'.equalsIgnoreCase(line.Product__r.ZZ_Primary_Category__c))
                    {
                        lineCollection.add(line);
                        linesMap.put(line.Account__c, lineCollection);
                    }
                }

            }

            //Map to ensure we only have a single item being updated at the end.
            //The requirement is to only set a single item to have the Applied_Account__c of the related business account.
            //This should ALSO be per product. Single record to operate on per product.
            //Map<Id, Active_Subscription_Line__c> singleRecordToOperateOnMap = new Map<Id, Active_Subscription_Line__c>();
            Active_Subscription_Line__c[] toUpdate = new Active_Subscription_Line__c[0];

            //Map is Contact Id, Set of Product Id.
            Map<Id, Set<Id>> productUsageMap = new Map<Id, Set<Id>>();
            for(Id key : contactAccountMap.keySet())
            {
                relationBlock itemBlock = contactAccountMap.get(key);
                System.debug(LoggingLevel.FINE, 'itemBlock relationBlock :: ' + itemBlock);

                if(
                    null != itemBlock.primaryAccount &&
                    linesMap.containsKey(itemBlock.primaryAccount)
                )
                {
                    Set<Id> usedProducts = (productUsageMap.containsKey(key)) ? productUsageMap.get(key) : new Set<Id>();
                    //Sift through each set of ASL records still not associated to the business account, but which are related to parent/personal account.
                    for(Active_Subscription_Line__c line : linesMap.get(itemBlock.primaryAccount))
                    {
                        if(null == line.Applied_Account__c && !usedProducts.contains(line.Product__c))
                        {
                            System.debug(LoggingLevel.FINE, 'applying account :: ' + itemBlock.businessAccount + ' for product ' + line.Product__c);
                            line.Applied_Account__c =  itemBlock.businessAccount;
                            usedProducts.add(line.Product__c);
                            productUsageMap.put(key,usedProducts);
                            toUpdate.add(line);
//                            singleRecordToOperateOnMap.put(itemBlock.businessAccount, line);

                            System.debug(LoggingLevel.FINE, 'updating usedProducts :: ' + usedProducts);
                        } else { System.debug(LoggingLevel.FINE, 'line.Product__c already used, moving to next...'); }
                    }
                }
            }

            System.debug(LoggingLevel.FINE, 'toUpdate :: ' + toUpdate);
            if(!toUpdate.isEmpty()
                    && toUpdate.size() > 0)
            {
                System.debug(LoggingLevel.FINER, 'valid for DML :: executing... update');
                update toUpdate;
            }

        }
    }
}