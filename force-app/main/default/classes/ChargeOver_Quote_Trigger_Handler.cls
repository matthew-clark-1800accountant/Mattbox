public without sharing class ChargeOver_Quote_Trigger_Handler
{

    private static Boolean afterUpdateRun = false;
    private static Set<Id> processed = new Set<Id>();

    public static void doBeforeTrigger(ChargeOver_Quote__c[] triggerNew, Map<Id, ChargeOver_Quote__c> oldMap, Boolean isInsert, Boolean isUpdate)
    {
        for(ChargeOver_Quote__c newRecord : triggerNew)
        {
            System.debug(LoggingLevel.FINER, 'doBeforeTrigger-setting GUID :: for record :: ' + newRecord);
            newRecord.ChargeOver_URL_Token__c = uniqueIdentifierGenerator(newRecord.Account__c);
        }
    }

    public static void doAfterTrigger(ChargeOver_Quote__c[] triggerNew, Map<Id, ChargeOver_Quote__c> oldMap, Boolean isInsert, Boolean isUpdate, Boolean isDelete)
    {
        if(isUpdate && !afterUpdateRun)
        {
            System.debug(LoggingLevel.FINE, 'doAfterTrigger-isUpdate :: afterUpdateRun is ' + afterUpdateRun);
            ChargeOver_doAfterUpdate(triggerNew);
//            afterUpdateRun = true;
        }
        if(isDelete)
        {
            ChargeOver_DoAfterDelete(oldMap.values());
        }
    }

    private static String uniqueIdentifierGenerator(Id recordId)
    {
        Blob b = Crypto.generateAesKey(128);
        String h = EncodingUtil.convertToHex(b);
        String guid = h.substring(0,8)+ '-' + h.substring(8,12) + '-' + h.substring(12,16) + '-' + h.substring(16,20) + '-' + h.substring(20);
        System.debug(guid);
        return guid + '-' + recordId;
    }

    private static void ChargeOver_DoAfterDelete(ChargeOver_Quote__c[] triggerNew)
    {
        System.debug(LoggingLevel.FINER, 'ChargeOver_DoAfterDelete :: ' + triggerNew);
        List<SObject> objs = new List<SObject>();

        for (SObject o : triggerNew)
        {
            objs.add(o);
        }

        //TODO: ChargeOver.deleteQuote should be consolidated into a single call if possible.
        for (Integer i = 0; i < objs.size(); i++)
        {
            System.debug(LoggingLevel.FINE, 'TRIGGERED ON ' + (String) objs[i].Id);
            ChargeOver.deleteQuote(objs[i].Id);
        }
    }

    private static List<Account> getRelatedAccounts(ChargeOver_Quote__c[] quotes)
    {
        List<Id> accountIds = new List<Id>();
        for (ChargeOver_Quote__c o : quotes)
        {
            accountIds.add(o.Account__c);
        }
        
        return [
            SELECT
                Id,
                Name,
                Primary_Contact_Email__c,
                Primary_Contact_First_Name__c,
                Primary_Contact_Last_Name__c,
                Primary_Contact_Phone__c,
                Primary_Contact_ID__c,
                BillingStreet,
                BillingCity,
                BillingState,
                BillingPostalCode,
                BillingCountry,
                Customer_Number__c
            FROM
                Account
            WHERE
                Id IN :accountIds ];
    }
    
    private static List<Product2> getRelatedProducts(ChargeOver_Quote_Line_Item__c[] lines)
    {
        List<Id> productIds = new List<Id>();
        for (ChargeOver_Quote_Line_Item__c o : lines)
        {
            productIds.add(o.Product__c);
        }
        
        return [
            SELECT 
                Id,
                Name,
                Setup_Fee__c,
                Price_Increase_Percent__c,
                Months_Before_Effective_Price_Increase__c
            FROM 
                Product2 
            WHERE
                Id IN :productIds ];
    }
    
    private static List<ChargeOver_Quote_Line_Item__c> getRelatedQuoteLines(ChargeOver_Quote__c[] quotes)
    {
        List<Id> quoteIds = new List<Id>();
        for (ChargeOver_Quote__c o : quotes)
        {
            quoteIds.add(o.Id);
        }
        
        return [
            SELECT
                Id,
                ChargeOver_Quote__c,
                Name,
                Product__c,
                Quantity__c,
                Description__c,
                Price_Per_Unit__c,
                Contract_Amount__c,
                Product_Description__c,
                HTML_Description__c,
                Applied_Account__c,
                of_times_this_should_recur__c,
                of_Free_Trial_Cycles_Cycles_to_Skip__c,
                Date_Time_Invoice_Being_Held_Until__c,
              of_Monthly_Bookkeeping_Transactions__c,
              of_Payroll_Employees__c
            FROM
                ChargeOver_Quote_Line_Item__c
            WHERE
                ChargeOver_Quote__c = :quoteIds 
            ORDER BY 
                Date_Time_Invoice_Being_Held_Until__c ASC,
                Sort_Order__c ASC ];
    }
    
    private static Account findRelatedAccount(List<Account> accounts, Id findAccountId)
    {
        for (Account o : accounts)
        {
            if (o.Id == findAccountId)
            {
                return o;
            }
        }
        
        return null;
    }
    
    private static Product2 findRelatedProduct(List<Product2> products, Id findProductId)
    {
        for (Product2 o : products)
        {
            if (o.Id == findProductId)
            {
                return o;
            }
        }
        
        return null;
    }
    
    private static List<ChargeOver_Quote_Line_Item__c> findRelatedLines(List<ChargeOver_Quote_Line_Item__c> lines, Id findQuoteId)
    {
        List<ChargeOver_Quote_Line_Item__c> related = new List<ChargeOver_Quote_Line_Item__c>();
        
        for (ChargeOver_Quote_Line_Item__c o : lines)
        {
            if (o.ChargeOver_Quote__c == findQuoteId)
            {
                related.add(o);
            }
        }
        
        return related;
    }
    
    // sc, obj, sub_lines, last_date_time_held
    private static void createSerializedQuote(Account a, String serialized_customer, SObject obj, List<Map<String, String>> sub_lines, String last_date_time_held)
    {
        if (((String) obj.get('Name')).length() > 0 &&
            ((String) obj.get('Name')).isNumeric())
        {
            // Previously synced? 
        }
        else
        {
            Date valid = Date.today().addDays(90);
            String validuntil = Datetime.newInstance(valid.year(), valid.month(), valid.day()).format('yyyy-MM-dd hh:mm:ss');
            
            Datetime created = (Datetime) obj.get('CreatedDate');
            String created_str = created.format('yyyy-MM-dd hh:mm:ss');
            
            Map<String, String> sub = new Map<String, String>();
            sub.put('customer_external_key', (String) obj.get('Account__c'));
            sub.put('paycycle', (String) obj.get('Payment_Cycle__c'));
            
            if (last_date_time_held == 'null' || 
               last_date_time_held == null)
            {
                sub.put('external_key', (String) obj.Id);
            }
            else 
            {
                sub.put('external_key', (String) obj.Id + last_date_time_held);
            }
            
            sub.put('custom_1', (String) obj.get('ChargeOver_URL_Token__c'));
            sub.put('custom_2', (String) obj.get('Opportunity__c'));
            
            sub.put('bill_addr1', (String) a.get('BillingStreet'));
            sub.put('bill_city', (String) a.get('BillingCity'));
            sub.put('bill_state', (String) a.get('BillingState'));
            sub.put('bill_postcode', (String) a.get('BillingPostalCode'));
            sub.put('bill_country', (String) a.get('BillingCountry'));
            
            System.debug(LoggingLevel.FINER, 'sub checkpoint 0 :: ' + sub);
            if (!String.isBlank((String) obj.get('Quote_Number__c')))
            {
                sub.put('custom_3', (String) obj.get('Quote_Number__c'));
            }
            
            sub.put('custom_5', (String) obj.get('Sales_Source__c'));
            
            if (!String.isBlank((String) obj.get('Redirect_URL__c')))
            {
                sub.put('url_acceptredirect', (String) obj.get('Redirect_URL__c'));
            }
            
            if (!String.isBlank((String) obj.get('Scheduler_URL__c')))
            {
                sub.put('url_nextstep', (String) obj.get('Scheduler_URL__c'));
            }
            
            // This is no longer used; it's at the line-item level now instead 
            //if (!String.isBlank((String) objs[i].get('Date_Time_Invoice_Being_Held_Until__c')))
            //{
            //    sub.put('holduntil_datetime_str', (String) objs[i].get('Date_Time_Invoice_Being_Held_Until__c'));
            //}
            
            if (last_date_time_held != 'null' && 
               last_date_time_held != null)
            {
                sub.put('holduntil_datetime_str', last_date_time_held);
            }
            
            sub.put('validuntil_date', validuntil);
            
            if (obj.get('Brand_Name__c') == 'Subscription Management Services')
            {
                sub.put('brand_id', '4');
            }
            else if (obj.get('Brand_Name__c') == 'ClientBooks')
            {
                sub.put('brand_id', '2');
            }
            else if (obj.get('Brand_Name__c') == 'EIN-Tax-Filing')
            {
                sub.put('brand_id', '3');
            }
            else if (obj.get('Brand_Name__c') == 'Bill62')
            {
                sub.put('brand_id', '5');
            }
            else if (obj.get('Brand_Name__c') == 'EzBizFile' || obj.get('Brand_Name__c') == 'Sprout' || obj.get('Brand_Name__c') == 'EZBizFile')
            {
                sub.put('brand_id', '6');
            }
            else
            {
                sub.put('brand_id', '1');
            }
            
            sub.put('custom_7', (String) obj.get('Name_of_Offer_Package__c'));
            sub.put('custom_6', (String) obj.get('Sale_Completed_By_Raw__c'));
            
            if (!String.isBlank((String) obj.get('Credit_Card_ID__c')))
            {
                sub.put('suggested_paymethod', 'crd');
                sub.put('suggested_creditcard_id', (String) obj.get('Credit_Card_ID__c'));
            }
            
            System.debug(LoggingLevel.FINER, 'sub checkpoint 1 :: ' + sub);
            if (obj.get('Installment_Payment_Schedule__c') != null)
            {
                String installment_sch = String.valueOf(obj.get('Installment_Payment_Schedule__c'));
                sub.put('first_invoice_schedule_template_id', installment_sch);
                sub.put('recurring_invoice_schedule_template_id', installment_sch);
                
                if (installment_sch == '4')
                {
                    sub.put('custom_4', '2 Pay');
                }
                else if (installment_sch == '5')
                {
                    sub.put('custom_4', '3 Pay'); 
                }
                else if (installment_sch == '6')
                {
                    sub.put('custom_4', '4 Pay'); 
                }
                else if (installment_sch == '7')
                {
                    sub.put('custom_4', '6 Pay'); 
                }
            }
            else if (((String) obj.get('Payment_Cycle__c')) == 'mon')
            {
                sub.put('custom_4', 'Monthly'); 
            }
            else 
            {
                sub.put('custom_4', 'No Financing'); 
            }
            System.debug(LoggingLevel.FINER, 'sub checkpoint 2 :: ' + sub);
            
            String sq = ChargeOver.serializeQuote(sub, sub_lines);

            //TODO: ChargeOver.createQuote should be consolidated into a single call if possible.
            ChargeOver.createQuote(serialized_customer, sq, (String) obj.Id);
        }
    }
    
    private static void ChargeOver_doAfterUpdate(ChargeOver_Quote__c[] triggerNew)
    {
        List<SObject> objs = new List<SObject>();
        System.debug('**triggerNew: '+triggerNew);
        List<Account> relatedAccounts = getRelatedAccounts(triggerNew);
        System.debug('**'+relatedAccounts);
        List<ChargeOver_Quote_Line_Item__c> relatedLines = getRelatedQuoteLines(triggerNew);
        List<Product2> relatedProducts = getRelatedProducts(relatedLines);
        System.debug('**processed: '+processed);
        for (ChargeOver_Quote__c o : triggerNew)
        {
            if(!processed.contains(o.Id)){ objs.add((SObject) o); }
            processed.add(o.Id);
        }
        System.debug('**objs: '+objs);
        System.debug(objs.size());
        for (Integer i = 0; i < objs.size(); i++)
        {
            if (objs[i].get('LAST_SOURCE__c') == 'ChargeOver')
            {

            }
            else if (objs[i].get('Quote_Created__c') != true)
            {
                // Do not send this yet; the flag isn't set
            }
            else
            {

                // Ensure the customer exists
                Account a = findRelatedAccount(relatedAccounts, (Id) objs[i].get('Account__c'));
                System.debug('***'+objs[i]);
                System.debug('***'+a);
                String superuser_email = (String) a.get('Primary_Contact_Email__c');
                String superuser_fname = (String) a.get('Primary_Contact_First_Name__c');
                String superuser_lname = (String) a.get('Primary_Contact_Last_Name__c');
                
                if (superuser_fname == null || superuser_fname.length() == 0)
                {
                    superuser_fname = 'Blank';
                }
                
                if (superuser_lname == null || superuser_lname.length() == 0)
                {
                    superuser_lname = 'Blank';
                }
                
                Id contact_id = (Id) a.get('Primary_Contact_ID__c');
                
                Map<String, String> v = new Map<String, String>();
                v.put('company', (String) a.get('Name'));
                v.put('external_key', (String) a.get('Id'));
                v.put('superuser_email', superuser_email);
                v.put('superuser_first_name', superuser_fname);
                v.put('superuser_last_name', superuser_lname);
                v.put('superuser_phone', (String) a.get('Primary_Contact_Phone__c'));
                v.put('superuser_external_key', (String) contact_id);
                v.put('bill_addr1', (String) a.get('BillingStreet'));
                v.put('bill_city', (String) a.get('BillingCity'));
                v.put('bill_state', (String) a.get('BillingState'));
                v.put('bill_postcode', (String) a.get('BillingPostalCode'));
                v.put('bill_country', (String) a.get('BillingCountry'));
                v.put('custom_1', (String) a.get('Customer_Number__c'));
                String sc = JSON.serialize(v);

                // Get the _line items_ for the quote
                List<ChargeOver_Quote_Line_Item__c> lines = findRelatedLines(relatedLines, (Id) objs[i].get('Id'));
                
                Integer counter = 0;
                String last_date_time_held = null;
                List<Map<String, String>> sub_lines = new List<Map<String, String>>();
                //List<Map<String, String>> single_sub_lines = new List<Map<String, String>>();
                for (ChargeOver_Quote_Line_Item__c l : lines)
                {
                    counter++;
                    
                    System.debug(LoggingLevel.FINER, 'l checkpoint 0 :: ' + l);
                    //single_sub_lines = new List<Map<String, String>>();
                    Map<String, String> m = new Map<String, String>();

                    m.put('external_key', (String) l.Id);
                    m.put('item_external_key', (String) l.Product__c);
                    m.put('line_quantity', String.valueOf(l.get('Quantity__c')));
                    m.put('obligation.obligation_amount', String.valueOf(l.get('Contract_Amount__c')));

                    if (l.get('Product_Description__c') != null)
                    {
                        m.put('descrip', (String) l.get('Product_Description__c'));
                    }

                    if (l.get('Applied_Account__c') != null)
                    {
                        m.put('custom_1', (String) l.get('Applied_Account__c'));
                    }

                    if (l.get('of_Monthly_Bookkeeping_Transactions__c') != null)
                    {
                        m.put('custom_4', (String) l.get('of_Monthly_Bookkeeping_Transactions__c'));
                    }

                    if (l.get('of_Payroll_Employees__c') != null)
                    {
                        m.put('custom_3', String.valueOf(l.get('of_Payroll_Employees__c')));
                    }

                    if (l.get('of_times_this_should_recur__c') != null)
                    {
                        m.put('expire_recurs', String.valueOf(l.get('of_times_this_should_recur__c')));
                    }
                    
                    if (l.get('of_Free_Trial_Cycles_Cycles_to_Skip__c') != null && 
                       String.valueOf(l.get('of_Free_Trial_Cycles_Cycles_to_Skip__c')) != '0')
                    {
                        m.put('trial_recurs', String.valueOf(l.get('of_Free_Trial_Cycles_Cycles_to_Skip__c')));
                    }

                    m.put('custom_2', (String) l.get('HTML_Description__c'));

                    Product2 p = findRelatedProduct(relatedProducts, l.Product__c);
                    
                    if (p != null && p.get('Setup_Fee__c') == 'One-Time')
                    {
                        m.put('tierset.setup', String.valueOf(l.get('Price_Per_Unit__c')));
                    }
                    else 
                    {
                        m.put('tierset.base', String.valueOf(l.get('Price_Per_Unit__c')));
                    }
                    
                    if (p != null && 
                        Integer.valueOf(p.get('Price_Increase_Percent__c')) > 0 && 
                        Integer.valueOf(p.get('Months_Before_Effective_Price_Increase__c')) > 0)
                    {
                        Integer percent = Integer.valueOf(p.get('Price_Increase_Percent__c'));
                        Integer months = Integer.valueOf(p.get('Months_Before_Effective_Price_Increase__c'));

                        Integer price_increase = (Integer) (Integer.valueOf(l.get('Price_Per_Unit__c')) * (percent / 100.0));
                        Integer new_price = Integer.valueOf(l.get('Price_Per_Unit__c')) + price_increase;

                        m.put('scheduled_updowngrades.tierset.base', String.valueOf(new_price));
                        if (months == 12)
                        {
                            m.put('scheduled_updowngrades.scheduled_date_str', '+363 days');
                        }
                        else 
                        {
                            m.put('scheduled_updowngrades.scheduled_date_str', '+' + String.valueOf(months) + ' months');
                        }
                    }
                    
                    m.put('on_sub_update', 'true');

                    System.debug(LoggingLevel.FINER, 'm checkpoint 0 :: ' + m);
                    
                    String this_date_time_hold = (String) l.get('Date_Time_Invoice_Being_Held_Until__c');
                    if (String.isBlank(this_date_time_hold))
                    {
                        last_date_time_held = this_date_time_hold;
                        
                        m.put('_hold_value', this_date_time_hold);
                        m.put('_hold_condition', 'BLANK');
                        m.put('_hold_counter', String.valueOf(counter));
                        
                        sub_lines.add(m);
                    }
                    else if (this_date_time_hold == last_date_time_held)
                    {
                        m.put('_hold_value', this_date_time_hold);
                        m.put('_hold_condition', 'same as last');
                        m.put('_hold_counter', String.valueOf(counter));
                        
                        sub_lines.add(m);
                    }
                    else 
                    {
                        if (sub_lines.size() > 0)
                        {
                            createSerializedQuote(a, sc, objs[i], sub_lines, last_date_time_held);
                        }
                        
                        sub_lines = new List<Map<String, String>>();
                        
                        m.put('_hold_value', this_date_time_hold);
                        m.put('_hold_condition', 'different');
                        m.put('_hold_counter', String.valueOf(counter));
                        
                        sub_lines.add(m);
                        
                        last_date_time_held = this_date_time_hold;
                    }
                }

                if (sub_lines.size() > 0)
                {
                    createSerializedQuote(a, sc, objs[i], sub_lines, last_date_time_held);
                }
                
            }
        }
    }
}