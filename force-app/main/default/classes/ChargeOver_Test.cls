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
}