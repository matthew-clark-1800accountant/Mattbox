public without sharing class ChargeOver {

    static String CHARGEOVER_URL;
    static String CHARGEOVER_USERNAME;
    static String CHARGEOVER_PASSWORD;
    
    static {
    
        // initialize static properties from custom setting Chargeover_URL__c at org level
        Chargeover_URL__c uset = Chargeover_URL__c.getOrgDefaults();
        
        CHARGEOVER_URL = uset.Chargeover_URL__c + '/api/v3';
        CHARGEOVER_USERNAME = uset.Chargeover_User__c;
        CHARGEOVER_PASSWORD = uset.Chargeover_Pass__c;
        
    }

    public ChargeOver()
    {

    }

    static public void createCustomer(String json)
    {
        ChargeOver.toChargeOver('/customer', json);
    }
    
    static public void updateCustomer(String co_id, String json)
    {
        ChargeOver.toChargeOver('/customer/' + co_id, json, 'PUT');
    }
    
    static public void blockCustomer(String co_id)
    {
        ChargeOver.toChargeOver('/customer/' + co_id + '?action=setBlocked', '{ "cancel_subscriptions": true, "close_quotes": true }', 'POST');
    }

    static public void createQuote(String json_customer, String json_quote, String sf_id)
    {
        ChargeOver.toChargeOverWithDependencySyncBack('/customer', json_customer, '/quote', json_quote, 'quote', sf_id);
    }

    static public void deleteQuote(String sf_id)
    {
        ChargeOver.toChargeOver('/quote/external_key:' + sf_id, '', 'DELETE');
    }

    static public String serializeQuote(Map<String, String> sub, List<Map<String, String>> lines)
    {
        JSONGenerator gen = JSON.createGenerator(true);

        gen.writeStartObject();
        for (String k: sub.keySet())
        {
            if (sub.get(k) != null)
            {
                gen.writeStringField(k, (String) sub.get(k));
            }
        }

        gen.writeFieldName('line_items');
        gen.writeStartArray();
        
        for (Integer i = 0; i < lines.size(); i++)
        {
            gen.writeStartObject();
            for (String line_field: lines[i].keySet())
            {
                if (line_field == 'tierset.base')
                {
                    gen.writeFieldName('tierset');
                    gen.writeStartObject();
                    gen.writeStringField('setup', '0');
                    gen.writeStringField('base', (String) lines[i].get(line_field) + '');
                    gen.writeStringField('pricemodel', 'fla');
                    gen.writeEndObject();
                }
                else if (line_field == 'tierset.setup')
                {
                    gen.writeFieldName('tierset');
                    gen.writeStartObject();
                    gen.writeStringField('setup', (String) lines[i].get(line_field) + '');
                    gen.writeStringField('base', '0');
                    gen.writeStringField('pricemodel', 'fla');
                    gen.writeEndObject();
                }
                else if (line_field == 'obligation.obligation_amount')
                {
                    gen.writeFieldName('obligation');
                    gen.writeStartObject();
                    gen.writeStringField('obligation_amount', (String) lines[i].get(line_field) + '');
                    gen.writeEndObject();
                }
                else if (line_field == 'scheduled_updowngrades.tierset.base')
                {
                    gen.writeFieldName('scheduled_updowngrades');
                    gen.writeStartArray();
                    
                    gen.writeStartObject();
                    	gen.writeStringField('item_external_key', (String) lines[i].get('item_external_key') + '');
                    
                    	gen.writeFieldName('tierset');
                    	gen.writeStartObject();
                    		gen.writeStringField('setup', '0');
                    		gen.writeStringField('base', (String) lines[i].get(line_field) + '');
                    		//gen.writeStringField('base', (String) lines[i].get(line_field) + ' (but also ' + lines[i].get('scheduled_updowngrades_2.tierset.base') + ' and ' + lines[i].get('scheduled_updowngrades_2.scheduled_date_str') + ')');
                    		gen.writeStringField('pricemodel', 'fla');
                    	gen.writeEndObject();
                    
                    	gen.writeStringField('scheduled_date_str', (String) lines[i].get('scheduled_updowngrades.scheduled_date_str') + '');                    
                    gen.writeEndObject();
                    
                    for (Integer j = 2; j < 99; j++)
                    {
                        String line_field_n_base = 'scheduled_updowngrades_' + String.valueOf(j) + '.tierset.base';
                        String line_field_n_date = 'scheduled_updowngrades_' + String.valueOf(j) + '.scheduled_date_str';
                        
                        String line_value_n_base = (String) lines[i].get(line_field_n_base);
                        String line_value_n_date = (String) lines[i].get(line_field_n_date);    
                        
                        if (line_value_n_base != null && 
                            line_value_n_base.length() > 0 && 
                            line_value_n_date != null && 
                            line_value_n_date.length() > 0)
                        {
                            gen.writeStartObject();
                                gen.writeStringField('item_external_key', (String) lines[i].get('item_external_key') + '');
                            
                                gen.writeFieldName('tierset');
                                gen.writeStartObject();
                                    gen.writeStringField('setup', '0');
                                    gen.writeStringField('base', line_value_n_base);
                                    gen.writeStringField('pricemodel', 'fla');
                                gen.writeEndObject();
                            
                                gen.writeStringField('scheduled_date_str', line_value_n_date);                    
                        	gen.writeEndObject();
                        }
                    }
                    
                    gen.writeEndArray();
                }
                else if (line_field.length() > 23 && 
                         line_field.substring(0, 23) == 'scheduled_updowngrades_')
                {
                    // Handled above; cases 2 through N
                }
                else if (line_field == 'scheduled_updowngrades.scheduled_date_str')
                {
                    // Handled above ^^^ ignore this
                }
                else
                {
                    gen.writeStringField(line_field, (String) lines[i].get(line_field) + '');
                }
            }
            gen.writeEndObject();
        }
        gen.writeEndArray();

        gen.writeEndObject();

        return gen.getAsString();
    }

    @future(callout=true)
    static public void toChargeOver(String endpoint, String json)
    {
        ChargeOver.FutureToChargeOver(endpoint, json, 'POST');
    }
    
    @future(callout=true)
    static public void toChargeOver(String endpoint, String json, String method)
    {
        ChargeOver.FutureToChargeOver(endpoint, json, method);
    }
    
    /*
    @future(callout=true)
    static public void toChargeOverWithDependency(String endpoint1, String json1, String endpoint2, String json2)
    {
        ChargeOver.FutureToChargeOver(endpoint1, json1, 'POST');
        ChargeOver.FutureToChargeOver(endpoint2, json2, 'POST');
    }
    */

    @future(callout=true)
    static public void toChargeOverWithDependencySyncBack(String endpoint1, String json1, String endpoint2, String json2, String context, String sf_id)
    {
        ChargeOver.FutureToChargeOver(endpoint1, json1, 'POST');
        ChargeOver.FutureToChargeOver(endpoint2, json2, 'POST');

        // Force the sync _back to Salesforce_ in real-time 
        JSONGenerator gen = JSON.createGenerator(true);

        gen.writeStartObject();
        gen.writeStringField('integration', 'salesforce');
        gen.writeStringField('context_str', context);
        gen.writeStringField('context_external_key', sf_id);
        gen.writeEndObject();

        String json3 = gen.getAsString();

        ChargeOver.FutureToChargeOver('/_integration?action=syncNow', json3, 'POST');
    }
        
    static public void FutureToChargeOver(String endpoint, String json, String method)
    {
        Blob header = Blob.valueOf(ChargeOver.CHARGEOVER_USERNAME + ':' + ChargeOver.CHARGEOVER_PASSWORD);
        String auth = 'Basic ' + EncodingUtil.base64Encode(header);

        HttpRequest req = new HttpRequest();
        req.setEndpoint(ChargeOver.CHARGEOVER_URL + endpoint);
        req.setMethod(method);
        req.setBody(json);
        req.setHeader('Authorization', auth);
        req.setHeader('Content-Type', 'application/json');

        try {
            Http http = new Http();
            HttpResponse resp = http.send(req);

            System.debug('Response body: ' + resp.getBody());
        }
        catch(Exception ex)
        {
            
        }
        
        return;
    }
}