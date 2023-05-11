@IsTest
public with sharing class ChargeOver_Test
{
    @IsTest
    private static void testSerializeQuote()
    {
        List<Map<String, String>> quote_lines = new List<Map<String, String>>();
        Map<String, String> quote = new Map<String, String>();
        
        // Quote data
        quote.put('customer_external_key', 'TestAccountId');
        
        // Quote _line_ data
        Map<String, String> m = new Map<String, String>();
		m.put('external_key', 'TestProductId');
        quote_lines.add(m);
        
        String sq = ChargeOver.serializeQuote(quote, quote_lines);
        System.assertEquals('{  "customer_external_key" : "TestAccountId",  "line_items" : [ {    "external_key" : "TestProductId"  } ]}', sq.replaceAll('\n', '').replaceAll('\r',''));
      
    }
    
    @IsTest
    private static void testPriceIncreases1stYear()
    {
        List<Map<String, String>> quote_lines = new List<Map<String, String>>();
        Map<String, String> quote = new Map<String, String>();
        
        // Quote data
        quote.put('customer_external_key', 'TestAccountId');
        
        // Quote _line_ data
        Map<String, String> m = new Map<String, String>();
		m.put('external_key', 'TestProductId');
        m.put('scheduled_updowngrades.tierset.base', '200');
        m.put('item_external_key', 'abc123');
        m.put('scheduled_updowngrades.scheduled_date_str', '+15 days');
        quote_lines.add(m);
        
        String sq = ChargeOver.serializeQuote(quote, quote_lines);
        System.assert(sq.indexOf('+15 days') != -1);
        System.assert(sq.indexOf('200') != -1);
    }
    
    @IsTest
    private static void testPriceIncrease2ndYear()
    {
        List<Map<String, String>> quote_lines = new List<Map<String, String>>();
        Map<String, String> quote = new Map<String, String>();
        
        // Quote data
        quote.put('customer_external_key', 'TestAccountId');
        
        // Quote _line_ data
        Map<String, String> m = new Map<String, String>();
		m.put('external_key', 'TestProductId');
        m.put('scheduled_updowngrades.tierset.base', '200');
        m.put('item_external_key', 'abc123');
        m.put('scheduled_updowngrades.scheduled_date_str', '+15 days');
        
        // 2nd year 
        m.put('scheduled_updowngrades_2.tierset.base', '210');
        m.put('scheduled_updowngrades_2.scheduled_date_str', '+30 days');
        
        quote_lines.add(m);
        
        String sq = ChargeOver.serializeQuote(quote, quote_lines);
        System.assert(sq.indexOf('+15 days') != -1);
        System.assert(sq.indexOf('200') != -1);
        
        System.assert(sq.indexOf('+30 days') != -1);
        System.assert(sq.indexOf('210') != -1);
    }
    
    @IsTest
    private static void testObligations()
    {
        List<Map<String, String>> quote_lines = new List<Map<String, String>>();
        Map<String, String> quote = new Map<String, String>();
        
        // Quote data
        quote.put('customer_external_key', 'TestAccountId');
        
        // Quote _line_ data
        Map<String, String> m = new Map<String, String>();
		m.put('external_key', 'TestProductId');
        
        m.put('obligation.obligation_amount', '200');
        quote_lines.add(m);
        
        String sq = ChargeOver.serializeQuote(quote, quote_lines);
        System.assert(sq.indexOf('obligation_amount" : "200"') != -1, 'Did not contain expected: ' + sq);
    }
    
    @IsTest
    private static void testTiersetBase()
    {
        List<Map<String, String>> quote_lines = new List<Map<String, String>>();
        Map<String, String> quote = new Map<String, String>();
        
        // Quote data
        quote.put('customer_external_key', 'TestAccountId');
        
        // Quote _line_ data
        Map<String, String> m = new Map<String, String>();
		m.put('external_key', 'TestProductId');
        
        m.put('tierset.base', '200');
        quote_lines.add(m);
        
        String sq = ChargeOver.serializeQuote(quote, quote_lines);
        System.assert(sq.indexOf('"base" : "200"') != -1, 'Did not contain expected: ' + sq);
        System.assert(sq.indexOf('"setup" : "0"') != -1, 'Did not contain expected: ' + sq);
    }
    
    @IsTest
    private static void testTiersetSetup()
    {
        List<Map<String, String>> quote_lines = new List<Map<String, String>>();
        Map<String, String> quote = new Map<String, String>();
        
        // Quote data
        quote.put('customer_external_key', 'TestAccountId');
        
        // Quote _line_ data
        Map<String, String> m = new Map<String, String>();
		m.put('external_key', 'TestProductId');
        
        m.put('tierset.setup', '200');
        quote_lines.add(m);
        
        String sq = ChargeOver.serializeQuote(quote, quote_lines);
        System.assert(sq.indexOf('"base" : "0"') != -1, 'Did not contain expected: ' + sq);
        System.assert(sq.indexOf('"setup" : "200"') != -1, 'Did not contain expected: ' + sq);
    }
}